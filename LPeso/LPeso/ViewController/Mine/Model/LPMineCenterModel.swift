//
//  LPMineCenterModel.swift
//  LPeso
//
//  Created by Kiven on 2024/11/4.
//

import UIKit

struct LPMineCenterModel: Codable {
    var PTUThrombolytici:[LPMineItemModel]?
}

struct LPMineItemModel: Codable {
    
    var PTUTilefishi:String?    //title
    var PTUTictoci:String?      //png
    var PTUThenarditei:String?  //html
}
