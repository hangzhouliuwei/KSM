//
//  LPAuthFaceModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/12.
//

import UIKit

struct LPAuthFaceModel: Codable {
    var PTUDesuetudei: LPAuthFaceSubModel
}

struct LPAuthFaceSubModel:Codable{
    var PTUPeltryi:String? ///relation_id
    var PTUMesenchymatousi:String? /// image
    var PTUHollanderi: LPIntString?
}

struct LPAuthFaceLimitModel: Codable {
    var PTUHelicedi: String?
}

struct LPAuthFaceLivenIdModel: Codable {
    var PTUStaggeryi: String?
}

