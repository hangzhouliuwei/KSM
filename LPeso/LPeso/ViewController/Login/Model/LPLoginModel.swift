//
//  LPLoginModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/1.
//

import Foundation

struct LPLoginModel: Codable{
    var PTUGotoi:LPLoginInfoModel?
}

struct LPLoginInfoModel: Codable {
    
    //code
    var PTUGotoi:String?        //item
    var PTUGoatpoxi:String?     //code
    var PTUCircumorali:String?  // message
    var PTUSetiferousi:LPIntString?  // countdown
    var is_show_captcha:LPIntString? //show code 0:no show，1:show
    
    //login
    var PTUPooli:LPIntString?   //isOld
    var PTUOhioi:LPIntString?   //smsMaxId
    var PTUDereferencei:String? //uid
    var PTUListedi:String?      //username
    var PTUTearlessi:String?    //realname
    var PTUBickyi:String?       //token
    var PTUSkittlei:String?     //sessionid
    var PTUDihydroxyacetonei:LPIntString?  //shenghezhanghao true false
}


