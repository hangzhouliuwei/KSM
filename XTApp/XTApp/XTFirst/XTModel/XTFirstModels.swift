//
//  XTFirstModels.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

// MARK: - Banner Model

struct BannerModel: Codable {
    var url: String?
    var imageURL: String?
    var productId: String?
    var title: String?
    var popupImageURL: String?
    var type: String?
    var buttonImageURL: String?
    var logoURL: String?
    var itemType: String?
    var inside: String?
    var buttonText: String?

    enum CodingKeys: String, CodingKey {
        case url = "relosixomNc"
        case imageURL = "cahesixctNc"
        case productId = "lietsixusNc"
        case title = "fldgsixeNc"
        case popupImageURL = "meulsixloblastomaNc"
        case type = "arissixNc"
        case buttonImageURL = "meabsixolismNc"
        case logoURL = "unrosixhibitedNc"
        case itemType = "flnksixydomNc"
        case inside = "quntsixasomeNc"
        case buttonText = "bukbsixeanNc"
    }
}

// MARK: - Card Model

struct CardModel: Codable {
    var productId: String?
    var productName: String?
    var logo: String?
    var buttonText: String?
    var maxAmount: String?
    var minAmount: String?
    var period: String?
    var interestRate: String?
    var daysRemaining: String?
    var financial: String?
    var type: String?
    var backgroundImageURL: String?
    var statusCode: String?
    var buttonBackground: String?
    var isApplied: Bool
    var isPending: Bool
    var memberURL: String?

    enum CodingKeys: String, CodingKey {
        case productId = "regnsixNc"
        case productName = "moossixyllabismNc"
        case logo = "sihosixuetteNc"
        case buttonText = "maansixNc"
        case maxAmount = "spffsixlicateNc"
        case minAmount = "eahosixleNc"
        case period = "cotesixnderNc"
        case interestRate = "urtesixrNc"
        case daysRemaining = "paadsixosNc"
        case financial = "fiansixcialNc"
        case type = "fatisixshNc"
        case backgroundImageURL = "seiasixutobiographicalNc"
        case statusCode = "codosixgNc"
        case buttonBackground = "brvasixdoNc"
        case isApplied = "enpisixritNc"
        case isPending = "pacasixrditisNc"
        case memberURL = "deensixsiveNc"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        productId = try c.decodeIfPresent(String.self, forKey: .productId)
        productName = try c.decodeIfPresent(String.self, forKey: .productName)
        logo = try c.decodeIfPresent(String.self, forKey: .logo)
        buttonText = try c.decodeIfPresent(String.self, forKey: .buttonText)
        maxAmount = try c.decodeIfPresent(String.self, forKey: .maxAmount)
        minAmount = try c.decodeIfPresent(String.self, forKey: .minAmount)
        period = try c.decodeIfPresent(String.self, forKey: .period)
        interestRate = try c.decodeIfPresent(String.self, forKey: .interestRate)
        daysRemaining = try c.decodeIfPresent(String.self, forKey: .daysRemaining)
        financial = try c.decodeIfPresent(String.self, forKey: .financial)
        type = try c.decodeIfPresent(String.self, forKey: .type)
        backgroundImageURL = try c.decodeIfPresent(String.self, forKey: .backgroundImageURL)
        statusCode = try c.decodeIfPresent(String.self, forKey: .statusCode)
        buttonBackground = try c.decodeIfPresent(String.self, forKey: .buttonBackground)
        memberURL = try c.decodeIfPresent(String.self, forKey: .memberURL)
        isApplied = (try? c.decode(Bool.self, forKey: .isApplied)) ?? false
        isPending = (try? c.decode(Bool.self, forKey: .isPending)) ?? false
    }
}

// MARK: - Icon Model

struct IconModel: Codable {
    var imageURL: String?
    var linkURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "intasixntNc"
        case linkURL = "kichsixiNc"
    }
}

// MARK: - Lantern (Marquee) Model

struct LanternModel: Codable {
    var text: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case text = "thcksixleafNc"
        case url = "epgysixnyNc"
    }
}

