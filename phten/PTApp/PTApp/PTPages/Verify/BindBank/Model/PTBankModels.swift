//
//  PTBankModels.swift
//  PTApp
//

import Foundation

@objc(PTBankValue)
@objcMembers
class PTBankValue: PTBaseModel {
    dynamic var bltenthelyNc: Int = 0
    dynamic var ovtenrcutNc: String = ""
}

@objc(PTBankItemModel)
@objcMembers
class PTBankItemModel: PTBaseModel {
    dynamic var uptenornNc: String = ""
    dynamic var retengnNc: Int = 0
    dynamic var ietenNc: String = ""
}

@objc(PTBankWalletModel)
@objcMembers
class PTBankWalletModel: PTBaseModel {
    dynamic var untenrderlyNc: [PTBankItemModel] = []
    dynamic var kotenNc: PTBankValue?

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["untenrderlyNc": PTBankItemModel.self]
    }
}

@objc(PTBankBankModel)
@objcMembers
class PTBankBankModel: PTBaseModel {
    dynamic var untenrderlyNc: [PTBankItemModel] = []
    dynamic var kotenNc: PTBankValue?

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["untenrderlyNc": PTBankItemModel.self]
    }
}

@objc(PTBankModel)
@objcMembers
class PTBankModel: PTBaseModel {
    dynamic var pateneographerNc: Int = 0
    dynamic var abtenentlyNc: PTBankWalletModel?
    dynamic var mutenrayNc: PTBankBankModel?
}
