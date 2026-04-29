//
//  LoanEntryCoordinator.swift
//  XTApp
//

import UIKit

enum LoanApplicationEntrySource {
    case home
    case html
}

final class LoanEntryCoordinator {
    static let shared = LoanEntryCoordinator()

    private init() {}

    func startApplication(productId: String?, from controller: XTBaseVC, source: LoanApplicationEntrySource) {
        guard let productId, !NSString.xt_isEmpty(productId) else { return }
        guard ensureLoggedIn(from: controller, retry: { [weak controller] in
            guard let controller else { return }
            self.startApplication(productId: productId, from: controller, source: source)
        }) else { return }

        switch source {
        case .home:
            performApply(productId: productId, from: controller, source: source)
        case .html:
            if XTUserManger.xt_share().xt_user?.xt_is_aduit == true {
                performApply(productId: productId, from: controller, source: source)
            } else {
                ensureLocationAccess(from: controller, includeCancelAction: true) { [weak controller] in
                    guard let controller else { return }
                    self.performApply(productId: productId, from: controller, source: source)
                }
            }
        }
    }

    func performApply(productId: String, from controller: XTBaseVC, source: LoanApplicationEntrySource) {
        XTUtility.xt_showProgress(controller.view, message: "loading...")
        LoanFlowCoordinator.shared.loadApplyDecision(productId, success: { [weak controller] decision in
            guard let controller else { return }
            XTUtility.xt_atHideProgress(controller.view)
            if decision.uploadType == 2 {
                XTRequestCenter.xt_share().xt_device()
            }

            let destination: () -> Void
            if NSString.xt_isValidateUrl(decision.url) {
                destination = {
                    XTRoute.xt_share().goHtml(decision.url, success: nil)
                }
            } else {
                destination = {
                    LoanFlowCoordinator.shared.continueAfterDetail(productId: productId, loadingView: controller.view)
                }
            }

            switch source {
            case .home:
                self.ensureLocationAccess(from: controller, skip: decision.isList, completion: destination)
            case .html:
                destination()
            }
        }, failure: { [weak controller] in
            guard let controller else { return }
            XTUtility.xt_atHideProgress(controller.view)
        })
    }

    func ensureLocationAccess(from controller: XTBaseVC, skip: Bool = false, includeCancelAction: Bool = false, completion: @escaping () -> Void) {
        if skip {
            completion()
            return
        }

        guard XTLocationManger.xt_share().xt_canLocation() else {
            showLocationAlert(from: controller, includeCancelAction: includeCancelAction)
            return
        }

        XTUtility.xt_showProgress(controller.view, message: "loading...")
        XTRequestCenter.xt_share().xt_location { [weak controller] success in
            guard let controller else { return }
            XTUtility.xt_atHideProgress(controller.view)
            if success {
                completion()
            }
        }
    }

    private func ensureLoggedIn(from controller: XTBaseVC, retry: @escaping () -> Void) -> Bool {
        guard !XTUserManger.xt_isLogin() else { return true }
        XTUtility.xt_login(retry)
        return false
    }

    private func showLocationAlert(from controller: XTBaseVC, includeCancelAction: Bool) {
        let alert = UIAlertController(
            title: "Tips",
            message: "To be able to use our app, please turn on your device location services.",
            preferredStyle: .alert
        )
        if includeCancelAction {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        controller.xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }
}