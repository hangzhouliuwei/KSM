//
//  AppAPI.swift
//  XTApp
//
//  Created by Codex on 2026/4/29.
//
//  All API endpoint definitions, replacing the YTKNetwork-based XTNetworkApis.swift
//

import Foundation

// MARK: - API Endpoints

extension NetworkService {

    // MARK: Auth

    func auth(productId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/auth", body: ["lietsixusNc": productId])
    }

    func authError(errorStr: String) async throws {
        _ = try await requestRaw(path: "sixca/auth_err", body: ["darysixmanNc": errorStr])
    }

    func card(productId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/card", body: ["lietsixusNc": productId])
    }

    func cardNext(params: [String: Any]) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/card_next", body: params)
    }

    func contact(productId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/contact", body: [
            "lietsixusNc": productId,
            "seissixacredNc": "blaalleynk"
        ])
    }

    func contactNext(params: [String: Any]) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/contact_next", body: params)
    }

    func detection(productId: String, livenessId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/detection", body: [
            "lietsixusNc": productId,
            "gyossixeNc": livenessId
        ])
    }

    func license() async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/license", body: [:])
    }

    func limit(productId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/limit", body: ["lietsixusNc": productId])
    }

    func person(productId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/person", body: [
            "lietsixusNc": productId,
            "bunasixbleNc": "stauistill"
        ])
    }

    func personNext(params: [String: Any]) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/person_next", body: params)
    }

    func photo(productId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/photo", body: ["lietsixusNc": productId])
    }

    func photoNext(params: [String: Any]) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/photo_next", body: params)
    }

    func saveAuth(params: [String: Any]) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixca/saveauth", body: params)
    }

    func uploadOCR(filePath: String, typeId: String) async throws -> (data: [String: Any]?, message: String?) {
        let fileURL = URL(fileURLWithPath: filePath)
        return try await upload(path: "sixca/ocr", fileURL: fileURL, params: ["light": typeId])
    }

    // MARK: Device / Location / Market

    func reportDevice(params: [String: Any]) async throws {
        _ = try await requestRaw(path: "sixcr/device", body: params)
    }

    func reportLocation(params: [String: Any]) async throws {
        _ = try await requestRaw(path: "sixcr/location", body: params)
    }

    func reportMarket(idfv: String, idfa: String) async throws {
        _ = try await requestRaw(path: "sixcr/market", body: [
            "manisixcideNc": idfv,
            "patusixrageNc": idfa,
            "asdfasasdgwg": "fewfdf",
            "ATETH": "123123555"
        ])
    }

    func reportAdid(idfv: String, adid: String) async throws {
        _ = try await requestRaw(path: "sixcr/aio", body: [
            "exepsixtionalNc": idfv,
            "fkgjsixgkxdkcnNc": adid
        ])
    }

    // MARK: First / Home

    func fetchIndex() async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixch/index", method: .get)
    }

    func fetchPopUp() async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixch/pop-up", method: .get)
    }

    func fetchHome() async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixch/home", method: .get)
    }

    // MARK: Loan / Order

    func apply(productId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixnv2/gce/apply", body: [
            "lietsixusNc": productId,
            "fuhasixmNc": "cakestand"
        ])
    }

    func detail(productId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixnv2/gce/detail", body: ["lietsixusNc": productId])
    }

    func push(orderId: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixnv2/gce/push", body: [
            "spsmsixogenicNc": orderId,
            "ditosixmeNc": "houijhyus"
        ])
    }

    func orderList(orderType: String, page: Int, pageSize: Int = 20) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "ph/loan/order-list", body: [
            "hafbsixackNc": orderType,
            "leitsiximismNc": "\(page)",
            "catosixnizationNc": "\(pageSize)"
        ])
    }

    // MARK: User / Account

    func login(params: [String: Any]) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixcp/login", body: params)
    }

    func getPhoneCode(phone: String) async throws -> (data: [String: Any]?, message: String?) {
        try await requestRaw(path: "sixcp/get_code", body: [
            "chresixographyNc": phone,
            "betysixNc": "juyttrr"
        ])
    }

    func logout() async throws {
        _ = try await requestRaw(path: "sixcp/logout", method: .get)
    }

    func deleteAccount() async throws {
        _ = try await requestRaw(path: "ph/user/del-account", body: [:])
    }

    // MARK: License key for liveness SDK

    func fetchLicenseKey() async throws -> String? {
        let result = try await license()
        return result.data?["sdkKey"] as? String
    }
}
