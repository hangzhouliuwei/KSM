//
//  XTAuthenticationModels.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

// MARK: - Note Model (selection option)

struct NoteModel: Codable {
    var name: String?
    var type: String?
    var icon: String?

    enum CodingKeys: String, CodingKey {
        case name = "uporsixnNc"
        case type = "itlisixanizeNc"
        case icon = "ieNcsix"
    }
}

// MARK: - OCR Note Model

struct OcrNoteModel: Codable {
    var backgroundImageURL: String?
    var name: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case backgroundImageURL = "ovrpsixunchNc"
        case name = "roansixizeNc"
        case type = "ceNcsix"
    }
}

// MARK: - List Model (form field)

final class ListModel: Codable {
    var id: String?
    var title: String?
    var subtitle: String?
    var code: String?
    var category: String?
    var noteList: [NoteModel]?
    var isOptional: Bool
    var value: String?
    var isHiddenCell: Bool

    // Computed / transient
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "regnsixNc"
        case title = "fldgsixeNc"
        case subtitle = "orinsixarilyNc"
        case code = "imeasixsurabilityNc"
        case category = "lebosixardNc"
        case noteList = "tubosixdrillNc"
        case value = "darysixmanNc"
        case isOptional = "tapasixxNc"
    }

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decodeIfPresent(String.self, forKey: .id)
        title = try c.decodeIfPresent(String.self, forKey: .title)
        subtitle = try c.decodeIfPresent(String.self, forKey: .subtitle)
        code = try c.decodeIfPresent(String.self, forKey: .code)
        category = try c.decodeIfPresent(String.self, forKey: .category)
        noteList = try c.decodeIfPresent([NoteModel].self, forKey: .noteList)
        value = try c.decodeIfPresent(String.self, forKey: .value)
        isOptional = (try? c.decode(Bool.self, forKey: .isOptional)) ?? false
        isHiddenCell = false

        // Compute display name
        if let cat = category, ["AASIXTENBG", "AASIXTENBL", "AASIXTENBJ"].contains(cat) {
            name = value
        } else if let intVal = Int(value ?? ""), intVal > 0 {
            name = noteList?.first { $0.type == value }?.name
        } else {
            name = ""
        }
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(id, forKey: .id)
        try c.encodeIfPresent(title, forKey: .title)
        try c.encodeIfPresent(subtitle, forKey: .subtitle)
        try c.encodeIfPresent(code, forKey: .code)
        try c.encodeIfPresent(category, forKey: .category)
        try c.encodeIfPresent(noteList, forKey: .noteList)
        try c.encodeIfPresent(value, forKey: .value)
        try c.encode(isOptional, forKey: .isOptional)
    }
}

// MARK: - Items Model (section with fields)

struct ItemsModel: Codable {
    var title: String?
    var subTitle: String?
    var hasMore: Bool
    var list: [ListModel]?
    var hiddenChild: Bool

    enum CodingKeys: String, CodingKey {
        case title = "fldgsixeNc"
        case subTitle = "sub_title"
        case hasMore = "more"
        case list = "xathsixosisNc"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        title = try c.decodeIfPresent(String.self, forKey: .title)
        subTitle = try c.decodeIfPresent(String.self, forKey: .subTitle)
        hasMore = (try? c.decode(Bool.self, forKey: .hasMore)) ?? false
        list = try c.decodeIfPresent([ListModel].self, forKey: .list)
        hiddenChild = false
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(title, forKey: .title)
        try c.encodeIfPresent(subTitle, forKey: .subTitle)
        try c.encode(hasMore, forKey: .hasMore)
        try c.encodeIfPresent(list, forKey: .list)
    }
}

// MARK: - Verify Base Model

struct VerifyBaseModel: Codable {
    var countdown: Int
    var items: [ItemsModel]?

    enum CodingKeys: String, CodingKey {
        case countdown = "paeosixgrapherNc"
        case items = "ovrfsixraughtNc"
    }
}

// MARK: - Contact Item Model

final class ContactItemModel: Codable {
    var title: String?
    var fields: [AnyCodable]?
    var relation: [NoteModel]?
    var name: String?
    var mobile: String?
    var relationType: String?

    var firstValue: String?
    var secondValue: String?
    var thirdValue: String?
    var thirdName: String?

    enum CodingKeys: String, CodingKey {
        case title = "fldgsixeNc"
        case fields = "inhosixationNc"
        case relation = "bedisixeNc"
        case nameNested = "koNcsix"
    }

    private enum NestedKeys: String, CodingKey {
        case name = "uporsixnNc"
        case mobile = "halosixwNc"
        case relationType = "bedisixeNc"
    }

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        title = try c.decodeIfPresent(String.self, forKey: .title)
        fields = try c.decodeIfPresent([AnyCodable].self, forKey: .fields)
        relation = try c.decodeIfPresent([NoteModel].self, forKey: .relation)
        if let nested = try? c.nestedContainer(keyedBy: NestedKeys.self, forKey: .nameNested) {
            name = try nested.decodeIfPresent(String.self, forKey: .name)
            mobile = try nested.decodeIfPresent(String.self, forKey: .mobile)
            relationType = try nested.decodeIfPresent(String.self, forKey: .relationType)
        }
        firstValue = name
        secondValue = mobile
        thirdValue = relationType
        thirdName = relation?.first { $0.type == relationType }?.name
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(title, forKey: .title)
        try c.encodeIfPresent(relation, forKey: .relation)
    }
}

