//
//  PTAuthenticationModels.swift
//  PTApp
//

import Foundation

@objc(PTAuthenticationItemModel)
@objcMembers
class PTAuthenticationItemModel: PTHomeBaseModel {
    dynamic var fltendgeNc: String = ""
    dynamic var frtenllyNc: Bool = false
    dynamic var dotenableNc: String = ""
    dynamic var retenloomNc: String = ""
}

@objc(PTAuthenticationNextModel)
@objcMembers
class PTAuthenticationNextModel: PTHomeBaseModel {
    dynamic var retenloomNc: String = ""
    dynamic var fltendgeNc: String = ""
}

@objc(PTAuthenticationLetenonishNcModel)
@objcMembers
class PTAuthenticationLetenonishNcModel: PTHomeBaseModel {
    dynamic var retengnNc: String = ""
    dynamic var cotenketNc: String = ""
}

@objc(PTAuthenticationModel)
@objcMembers
class PTAuthenticationModel: PTHomeBaseModel {
    dynamic var attenesiaNc: [PTAuthenticationItemModel] = []
    dynamic var hetenistopNc: PTAuthenticationNextModel?
    dynamic var letenonishNc: PTAuthenticationLetenonishNcModel?

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["attenesiaNc": PTAuthenticationItemModel.self]
    }
}
