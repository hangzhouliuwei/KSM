//
//  LPBaseModel.swift
//  LPeso
//
//  Created by Kiven on 2024/10/30.
//

import UIKit

struct LPBaseModel<T: Codable>: Codable {
    var code: LPIntString?
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case code = "PTUGoatpoxi"
        case message = "PTUCircumorali"
        case data = "PTUHairclothi"
    }
}

struct LPEmptyModel: Codable {
    
}

struct LPIntString: Codable {
    
    var int: Int
    var float: Float
    var double: Double
    var decimal: Decimal
    var string: String
    var bool: Bool
    
    init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        
        if let stringValue = try? singleValueContainer.decode(String.self) {
            string = stringValue
            bool = Bool(stringValue) ?? false
            decimal = Decimal(string: stringValue) ?? 0.0
            let decimalNumber = decimal as NSDecimalNumber
            double = decimalNumber.doubleValue
            float = decimalNumber.floatValue
            int = decimalNumber.intValue
        } else if let decimalValue = try? singleValueContainer.decode(Decimal.self) {
            bool = (decimalValue as NSDecimalNumber).boolValue
            decimal = decimalValue
            let decimalNumberValue = decimalValue as NSDecimalNumber
            string = decimalNumberValue.stringValue
            double = decimalNumberValue.doubleValue
            float = decimalNumberValue.floatValue
            int = decimalNumberValue.intValue
        } else if let boolValue = try? singleValueContainer.decode(Bool.self) {
            bool = boolValue
            string = boolValue ? "true" : "false"
            decimal = boolValue ? 1.0 : 0.0
            double = boolValue ? 1.0 : 0.0
            float = boolValue ? 1.0 : 0.0
            int = boolValue ? 1 : 0
        } else {
            bool = false
            string = ""
            decimal = 0.0
            double = 0.0
            float = 0.0
            int = 0
        }
    }
    
    
}
