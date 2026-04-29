//
//  XTDevice.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import AdSupport
import AppTrackingTransparency
import CoreTelephony
import Foundation
import SAMKeychain
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork
import UIKit

final class XTDevice {
    static let shared = XTDevice()
    private var firstTimeStorage: String?

    private init() {}

    // MARK: - Identity

    lazy var language: String = {
        (UserDefaults.standard.object(forKey: "AppleLanguages") as? [String])?.first ?? ""
    }()

    lazy var idfv: String = {
        let service = AppConstants.bundleId
        if let v = SAMKeychain.password(forService: service, account: "xt_idfv"), !v.isEmpty { return v }
        let v = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        SAMKeychain.setPassword(v, forService: service, account: "xt_idfv")
        return v
    }()

    lazy var uuid: String = {
        let service = AppConstants.bundleId
        if let v = SAMKeychain.password(forService: service, account: "xt_uuid"), !v.isEmpty { return v }
        let v = UUID().uuidString
        SAMKeychain.setPassword(v, forService: service, account: "xt_uuid")
        return v
    }()

    // MARK: - System Info

    lazy var sysVersion: String = UIDevice.current.systemVersion

    lazy var mobileStyle: String = {
        var info = utsname(); uname(&info)
        let id = Mirror(reflecting: info.machine).children.reduce(into: "") { r, c in
            guard let v = c.value as? Int8, v != 0 else { return }
            r.append(String(UnicodeScalar(UInt8(v))))
        }
        if let url = Bundle.main.url(forResource: "XTMobile.plist", withExtension: nil),
           let dict = NSDictionary(contentsOf: url), let model = dict[id] {
            return XT_Object_To_Stirng(model)
        }
        return id
    }()

    lazy var usableDiskSize: String = {
        let a = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return XT_Object_To_Stirng(a?[.systemFreeSize])
    }()

    lazy var totalDiskSize: String = {
        let a = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return XT_Object_To_Stirng(a?[.systemSize])
    }()

    lazy var usableMemorySize: String = {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        let r: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        return r == KERN_SUCCESS ? "\(info.resident_size)" : "0"
    }()

    lazy var totalMemorySize: String = "\(ProcessInfo.processInfo.physicalMemory)"

    var usableQuantity: String {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return String(format: "%.2f", UIDevice.current.batteryLevel * 100)
    }

    var isFullQuantity: String {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .full ? "1" : "0"
    }

    var isCharging: String {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .charging ? "1" : "0"
    }

    lazy var screenHeight: Double = Double(UIScreen.main.nativeBounds.height)
    lazy var screenWidth: Double = Double(UIScreen.main.nativeBounds.width)

    lazy var physicalSize: String = {
        String(format: "%.1f", sqrt(screenWidth * screenWidth + screenHeight * screenHeight))
    }()

    lazy var deliveryTime: TimeInterval = {
        let a = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return (a?[.creationDate] as? Date)?.timeIntervalSince1970 ?? 0
    }()

    lazy var isSimulator: String = {
        #if targetEnvironment(simulator)
        return "1"
        #else
        return "0"
        #endif
    }()

    lazy var localTimeZone: String = TimeZone.current.abbreviation() ?? ""

    var networkType: String {
        let mgr = NetworkReachabilityManager.shared
        return mgr.isReachableViaWiFi ? "wifi" : (mgr.isReachableViaWWAN ? "4g" : "")
    }

    var isProxy: String {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue(),
              let proxies = CFNetworkCopyProxiesForURL(URL(string: "http://www.google.com")! as CFURL, settings)
                .takeRetainedValue() as? [[AnyHashable: Any]],
              let type = proxies.first?[kCFProxyTypeKey as String] as? String else { return "0" }
        return type == (kCFProxyTypeNone as String) ? "0" : "1"
    }

    var isVPN: String {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let scoped = settings["__SCOPED__"] as? [String: Any] else { return "0" }
        return scoped.keys.contains { $0.contains("tap") || $0.contains("tun") || $0.contains("ipsec") || $0.contains("ppp") } ? "1" : "0"
    }

    var phoneOperator: String {
        let p = CTTelephonyNetworkInfo().subscriberCellularProvider
        return p?.isoCountryCode == nil ? "" : (p?.carrierName ?? "")
    }

    // MARK: - First App Time

    func firstAppTime() -> String {
        if firstTimeStorage == nil {
            let service = AppConstants.bundleId
            if let v = SAMKeychain.password(forService: service, account: "firstAppTime"), !v.isEmpty {
                firstTimeStorage = v
            } else {
                firstTimeStorage = "\(UInt64(Date().timeIntervalSince1970))000"
                SAMKeychain.setPassword(firstTimeStorage ?? "", forService: service, account: "xt_firstAppTime")
            }
        }
        return firstTimeStorage ?? ""
    }

