//
//  XTFirstViewModel.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

final class FirstViewModel {
    private(set) var indexModel: IndexModel?

    // MARK: - Fetch index page data

    func fetchFirst() async throws {
        let (data, _) = try await NetworkService.shared.fetchIndex()
        guard let data else { throw NetworkError.noData }
        indexModel = try JSONDecoder().decode(IndexModel.self, from: JSONSerialization.data(withJSONObject: data))
    }

    // MARK: - Fetch popup

    func fetchPopUp() async throws -> (imageURL: String, url: String, buttonText: String) {
        let (data, _) = try await NetworkService.shared.fetchPopUp()
        guard let data else { throw NetworkError.noData }
        let imageURL = XT_Object_To_Stirng(data["meulsixloblastomaNc"])
        let url = XT_Object_To_Stirng(data["relosixomNc"])
        let buttonText = XT_Object_To_Stirng(data["maansixNc"])
        return (imageURL, url, buttonText)
    }

    // MARK: - Apply for loan

    struct ApplyResult {
        let uploadType: Int
        let url: String
        let isList: Bool
    }

    func apply(productId: String) async throws -> ApplyResult {
        let (data, _) = try await NetworkService.shared.apply(productId: productId)
        guard let data else { throw NetworkError.noData }
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
        return ApplyResult(uploadType: uploadType, url: url, isList: isList)
    }

    // MARK: - Fetch product detail

    func fetchDetail(productId: String) async throws -> (code: String?, orderId: String?) {
        let (data, _) = try await NetworkService.shared.detail(productId: productId)
        guard let data else { throw NetworkError.noData }
        let topInfo = data["heissixtopNc"] as? [String: Any]
        let loanInfo = data["leonsixishNc"] as? [String: Any]
        let code = topInfo.map { XT_Object_To_Stirng($0["excuse"]) }
        let orderId = loanInfo.map { XT_Object_To_Stirng($0["cokesixtNc"]) }
        return (code, orderId)
    }
}

// MARK: - Legacy ObjC shim
typealias XTFirstViewModel = FirstViewModel
