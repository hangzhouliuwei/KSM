//
//  PTContactVerifyModels.swift
//  PTApp
//

import Foundation

@objc(PTContactRelationEnumModel)
@objcMembers
class PTContactRelationEnumModel: PTBaseModel {
    dynamic var uptenornNc: String = ""
    dynamic var detenmphasizeNc: Int = 0
}

@objc(PTContactRelationModel)
@objcMembers
class PTContactRelationModel: PTBaseModel {
    dynamic var uptenornNc: String = ""
    dynamic var hatenlowNc: String = ""
    dynamic var betendieNc: Int = 0
}

@objc(PTContactItmeModel)
@objcMembers
class PTContactItmeModel: PTBaseModel {
    dynamic var betendieNc: [PTContactRelationEnumModel] = []
    dynamic var kotenNc: PTContactRelationModel?
    dynamic var intenhoationNc: [[String: Any]] = []
    dynamic var fltendgeNc: String = ""

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["betendieNc": PTContactRelationEnumModel.self]
    }
}

@objc(PTContactVerifyModel)
@objcMembers
class PTContactVerifyModel: PTBaseModel {
    dynamic var ovtenrfraughtNc: [PTContactItmeModel] = []
    dynamic var pateneographerNc: Int = 0

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["ovtenrfraughtNc": PTContactItmeModel.self]
    }
}
