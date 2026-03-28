//
//  LPApplyModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/5.
//

import UIKit

struct LPApplyModel: Codable {
    var PTUThenarditei:String?          //h5 url
    var PTUTheorematici:LPIntString?    //1 update contact  2 update deviceinfo
    var PTUTulipomaniai:LPIntString?    //showVerification  0 no(need location) 1 show
    
}

struct LPProductDetailModel: Codable {
    var PTULikedi:LPProductInfoModel?   //productDetail
    var PTUMonazitei:LPNextStepModel?   //nextStep
}

struct LPProductInfoModel: Codable {
    var PTUEnjoyi:LPIntString?          //orderNo
    
}

struct LPNextStepModel: Codable {
    var excuse:String?                  //step
}

struct LPSaveDataModel: Codable {
    var PTUPedophiliai:LPNextStepModel?
    var PTUThenarditei:String?      //url
}






