//
//  XTUserSession.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation
import UIKit

// MARK: - User Model

struct UserModel: Codable {
    var isOld: String?
    var smsMaxId: String?
    var userId: String?
    var phone: String?
    var realName: String?
    var token: String?
    var sessionId: String?
    var isAudit: Bool

    enum CodingKeys: String, CodingKey {
        case isOld = "phsisixographicalNc"
        case smsMaxId = "heersixochromaticNc"
        case userId = "bamysixNc"
        case phone = "stwasixrdessNc"
        case realName = "edNcsix"
        case token = "tetosixgenesisNc"
        case sessionId = "fifosixotedNc"
        case isAudit = "aoNcsix"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isOld = try container.decodeIfPresent(String.self, forKey: .isOld)
        smsMaxId = try container.decodeIfPresent(String.self, forKey: .smsMaxId)
        userId = try container.decodeIfPresent(String.self, forKey: .userId)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        realName = try container.decodeIfPresent(String.self, forKey: .realName)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        // Server may send Bool or Int (0/1)
        if let boolVal = try? container.decode(Bool.self, forKey: .isAudit) {
            isAudit = boolVal
        } else if let intVal = try? container.decode(Int.self, forKey: .isAudit) {
            isAudit = intVal != 0
        } else {
            isAudit = false
        }
    }
}

// MARK: - UserSession Manager

final class UserSession {
    static let shared = UserSession()

    private let userFilePath: String = AppConstants.documentPath + "/XT_USER"
    private var cachedUser: UserModel?

    private init() {}

    var currentUser: UserModel? {
        get {
            if cachedUser == nil {
                cachedUser = loadUserFromDisk()
            }
            return cachedUser
        }
        set {
            cachedUser = newValue
        }
    }

    var isLoggedIn: Bool {
        guard let user = currentUser,
              let userId = user.userId,
              let sessionId = user.sessionId else { return false }
        return !userId.isEmpty && !sessionId.isEmpty
    }

    func saveUser(from dictionary: [String: Any]) {
        currentUser = try? JSONDecoder().decode(UserModel.self, from: JSONSerialization.data(withJSONObject: dictionary))
        guard let user = currentUser,
              let data = try? JSONEncoder().encode(user) else { return }
        try? data.write(to: URL(fileURLWithPath: userFilePath))
    }

    func logout() {
        try? FileManager.default.removeItem(atPath: userFilePath)
        cachedUser = nil
        DispatchQueue.main.async {
            XT_AppDelegate?.xt_loginView()
        }
    }

    // MARK: - Private

    private func loadUserFromDisk() -> UserModel? {
        guard FileManager.default.fileExists(atPath: userFilePath),
              let data = try? Data(contentsOf: URL(fileURLWithPath: userFilePath)) else { return nil }
        return try? JSONDecoder().decode(UserModel.self, from: data)
    }
}

// MARK: - Legacy ObjC compatibility shim
// These typealiases and wrappers allow existing call-sites to migrate incrementally.

typealias XTUserModel = UserModel
typealias XTUserManger = UserSession
