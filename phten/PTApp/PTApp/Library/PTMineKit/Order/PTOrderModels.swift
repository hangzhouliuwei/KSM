//
//  PTOrderModels.swift
//  PTApp
//

import Foundation

@objc(PTOrderListModel)
@objcMembers
class PTOrderListModel: PTBaseModel {
    dynamic var motenosyllabismNc: String = ""
    dynamic var sitenhouetteNc: String = ""
    dynamic var cotenvictiveNc: Int = 0
    dynamic var mutenniumNc: String = ""
    dynamic var latenarckianNc: String = ""
    dynamic var imtenotenceNc: String = ""
    dynamic var istentacNc: String = ""
    dynamic var aptenlicableNc: String = ""
    dynamic var matenanNc: String = ""
    dynamic var shtenkariNc: String = ""
    dynamic var exteneriencelessNc: String = ""
    dynamic var detentrogyrateNc: Int = 0
}

@objc(PTOrderModel)
@objcMembers
class PTOrderModel: PTBaseModel {
    dynamic var xatenthosisNc: [PTOrderListModel] = []

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["xatenthosisNc": PTOrderListModel.self]
    }
}
