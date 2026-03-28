//
//  LPHomeDataModel.swift
//  LPeso
//
//  Created by Kiven on 2024/10/31.
//


import Foundation

struct LPHomeDataModel: Codable {
    var custom: LPHomeIconModel?
    var itemList: [LPHomeListModel]?
    
    enum CodingKeys: String, CodingKey {
        case custom = "PTUTictoci"
        case itemList = "PTUIncipienti"
    }
}

struct LPHomeAlertModel: Codable {
    var PTUImitablei: String?           //imgUrl
    var PTUThenarditei: String?         //url
    var PTUTirosi: String?              //buttonText
}


// MARK: - Service
struct LPHomeIconModel: Codable {
    var png: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case png = "PTUOnionskini"
        case url = "PTUSteepyi"
    }
}

// MARK: - LPHomeListModel
struct LPHomeListModel: Codable {
    var type: HomeItemType?
    var items: [LPHomeItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case type = "PTUItalianisti"
        case items = "PTUGotoi"
    }

}


// MARK: - LPHomeItemModel
struct LPHomeItemModel: Codable {
    
    var PTUTilefishi: String? // title
    var PTUThenarditei: String? // jump url
    
    // BANNER > HYNMKS
    var PTUImitablei: String? // img url
    var PTUNaturopathici: String? // new img url

    //LARGE_CARD > HYNMKKA
    //SMALL_CARD > HYNQQQA
    var PTUProfanei: LPIntString?       // id
    var PTUTrimonthlyi: String?         // productName
    var PTUTalofibulari: String?        // productLogo
    var PTUTirosi: String?              // buttonText
    var PTUJuglandaceousi: String?      // buttoncolor
    var PTUTaeniai: LPIntString?        // amountRange
    var PTUMeconici: String?            // amountRangeDes
    var PTUCrenationi: LPIntString?     // termInfo
    var PTUPyrographeri: String?        // termInfoDes
    var PTUReedlingi: LPIntString?      // loanRate
    var PTUStatelessi: String?          // loanRateDes
    var PTUUnorganizedi: String?        // termInfoImg
    var PTUCommisioni: String?          // loanRateImg
    var PTUStraggleri: LPIntString?     // showProgressBar
    var PTUInglenooki: LPIntString?     // canClick
    
    var PTUTrithingi: String?           // memberUrl
    
    //REPAY > HYNQQQC
    var PTUJeridi: String?              // titleBg
    var PTUCircumorali: String?         // message
    
    //RIDING_LANTERN > HYNIUDS
    var PTUZedoaryi: String?            // content
    var PTUPolysemyi: String?           // color
    
    //PRODUCT_LIST > HYNQQQB
    var PTUFussyi: [String]?            // productTags
    var PTUArsenitei: String?           // productDesc
    var PTUBallasti: LPIntString?       // buttonStatus
    var PTUStragglinglyi: LPIntString?  // productType  1 API 2 H5
    var PTUCarfuli: LPIntString?        // loan_rate
    var PTUDeducei: LPIntString?        // todayClicked
    var PTUFamei: LPIntString?          // amountMax
    var PTUArgentitei: LPIntString?     // orderStatus
    
}




