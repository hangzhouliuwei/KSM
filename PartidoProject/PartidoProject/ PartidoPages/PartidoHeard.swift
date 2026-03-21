//
//  PartidoHeard.swift
//  PartidoProject
//
//  Created by Buller on 2025/1/21.
//
import KeychainAccess
@_exported import SwiftyJSON
@_exported import Kingfisher
@_exported import SnapKit
@_exported import IQKeyboardManagerSwift

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let safeAreaTop = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
let safeAreaBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
let navigationBarHeight = 44.0 + safeAreaTop
let screenScale =   (screenWidth/375.0)

func getAppTimeStr() -> String {
    
    let timestamp = Date().timeIntervalSince1970 * 1000
    return String(format: "%.0f", timestamp)
}

func appisNilString(_ string: String?) -> Bool {
    guard let str = string, !str.isEmpty else {
          return true
      }
    
      return false
}

func hexColor(_ hexString: String,alpha:CGFloat = 1.0) -> UIColor {
    var cleanString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if cleanString.hasPrefix("#") {
        cleanString.removeFirst()
    }
    guard cleanString.count == 6 else {
        print("Invalid hex string length: \(cleanString)")
        return .clear
    }
    var rgbValue: UInt64 = 0
    guard Scanner(string: cleanString).scanHexInt64(&rgbValue) else {
        print("Failed to scan hex string: \(cleanString)")
        return .clear
    }
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

func getAppVersion() -> String {
    
     Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
}

func getAppName() -> String{
    
    Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
}

func  getOSVersion() -> String{
    
    UIDevice.current.systemVersion
}

func getAppbundleId() ->String{
    Bundle.main.bundleIdentifier ?? ""
}

func getAppidfv() ->String{
    
    let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")
    var idfvStr = try? keychain.get(getAppbundleId())
    if idfvStr == nil || idfvStr == ""{
        idfvStr =  UIDevice.current.identifierForVendor?.uuidString ?? ""
        do { try keychain.set(idfvStr ?? "", key: getAppbundleId()) } catch {}
    }
    return idfvStr ?? ""
}


func getAppDeviceName() ->String{
    
    var systemInfo = utsname()
       uname(&systemInfo)
       let machine = withUnsafePointer(to: &systemInfo.machine) {
           $0.withMemoryRebound(to: CChar.self, capacity: 1) {
               String(cString: $0)
           }
       }
       
       let deviceMap: [String: String] = [
           "iPhone3,1": "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
           "iPhone4,1": "iPhone 4s",
           "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5 (GSM+CDMA)",
           "iPhone5,3": "iPhone 5c (GSM)", "iPhone5,4": "iPhone 5c (GSM+CDMA)",
           "iPhone6,1": "iPhone 5s (GSM)", "iPhone6,2": "iPhone 5s (GSM+CDMA)",
           "iPhone7,2": "iPhone 6", "iPhone7,1": "iPhone 6 Plus",
           "iPhone8,1": "iPhone 6s", "iPhone8,2": "iPhone 6s Plus", "iPhone8,4": "iPhone SE",
           "iPhone9,1": "iPhone 7", "iPhone9,2": "iPhone 7 Plus",
           "iPhone10,1": "iPhone 8", "iPhone10,2": "iPhone 8 Plus",
           "iPhone10,3": "iPhone X", "iPhone11,8": "iPhone XR",
           "iPhone11,2": "iPhone XS", "iPhone11,4": "iPhone XS Max", "iPhone11,6": "iPhone XS Max",
           "iPhone12,1": "iPhone 11", "iPhone12,3": "iPhone 11 Pro", "iPhone12,5": "iPhone 11 Pro Max",
           "iPhone12,8": "iPhone SE2", "iPhone13,1": "iPhone 12 mini",
           "iPhone13,2": "iPhone 12", "iPhone13,3": "iPhone 12 Pro", "iPhone13,4": "iPhone 12 Pro Max",
           "iPhone14,4": "iPhone 13 mini", "iPhone14,5": "iPhone 13",
           "iPhone14,2": "iPhone 13 Pro", "iPhone14,3": "iPhone 13 Pro Max",
           "iPhone14,7": "iPhone 14", "iPhone14,8": "iPhone 14 Plus",
           "iPhone15,2": "iPhone 14 Pro", "iPhone15,3": "iPhone 14 Pro Max",
           "iPhone15,4": "iPhone 15", "iPhone15,5": "iPhone 15 Plus",
           "iPhone16,1": "iPhone 15 Pro", "iPhone16,2": "iPhone 15 Pro Max",
           "iPhone17,1": "iPhone 16", "iPhone17,2": "iPhone 16 Plus",
           "iPhone17,3": "iPhone 16 Pro", "iPhone17,4": "iPhone 16 Pro Max",
           
           "iPad1,1": "iPad", "iPad1,2": "iPad 3G",
           "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
           "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
           "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
           "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
           "iPad6,3": "iPad Pro 9.7", "iPad6,4": "iPad Pro 9.7",
           "iPad6,7": "iPad Pro 12.9", "iPad6,8": "iPad Pro 12.9",
           
           "i386": "Simulator", "x86_64": "Simulator", "arm64": "Simulator"
       ]
       
       return deviceMap[machine] ?? machine
}