// MARK: - Verify Contact Model

struct VerifyContactModel: Codable {
    var countdown: Int
    var items: [ContactItemModel]?

    enum CodingKeys: String, CodingKey {
        case countdown = "paeosixgrapherNc"
        case items = "ovrfsixraughtNc"
    }
}

// MARK: - Photo Model

final class PhotoModel: Codable {
    var relationId: String?
    var imageURL: String?
    var type: String?
    var notes: [OcrNoteModel]?
    var list: [ListModel]?
    var path: String?
    var value: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case relationId = "darysixmanNc"
        case imageURL = "relosixomNc"
        case type = "decasixleNc"
        case notes = "tubosixdrillNc"
        case list = "xathsixosisNc"
    }

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        relationId = try c.decodeIfPresent(String.self, forKey: .relationId)
        imageURL = try c.decodeIfPresent(String.self, forKey: .imageURL)
        type = try c.decodeIfPresent(String.self, forKey: .type)
        notes = try c.decodeIfPresent([OcrNoteModel].self, forKey: .notes)
        list = try c.decodeIfPresent([ListModel].self, forKey: .list)
        name = notes?.first { $0.type == type }?.name
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(relationId, forKey: .relationId)
        try c.encodeIfPresent(imageURL, forKey: .imageURL)
        try c.encodeIfPresent(type, forKey: .type)
        try c.encodeIfPresent(notes, forKey: .notes)
        try c.encodeIfPresent(list, forKey: .list)
    }
}

// MARK: - OCR Model

struct OcrModel: Codable {
    var countdown: Int
    var model: PhotoModel?

    enum CodingKeys: String, CodingKey {
        case countdown = "paeosixgrapherNc"
        case model = "casasixbNc"
    }
}

// MARK: - Face Model

struct FaceModel: Codable {
    var relationId: String?
    var url: String?
    var isLiveness: Bool?

    enum CodingKeys: String, CodingKey {
        case relationId = "darysixmanNc"
        case url = "relosixomNc"
        case isLiveness = "fonNsixc"
    }
}

// MARK: - Bank Item Model

final class BankItemModel: Codable {
    var notes: [NoteModel]?
    var channel: String?
    var channelName: String?
    var account: String?

    enum CodingKeys: String, CodingKey {
        case notes = "unrdsixerlyNc"
        case channelNested = "koNcsix"
    }

    private enum NestedKeys: String, CodingKey {
        case channel = "blthsixelyNc"
        case account = "ovrcsixutNc"
    }

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        notes = try c.decodeIfPresent([NoteModel].self, forKey: .notes)
        if let nested = try? c.nestedContainer(keyedBy: NestedKeys.self, forKey: .channelNested) {
            channel = try nested.decodeIfPresent(String.self, forKey: .channel)
            let rawAccount = try nested.decodeIfPresent(String.self, forKey: .account)
            account = rawAccount
        }
        channelName = notes?.first { $0.type == channel }?.name

        // Prefix phone with "0" if needed
        if account == nil || account!.isEmpty {
            let phone = UserSession.shared.currentUser?.phone ?? ""
            account = phone.hasPrefix("0") ? phone : "0\(phone)"
        }
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(notes, forKey: .notes)
    }
}

// MARK: - Bank Model

struct BankModel: Codable {
    var countdown: Int
    var bankItem: BankItemModel?
    var walletItem: BankItemModel?

    enum CodingKeys: String, CodingKey {
        case countdown = "paeosixgrapherNc"
        case bankItem = "murasixyNc"
        case walletItem = "abensixtlyNc"
    }
}

// MARK: - Verify List Model

struct VerifyListModel: Codable {
    var stepCode: String?
    var title: String?
    var status: String?
    var isCompleted: Bool

    enum CodingKeys: String, CodingKey {
        case stepCode = "noassixsessabilityNc"
        case title = "fldgsixeNc"
        case status = "doabsixleNc"
        case isCompleted = "frllsixyNc"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        stepCode = try c.decodeIfPresent(String.self, forKey: .stepCode)
        title = try c.decodeIfPresent(String.self, forKey: .title)
        status = try c.decodeIfPresent(String.self, forKey: .status)
        isCompleted = (try? c.decode(Bool.self, forKey: .isCompleted)) ?? false
    }
}

// MARK: - Typealias for legacy call sites

typealias XTNoteModel = NoteModel
typealias XTOcrNoteModel = OcrNoteModel
typealias XTListModel = ListModel
typealias XTItemsModel = ItemsModel
typealias XTVerifyBaseModel = VerifyBaseModel
typealias XTContactItemModel = ContactItemModel
typealias XTVerifyContactModel = VerifyContactModel
typealias XTPhotoModel = PhotoModel
typealias XTOcrModel = OcrModel
typealias XTFaceModel = FaceModel
typealias XTBankItemModel = BankItemModel
typealias XTBankModel = BankModel
typealias XTVerifyListModel = VerifyListModel
