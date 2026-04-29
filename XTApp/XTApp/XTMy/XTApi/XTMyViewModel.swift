//
//  XTMyViewModel.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

final class MyViewModel {
    private(set) var myModel: MyModel?

    func fetchHome() async throws {
        let (data, _) = try await NetworkService.shared.fetchHome()
        guard let data else { throw NetworkError.noData }
        let jsonData = try JSONSerialization.data(withJSONObject: data)
        myModel = try JSONDecoder().decode(MyModel.self, from: jsonData)
    }

    func fetchOrderList(orderType: String, page: Int) async throws -> [OrderModel] {
        let (data, _) = try await NetworkService.shared.orderList(orderType: orderType, page: page)
        guard let list = data?["list"] as? [Any] else { return [] }
        let jsonData = try JSONSerialization.data(withJSONObject: list)
        return try JSONDecoder().decode([OrderModel].self, from: jsonData)
    }

    func logout() async throws {
        try await NetworkService.shared.logout()
        UserSession.shared.logout()
    }

    func deleteAccount() async throws {
        try await NetworkService.shared.deleteAccount()
        UserSession.shared.logout()
    }
}

// MARK: - Legacy shim
typealias XTMyViewModel = MyViewModel
