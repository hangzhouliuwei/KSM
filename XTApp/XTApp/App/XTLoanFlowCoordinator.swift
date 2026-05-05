//
//  XTLoanFlowCoordinator.swift
//  XTApp
//

import UIKit

struct XTLoanApplyDecision {
    let uploadType: Int
    let url: String
    let isList: Bool

    var requiresDeviceReport: Bool {
        uploadType == 2
    }
}

final class XTLoanFlowCoordinator {
    static let shared = XTLoanFlowCoordinator()

    private let network: NetworkService
    private enum ResponseKey {
        static let uploadType = "flcNsixc"
        static let jumpURL = "relosixomNc"
        static let isList = "detrsixogyrateNc"
        static let topInfo = "heissixtopNc"
        static let loanInfo = "leonsixishNc"
        static let verifyCode = "excuse"
        static let orderId = "cokesixtNc"
    }

    init(network: NetworkService = .shared) {
        self.network = network
    }

    func loadApplyDecision(_ productId: String, success: ((XTLoanApplyDecision) -> Void)?, failure: XTBlock?) {
        network.apply(productId: productId) { result in
            switch result {
            case .success(let response):
                self.handleDataResponse(response.data, success: { data in
                    success?(self.makeApplyDecision(from: data))
                }, failure: failure)
            case .failure:
                failure?()
            }
        }
    }

    func loadDetail(_ productId: String, success: ((String, String) -> Void)?, failure: XTBlock?) {
        network.detail(productId: productId) { result in
            switch result {
            case .success(let response):
                self.handleDataResponse(response.data, success: { data in
                    let detail = self.makeDetail(from: data)
                    success?(detail.code, detail.orderId)
                }, failure: failure)
            case .failure:
                failure?()
            }
        }
    }

    func loadPushURL(_ orderId: String, success: ((String) -> Void)?, failure: XTBlock?) {
        network.push(orderId: orderId) { result in
            switch result {
            case .success(let response):
                self.handleDataResponse(response.data, success: { data in
                    success?(XT_Object_To_Stirng(data[ResponseKey.jumpURL]))
                }, failure: failure)
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

    private func handleDataResponse(_ data: [String: Any]?, success: ([String: Any]) -> Void, failure: XTBlock?) {
        guard let data else {
            failure?()
            return
        }
        success(data)
    }

    private func makeApplyDecision(from data: [String: Any]) -> XTLoanApplyDecision {
        XTLoanApplyDecision(
            uploadType: Int(XT_Object_To_Stirng(data[ResponseKey.uploadType])) ?? 0,
            url: XT_Object_To_Stirng(data[ResponseKey.jumpURL]),
            isList: boolValue(from: data[ResponseKey.isList])
        )
    }

    private func makeDetail(from data: [String: Any]) -> (code: String, orderId: String) {
        let topInfo = data[ResponseKey.topInfo] as? [String: Any]
        let loanInfo = data[ResponseKey.loanInfo] as? [String: Any]
        return (
            XT_Object_To_Stirng(topInfo?[ResponseKey.verifyCode]),
            XT_Object_To_Stirng(loanInfo?[ResponseKey.orderId])
        )
    }

    private func boolValue(from value: Any?) -> Bool {
        if let boolValue = value as? Bool {
            return boolValue
        }
        if let intValue = value as? Int {
            return intValue != 0
        }
        return false
    }
}
