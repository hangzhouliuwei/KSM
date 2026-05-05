//
//  PTBasicVerifyModels.swift
//  PTApp
//

import UIKit

@objc(PTBasicEnumModel)
@objcMembers
class PTBasicEnumModel: PTBaseModel {
    dynamic var uptenornNc: String = ""
    dynamic var ittenlianizeNc: Int = 0
}

@objc(PTBasicRowModel)
@objcMembers
class PTBasicRowModel: PTBaseModel {
    dynamic var tetenchedNc: String = ""
    dynamic var tatenpaxNc: String = ""
    dynamic var orteninarilyNc: String = ""
    dynamic var imteneasurabilityNc: String = ""
    dynamic var frtenllyNc: String = ""
    dynamic var datenrymanNc: String = ""
    dynamic var phtentotoxicityNc: String = ""
    dynamic var sutenfonicNc: Bool = false
    dynamic var retengnNc: String = ""
    dynamic var letenboardNc: String = ""
    dynamic var fltendgeNc: String = ""
    dynamic var tutenbodrillNc: [PTBasicEnumModel] = []

    dynamic var cellType: String {
        get {
            switch letenboardNc {
            case "AABFTEN":
                return "enum"
            case "AABGTEN":
                return "txt"
            case "AABJTEN":
                return "day"
            case "AABITEN":
                return "option"
            default:
                return ""
            }
        }
        set {}
    }

    dynamic var cellHight: CGFloat {
        get { 56 }
        set {}
    }

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["tutenbodrillNc": PTBasicEnumModel.self]
    }
}

@objc(PTBasicItmeModel)
@objcMembers
class PTBasicItmeModel: PTBaseModel {
    dynamic var more: Bool = false
    dynamic var fltendgeNc: String = ""
    dynamic var sub_title: String = ""
    dynamic var xatenthosisNc: [PTBasicRowModel] = []
    dynamic var isSelected: Bool = false

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["xatenthosisNc": PTBasicRowModel.self]
    }
}

@objc(PTBasicVerifyModel)
@objcMembers
class PTBasicVerifyModel: PTBaseModel {
    dynamic var ovtenrfraughtNc: [PTBasicItmeModel] = []
    dynamic var pateneographerNc: Int = 0

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["ovtenrfraughtNc": PTBasicItmeModel.self]
    }
}
