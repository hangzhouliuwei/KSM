//
//  PKUserManager.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/13.
//

import UIKit

struct PKUserManager {
    
    static var sessionid:String {
        get{
            return UserDefaults.standard.string(forKey: "vEQlLmrCarcanetXvNyGgb") ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "vEQlLmrCarcanetXvNyGgb")
        }
        
    }
    
    static var phone:String {
        get{
            return UserDefaults.standard.string(forKey: "ocFehOsUrethrotomyMFdQkGM") ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "ocFehOsUrethrotomyMFdQkGM")
        }
        
    }
    
    static func pkisLogin() -> Bool {
        return !sessionid.isEmpty
    }
    
    static func pkgotoLogin() {
        cleanUserInfo()
        let nav = UIApplication.shared.windows.first?.rootViewController as! UINavigationController
        let topPage = nav.topViewController
        let page = PKLogPhoneViewController()
        page.modalPresentationStyle = .fullScreen
        topPage?.present(page, animated: true)
    }
    
    static func cleanUserInfo(){
        sessionid = ""
        phone = ""
    }
    
    
    static func pkGetNowTime() -> String {
        let time = Date().timeIntervalSince1970 * 1000
        let timeString = String(format: "%.0f", time)
        return timeString
    }

}
