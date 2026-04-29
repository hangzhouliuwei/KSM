//
//  XTLoginFlowCoordinator.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import UIKit

final class XTLoginFlowCoordinator {
    static let shared = XTLoginFlowCoordinator()

    private let viewModel = XTLoginViewModel()

    private init() {}

    func requestCode(phone: String, loadingView: UIView, success: @escaping (String) -> Void, failure: XTBlock?) {
        let api = XTPhoneCodeApi(phone: phone)
        XTUtility.xt_showProgress(loadingView, message: "loading...")
        api.xt_startRequestSuccess { dic, str in
            XTUtility.xt_atHideProgress(loadingView)
            XTUtility.xt_showTips(str, view: nil)
            let codeInfo = dic?["gugosixyleNc"] as? [AnyHashable: Any]
            let countDown = XT_Object_To_Stirng(codeInfo?["tedisixurnalNc"])
            success(countDown)
        } failure: { _, str in
            XTUtility.xt_atHideProgress(loadingView)
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in
            XTUtility.xt_atHideProgress(loadingView)
            failure?()
        }
    }

    func pushVerification(phone: String, countDown: String, from: UIViewController, loginBlock: XTBlock?, resendHandler: XTBlock?) -> XTLoginVC {
        let vc = XTLoginVC(phone: phone, countDown: countDown)
        vc.loginBlock = loginBlock
        vc.resendBlock = resendHandler
        from.navigationController?.pushViewController(vc, animated: true)
        return vc
    }

    func login(phone: String, code: String, startTime: String, loadingView: UIView, success: XTBlock?, failure: XTBlock?) {
        let point: [String: Any] = [
            "deamsixatoryNc": XT_Object_To_Stirng(startTime),
            "munisixumNc": "1",
            "hyrasixrthrosisNc": "21",
            "boomsixofoNc": XT_Object_To_Stirng(XTLocationManger.xt_share().xt_latitude),
            "unulsixyNc": XT_Object_To_Stirng(XTUtility.xt_share().xt_nowTimeStamp()),
            "cacosixtomyNc": XT_Object_To_Stirng(XTDevice.xt_share().xt_idfv),
            "unevsixoutNc": XT_Object_To_Stirng(XTLocationManger.xt_share().xt_longitude)
        ]
        let params: [String: Any] = [
            "stwasixrdessNc": phone,
            "firosixticNc": code,
            "latesixscencyNc": "duiuyiton",
            "point": point
        ]

        XTUtility.xt_showProgress(loadingView, message: "loading...")
        viewModel.getLogin(params as NSDictionary) {
            XTUtility.xt_atHideProgress(loadingView)
            success?()
        } failure: {
            XTUtility.xt_atHideProgress(loadingView)
            failure?()
        }
    }

    func finishLogin(from viewController: UIViewController, loginBlock: XTBlock?) {
        loginBlock?()
        if XT_AppDelegate?.xt_nv != nil {
            viewController.navigationController?.dismiss(animated: true)
        } else {
            XT_AppDelegate?.xt_mainView()
        }
    }
}