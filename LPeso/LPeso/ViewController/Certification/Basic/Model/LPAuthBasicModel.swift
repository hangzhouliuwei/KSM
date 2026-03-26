//
//  LPAuthBasicModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit


enum LPUnhcrType: String, Codable{
    case enums = "HYNQQQJ"
    case txt = "HYNQQQK"
    case citySelect = "HYNQQQL"
    case option = "HYNQQAA"
    case day = "HYNQQBB"
    case photo = "HYNQQCC"
    case linkage = "HYNQQDD"
}

struct LPAuthBasicModel: Codable {
    var PTUKickouti:LPIntString?
    var PTUCyprinidi:[LPAuthGoupModel]?
}

struct LPAuthGoupModel: Codable {
    var PTUTilefishi:String?
    var sub_title:String?
    var more:LPIntString?
    var isFold:Bool?
    var PTUIncipienti:[LPAuthItemModel]?
}

struct LPAuthItemModel: Codable {
    var PTUProfanei:LPIntString?            //id
    var PTUTilefishi:String?                //title
    var PTUAntehalli:String?                //subtitle
    var PTUPeltryi:LPIntString?             //keyboardType 0:default 1:numberPad
    var PTUIndividualityi:LPIntString?      //optional -> can empty
    var PTUGoatpoxi:String?                 //code
    var PTUMesenchymatousi:LPIntString?     //value -> LPAuthSelectModel:type
    var PTUCockadei:LPUnhcrType?            //cate
    var PTUPosi:[LPAuthSelectModel]?        //note
}


struct LPAuthSelectModel: Codable {
    var name:String?
    var type:LPIntString?
    
    enum CodingKeys: String, CodingKey {
        case name = "PTUCarmarthenshirei"
        case typeBasic = "PTUItalianisti"
        case typeContact = "PTULickerishi"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let basicType = try? container.decode(LPIntString.self, forKey: .typeBasic) {
            self.type = basicType
        }else if let contactType = try? container.decode(LPIntString.self, forKey: .typeContact) {
            self.type = contactType
        }else{
            self.type = nil
        }
        
        self.name = try? container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .typeBasic)
    }
    
    init(name: String, type: LPIntString) {
        self.name = name
        self.type = type
    }
    
}
