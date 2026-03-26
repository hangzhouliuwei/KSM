//
//  LPLoginManager.swift
//  LPeso
//
//  Created by Kiven on 2024/11/1.
//

import UIKit

let UserSession = LPLoginManager.shared

class LPLoginManager: NSObject {
    
    static let shared = LPLoginManager()
    
    var id:String{
        get{
            let str =  UserDefaults.standard.string(forKey: "lp_ids") ?? ""
            return str
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "lp_ids")
        }
        
    }
    
    var phone:String{
        get{
            let str = UserDefaults.standard.string(forKey: "lp_phones") ?? ""
            return str
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "lp_phones")
        }
        
    }
    
    func isLogin() ->Bool{
        if isBlank(id){
            Route.showLogin()
            return false
        }
        return true
        
    }
    
    func clearUserData(){
        self.id = ""
        self.phone = ""
    }
    
    func logOut(){
        Request.send(api: .loginOut,showLoading: true,showResult: true) { (result:LPEmptyModel?) in
            self.clearUserData()
            Route.reSetRootVC()
            
        } failure: { error in
            
        }
        
    }
    
    func getWalletPhone() ->String{
        var number = self.phone
        if !phone.hasPrefix("0"){
            number = "0"+number
        }
        return number
        
    }
    
    var timer:Timer?
    var countdownTime: Int = 0
    var lastPhone:String?
    
    func continueCountDown(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(toCountDown), userInfo: nil, repeats: true)
    }
    
    @objc private func toCountDown() {
        if countdownTime>0{
            countdownTime -= 1
        }else{
            stopCountDown()
        }
        
    }
    
    func stopCountDown() {
        timer?.invalidate()
        timer = nil
        
    }
    
    
    
}
