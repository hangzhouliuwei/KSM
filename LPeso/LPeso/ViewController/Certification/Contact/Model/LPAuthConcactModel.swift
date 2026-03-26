//
//  LPAuthConcactModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/11.
//

import UIKit

struct LPAuthConcactModel: Codable {
    var PTUKickouti:LPIntString?
    var PTUCyprinidi:[LPAuthConcactItemModel]?
}

struct LPAuthConcactItemModel: Codable {
    var PTUTilefishi:String?                        //title
    var PTUHeuristici:[LPAuthSelectModel]?          //field  name-mobile-relation
    var PTUDentistryi:[LPAuthSelectModel]?          //relation
    var PTUMechanotheropyi:LPConcactFilledModel?    //filled
}


struct LPConcactFilledModel: Codable {
    var PTUCarritchi:String?            //mobile
    var PTUCarmarthenshirei:String?     //name
    var PTUDentistryi:LPIntString?      //relation
}