// MARK: - Product Model

struct ProductModel: Codable {
    var productId: String?
    var productName: String?
    var minAmount: String?
    var tags: [String]?
    var productType: String?
    var logo: String?
    var buttonText: String?
    var maxAmount: String?
    var period: String?
    var type: String?
    var imageURL: String?
    var rate: String?
    var inside: String?
    var minPeriod: String?
    var fee: String?
    var annualRate: String?
    var url: String?
    var interestRate: String?
    var productCode: String?
    var bannerImages: [String]?
    var statusColor: String?
    var images: [String]?
    var repaymentType: String?
    var noGuarantee: String?
    var financial: String?
    var buttonBackground: String?
    var isApplied: Bool
    var isPending: Bool
    var orderStatus: String?

    enum CodingKeys: String, CodingKey {
        case productId = "regnsixNc"
        case productName = "moossixyllabismNc"
        case minAmount = "eahosixleNc"
        case tags = "sefisixshNc"
        case productType = "liotsixesNc"
        case logo = "sihosixuetteNc"
        case buttonText = "maansixNc"
        case maxAmount = "spffsixlicateNc"
        case period = "cotesixnderNc"
        case type = "fatisixshNc"
        case imageURL = "godosixlaNc"
        case rate = "prgesixstinNc"
        case inside = "quntsixasomeNc"
        case minPeriod = "magisixnNc"
        case fee = "cogesixnitallyNc"
        case annualRate = "sesisixtisationNc"
        case url = "relosixomNc"
        case interestRate = "urtesixrNc"
        case productCode = "stthsixoscopyNc"
        case bannerImages = "scumsixmageNc"
        case statusColor = "lipssixyNc"
        case images = "casusixpNc"
        case repaymentType = "budisixeNc"
        case noGuarantee = "noilsixladaNc"
        case financial = "fiansixcialNc"
        case buttonBackground = "brvasixdoNc"
        case isApplied = "enpisixritNc"
        case isPending = "pacasixrditisNc"
        case orderStatus = "covisixctiveNc"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        productId = try c.decodeIfPresent(String.self, forKey: .productId)
        productName = try c.decodeIfPresent(String.self, forKey: .productName)
        minAmount = try c.decodeIfPresent(String.self, forKey: .minAmount)
        productType = try c.decodeIfPresent(String.self, forKey: .productType)
        logo = try c.decodeIfPresent(String.self, forKey: .logo)
        buttonText = try c.decodeIfPresent(String.self, forKey: .buttonText)
        maxAmount = try c.decodeIfPresent(String.self, forKey: .maxAmount)
        period = try c.decodeIfPresent(String.self, forKey: .period)
        type = try c.decodeIfPresent(String.self, forKey: .type)
        imageURL = try c.decodeIfPresent(String.self, forKey: .imageURL)
        rate = try c.decodeIfPresent(String.self, forKey: .rate)
        inside = try c.decodeIfPresent(String.self, forKey: .inside)
        minPeriod = try c.decodeIfPresent(String.self, forKey: .minPeriod)
        fee = try c.decodeIfPresent(String.self, forKey: .fee)
        annualRate = try c.decodeIfPresent(String.self, forKey: .annualRate)
        url = try c.decodeIfPresent(String.self, forKey: .url)
        interestRate = try c.decodeIfPresent(String.self, forKey: .interestRate)
        productCode = try c.decodeIfPresent(String.self, forKey: .productCode)
        statusColor = try c.decodeIfPresent(String.self, forKey: .statusColor)
        repaymentType = try c.decodeIfPresent(String.self, forKey: .repaymentType)
        noGuarantee = try c.decodeIfPresent(String.self, forKey: .noGuarantee)
        financial = try c.decodeIfPresent(String.self, forKey: .financial)
        buttonBackground = try c.decodeIfPresent(String.self, forKey: .buttonBackground)
        orderStatus = try c.decodeIfPresent(String.self, forKey: .orderStatus)
        tags = (try? c.decode([String].self, forKey: .tags))
        bannerImages = (try? c.decode([String].self, forKey: .bannerImages))
        images = (try? c.decode([String].self, forKey: .images))
        isApplied = (try? c.decode(Bool.self, forKey: .isApplied)) ?? false
        isPending = (try? c.decode(Bool.self, forKey: .isPending)) ?? false
    }
}

