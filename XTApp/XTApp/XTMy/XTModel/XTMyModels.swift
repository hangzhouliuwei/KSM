//
//  XTMyModels.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

// MARK: - Extend List Model

struct ExtendListModel: Codable {
    var title: String?
    var icon: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case title = "fldgsixeNc"
        case icon = "ieNcsix"
        case url = "relosixomNc"
    }
}

// MARK: - Repayment Model

struct RepaymentModel: Codable {
    var orderNo: String?
    var productId: String?
    var date: String?
    var amount: String?
    var productName: String?
    var icon: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case orderNo = "spsmsixogenicNc"
        case productId = "lietsixusNc"
        case date = "acepsixtablyNc"
        case amount = "geersixalitatNc"
        case productName = "moossixyllabismNc"
        case icon = "sihosixuetteNc"
        case url = "relosixomNc"
    }
}

// MARK: - My Model

struct MyModel: Codable {
    var memberURL: String?
    var repayment: RepaymentModel?
    var extendLists: [ExtendListModel]?

    enum CodingKeys: String, CodingKey {
        case memberURL = "deensixsiveNc"
        case repayment = "unqusixalizeNc"
        case extendLists = "mehasixemoglobinNc"
    }
}

// MARK: - Order Model

struct OrderModel: Codable {
    var orderId: String?
    var productId: String?
    var inside: String?
    var productName: String?
    var productLogo: String?
    var orderStatus: String?
    var orderStatusDesc: String?
    var orderStatusColor: String?
    var orderAmount: String?
    var loanDetailURL: String?
    var buttonText: String?
    var buttonBackground: String?
    var repayTime: String?
    var showVerification: Bool

    enum CodingKeys: String, CodingKey {
        case orderId = "sttesixhoodNc"
        case productId = "munisixumNc"
        case inside = "quntsixasomeNc"
        case productName = "moossixyllabismNc"
        case productLogo = "sihosixuetteNc"
        case orderStatus = "covisixctiveNc"
        case orderStatusDesc = "laarsixckianNc"
        case orderStatusColor = "imotsixenceNc"
        case orderAmount = "istasixcNc"
        case loanDetailURL = "aplisixcableNc"
        case buttonText = "maansixNc"
        case buttonBackground = "shkasixriNc"
        case repayTime = "exersixiencelessNc"
        case showVerification = "detrsixogyrateNc"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        orderId = try c.decodeIfPresent(String.self, forKey: .orderId)
        productId = try c.decodeIfPresent(String.self, forKey: .productId)
        inside = try c.decodeIfPresent(String.self, forKey: .inside)
        productName = try c.decodeIfPresent(String.self, forKey: .productName)
        productLogo = try c.decodeIfPresent(String.self, forKey: .productLogo)
        orderStatus = try c.decodeIfPresent(String.self, forKey: .orderStatus)
        orderStatusDesc = try c.decodeIfPresent(String.self, forKey: .orderStatusDesc)
        orderStatusColor = try c.decodeIfPresent(String.self, forKey: .orderStatusColor)
        orderAmount = try c.decodeIfPresent(String.self, forKey: .orderAmount)
        loanDetailURL = try c.decodeIfPresent(String.self, forKey: .loanDetailURL)
        buttonText = try c.decodeIfPresent(String.self, forKey: .buttonText)
        buttonBackground = try c.decodeIfPresent(String.self, forKey: .buttonBackground)
        repayTime = try c.decodeIfPresent(String.self, forKey: .repayTime)
        showVerification = (try? c.decode(Bool.self, forKey: .showVerification)) ?? false
    }
}

// MARK: - Typealias for legacy call sites

typealias XTExtendListModel = ExtendListModel
typealias XTRepaymentModel = RepaymentModel
typealias XTMyModel = MyModel
typealias XTOrderModel = OrderModel