    // MARK: - Network Check

    func checkNetwork(_ completion: @escaping (Bool) -> Void) {
        NetworkReachabilityManager.shared.startMonitoring(completion: completion)
    }

    // MARK: - IDFA

    func getIDFA(showAlert: Bool, completion: @escaping (String) -> Void) {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : "")
                }
            }
        } else {
            let idfa = ASIdentifierManager.shared().isAdvertisingTrackingEnabled
                ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : ""
            completion(idfa)
        }
    }

    // MARK: - Device Info Dictionary (for /device API)

    func deviceInfoDictionary() -> [String: Any] {
        var idfa = ""
        getIDFA(showAlert: false) { idfa = $0 }

        let storage: [String: Any] = [
            "chyssixalidesNc": usableDiskSize,
            "ebdisixcNc": totalDiskSize,
            "sclisixmazelNc": totalMemorySize,
            "hiacsixkNc": usableMemorySize
        ]
        let battery: [String: Any] = [
            "delasixsseNc": usableQuantity,
            "battery_status": isFullQuantity,
            "akavsixitNc": isCharging
        ]
        let hardware: [String: Any] = [
            "xeotsiximeNc": sysVersion,
            "prtusixbercularNc": "iPhone",
            "bauvsixrihiNc": mobileStyle,
            "pemesixanceNc": screenHeight,
            "sttusixsNc": screenWidth,
            "soensixoidNc": physicalSize,
            "terasixNc": deliveryTime
        ]
        let signal: [String: Any] = [
            "brezsixinessNc": "0",
            "deissixableNc": isSimulator,
            "sinmsixanNc": 0
        ]
        let carrier: [String: Any] = [
            "ovresixxertNc": localTimeZone,
            "pltisixniferousNc": isProxy,
            "sumesixrgibleNc": isVPN,
            "conssixellorNc": phoneOperator,
            "manisixcideNc": idfv,
            "tuedsixoNc": language,
            "leelsixlingNc": networkType,
            "bahlsixykNc": 1,
            "patusixrageNc": idfa
        ]
        let wifi: [String: Any] = [
            "mitisixmeNc": bssidString() ?? "",
            "frscsixatiNc": wifiName() ?? "",
            "koobsixehNc": bssidString() ?? "",
            "uporsixnNc": wifiName() ?? ""
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

    // MARK: - WiFi Helpers

    private func bssidString() -> String? {
        currentWiFiInfo(key: "BSSID").map { formattedMAC($0) }
    }

    private func wifiName() -> String? {
        currentWiFiInfo(key: "SSID")
    }

    private func currentWiFiInfo(key: String) -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else { return nil }
        for iface in interfaces {
            if let info = CNCopyCurrentNetworkInfo(iface as CFString) as? [String: Any],
               let v = info[key] as? String { return v }
        }
        return nil
    }

    private func formattedMAC(_ mac: String) -> String {
        mac.components(separatedBy: CharacterSet(charactersIn: ":-"))
            .map { $0.count == 1 ? "0\($0)" : $0 }
            .joined(separator: ":").uppercased()
    }
}

// MARK: - Network Reachability (replaces AFNetworkReachabilityManager)

final class NetworkReachabilityManager {
    static let shared = NetworkReachabilityManager()
    private var reachability: SCNetworkReachability?
    private(set) var isReachableViaWiFi = false
    private(set) var isReachableViaWWAN = false
    var isReachable: Bool { isReachableViaWiFi || isReachableViaWWAN }

    private init() {
        reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    }

    func startMonitoring(completion: @escaping (Bool) -> Void) {
        guard let r = reachability else { completion(false); return }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(r, &flags)
        let reachable = flags.contains(.reachable) && !flags.contains(.connectionRequired)
        isReachableViaWiFi = reachable && !flags.contains(.isWWAN)
        isReachableViaWWAN = reachable && flags.contains(.isWWAN)
        DispatchQueue.main.async { completion(reachable) }
    }
}

// MARK: - Legacy shim

extension XTDevice {
    // Keep old call sites compiling while migration proceeds
    static func xt_share() -> XTDevice { shared }
    static func xt_getIdfaShowAlt(_ show: Bool, block: ((String) -> Void)?) {
        shared.getIDFA(showAlert: show) { block?($0) }
    }
    @available(iOS 14.0, *)
    static func fixTrackingAuthorization(completion: ((ATTrackingManager.AuthorizationStatus) -> Void)?) {
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async { completion?(status) }
        }
    }
    var xt_idfv: String { idfv }
    var xt_sysVersion: String { sysVersion }
    var xt_mobileStyle: String { mobileStyle }
    func xt_checkNetWork(_ block: ((Bool) -> Void)?) { checkNetwork { block?($0) } }
    func xt_deviceInfoDic() -> NSDictionary { deviceInfoDictionary() as NSDictionary }
}
