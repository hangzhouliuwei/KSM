//
//  PTIdentifyModels.swift
//  PTApp
//

import UIKit

@objc(PTIdentifyListModel)
@objcMembers
class PTIdentifyListModel: PTBaseModel {
    dynamic var rotenanizeNc: String = ""
    dynamic var ovtenrpunchNc: String = ""
    dynamic var cetenNc: Int = 0
    dynamic var uptenornNc: String = ""
    dynamic var ittenlianizeNc: Int = 0

    @objc class func modelCustomPropertyMapper() -> [String: String] {
        [
            "uptenornNc": "rotenanizeNc",
            "ittenlianizeNc": "cetenNc"
        ]
    }
}

@objc(PTIdentifyDetailModel)
@objcMembers
class PTIdentifyDetailModel: PTBaseModel {
    dynamic var xatenthosisNc: [PTBasicRowModel] = []
    dynamic var tutenbodrillNc: [PTIdentifyListModel] = []
    dynamic var datenrymanNc: String = ""
    dynamic var retenloomNc: String = ""
    dynamic var detencaleNc: Int = 0
    dynamic var idCardImage: UIImage?
    dynamic var patenalympicsNc: String = ""

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        [
            "xatenthosisNc": PTBasicRowModel.self,
            "tutenbodrillNc": PTIdentifyListModel.self
        ]
    }
}

@objc(PTIdentifyModel)
@objcMembers
class PTIdentifyModel: PTBaseModel {
    dynamic var catensabNc: PTIdentifyDetailModel?
    dynamic var pateneographerNc: Int = 0
}
