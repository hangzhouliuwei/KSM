//
//  LPTools.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit

class LPTools {

    static func currentTime() -> String {
        let time = Date().timeIntervalSince1970 * 1000
        let timeString = String(format: "%.0f", time)
        return timeString
    }
    
    static func getUrlParams() ->[String:Any]{
        let urlParams: [String:Any] = [
            "PTUFrogmouthi": "ios",
            "PTUTarnishi": Device.appVersion,
            "PTURibleti": Device.modelName,
            "PTURepricingi": Device.IDFV,
            "PTUDarlingi": Device.systemVersion,
            "PTUMoodyi": "ph",
            "PTUCassisi": UserSession.id,
            "PTUConsecratoryi": Device.bundleId,
            "PTUColumnai": MarketID.IDFA,
            "PTUCursedi" : UserSession.phone,               
        ]
        return urlParams
    }
    
    static func getPointParams(startTime:String,sceneType:String) ->[String:Any]{
        
        let point: [String:Any] = [
            "PTUHurteri": startTime,
            "PTUSoftwarei": "1",
            "PTUTrimethylglycinei": sceneType,
            "PTUOutfalli": Location.lp_latitude,
            "PTUHypomanici": LPTools.currentTime(),
            "PTUSangi": Device.IDFV,
            "PTUAnisodonti": Location.lp_longitude,
        ]
        return point
    }
    
    static func compressImage(orangeImg:UIImage) -> Data? {
        let maxL = 2 * 1024 * 1024
        var compress:CGFloat = 0.9
        let maxCompress:CGFloat = 0.1
        var imageData = orangeImg.jpegData(compressionQuality: compress)
        while (imageData?.count)! > maxL && compress > maxCompress {
            compress -= 0.1
            imageData = orangeImg.jpegData(compressionQuality: compress)
        }
        return imageData
    }
    
    static func getJsonFromDic(dict: [String: Any]) -> String {
        if (!JSONSerialization.isValidJSONObject(dict)) { return "" }
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return "" }
        guard let JSONString = String(data: data, encoding: .utf8) else { return "" }
        return JSONString
    }
    
    static func getJsonFromArray(array: [Any]) -> String {
        if (!JSONSerialization.isValidJSONObject(array)) { return "" }
        guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else { return "" }
        guard let JSONString = String(data: data, encoding: .utf8) else { return "" }
        return JSONString
    }
    
    static func jsonFromDic(dictionary: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let jsonStringWithoutSpaces = jsonString.replacingOccurrences(of: " ", with: "")
                    .replacingOccurrences(of: "\n", with: "")
                return jsonStringWithoutSpaces
            }
        } catch {
            print("Error serializing JSON: \(error)")
        }
        return nil
    }

    
}
