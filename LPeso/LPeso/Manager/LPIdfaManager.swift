//
//  LPIdfaManager.swift
//  LPeso
//
//  Created by Kiven on 2024/10/30.
//

import UIKit
import AppTrackingTransparency
import AdSupport

let MarketID = LPIdfaManager.shared

class LPIdfaManager: NSObject {
    
    static let shared = LPIdfaManager()
    
    var IDFA:String = ""
    
    func getStart()  {
        if #available(iOS 14, *) {
            Task {
            let _ = await ATTrackingHelper.attrackStatus()
                self.sendNewIdfa()
            }
        }else{
            self.sendNewIdfa()
        }
    }
    
    func sendNewIdfa(){
        IDFA = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        //TODO: uploadGoogleMarket
        print("k-- Idfa:\(self.IDFA)")
        Request.send(api: .googleId) { (result:LPEmptyModel?) in
            
        } failure: { error in
            
        }

    }
    
    final class ATTrackingHelper {
        @available(iOS 14, *)
        class func attrackStatus() async -> ATTrackingManager.AuthorizationStatus {
            let status = await ATTrackingManager.requestTrackingAuthorization()
            if status == .denied, ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                debugPrint("iOS 17.4 ATT bug detected")
                if #available(iOS 15, *) {
                    for await _ in await NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                        return await attrackStatus()
                    }
                } else {
                    return status
                }
            }

            return status
        }
    }
 
    
}