// MARK: - Repay Model

struct RepayModel: Codable {
    var title: String?
    var amount: String?
    var date: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case title = "fldgsixeNc"
        case amount = "upeasixrNc"
        case date = "frwnsixNc"
        case url = "relosixomNc"
    }
}

// MARK: - Index Section

private struct IndexSection: Codable {
    let type: String?
    let values: [RawJSON]?

    enum CodingKeys: String, CodingKey {
        case type = "itlisixanizeNc"
        case values = "gugosixyleNc"
    }
}

// MARK: - RawJSON Helper

struct RawJSON: Codable {
    private var storage: [String: AnyCodable]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        storage = try container.decode([String: AnyCodable].self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(storage)
    }

    var dictionary: [String: Any] {
        storage.mapValues { $0.value }
    }
}

// MARK: - Index Model

struct IndexModel: Codable {
    var iconModel: IconModel?
    var bannerArr: [BannerModel]?
    var big: CardModel?
    var small: CardModel?
    var repayArr: [RepayModel]?
    var lanternArr: [LanternModel]?
    var productArr: [ProductModel]?
    var noticeModel: RepayModel?

    enum CodingKeys: String, CodingKey {
        case iconModel = "ieNcsix"
        case sections = "xathsixosisNc"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iconModel = try container.decodeIfPresent(IconModel.self, forKey: .iconModel)

        if let sections = try container.decodeIfPresent([IndexSection].self, forKey: .sections) {
            for section in sections {
                let type = section.type ?? ""
                switch type {
                case "AASIXTENAV":
                    bannerArr = section.values?.compactMap {
                        try? JSONDecoder().decode(BannerModel.self, from: JSONSerialization.data(withJSONObject: $0.dictionary))
                    }
                case "AASIXTENAW":
                    lanternArr = section.values?.compactMap {
                        try? JSONDecoder().decode(LanternModel.self, from: JSONSerialization.data(withJSONObject: $0.dictionary))
                    }
                case "AASIXTENAX":
                    if let first = section.values?.first {
                        big = try? JSONDecoder().decode(CardModel.self, from: JSONSerialization.data(withJSONObject: first.dictionary))
                    }
                case "AASIXTENAY":
                    if let first = section.values?.first {
                        small = try? JSONDecoder().decode(CardModel.self, from: JSONSerialization.data(withJSONObject: first.dictionary))
                    }
                case "AASIXTENAZ":
                    productArr = section.values?.compactMap {
                        try? JSONDecoder().decode(ProductModel.self, from: JSONSerialization.data(withJSONObject: $0.dictionary))
                    }
                case "REPAY_NOTICE":
                    if let first = section.values?.first {
                        noticeModel = try? JSONDecoder().decode(RepayModel.self, from: JSONSerialization.data(withJSONObject: first.dictionary))
                    }
                default:
                    break
                }
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        // Encode only what's needed for caching
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(iconModel, forKey: .iconModel)
    }
}

// MARK: - AnyCodable Helper

struct AnyCodable: Codable {
    let value: Any

    init(_ value: Any) { self.value = value }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int = try? container.decode(Int.self) { value = int }
        else if let double = try? container.decode(Double.self) { value = double }
        else if let string = try? container.decode(String.self) { value = string }
        else if let bool = try? container.decode(Bool.self) { value = bool }
        else if let array = try? container.decode([AnyCodable].self) { value = array.map(\.value) }
        else if let dict = try? container.decode([String: AnyCodable].self) { value = dict.mapValues(\.value) }
        else { value = "" }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch value {
        case let int as Int: try container.encode(int)
        case let double as Double: try container.encode(double)
        case let string as String: try container.encode(string)
        case let bool as Bool: try container.encode(bool)
        default: try container.encodeNil()
        }
    }
}
