//
//  DeviceExt.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import CoreTelephony

let Device = UIDevice.current

extension UIDevice{
    
    var appVersion: String{
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    var appName: String{
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
    
    var bundleId: String{
        Bundle.main.bundleIdentifier ?? ""
    }
    
    var IDFV: String{
        if let idfv = LPKaychainTools.getValueWithKey(key: GoogleMarketID),!isBlank(idfv){
            return idfv
        }
        let idfv =  UIDevice.current.identifierForVendor?.uuidString ?? ""
        LPKaychainTools.save(value: idfv, withKey: GoogleMarketID)
        return idfv
    }
    
    var batteryNumber: Int{
        UIDevice.current.isBatteryMonitoringEnabled = true
        return Int(ceilf(Device.batteryLevel*100))
    }
    
    var isFull: Bool{
        UIDevice.current.batteryState == .full
    }
    
    var isCharging: Bool{
        UIDevice.current.batteryState == .charging
    }
    
    var language: String {
        var languageStr:String = ""
        if let preferredLanguage = NSLocale.preferredLanguages.first {
            if let language = preferredLanguage.components(separatedBy: "-").first {
                languageStr = language
            }
        }
        return languageStr
    }
    
    var timeZone:String{
        TimeZone.current.abbreviation() ?? ""
    }
    
    // wifi name
    var SSID: String {
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
    
    //mac address
    var BSSID: String {
        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else { return "" }
        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else { return "" }
        var BSSID: String = ""
        for interface in swiftInterfaces {
            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else { return "" }
            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else { return "" }
            guard let bssid = SSIDDict["BSSID"] as? String else { return "" }
            let stringArray = bssid.components(separatedBy: ":-")
            var tempBSSID: String = ""
            stringArray.forEach { string in
                if string.count == 1 {
                    tempBSSID += String(format: "0%@", string)
                } else {
                    tempBSSID += string
                }
            }
            BSSID = tempBSSID
        }
        return BSSID
    }
    
    // SIM Operator
    var mobileOperator: String {
        let info = CTTelephonyNetworkInfo()
        var supplier: String = ""
        if #available(iOS 12.0, *) {
            if let carriers = info.serviceSubscriberCellularProviders {
                if carriers.keys.count == 0 {
                    return ""
                } else {
                    for (index, carrier) in carriers.values.enumerated() {
                        guard carrier.carrierName != nil else { return "" }
                        if index == 0 {
                            supplier = carrier.carrierName!
                        } else {
                            supplier = supplier + "," + carrier.carrierName!
                        }
                    }
                    return supplier
                }
            } else{
                return ""
            }
        } else {
            if let carrier = info.subscriberCellularProvider {
                guard carrier.carrierName != nil else { return "" }
                return carrier.carrierName!
            } else{
                return ""
            }
        }
    }
    
    // IP
    var IP: String {
        let networkType = UIDevice.current.networkType
        switch networkType {
        case "WIFI":
            return UIDevice.current.WifiIP
        default:
            return UIDevice.current.operatorsIP
        }
    }
    
    var WifiIP: String {
        var address: String = ""
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else { return address }
        guard let firstAddr = ifaddr else { return address }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            // Check for IPV4 or IPV6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    // Convert interface address to a human readable string
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
    
    var operatorsIP: String {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP | IFF_RUNNING | IFF_LOOPBACK )) == (IFF_UP | IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8: hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        if let ipStr = addresses.first {
            return ipStr
        } else {
            return ""
        }
    }
    
    var totalDiskSize: Int64 {
        var fs = UIDevice.blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
        }
        return 0
    }
    
    var availableDiskSize: Int64 {
        var fs = UIDevice.blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_bavail)
        }
        return 0
    }
    
    var totalMemorySize: Int64 {
        return Int64(ProcessInfo.processInfo.physicalMemory)
    }
    
    var availableMemorySize: Int64 {
        let hostPort: mach_port_t = mach_host_self()
        let HOST_BASIC_INFO_COUNT = MemoryLayout<vm_statistics_data_t>.stride/MemoryLayout<integer_t>.stride
        var host_size = mach_msg_type_number_t(HOST_BASIC_INFO_COUNT)
        var pagesize: vm_size_t = 0
        host_page_size(hostPort, &pagesize)
        var vmStat: vm_statistics = vm_statistics_data_t()
        let tempVmStat = vmStat
        let status: kern_return_t = withUnsafeMutableBytes(of: &vmStat) {
            let boundPtr = $0.baseAddress?.bindMemory(to: Int32.self, capacity: MemoryLayout.size(ofValue: tempVmStat) / MemoryLayout<Int32>.stride)
            return host_statistics(hostPort, HOST_VM_INFO, boundPtr, &host_size)
        }
        if status == KERN_SUCCESS {
            let usedMemory: Int64 = Int64((vm_size_t)(vmStat.active_count + vmStat.inactive_count + vmStat.wire_count
            ) * pagesize)
            let totalMemory: Int64 = Int64(ProcessInfo.processInfo.physicalMemory)
            return totalMemory - usedMemory
        }
        return 0
    }
    
    
    var isJailbroken: Bool {
        let appPath = "/Applications/"
        if FileManager.default.fileExists(atPath: appPath) {
            if let apps = try? FileManager.default.contentsOfDirectory(atPath: appPath) {
                if !apps.isEmpty {
                    return true
                }
            }
        }
        return false
    }
    
    var modeType: String{
        (Device.userInterfaceIdiom == .phone) ? "1" : ((Device.userInterfaceIdiom == .pad) ? "2" : "")
    }
    
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    var WANIP: String {
        let ipURL = URL(string: "http://pv.sohu.com/cityjson?ie=utf-8")
        var ip: String = ""
        do {
            if let ipURL {
                ip = try String(contentsOf: ipURL, encoding: .utf8)
            }
        } catch {
            print("k-- WANIP:\(error)")
        }
        if ip.hasPrefix("var returnCitySN = ") {
            let range = NSRange(location: 0, length: 19)
            if let subRange = Range<String.Index>(range, in: ip) {
                ip.removeSubrange(subRange)
            }
            let nowIp = NSString(string: ip).substring(to: ip.count - 1)
            let data = nowIp.data(using: .utf8)
            var dict: [String: Any] = [:]
            do {
                if let data {
                    let object = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let tempDict = object as? [String: Any] {
                        dict = tempDict
                    }
                }
            } catch {
                print("k-- WANIP:\(error)")
            }
            if let cip = dict["cip"] as? String {
                return cip
            }
        }
        return ""
    }
    
    
    var isOpenProxy: Bool {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        guard let dict = proxy as? [String: Any] else { return false }
        guard let HTTPProxy = dict["HTTPProxy"] as? String else { return false }
        return HTTPProxy.count > 0
    }
    
    
    var isOpenVPN: Bool {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        guard let dict = proxy as? [String: Any] else { return false }
        guard let scopedDict = dict["__SCOPED__"] as? [String: Any] else { return false }
        for key in scopedDict.keys {
            if (key == "tap") || (key == "tun") || (key == "ppp") || (key == "ipsec") || (key == "ipsec0") {
                return true
            }
        }
        return false
    }
    
    // 2G、3G、4G、5G、WIFI、OTHER、NONE
    var networkType: String {
        var zeroAddress = sockaddr_storage()
        bzero(&zeroAddress, MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_len = __uint8_t(MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { address in
                SCNetworkReachabilityCreateWithAddress(nil, address)
            }
        }
        guard let defaultRouteReachability = defaultRouteReachability else { return "NONE" }
        var flags = SCNetworkReachabilityFlags()
        let didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        guard didRetrieveFlags && flags.contains(.reachable) && !flags.contains(.connectionRequired) else { return "NONE" }
        if flags.contains(.isWWAN) {
            return UIDevice.current.cellularType
        } else {
            return "WIFI"
        }
    }
    
    var cellularType: String {
        let info = CTTelephonyNetworkInfo()
        var status: String
        if #available(iOS 12.0, *) {
            guard let dict = info.serviceCurrentRadioAccessTechnology, let firstKey = dict.keys.first, let tempStatus = dict[firstKey] else { return "NONE" }
            status = tempStatus
        } else {
            guard let tempStatus = info.currentRadioAccessTechnology else { return "NONE" }
            status = tempStatus
        }
        if #available(iOS 14.1, *) {
            if (status == CTRadioAccessTechnologyNR) || (status == CTRadioAccessTechnologyNRNSA) {
                return "5G"
            }
        }
        switch status {
        case CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyCDMA1x:
            return "2G"
        case CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyHSUPA,
             CTRadioAccessTechnologyeHRPD,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB:
            return "3G"
        case CTRadioAccessTechnologyLTE:
            return "4G"
        default:
            return "OTHER"
        }
    }
  
    static func blankof<T>(type:T.Type) -> T {
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
        let val = ptr.pointee
        return val
    }
    
    
    var modelName: String{
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":   return "Apple TV 4"
            
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":   return "iPod Touch 6"
        case "iPod9,1":   return "iPod Touch 7"
            
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "iPad6,11", "iPad6,12":  return "iPad 5"
        case "iPad7,1", "iPad7,2":  return "iPad Pro 12.9 inch 2nd gen"
        case "iPad7,3", "iPad7,4":  return "iPad Pro 10.5 inch"
        case "iPad7,5", "iPad7,6":  return "iPad 6"
        case "iPad7,11", "iPad7,12":  return "iPad 7"
        case "iPad8,1 ~ 8,4":  return "iPad Pro 11-inch"
        case "iPad8,5 ~ 8,8":  return "iPad Pro 12.9-inch 3rd gen"
        case "iPad8,9 ~ 8,10":  return "iPad Pro 11-inch 2nd gen"
        case "iPad8,11 ~ 8,12":  return "iPad Pro 12.9-inch 4th gen"
        case "iPad11,1", "iPad11,2":  return "iPad Mini 5"
        case "iPad11,3", "iPad11,4":  return "iPad Air 3"
        case "iPad11,6", "iPad11,7":  return "iPad 8"
        case "iPad12,1", "iPad12,2":  return "iPad 9"
        case "iPad13,1", "iPad13,2":  return "iPad Air 4"
        case "iPad14,1", "iPad14,2":  return "iPad Mini 6"
        case "iPad13,4 ~ 13,7":return "iPad Pro 11-inch 3nd gen"
        case "iPad13,8 ~ 13,11":return "iPad Pro 12.9-inch 5th gen"
        case "iPad13,16","iPad13,17":return "iPad Air 5"
        case "iPad13,18","iPad13,19":return "iPad 10"
        case "iPad14,3 ~ 14,4":return "iPad Pro 11-inch 4th gen"
        case "iPad14,5 ~ 14,6":return "iPad Pro 12.9-inch 6th gen"
   
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":   return "iPhone 7"
        case "iPhone9,2":  return "iPhone 7 Plus"
        case "iPhone9,3":  return "iPhone 7"
        case "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        case "iPhone11,8":  return "iPhone XR"
        case "iPhone11,2":  return "iPhone XS"
        case "iPhone11,6", "iPhone11,4":    return "iPhone XS Max"
        case "iPhone12,1":  return "iPhone 11"
        case "iPhone12,3":  return "iPhone 11 Pro"
        case "iPhone12,5":  return "iPhone 11 Pro Max"
        case "iPhone12,8":  return "iPhone SE2"
        case "iPhone13,1":  return "iPhone 12 mini"
        case "iPhone13,2":  return "iPhone 12"
        case "iPhone13,3":  return "iPhone 12 Pro"
        case "iPhone13,4":  return "iPhone 12 Pro Max"
        case "iPhone14,4":  return "iPhone 13 mini"
        case "iPhone14,5":  return "iPhone 13"
        case "iPhone14,2":  return "iPhone 13 Pro"
        case "iPhone14,3":  return "iPhone 13 Pro Max"
        case "iPhone14,7":  return "iPhone 14"
        case "iPhone14,8":  return "iPhone 14 Plus"
        case "iPhone15,2":  return "iPhone 14 Pro"
        case "iPhone15,3":  return "iPhone 14 Pro Max"
        case "iPhone15,4":  return "iPhone 15"
        case "iPhone15,5":  return "iPhone 15 Plus"
        case "iPhone16,1":  return "iPhone 15 Pro"
        case "iPhone16,2":  return "iPhone 15 Pro Max"
        case "iPhone17,1":  return "iPhone 16"
        case "iPhone17,2":  return "iPhone 16 Plus"
        case "iPhone17,3":  return "iPhone 16 Pro"
        case "iPhone17,4":  return "iPhone 16 Pro Max"
            
        case "i386","x86_64":   return "Simulator"
            
        default:  return identifier
        }
    }
    
    var screenHeight: CGFloat{
        UIScreen.main.nativeBounds.size.height
    }
    
    var screenWidth: CGFloat{
        UIScreen.main.nativeBounds.size.width
    }
    
    var physicalDimensions: String{
        let width = screenWidth
        let height = screenHeight
        let physical = sqrt(width * width + height * height)
        return String(format: "%.0f", physical)
    }
    
    var deviceAbsoluteTime: TimeInterval {
        if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let creationDate = systemAttributes[.creationDate] as? Date {
                return creationDate.timeIntervalSince1970
            }
        }
        return 0
    }
    
    
    var topSafe: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else { return 0 }
        guard let window = windowScene.windows.first else { return 0 }
        return window.safeAreaInsets.top
    }
    

    var bottomSafe: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else { return 0 }
        guard let window = windowScene.windows.first else { return 0 }
        return window.safeAreaInsets.bottom
    }
    
    
    var topBar: CGFloat {
        var statusBarHeight: CGFloat = 0
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else { return 0 }
        guard let statusBarManager = windowScene.statusBarManager else { return 0 }
        statusBarHeight = statusBarManager.statusBarFrame.height
        return statusBarHeight
    }
    
    
    var topNavi: CGFloat {
        return 44.0
    }
    
    var topNaviBar: CGFloat {
        return Device.topBar + Device.topNavi
    }
    
}
