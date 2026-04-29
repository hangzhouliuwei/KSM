//
//  LoanFlowCoordinator.swift
//  XTApp
//

import UIKit

struct LoanApplyDecision {
    let uploadType: Int
    let url: String
    let isList: Bool
}

final class LoanFlowCoordinator {
    static let shared = LoanFlowCoordinator()

    private let network: NetworkService

    init(network: NetworkService = .shared) {
        self.network = network
    }

    func loadApplyDecision(_ productId: String, success: ((LoanApplyDecision) -> Void)?, failure: XTBlock?) {
        network.apply(productId: productId) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    failure?()
                    return
                }
                let uploadType = Int(XT_Object_To_Stirng(data["flcNsixc"])) ?? 0
                let url = XT_Object_To_Stirng(data["relosixomNc"])
                let isList: Bool
                if let boolVal = data["detrsixogyrateNc"] as? Bool {
                    isList = boolVal
                } else if let intVal = data["detrsixogyrateNc"] as? Int {
                    isList = intVal != 0
                } else {
                    isList = false
                }
                success?(LoanApplyDecision(uploadType: uploadType, url: url, isList: isList))
            case .failure:
                failure?()
            }
        }
    }

    func loadDetail(_ productId: String, success: ((String, String) -> Void)?, failure: XTBlock?) {
        network.detail(productId: productId) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    failure?()
                    return
                }
                let topInfo = data["heissixtopNc"] as? [String: Any]
                let loanInfo = data["leonsixishNc"] as? [String: Any]
                success?(
                    XT_Object_To_Stirng(topInfo?["excuse"]),
                    XT_Object_To_Stirng(loanInfo?["cokesixtNc"])
                )
            case .failure:
                failure?()
            }
        }
    }

    func loadPushURL(_ orderId: String, success: ((String) -> Void)?, failure: XTBlock?) {
        network.push(orderId: orderId) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    failure?()
                    return
                }
                success?(XT_Object_To_Stirng(data["relosixomNc"]))
            case .failure:
                failure?()
            }
        }
    }

    func continueAfterDetail(productId: String, loadingView: UIView, failure: XTBlock? = nil) {
        XTUtility.xt_showProgress(loadingView, message: "loading...")
        loadDetail(productId, success: { [weak self] code, orderId in
            guard let self else { return }
            if NSString.xt_isEmpty(code) {
                self.openPush(orderId: orderId, loadingView: loadingView, showProgress: false, failure: failure)
                return
            }
            XTUtility.xt_atHideProgress(loadingView)
            XTRoute.xt_share().goVerifyItem(code, productId: productId, orderId: orderId, success: nil)
        }, failure: {
            XTUtility.xt_atHideProgress(loadingView)
            failure?()
        })
    }

    func openPush(orderId: String, loadingView: UIView, showProgress: Bool = true, removeCurrentController: XTBaseVC? = nil, failure: XTBlock? = nil) {
        if showProgress {
            XTUtility.xt_showProgress(loadingView, message: "loading...")
        }
        loadPushURL(orderId, success: { [weak removeCurrentController] url in
            XTUtility.xt_atHideProgress(loadingView)
            XTRoute.xt_share().goHtml(url, success: { success in
                if success {
                    removeCurrentController?.xtVerifyRemoveSelf()
                }
            })
        }, failure: {
            XTUtility.xt_atHideProgress(loadingView)
            failure?()
        })
    }

    func routeNext(code: String?, productId: String, orderId: String, loadingView: UIView, removeCurrentController: XTBaseVC? = nil, failure: XTBlock? = nil) {
        guard !NSString.xt_isEmpty(code) else {
            openPush(orderId: orderId, loadingView: loadingView, removeCurrentController: removeCurrentController, failure: failure)
            return
        }
        XTRoute.xt_share().goVerifyItem(code ?? "", productId: productId, orderId: orderId, success: { [weak removeCurrentController] success in
            if success {
                removeCurrentController?.xtVerifyRemoveSelf()
            }
        })
    }
}