//
//  XTRoute.swift
//  XTApp
//
//  Created by Codex on 2026/4/28.
//

import UIKit

@objcMembers
@objc(XTRoute)
class XTRoute: NSObject {
    private static let shared = XTRoute()

    @objc class func xt_share() -> XTRoute {
        shared
    }

    @objc(goHtml:success:)
    func goHtml(_ url: String, success: XTBoolBlock?) {
        guard NSString.xt_isValidateUrl(url) else {
            success?(false)
            return
        }
        let htmlVC = XTHtmlVC(url: url)
        guard let navigationController = XTUtility.xt_getCurrentVCInNav()?.navigationController else {
            success?(false)
            return
        }
        navigationController.pushViewController(htmlVC, animated: true)
        success?(true)
    }

    @objc(goVerifyList:)
    func goVerifyList(_ productId: String) {
        let vc = XTVerifyListVC(productId: productId)
        XTUtility.xt_getCurrentVCInNav()?.navigationController?.pushViewController(vc, animated: true)
    }

    @objc(goVerifyItem:productId:orderId:success:)
    func goVerifyItem(_ code: String, productId: String, orderId: String, success: XTBoolBlock?) {
        let vc: UIViewController?
        switch code {
        case "AASIXTENBO":
            vc = XTVerifyBaseVC(productId: productId, orderId: orderId)
        case "AASIXTENBC":
            vc = XTVerifyContactVC(productId: productId, orderId: orderId)
        case "AASIXTENBD":
            vc = XTOCRVC(productId: productId, orderId: orderId)
        case "AASIXTENBP":
            vc = XTVerifyFaceVC(productId: productId, orderId: orderId)
        case "AASIXTENBE":
            vc = XTVerifyBankVC(productId: productId, orderId: orderId)
        default:
            vc = nil
        }

        guard let vc,
              let navigationController = XTUtility.xt_getCurrentVCInNav()?.navigationController else {
            success?(false)
            return
        }
        navigationController.pushViewController(vc, animated: true)
        success?(true)
    }
}
