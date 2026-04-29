//
//  XTVerifyViewModel.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

final class VerifyViewModel {
    private(set) var list: [VerifyListModel]?
    private(set) var baseModel: VerifyBaseModel?
    private(set) var contactModel: VerifyContactModel?
    private(set) var ocrModel: OcrModel?
    private(set) var faceModel: FaceModel?
    private(set) var bankModel: BankModel?

    private let network = NetworkService.shared

    // MARK: - Decode helpers

    private func decode<T: Decodable>(_ type: T.Type, from dict: [String: Any]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dict)
        return try JSONDecoder().decode(type, from: data)
    }

    private func decodeArray<T: Decodable>(_ type: T.Type, from array: [Any]) throws -> [T] {
        let data = try JSONSerialization.data(withJSONObject: array)
        return try JSONDecoder().decode([T].self, from: data)
    }

    private func nextCode(from data: [String: Any]?) -> String? {
        guard let next = data?["deecsixtibleNc"] as? [String: Any] else { return nil }
        return next["excuse"] as? String
    }

    private func handleModel<T: Decodable>(
        _ result: Result<NetworkRawResponse, NetworkError>,
        assign: (T) -> Void,
        success: XTBlock?,
        failure: XTBlock?
    ) {
        switch result {
        case .success(let response):
            guard let data = response.data,
                  let model = try? decode(T.self, from: data) else {
                failure?()
                return
            }
            assign(model)
            success?()
        case .failure:
            failure?()
        }
    }

    func xt_detail(_ productId: String, success: ((String?, String?) -> Void)?, failure: XTBlock?) {
        network.detail(productId: productId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                guard let data = response.data,
                      let listJSON = data["atessixiaNc"] as? [Any],
                      let loanInfo = data["leonsixishNc"] as? [String: Any],
                      let decodedList = try? self.decodeArray(VerifyListModel.self, from: listJSON) else {
                    failure?()
                    return
                }
                self.list = decodedList
                let topInfo = data["heissixtopNc"] as? [String: Any]
                success?(topInfo.map { XT_Object_To_Stirng($0["excuse"]) }, XT_Object_To_Stirng(loanInfo["cokesixtNc"]))
            case .failure:
                failure?()
            }
        }
    }

    func xt_person(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        network.person(productId: productId) { [weak self] result in
            guard let self else { return }
            self.handleModel(result, assign: { self.baseModel = $0 }, success: success, failure: failure)
        }
    }

    func xt_person_next(_ params: NSDictionary, success: ((String?) -> Void)?, failure: XTBlock?) {
        network.personNext(params: params as? [String: Any] ?? [:]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                success?(self.nextCode(from: response.data))
            case .failure:
                failure?()
            }
        }
    }

    func xt_contact(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        network.contact(productId: productId) { [weak self] result in
            guard let self else { return }
            self.handleModel(result, assign: { self.contactModel = $0 }, success: success, failure: failure)
        }
    }

    func xt_contact_next(_ params: NSDictionary, success: ((String?) -> Void)?, failure: XTBlock?) {
        network.contactNext(params: params as? [String: Any] ?? [:]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                success?(self.nextCode(from: response.data))
            case .failure:
                failure?()
            }
        }
    }

    func xt_photo(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        network.photo(productId: productId) { [weak self] result in
            guard let self else { return }
            self.handleModel(result, assign: { self.ocrModel = $0 }, success: success, failure: failure)
        }
    }

    func xt_photo_next(_ params: NSDictionary, success: ((String?) -> Void)?, failure: XTBlock?) {
        network.photoNext(params: params as? [String: Any] ?? [:]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                success?(self.nextCode(from: response.data))
            case .failure:
                failure?()
            }
        }
    }

    func xt_upload_ocr_image(_ filePath: String, typeId: String, success: XTBlock?, failure: XTBlock?) {
        network.uploadOCR(filePath: filePath, typeId: typeId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                guard let data = response.data,
                      let model = try? self.decode(OcrModel.self, from: data) else {
                    failure?()
                    return
                }
                self.ocrModel = model
                success?()
            case .failure:
                failure?()
            }
        }
    }

    func xt_auth(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        network.auth(productId: productId) { [weak self] result in
            guard let self else { return }
            self.handleModel(result, assign: { self.faceModel = $0 }, success: success, failure: failure)
        }
    }

    func xt_limit(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        network.limit(productId: productId) { result in
            switch result {
            case .success:
                success?()
            case .failure:
                failure?()
            }
        }
    }

    func xt_licenseSuccess(_ success: ((String?) -> Void)?, failure: XTBlock?) {
        network.license { result in
            switch result {
            case .success(let response):
                success?(response.data?["sdkKey"] as? String)
            case .failure:
                failure?()
            }
        }
    }

    func xt_auth_err(_ errorStr: String) {
        network.authError(errorStr: errorStr) { _ in }
    }

    func xt_detectionProductId(_ productId: String, livenessId: String, success: ((String?) -> Void)?, failure: XTBlock?) {
        network.detection(productId: productId, livenessId: livenessId) { result in
            switch result {
            case .success(let response):
                success?(response.data.map { XT_Object_To_Stirng($0["relosixomNc"]) })
            case .failure:
                failure?()
            }
        }
    }

    func xt_save_auth(_ params: NSDictionary, success: ((String?) -> Void)?, failure: XTBlock?) {
        network.saveAuth(params: params as? [String: Any] ?? [:]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                success?(self.nextCode(from: response.data))
            case .failure:
                failure?()
            }
        }
    }

    func xt_card(_ productId: String, success: XTBlock?, failure: XTBlock?) {
        network.card(productId: productId) { [weak self] result in
            guard let self else { return }
            self.handleModel(result, assign: { self.bankModel = $0 }, success: success, failure: failure)
        }
    }

    func xt_card_next(_ params: NSDictionary, success: ((String?) -> Void)?, failure: XTBlock?) {
        network.cardNext(params: params as? [String: Any] ?? [:]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                success?(self.nextCode(from: response.data))
            case .failure:
                failure?()
            }
        }
    }

    func xt_push(_ orderId: String, success: ((String?) -> Void)?, failure: XTBlock?) {
        LoanFlowCoordinator.shared.loadPushURL(orderId, success: { url in
            success?(url)
        }, failure: failure)
    }
}

// MARK: - Legacy shim
typealias XTVerifyViewModel = VerifyViewModel
