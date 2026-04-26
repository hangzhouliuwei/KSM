//
//  XTVerifyViewModel.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation
import YYModel

private func xtCodeFromNext(_ dic: [AnyHashable: Any]?) -> String? {
    guard let next = dic?["deecsixtibleNc"] as? [AnyHashable: Any] else { return nil }
    return XT_Object_To_Stirng(next["excuse"])
}

@objcMembers
@objc(XTVerifyViewModel)
class XTVerifyViewModel: NSObject {
    dynamic var list: [XTVerifyListModel]?
    dynamic var baseModel: XTVerifyBaseModel?
    dynamic var contactModel: XTVerifyContactModel?
    dynamic var ocrModel: XTOcrModel?
    dynamic var faceModel: XTFaceModel?
    dynamic var bankModel: XTBankModel?

    @objc(xt_detail:success:failure:)
    func xt_detail(_ productId: String, success: ((_ code: String?, _ orderId: String?) -> Void)?, failure: XTBlock?) {
        let api = XTDetailApi(productId: productId)
        api.xt_startRequestSuccess { [weak self] dic, str in
            guard let dic,
                  let listJSON = dic["atessixiaNc"] as? [Any],
                  let loanInfo = dic["leonsixishNc"] as? [AnyHashable: Any] else {
                XTUtility.xt_showTips(str, view: nil)
                failure?()
                return
            }
            self?.list = NSArray.yy_modelArray(with: XTVerifyListModel.self, json: listJSON) as? [XTVerifyListModel]
            let topInfo = dic["heissixtopNc"] as? [AnyHashable: Any]
            success?(topInfo.map { XT_Object_To_Stirng($0["excuse"]) }, XT_Object_To_Stirng(loanInfo["cokesixtNc"]))
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in
            failure?()
        }
    }

