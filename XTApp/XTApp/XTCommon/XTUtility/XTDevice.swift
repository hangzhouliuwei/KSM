//
//  XTDevice.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import AdSupport
import AFNetworking
import AppTrackingTransparency
import CoreTelephony
import Foundation
import SAMKeychain
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork
import UIKit

@objcMembers
@objc(XTDevice)
class XTDevice: NSObject {
    private static let shared = XTDevice()
    private var firstTimeStorage: String?

    dynamic lazy var xt_language: String = {
        (UserDefaults.standard.object(forKey: "AppleLanguages") as? [String])?.first ?? ""
    }()

    dynamic lazy var xt_idfv: String = {
        let service = XT_App_BundleId
        if let value = SAMKeychain.password(forService: service, account: "xt_idfv"), !value.isEmpty {
            return value
        }
        let value = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        SAMKeychain.setPassword(value, forService: service, account: "xt_idfv")
        return value
    }()

    dynamic lazy var xt_uuid: String = {
        let service = XT_App_BundleId
        if let value = SAMKeychain.password(forService: service, account: "xt_uuid"), !value.isEmpty {
            return value
        }
        let value = UUID().uuidString
        SAMKeychain.setPassword(value, forService: service, account: "xt_uuid")
        return value
    }()

    dynamic var xt_networkType: String {
        AFNetworkReachabilityManager.shared().isReachableViaWiFi ? "wifi" : (AFNetworkReachabilityManager.shared().isReachableViaWWAN ? "4g" : "")
    }

    dynamic lazy var xt_sysVersion: String = UIDevice.current.systemVersion

