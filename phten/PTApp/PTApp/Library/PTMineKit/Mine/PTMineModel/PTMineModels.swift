//
//  PTMineModels.swift
//  PTApp
//

import Foundation

@objc(PTMineNcModel)
@objcMembers
class PTMineNcModel: PTHomeBaseModel {
    dynamic var sptensmogenicNc: String = ""
    dynamic var lielevenetusNc: String = ""
    dynamic var acteneptablyNc: String = ""
    dynamic var geteneralitatNc: String = ""
    dynamic var hatenryNc: String = ""
    dynamic var ietenNc: String = ""
    dynamic var retenloomNc: String = ""
}

@objc(PTMineItemModel)
@objcMembers
class PTMineItemModel: PTHomeBaseModel {
    dynamic var fltendgeNc: String = ""
    dynamic var ietenNc: String = ""
    dynamic var retenloomNc: String = ""
}

@objc(PTMineModel)
@objcMembers
class PTMineModel: PTHomeBaseModel {
    dynamic var detenensiveNc: String = ""
    dynamic var getenticNc: [PTMineItemModel] = []
    dynamic var untenqualizeNc: PTMineNcModel?

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["getenticNc": PTMineItemModel.self]
    }
}
