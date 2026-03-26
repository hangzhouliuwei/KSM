//
//  LPAuthBankModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/13.
//

import UIKit

struct LPAuthBankModel: Codable {
    var PTUKickouti:LPIntString?
    var PTUInterlaboratoryi:LPAuthBankGroupModel?    //Bank
    var PTUSubmucosai:LPAuthBankGroupModel?          //E-Wallet
}


struct LPAuthBankGroupModel: Codable{
    var PTURadiogoniometryi:[LPAuthBankItemModel]?
    var PTUMechanotheropyi:LPAuthBankFiledModel?
}


struct LPAuthBankItemModel: Codable{
    var PTUCarmarthenshirei:String? //name
    var PTUProfanei:LPIntString?    //id
    var PTUTictoci:String?          //url
}


struct LPAuthBankFiledModel: Codable{
    var PTUPenitentiaryi:LPIntString?  //id
    var PTUSpringharei:String?         //value
}

