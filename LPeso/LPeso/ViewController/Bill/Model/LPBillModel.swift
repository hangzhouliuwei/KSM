//
//  LPBillModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/14.
//

import UIKit

struct LPBillModel: Codable {
    var PTUIncipienti:[LPBillItemModel]?
}

struct LPBillItemModel: Codable {
    var PTUMoldaui: LPIntString?               // orderId
    var PTUSoftwarei: LPIntString?             // productId
    var PTUCapoidi: LPIntString?               // inside
    
    var PTUTrimonthlyi: String?                 // productName
    var PTUTalofibulari: String?                // productLogo
    
    var PTUArgentitei: LPIntString?             // orderStatus
    var PTUAmortisationi: String?               // orderStatusDesc
    var PTUHolmiumi: String?                    // orderStatusColor
    
    var PTUNandini: LPIntString?                     // orderAmount
    
    var PTUPetemani: String?                    // loanDetailUrl
    
    var PTUTirosi: String?                      // buttonText
    var PTUAeropoliticsi: String?               // buttonBackground
    
    var PTUColonialismi: String?                // repayTime
    
    var PTUTulipomaniai: LPIntString?           // showVerification
    
    var PTUoihjivgc:String?                     // amount_foot_text
    
    var PTUuqwsdgytc:[LPBillPlanModel]?        // repay_plan_list
    
}

struct LPBillPlanModel: Codable{
    
    var PTUCopremiai: LPIntString?      // periods
    var PTUHousemaidi: String?          // date
    var PTUWaxingi: LPIntString?             // amount
    var PTUPolysemyi: String?           // color
    
}