    @objc(xt_person:success:failure:)
    func xt_person(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        let api = XTPersonApi(productId: productId)
        api.xt_startRequestSuccess { [weak self] dic, _ in
            self?.baseModel = dic.flatMap { XTVerifyBaseModel.yy_model(with: $0) }
            success?()
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_person_next:success:failure:)
    func xt_person_next(_ parameter: NSDictionary, success: XTStrBlock?, failure: XTBlock?) {
        nextCode(api: XTPersonNextApi(dic: parameter), success: success, failure: failure)
    }

    @objc(xt_push:success:failure:)
    func xt_push(_ orderId: String, success: XTStrBlock?, failure: XTBlock?) {
        let api = XTPushApi(orderId: orderId)
        api.xt_startRequestSuccess { dic, str in
            guard let dic else {
                XTUtility.xt_showTips(str, view: nil)
                failure?()
                return
            }
            success?(XT_Object_To_Stirng(dic["relosixomNc"]))
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_contact:success:failure:)
    func xt_contact(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        let api = XTContactApi(productId: productId)
        api.xt_startRequestSuccess { [weak self] dic, _ in
            self?.contactModel = dic.flatMap { XTVerifyContactModel.yy_model(with: $0) }
            success?()
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_contact_next:success:failure:)
    func xt_contact_next(_ parameter: NSDictionary, success: XTStrBlock?, failure: XTBlock?) {
        nextCode(api: XTContactNextApi(dic: parameter), success: success, failure: failure)
    }

    @objc(xt_photo:success:failure:)
    func xt_photo(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        let api = XTPhotoApi(productId: productId)
        api.xt_startRequestSuccess { [weak self] dic, _ in
            self?.ocrModel = dic.flatMap { XTOcrModel.yy_model(with: $0) }
            success?()
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_upload_ocr_image:typeId:success:failure:)
    func xt_upload_ocr_image(_ path: String, typeId: String, success: XTBlock?, failure: XTBlock?) {
        let api = XTUpApi(path: path, typeId: typeId)
        api.xt_startRequestSuccess { [weak self] dic, str in
            guard let self else { return }
            guard let dic else {
                XTUtility.xt_showTips(str, view: nil)
                failure?()
                return
            }
            self.ocrModel?.model?.list = NSArray.yy_modelArray(with: XTListModel.self, json: dic["xathsixosisNc"] ?? []) as? [XTListModel]
            self.ocrModel?.model?.xt_img = path
            self.ocrModel?.model?.xt_relation_id = XT_Object_To_Stirng(dic["paalsixympicsNc"])
            success?()
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_photo_next:success:failure:)
    func xt_photo_next(_ parameter: NSDictionary, success: XTStrBlock?, failure: XTBlock?) {
        nextCode(api: XTPhotoNextApi(dic: parameter), success: success, failure: failure)
    }

    @objc(xt_auth:success:failure:)
    func xt_auth(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        let api = XTAuthApi(productId: productId)
        api.xt_startRequestSuccess { [weak self] dic, str in
            guard let faceInfo = dic?["prtosixzoalNc"] as? [AnyHashable: Any] else {
                XTUtility.xt_showTips(str, view: nil)
                failure?()
                return
            }
            self?.faceModel = XTFaceModel.yy_model(with: faceInfo)
            success?()
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_limit:success:failure:)
    func xt_limit(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        let api = XTLimitApi(productId: productId)
        api.xt_startRequestSuccess { _, _ in
            success?()
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_licenseSuccess:failure:)
    func xt_licenseSuccess(_ success: XTStrBlock?, failure: XTBlock?) {
        let api = XTLicenseApi()
        api.xt_startRequestSuccess { dic, str in
            guard let dic else {
                XTUtility.xt_showTips(str, view: nil)
                failure?()
                return
            }
            success?(XT_Object_To_Stirng(dic["tafysixNc"]))
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_auth_err:)
    func xt_auth_err(_ str: String) {
        let api = XTAuthErrApi(errorStr: str)
        api.xt_startRequestSuccess { _, _ in
        } failure: { _, _ in
        } error: { _ in
        }
    }

    @objc(xt_detectionProductId:livenessId:success:failure:)
    func xt_detectionProductId(_ productId: String, livenessId: String, success: XTStrBlock?, failure: XTBlock?) {
        let api = XTDetectionApi(productId: productId, livenessId: livenessId)
        api.xt_startRequestSuccess { dic, str in
            guard let dic else {
                XTUtility.xt_showTips(str, view: nil)
                failure?()
                return
            }
            success?(XT_Object_To_Stirng(dic["paalsixympicsNc"]))
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_save_auth:success:failure:)
    func xt_save_auth(_ parameter: NSDictionary, success: XTStrBlock?, failure: XTBlock?) {
        nextCode(api: XTSaveAuthApi(dic: parameter), success: success, failure: failure)
    }

    @objc(xt_card:success:failure:)
    func xt_card(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        let api = XTCardApi(productId: productId)
        api.xt_startRequestSuccess { [weak self] dic, str in
            guard let dic else {
                XTUtility.xt_showTips(str, view: nil)
                failure?()
                return
            }
            self?.bankModel = XTBankModel.yy_model(with: dic)
            success?()
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }

    @objc(xt_card_next:success:failure:)
    func xt_card_next(_ parameter: NSDictionary, success: XTStrBlock?, failure: XTBlock?) {
        nextCode(api: XTCardNextApi(dic: parameter), success: success, failure: failure)
    }

    private func nextCode(api: XTBaseApi, success: XTStrBlock?, failure: XTBlock?) {
        api.xt_startRequestSuccess { dic, str in
            guard let code = xtCodeFromNext(dic) else {
                XTUtility.xt_showTips(str, view: nil)
                failure?()
                return
            }
            success?(code)
        } failure: { _, str in
            XTUtility.xt_showTips(str, view: nil)
            failure?()
        } error: { _ in failure?() }
    }
}

