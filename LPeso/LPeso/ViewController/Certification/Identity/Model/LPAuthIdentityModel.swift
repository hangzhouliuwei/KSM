//
//  LPAuthIdentityModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/12.
//

import UIKit

struct LPAuthIdentityModel: Codable {
    var PTUKickouti:LPIntString?
    var PTUShifti:LPIdentityPhotoModel?
}

struct LPIdentityPhotoModel: Codable {
    var PTUMesenchymatousi:String?              //relation_id
    var PTUThenarditei:String?                  //url
    var PTUTickiei:LPIntString?                 //id_type
    var PTUPosi:[LPIdentityCardModel]?          //note
    var PTUIncipienti:[LPAuthItemModel]?        //list
}

struct LPIdentityCardModel: Codable {
    var PTUParajournalismi:LPIntString?         //card_title
    var PTUEroductioni:LPIntString?             //value
    var PTUMiloni:String?                       //card_bg -> png url
}

struct LPIdentityUploadModel :Codable{
    var PTUStaggeryi:String?                    //relation_id
    var PTUIncipienti:[LPAuthItemModel]?        //list
    
}

