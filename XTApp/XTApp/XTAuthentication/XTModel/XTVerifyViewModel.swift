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

    // MARK: - Detail

    struct DetailResult {
        let code: String?
        let orderId: String?
    }

    func fetchDetail(productId: String) async throws -> DetailResult {
        let (data, _) = try await network.detail(productId: productId)
        guard let data,
              let listJSON = data["atessixiaNc"] as? [Any],
              let loanInfo = data["leonsixishNc"] as? [String: Any] else {
            throw NetworkError.noData
        }
        list = try decodeArray(VerifyListModel.self, from: listJSON)
        let topInfo = data["heissixtopNc"] as? [String: Any]
        let code = topInfo.map { XT_Object_To_Stirng($0["excuse"]) }
        let orderId = XT_Object_To_Stirng(loanInfo["cokesixtNc"])
        return DetailResult(code: code, orderId: orderId)
    }

    // MARK: - Person (基本信息)

    func fetchPerson(productId: String) async throws {
        let (data, _) = try await network.person(productId: productId)
        if let data {
            baseModel = try decode(VerifyBaseModel.self, from: data)
        }
    }

    func submitPerson(params: [String: Any]) async throws -> String? {
        let (data, _) = try await network.personNext(params: params)
        return nextCode(from: data)
    }

    // MARK: - Contact

    func fetchContact(productId: String) async throws {
        let (data, _) = try await network.contact(productId: productId)
        if let data {
            contactModel = try decode(VerifyContactModel.self, from: data)
        }
    }

    func submitContact(params: [String: Any]) async throws -> String? {
        let (data, _) = try await network.contactNext(params: params)
        return nextCode(from: data)
    }

    // MARK: - Photo / OCR

    func fetchPhoto(productId: String) async throws {
        let (data, _) = try await network.photo(productId: productId)
        if let data {
            ocrModel = try decode(OcrModel.self, from: data)
        }
    }

    func submitPhoto(params: [String: Any]) async throws -> String? {
        let (data, _) = try await network.photoNext(params: params)
        return nextCode(from: data)
    }

    func uploadOCR(filePath: String, typeId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await network.uploadOCR(filePath: filePath, typeId: typeId)
    }

    // MARK: - Face Liveness

    func fetchLicense() async throws {
        _ = try await network.license()
    }

    func fetchFaceModel(productId: String) async throws {
        let (data, _) = try await network.auth(productId: productId)
        if let data {
            faceModel = try decode(FaceModel.self, from: data)
        }
    }

    func submitDetection(productId: String, livenessId: String) async throws -> String? {
        let (data, _) = try await network.detection(productId: productId, livenessId: livenessId)
        return data.map { XT_Object_To_Stirng($0["relosixomNc"]) }
    }

    func reportAuthError(errorStr: String) async {
        try? await network.authError(errorStr: errorStr)
    }

    // MARK: - Bank

    func fetchCard(productId: String) async throws {
        let (data, _) = try await network.card(productId: productId)
        if let data {
            bankModel = try decode(BankModel.self, from: data)
        }
    }

    func fetchLimit(productId: String) async throws -> String? {
        let (data, _) = try await network.limit(productId: productId)
        return data.map { XT_Object_To_Stirng($0["relosixomNc"]) }
    }

    func submitCard(params: [String: Any]) async throws -> String? {
        let (data, _) = try await network.cardNext(params: params)
        return nextCode(from: data)
    }

    // MARK: - Push / Submit order

    func push(orderId: String) async throws -> String {
        let (data, _) = try await network.push(orderId: orderId)
        guard let data else { throw NetworkError.noData }
        return XT_Object_To_Stirng(data["relosixomNc"])
    }

    // MARK: - Save Auth

    func saveAuth(params: [String: Any]) async throws -> String? {
        let (data, _) = try await network.saveAuth(params: params)
        return nextCode(from: data)
    }

    // MARK: - Private

    private func nextCode(from data: [String: Any]?) -> String? {
        guard let next = data?["deecsixtibleNc"] as? [String: Any] else { return nil }
        return next["excuse"] as? String
    }
}

// MARK: - Legacy shim
typealias XTVerifyViewModel = VerifyViewModel
