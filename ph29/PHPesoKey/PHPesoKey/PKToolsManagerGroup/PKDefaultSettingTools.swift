//
//  PKDefaultSettingTools.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import CryptoKit

let mainUpper:String = "https://api-29i.ph.dev.ksmdev.top/api"
let WebUpper:String = "https://api-29i.ph.dev.ksmdev.top"

let width_PK_bounds = UIScreen.main.bounds.size.width

let height_PK_bounds = UIScreen.main.bounds.size.height

let safe_PK_bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0

let safe_PK_top = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0

let PK_NaviH = safe_PK_top + 44

let PK_Scale =   (width_PK_bounds/375)


func  Helvetica_Bold(size:CGFloat) ->UIFont{
    let Helvetica_BoldSC = UIFont(name: "Helvetica-Bold", size: size)
    return Helvetica_BoldSC ?? UIFont.systemFont(ofSize: size, weight: .semibold)
}

func pKCheckString(with string:String?=nil) ->Bool{
    if string == nil{
        return false
    }
    if string!.isEmpty{
        return false
    }
    if  string == "" {
        return false
    }
    return true
}

 func pkUpDataDeviceinfo(){

     PKupLoadingManager.upload.loadPost(place: "/rsOxxCovalencyOdoCJ", dict:PKAppInfo.getPKAppDeviceInfo(),upping: false) { suc in
        
     } failed: { errorMsg in

     }
     
}


struct PKAppInfo {
  
   
   static var appInfoIdentifier: String {
       return  Bundle.main.bundleIdentifier ?? ""
    }
    
    static var appInfoDeviceName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2": return "iPhone 5"
        case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1", "iPhone9,3": return "iPhone 7"
        case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE (2nd generation)"
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPhone14,4": return "iPhone 13 mini"
        case "iPhone14,5": return "iPhone 13"
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
        case "iPhone14,6": return "iPhone SE (3rd generation)"
        case "iPhone14,7": return "iPhone 14"
        case "iPhone14,8": return "iPhone 14 Plus"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"
        case "iPhone15,4": return "iPhone 15"
        case "iPhone15,5": return "iPhone 15 Plus"
        case "iPhone16,1": return "iPhone 15 Pro"
        case "iPhone16,2": return "iPhone 15 Pro Max"
        case "iPhone17,1": return "iPhone 16"
        case "iPhone17,2": return "iPhone 16 Plus"
        case "iPhone17,3": return "iPhone 16 Pro"
        case "iPhone17,4": return "iPhone 16 Pro Max"

        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
        case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
        case "iPad5,3", "iPad5,4": return "iPad Air 2"
        case "iPad6,3", "iPad6,4": return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8": return "iPad Pro 12.9"

        case "i386", "x86_64", "arm64": return "Simulator"

