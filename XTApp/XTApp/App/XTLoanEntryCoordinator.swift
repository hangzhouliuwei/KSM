//
//  XTLoanEntryCoordinator.swift
//  XTApp
//

import UIKit

enum XTLoanApplicationEntrySource {
    case home
    case html
}

final class XTLoanEntryCoordinator {
    static let shared = XTLoanEntryCoordinator()

    private let flowCoordinator: XTLoanFlowCoordinator
    private let sessionManager: SessionManaging

    init(
        flowCoordinator: XTLoanFlowCoordinator = .shared,
        sessionManager: SessionManaging = UserSession.shared
    ) {
        self.flowCoordinator = flowCoordinator
        self.sessionManager = sessionManager
    }

    func startApplication(productId: String?, from controller: XTBaseVC, source: XTLoanApplicationEntrySource) {
        guard let productId = validProductId(productId) else { return }
        guard ensureLoggedIn(from: controller, retry: { [weak self, weak controller] in
            guard let self, let controller else { return }
            self.startApplication(productId: productId, from: controller, source: source)
        }) else { return }

        guard needsLocationBeforeApply(from: source) else {
            performApply(productId: productId, from: controller, source: source)
            return
        }

        ensureLocationAccess(from: controller, includeCancelAction: true) { [weak self, weak controller] in
            guard let self, let controller else { return }
            self.performApply(productId: productId, from: controller, source: source)
        }
    }

    func performApply(productId: String, from controller: XTBaseVC, source: XTLoanApplicationEntrySource) {
        showLoading(on: controller)
        flowCoordinator.loadApplyDecision(productId, success: { [weak self, weak controller] decision in
            guard let self, let controller else { return }
            self.hideLoading(on: controller)
            self.handleApplyDecision(decision, productId: productId, from: controller, source: source)
        }, failure: { [weak self, weak controller] in
            guard let self, let controller else { return }
            self.hideLoading(on: controller)
        })
    }

    func ensureLocationAccess(from controller: XTBaseVC, skip: Bool = false, includeCancelAction: Bool = false, completion: @escaping () -> Void) {
        if skip {
            completion()
            return
        }

        guard XTLocationManager.shared.xt_canLocation() else {
            showLocationAlert(from: controller, includeCancelAction: includeCancelAction)
            return
        }

        showLoading(on: controller)
        XTRequestCenter.xt_share().xt_location { [weak self, weak controller] success in
            guard let self, let controller else { return }
            self.hideLoading(on: controller)
            if success {
                completion()
            }
        }
    }

    private func validProductId(_ productId: String?) -> String? {
        guard let productId, !NSString.xt_isEmpty(productId) else { return nil }
        return productId
    }

    private func needsLocationBeforeApply(from source: XTLoanApplicationEntrySource) -> Bool {
        source == .html && sessionManager.currentUser?.isAudit != true
    }

    private func handleApplyDecision(_ decision: XTLoanApplyDecision, productId: String, from controller: XTBaseVC, source: XTLoanApplicationEntrySource) {
        reportDeviceIfNeeded(for: decision)

        let destination = makeDestination(for: decision, productId: productId, from: controller)
        if source == .home {
            ensureLocationAccess(from: controller, skip: decision.isList, completion: destination)
        } else {
            destination()
        }
    }

    private func reportDeviceIfNeeded(for decision: XTLoanApplyDecision) {
        if decision.requiresDeviceReport {
            XTRequestCenter.xt_share().xt_device()
        }
    }

    private func makeDestination(for decision: XTLoanApplyDecision, productId: String, from controller: XTBaseVC) -> () -> Void {
        if NSString.xt_isValidateUrl(decision.url) {
            return {
                XTRoute.xt_share().goHtml(decision.url, success: nil)
            }
        }

        return { [weak self, weak controller] in
            guard let self, let controller else { return }
            self.flowCoordinator.continueAfterDetail(productId: productId, loadingView: controller.view)
        }
    }

    private func ensureLoggedIn(from controller: XTBaseVC, retry: @escaping () -> Void) -> Bool {
        guard sessionManager.isLoggedIn else {
            XTUtility.xt_login(retry)
            return false
        }
        return true
    }

    private func showLoading(on controller: XTBaseVC) {
        XTUtility.xt_showProgress(controller.view, message: "loading...")
    }

    private func hideLoading(on controller: XTBaseVC) {
        XTUtility.xt_atHideProgress(controller.view)
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
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        controller.xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }
}