    dynamic lazy var xt_mobileStyle: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        let identifier = mirror.children.reduce(into: "") { result, child in
            guard let value = child.value as? Int8, value != 0 else { return }
            result.append(String(UnicodeScalar(UInt8(value))))
        }
        if let url = Bundle.main.url(forResource: "XTMobile.plist", withExtension: nil),
           let dictionary = NSDictionary(contentsOf: url),
           let model = dictionary[identifier] {
            return XT_Object_To_Stirng(model)
        }
        return identifier
    }()

    dynamic lazy var xt_usableDiskSize: String = {
        let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return XT_Object_To_Stirng(attributes?[.systemFreeSize])
    }()

    dynamic lazy var xt_totalDiskSize: String = {
        let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return XT_Object_To_Stirng(attributes?[.systemSize])
    }()

    dynamic lazy var xt_usableMemorySize: String = {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        let result: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        guard result == KERN_SUCCESS else { return "0" }
        return "\(info.resident_size)"
    }()

    dynamic lazy var xt_totalMemorySize: String = "\(ProcessInfo.processInfo.physicalMemory)"

    dynamic var xt_usableQuantity: String {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return String(format: "%.2f", UIDevice.current.batteryLevel * 100)
    }

    dynamic var xt_isFullQuantity: String {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .full ? "1" : "0"
    }

    dynamic var xt_isCharging: String {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .charging ? "1" : "0"
    }

    dynamic lazy var xt_screenHeight: NSNumber = NSNumber(value: Double(UIScreen.main.nativeBounds.height))
    dynamic lazy var xt_screenWidth: NSNumber = NSNumber(value: Double(UIScreen.main.nativeBounds.width))

    dynamic lazy var xt_physicalSize: String = {
        let width = xt_screenWidth.doubleValue
        let height = xt_screenHeight.doubleValue
        return String(format: "%.1f", sqrt(width * width + height * height))
    }()

    dynamic lazy var xt_deliveryTime: NSNumber = {
        let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        if let date = attributes?[.creationDate] as? Date {
            return NSNumber(value: date.timeIntervalSince1970)
        }
        return 0
    }()

    dynamic lazy var xt_simulator: String = {
        #if targetEnvironment(simulator)
        return "1"
        #else
        return "0"
        #endif
    }()

    dynamic lazy var xt_localTimeZone: String = TimeZone.current.abbreviation() ?? ""

    dynamic var xt_isProxy: String {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue(),
              let proxies = CFNetworkCopyProxiesForURL(URL(string: "http://www.google.com")! as CFURL, settings).takeRetainedValue() as? [[AnyHashable: Any]],
              let first = proxies.first,
              let type = first[kCFProxyTypeKey as String] as? String else {
            return "0"
        }
        return type == kCFProxyTypeNone as String ? "0" : "1"
    }

    dynamic var xt_isVPN: String {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let scoped = settings["__SCOPED__"] as? [String: Any] else {
            return "0"
        }
        let keys = scoped.keys
        let found = keys.contains { key in
            key.contains("tap") || key.contains("tun") || key.contains("ipsec") || key.contains("ppp")
        }
        return found ? "1" : "0"
    }

    dynamic var xt_phoneOperator: String {
        let provider = CTTelephonyNetworkInfo().subscriberCellularProvider
        return provider?.isoCountryCode == nil ? "" : (provider?.carrierName ?? "")
    }

    dynamic var xt_ipAddress: String {
        guard let url = URL(string: "https://pv.sohu.com/cityjson?ie=utf-8"),
              var string = try? String(contentsOf: url, encoding: .utf8),
              string.hasPrefix("var returnCitySN = ") else {
            return ""
        }
        string.removeFirst("var returnCitySN = ".count)
        if string.hasSuffix(";") {
            string.removeLast()
        }
        guard let data = string.data(using: .utf8),
              let dic = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return ""
        }
        return dic["cip"] as? String ?? ""
    }

    @objc class func xt_share() -> XTDevice {
        shared
    }

    @objc(xt_checkNetWork:)
    func xt_checkNetWork(_ block: XTBoolBlock?) {
        let manager = AFNetworkReachabilityManager.shared()
        manager.startMonitoring()
        manager.setReachabilityStatusChange { status in
            switch status {
            case .reachableViaWiFi, .reachableViaWWAN:
                block?(true)
            default:
                block?(false)
            }
        }
    }

    @available(iOS 14.0, *)
    @objc(xt_requestTrackingAuthorizationWithCompletion:)
    class func xt_requestTrackingAuthorization(completion: ((ATTrackingManager.AuthorizationStatus) -> Void)?) {
        ATTrackingManager.requestTrackingAuthorization { status in
            if status == .denied && ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                if #available(iOS 15.0, *) {
                    var observer: NSObjectProtocol?
                    observer = NotificationCenter.default.addObserver(
                        forName: UIApplication.didBecomeActiveNotification,
                        object: nil,
                        queue: nil
                    ) { _ in
                        if let observer {
                            NotificationCenter.default.removeObserver(observer)
                        }
                        xt_requestTrackingAuthorization(completion: completion)
                    }
                }
            } else {
                completion?(status)
            }
        }
    }

    @objc(xt_getIdfaShowAlt:block:)
    class func xt_getIdfaShowAlt(_ showAlt: Bool, block: ((String) -> Void)?) {
        if #available(iOS 14.0, *) {
            xt_requestTrackingAuthorization { status in
                if status == .authorized {
                    block?(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                } else {
                    block?("")
                    if showAlt {
                        XTLog("请在设置-隐私-跟踪中允许App请求跟踪")
                    }
                }
            }
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                block?(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
            } else {
                block?("")
                if showAlt {
                    XTLog("请在设置-隐私-广告中打开广告跟踪功能")
                }
            }
        }
    }

    @objc func xt_firstAppTime() -> String {
        if firstTimeStorage == nil {
            let service = XT_App_BundleId
            if let value = SAMKeychain.password(forService: service, account: "firstAppTime"), !value.isEmpty {
                firstTimeStorage = value
            } else {
                firstTimeStorage = "\(UInt64(Date().timeIntervalSince1970))000"
                SAMKeychain.setPassword(firstTimeStorage ?? "", forService: service, account: "xt_firstAppTime")
            }
        }
        return firstTimeStorage ?? ""
    }

    @objc func xt_deviceInfoDic() -> NSDictionary {
        let storage: [String: Any] = [
            "chyssixalidesNc": XT_Object_To_Stirng(xt_usableDiskSize),
            "ebdisixcNc": XT_Object_To_Stirng(xt_totalDiskSize),
            "sclisixmazelNc": XT_Object_To_Stirng(xt_totalMemorySize),
            "hiacsixkNc": XT_Object_To_Stirng(xt_usableMemorySize)
        ]
        let battery: [String: Any] = [
            "delasixsseNc": XT_Object_To_Stirng(xt_usableQuantity),
            "battery_status": XT_Object_To_Stirng(xt_isFullQuantity),
            "akavsixitNc": XT_Object_To_Stirng(xt_isCharging)
        ]
        let hardware: [String: Any] = [
            "xeotsiximeNc": XT_Object_To_Stirng(xt_sysVersion),
            "prtusixbercularNc": "iPhone",
            "bauvsixrihiNc": XT_Object_To_Stirng(xt_mobileStyle),
            "pemesixanceNc": xt_screenHeight,
            "sttusixsNc": xt_screenWidth,
            "soensixoidNc": XT_Object_To_Stirng(xt_physicalSize),
            "terasixNc": xt_deliveryTime
        ]
        let signal: [String: Any] = [
            "brezsixinessNc": "0",
            "deissixableNc": XT_Object_To_Stirng(xt_simulator),
            "sinmsixanNc": 0
        ]
        let carrier = NSMutableDictionary(dictionary: [
            "ovresixxertNc": XT_Object_To_Stirng(xt_localTimeZone),
            "pltisixniferousNc": XT_Object_To_Stirng(xt_isProxy),
            "sumesixrgibleNc": XT_Object_To_Stirng(xt_isVPN),
            "conssixellorNc": XT_Object_To_Stirng(xt_phoneOperator),
            "manisixcideNc": XT_Object_To_Stirng(xt_idfv),
            "tuedsixoNc": XT_Object_To_Stirng(xt_language),
            "leelsixlingNc": XT_Object_To_Stirng(xt_networkType),
            "bahlsixykNc": 1,
            "deodsixulateNc": XT_Object_To_Stirng(xt_ipAddress)
        ])
        XTDevice.xt_getIdfaShowAlt(false) { idfa in
            carrier["patusixrageNc"] = XT_Object_To_Stirng(idfa)
        }
        let wifi: [String: Any] = [
            "mitisixmeNc": XT_Object_To_Stirng(xt_bssidString()),
            "frscsixatiNc": XT_Object_To_Stirng(xt_wifiName()),
            "koobsixehNc": XT_Object_To_Stirng(xt_bssidString()),
            "uporsixnNc": XT_Object_To_Stirng(xt_wifiName())
        ]
        return [
            "zoaisixsmNc": storage,
            "battery_status": battery,
            "hardware": hardware,
            "cochsixNc": [:],
            "watysixNc": signal,
            "rencsixounterNc": carrier,
            "eatesixrnizeNc": ["parisixcentricNc": [wifi]]
        ]
    }

    private func xt_bssidString() -> String? {
        currentWiFiInfo(key: "BSSID").map { xt_getFormateMAC($0) }
    }

    private func xt_wifiName() -> String? {
        currentWiFiInfo(key: "SSID")
    }

    private func currentWiFiInfo(key: String) -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else { return nil }
        for interface in interfaces {
            guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                  let value = info[key] as? String else { continue }
            return value
        }
        return nil
    }

    private func xt_getFormateMAC(_ mac: String) -> String {
        mac.components(separatedBy: CharacterSet(charactersIn: ":-")).map { part in
            part.count == 1 ? "0\(part)" : part
        }.joined(separator: ":").uppercased()
    }

    @available(iOS 14.0, *)
    @objc(fixTrackingAuthorizationWithCompletion:)
    class func fixTrackingAuthorization(completion: ((ATTrackingManager.AuthorizationStatus) -> Void)?) {
        ATTrackingManager.requestTrackingAuthorization { status in
            if status == .denied && ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                if #available(iOS 15.0, *) {
                    var observer: NSObjectProtocol?
                    observer = NotificationCenter.default.addObserver(
                        forName: UIApplication.didBecomeActiveNotification,
                        object: nil,
                        queue: .main
                    ) { _ in
                        if let observer {
                            NotificationCenter.default.removeObserver(observer)
                        }
                        fixTrackingAuthorization(completion: completion)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion?(status)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion?(status)
                }
            }
        }
    }
}
