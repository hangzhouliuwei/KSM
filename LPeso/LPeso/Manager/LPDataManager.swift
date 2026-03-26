//
//  LPDataManager.swift
//  LPeso
//
//  Created by Kiven on 2024/11/4.
//

import UIKit

class LPDataManager: NSObject {

    static let shared = LPDataManager()
    
    var centerList:[LPMineItemModel] = []
    
    var domainsId:String?
    
    var customModel:LPHomeIconModel?
    
    var homeAlertDict:[String:Bool] = [:]
    
    func reloadMineData(){
        Request.send(api: .mine) { (result:LPMineCenterModel?) in
            if let list = result?.PTUThrombolytici,list.count > 0{
                self.centerList = list
                NotificationCenter.default.post(name: Mine_noti, object: nil)
            }
            
        } failure: { error in
            
        }
        
    }
    
    func dealDomains(userActivity: NSUserActivity){
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let webpageURL = userActivity.webpageURL,let host = webpageURL.host,host == "www.moonserve-delight-lending.com"{
                let params = webpageURL.parameters()
                if let productId = params["p"] {
                    if UserSession.isLogin(){
                        LPApplyManager.shared.applyNow(proID: productId)
                    }else{
                        domainsId = productId
                    }
                }
            }
        }
        
    }
    
    func checkDomains(){
        guard let proID = LPDataManager.shared.domainsId else { return }
        LPDataManager.shared.domainsId = nil
        LPApplyManager.shared.applyNow(proID: proID)        
    }
    
}
