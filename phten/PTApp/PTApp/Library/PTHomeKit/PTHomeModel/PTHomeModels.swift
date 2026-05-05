//
//  PTHomeModels.swift
//  PTApp
//

import Foundation

@objc(PTHomeBaseModel)
@objcMembers
class PTHomeBaseModel: PTBaseModel {
    dynamic var level: Int = 0
    dynamic var cellType: String = ""
    dynamic var cellHigh: Int = 0
}

@objc(PTHomeApplyModel)
@objcMembers
class PTHomeApplyModel: PTBaseModel {
    dynamic var retenloomNc: String = ""
    dynamic var fltencNc: Int = 0
    dynamic var detentrogyrateNc: Bool = false
}

@objc(PTHomeIetenNcModel)
@objcMembers
class PTHomeIetenNcModel: PTHomeBaseModel {
    dynamic var intentantNc: String = ""
    dynamic var kitenchiNc: String = ""
}

@objc(PTHomeBannerItemModel)
@objcMembers
class PTHomeBannerItemModel: PTHomeBaseModel {
    dynamic var retenloomNc: String = ""
    dynamic var artenisNc: String = ""
}

@objc(PTHomeBannerModel)
@objcMembers
class PTHomeBannerModel: PTHomeBaseModel {
    dynamic var ittenlianizeNc: String = ""
    dynamic var gutengoyleNc: [PTHomeBannerItemModel] = []

    override var level: Int {
        get { 6 }
        set { super.level = newValue }
    }

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["gutengoyleNc": PTHomeBannerItemModel.self]
    }
}

@objc(PTHomeLargeEcardItemModel)
@objcMembers
class PTHomeLargeEcardItemModel: PTHomeBaseModel {
    dynamic var retengnNc: String = ""
    dynamic var motenosyllabismNc: String = ""
    dynamic var sitenhouetteNc: String = ""
    dynamic var matenanNc: String = ""
    dynamic var sptenfflicateNc: String = ""
    dynamic var eatenholeNc: String = ""
    dynamic var cotentenderNc: String = ""
    dynamic var urtenterNc: String = ""
    dynamic var patenadosNc: String = ""
    dynamic var fitenancialNc: String = ""
    dynamic var fatentishNc: String = ""
    dynamic var seteniautobiographicalNc: String = ""
    dynamic var cotendogNc: String = ""
}

@objc(PTHomeLargeEcardModel)
@objcMembers
class PTHomeLargeEcardModel: PTHomeBaseModel {
    dynamic var ittenlianizeNc: String = ""
    dynamic var gutengoyleNc: [PTHomeLargeEcardItemModel] = []

    override var level: Int {
        get { 1 }
        set { super.level = newValue }
    }

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["gutengoyleNc": PTHomeLargeEcardItemModel.self]
    }
}

@objc(PTHomeProductListModel)
@objcMembers
class PTHomeProductListModel: PTHomeBaseModel {
    dynamic var retengnNc: String = ""
    dynamic var motenosyllabismNc: String = ""
    dynamic var sitenhouetteNc: String = ""
    dynamic var eatenholeNc: String = ""
    dynamic var cotentenderNc: String = ""
    dynamic var sptenfflicateNc: String = ""
    dynamic var matenanNc: String = ""

    override var level: Int {
        get { 7 }
        set { super.level = newValue }
    }
}

@objc(PTHomeProductModel)
@objcMembers
class PTHomeProductModel: PTHomeBaseModel {
    dynamic var ittenlianizeNc: String = ""
    dynamic var gutengoyleNc: [PTHomeProductListModel] = []

    override var level: Int {
        get { 7 }
        set { super.level = newValue }
    }

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["gutengoyleNc": PTHomeProductListModel.self]
    }
}

@objc(PTHomeRepayRealModel)
@objcMembers
class PTHomeRepayRealModel: PTHomeBaseModel {
    dynamic var frtenwnNc: String = ""
    dynamic var retenloomNc: String = ""

    override var cellHigh: Int {
        get { 128 }
        set { super.cellHigh = newValue }
    }

    override var level: Int {
        get { 5 }
        set { super.level = newValue }
    }
}

@objc(PTHomeRepayModel)
@objcMembers
class PTHomeRepayModel: PTHomeBaseModel {
    dynamic var gutengoyleNc: [PTHomeRepayRealModel] = []

    override var cellHigh: Int {
        get { 128 }
        set { super.cellHigh = newValue }
    }

    override var level: Int {
        get { 5 }
        set { super.level = newValue }
    }

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["gutengoyleNc": PTHomeRepayRealModel.self]
    }
}

@objc(PTHomeSmallCardItemModel)
@objcMembers
class PTHomeSmallCardItemModel: PTHomeBaseModel {
    dynamic var retengnNc: String = ""
    dynamic var motenosyllabismNc: String = ""
    dynamic var sitenhouetteNc: String = ""
    dynamic var matenanNc: String = ""
    dynamic var sptenfflicateNc: String = ""
    dynamic var eatenholeNc: String = ""
    dynamic var cotentenderNc: String = ""
    dynamic var urtenterNc: String = ""
    dynamic var patenadosNc: String = ""
    dynamic var fitenancialNc: String = ""
    dynamic var fatentishNc: String = ""
    dynamic var seteniautobiographicalNc: String = ""
    dynamic var cotendogNc: String = ""
    dynamic var detenensiveNc: String = ""
}

@objc(PTHomeSmallCardModel)
@objcMembers
class PTHomeSmallCardModel: PTHomeBaseModel {
    dynamic var ittenlianizeNc: String = ""
    dynamic var gutengoyleNc: [PTHomeSmallCardItemModel] = []

    override var level: Int {
        get { 4 }
        set { super.level = newValue }
    }

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["gutengoyleNc": PTHomeSmallCardItemModel.self]
    }
}

@objc(PTRidingLanternItemModel)
@objcMembers
class PTRidingLanternItemModel: PTHomeBaseModel {
    dynamic var thtenckleafNc: String = ""
    dynamic var eptengynyNc: String = ""
}

@objc(PTRidingLanternModel)
@objcMembers
class PTRidingLanternModel: PTHomeBaseModel {
    dynamic var ittenlianizeNc: String = ""
    dynamic var gutengoyleNc: [PTRidingLanternItemModel] = []

    @objc class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["gutengoyleNc": PTRidingLanternItemModel.self]
    }
}