        default: return identifier
        }
    }
    
    
    
    static var IDFV: String {
        let readIDFV =  PKAppInfo().pkAppInfoReadDataFromKeychain(service:PKAppInfo.appInfoIdentifier, account: "PKInfoIDFV")
        if let idfvData = readIDFV as? Data, let idfvStr = String(data: idfvData, encoding: .utf8) {
            return idfvStr
        }else {
            let idfv = UIDevice.current.identifierForVendor?.uuidString ?? ""
            _ =  PKAppInfo().pkAppInfoSaveDataToKeychain(data: idfv, service: PKAppInfo.appInfoIdentifier, account: "PKInfoIDFV")
            return idfv
        }
    }
   
     func pkAppInfoSaveDataToKeychain(data: String, service: String, account: String) -> OSStatus {
        
         let query: [String: Any] = [
             kSecClass as String: kSecClassGenericPassword,
             kSecAttrService as String: service,
             kSecAttrAccount as String: account,
             kSecValueData as String: data.data(using: .utf8)!
         ]

         return SecItemAdd(query as CFDictionary, nil)
     }


     
      func pkAppInfoReadDataFromKeychain(service: String, account: String) -> Any? {
         
         let query: [String: Any] = [
             kSecClass as String: kSecClassGenericPassword,
             kSecAttrService as String: service,
             kSecAttrAccount as String: account,
             kSecMatchLimit as String: kSecMatchLimitOne,
             kSecReturnData as String: kCFBooleanTrue!
         ]

        
         var result: AnyObject?
         let status = SecItemCopyMatching(query as CFDictionary, &result)
         if status == errSecSuccess {
             return result
         } else {
             return nil
         }
     }
    
    
    //可用存储大小
    static func freeDiskCapacity() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last ?? "") {
            if let free = dictionary[.systemFreeSize] as? NSNumber {
                let freeSize = free.uint64Value
                return String(format: "%.f", Double(freeSize))
            }
        }
        return "0"
    }
    
    //总存储大小
    static func totalDiskCapacity() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last ?? "") {
            if let total = dictionary[.systemSize] as? NSNumber {
                let totalSize = total.uint64Value
                return String(format: "%.f", Double(totalSize))
            }
        }
        return "0"
    }

    
    //总内存大小
    static func totalMemoryCapacity() -> String {
        return String(ProcessInfo.processInfo.physicalMemory)
    }
    
    //内存可用大小
    static func usedMemoryCapacity() -> String {
        var usedBytes: Int64 = 0
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        let kerr = withUnsafeMutablePointer(to: &info) { infoPtr -> kern_return_t in
            infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        if kerr == KERN_SUCCESS {
            usedBytes = Int64(info.resident_size)
        }
        return String(format: "%lld", usedBytes)
    }
    
    static func batteryChargeLevel() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return Int(UIDevice.current.batteryLevel * 100)
    }
    
    static func isDeviceFullyCharged() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .full ? 1 : 0
    }
    
    static func isDeviceCharging() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .charging ? 1 : 0
    }
    
    static func isSimulator() -> Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    
    static func isJailbroken() ->  Bool {
        let appPath = "/Applications/"
        if FileManager.default.fileExists(atPath: appPath),
           let apps = try? FileManager.default.contentsOfDirectory(atPath: appPath),
           !apps.isEmpty {
            return true
        }
        return false
    }
    
    static func isProxyServerEnabled() -> String {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else {
            return "0"
        }
        guard let dict = proxy as? [String: Any] else {
            return "0"
        }
        guard let HTTPProxy = dict["HTTPProxy"] as? String else {
            return "0"
        }
        return HTTPProxy.count > 0 ? "1" : "0"

    }
    
    static func isUsingVPN() -> String {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return "0" }
        guard let dict = proxy as? [String: Any] else { return "0" }
        guard let scopedDict = dict["__SCOPED__"] as? [String: Any] else { return "0" }
        for key in scopedDict.keys {
            if (key == "tap") || (key == "tun") || (key == "ppp") || (key == "ipsec") || (key == "ipsec0") {
                return "1"
            }
        }
        return "0"

    }
    
    static func pkAppLanguageCode() -> String {
        NSLocale.preferredLanguages.first?.components(separatedBy: "-").first ?? ""
    }
    
    static func pkAppIpAddress() -> String {
        var address = "127.0.0.1"
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                if let interface = ptr?.pointee,
                   interface.ifa_addr.pointee.sa_family == UInt8(AF_INET),
                   String(cString: interface.ifa_name) == "en0" {
                    address = String(cString: inet_ntoa((interface.ifa_addr.withMemoryRebound(to: sockaddr_in.self, capacity: 1) { $0 }).pointee.sin_addr))
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    static func wifiAddress() -> String {
        guard let dsfaeWEesd = CNCopySupportedInterfaces() else { return "" }
        guard let swiftInterfaces = (dsfaeWEesd as NSArray) as? [String] else { return "" }
        var BSSID: String = ""
        for interface in swiftInterfaces {
            guard let edfgfWWWW = CNCopyCurrentNetworkInfo(interface as CFString) else { return "" }
            guard let SSIDDict = (edfgfWWWW as NSDictionary) as? [String: AnyObject] else { return "" }
            guard let bssid = SSIDDict["BSSID"] as? String else { return "" }
            let stringArray = bssid.components(separatedBy: ":-")
            var hhsjTVDddud: String = ""
            stringArray.forEach { string in
                if string.count == 1 {
                    hhsjTVDddud += String(format: "0%@", string)
                } else {
                    hhsjTVDddud += string
                }
            }
            BSSID = hhsjTVDddud
        }
        return BSSID
    }
    
    static func wifiName() -> String {
        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else { return "" }
        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else { return "" }
        var SSID: String = ""
        for interface in swiftInterfaces {
            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else { return "" }
            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else { return "" }
            
            guard let ssid = SSIDDict["SSID"] as? String else { return "" }
            SSID = ssid
        }
        return SSID

    }
    
    static func getPKAppDeviceInfo() -> [String : Any] {
        return [
            "cLbagmrGersIMvPhVz":[
                                 "UtOFJikDeclarerQNnwksL": freeDiskCapacity(),
                                 "LlkevLyLemonyBaWAuWX": totalDiskCapacity(),
                                 "UgoKKrMMinionNdPpoVc": totalMemoryCapacity(),
                                 "bjwBGiPShipshapeNQLJtdk": usedMemoryCapacity()
                                ],
               "battery_status":[
                                 "qykoFYWExfiltrateXzqjzRh": batteryChargeLevel(),
                                 "battery" + "_status" : isDeviceFullyCharged(),
                                 "vxTRJzbCeresineFygbWwY": isDeviceCharging(),
                                ],
                    "hardware":[
                               "LeAIaiMElintNDUrzjf" : UIDevice.current.systemVersion,
                               "VNaWDQVSpielerFHNKqgv": "iPhone",
                               "ewVVpMwSyngarnyZfXitQe": appInfoDeviceName,
                               "CTGlAAILuzonSasbTyY": UIScreen.main.nativeBounds.size.height,
                               "fJpydolInformerInZDBdR": UIScreen.main.nativeBounds.size.width,
                               "RlzOsnhNuciformNuEDoMc": String(format: "%.0f", sqrt(UIScreen.main.nativeBounds.size.width*UIScreen.main.nativeBounds.size.width + UIScreen.main.nativeBounds.size.height*UIScreen.main.nativeBounds.size.height)),
                               "hSUPAepTigrisKuCcLLW": ""
                              ],
      "FmQPibCTruckerOxrbxLT":[:],
  "xhzHLGRUnmentionedIHRihox":[
                               "fiAaLYoSiratroHgAvRdk": 0,
                               "lSLQYIFGenbakushoMzyyFgg" : isSimulator() ? 1 : 0,
                               "vLJJFhVSadduceeTnYCRCn" : isJailbroken() ? 1 : 0
                              ],
      "QhPQIbNFrakturNAuMdCD":[
                               "xYgJklzAntibusingXWeKmzI":TimeZone.current.abbreviation() ?? "",
                               "bryBewoNjorthPEXTnKJ": isProxyServerEnabled() ,
                               "DJMPoBQJellyfishYkyyDxP": isUsingVPN(),
                               "auYDMPmExcerptaPbHLFHT": "",
                               "GQzSYrEPlaybusQZWzbrk": IDFV,
                               "aAmoJXfBaggerLhaZteJ": pkAppLanguageCode(),
                               "iBWjDeLCavernicolousUwUHwSL":PKupLoadingManager.upload.keeper,
                               "fyYyTzcEmblemCPyOlCJ": UIDevice.current.userInterfaceIdiom == .phone ? "1" : "2",
                               "BTwzPQLNseZAAFBkb":pkAppIpAddress(),
                               "yrFpRPwLaudablenessLKLGqMe": ""
                              ],
   "AOapVtxIngloriousDjLAFqw":[
                "lhjWmXyHejazTzycDgx":[
                    "xyLXBbPKiboshYdZuhVj":wifiAddress(),
                    "SGIVoDTSparinglyMgPZeVt":wifiName(),
                    "OIvexYQPetrologistRtWPEnA":wifiAddress(),
                    "ZCHfNtdEboniseOnEWitA":wifiName(),
                ]
            ]
        ]
    }
}



