//
//  XTLoginViewModel.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

final class LoginViewModel {

    func getPhoneCode(phone: String) async throws -> String? {
        let (_, message) = try await NetworkService.shared.getPhoneCode(phone: phone)
        return message
    }

    func login(params: [String: Any]) async throws {
        let (data, message) = try await NetworkService.shared.login(params: params)
        AppToast.show(message ?? "")
        guard let userDict = data?["gugosixyleNc"] as? [String: Any] else {
            throw NetworkError.noData
        }
        UserSession.shared.saveUser(from: userDict)
    }
}

// MARK: - Legacy shim
typealias XTLoginViewModel = LoginViewModel
