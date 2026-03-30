//
//  PKupLoadingManager.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit
@_exported import Alamofire
@_exported import SwiftyJSON
@_exported import SnapKit
@_exported import Kingfisher

class RunModel{
    var runState:Int = 0
    var runMsg:String = ""
    var runData = JSON()
}

class PKupLoadingManager: NSObject {
    
    static let upload = PKupLoadingManager()
    
    private let pkSender = NetworkReachabilityManager()
    
    var keeper:String = ""
    
    var defaultDict:[String:Any]  {
        return [
            "GyfoAwUCelibacyNREstFM": "ios",
            "FbyPfTCRagtagAfRAJFo": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0",
            "jdoHFOdInconditeETCCDDq": PKAppInfo.appInfoDeviceName,
            "HzPnQxwPermeableAJXxdKr": PKAppInfo.IDFV,//
            "XTxzTeZSteveNSLwoJq":  UIDevice.current.systemVersion as NSString,
            "yiSHhUzInspiringZrqKTOi":"ph",
            "sgGQdJIPhreatophyteIFcENeX": PKUserManager.sessionid,//sessionId
            "wVRjpLsElectropathyXrmvcmN":Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "",
            "AWhegFBBeidaiheTaaByzb":"",//idfa
            "MdwYZhVPerpetuallyCeEnxjn":PKUserManager.phone//phoneNumber
        ]
    }
    
    func upHeader(place:String) ->String{
        
        let passStr = URLEncoding.default.runCoding(defaultDict)
        
        return mainUpper + place + "?" + passStr
        
    }
    
    func getHeader() -> String{
        
        return URLEncoding.default.runCoding(defaultDict)
    }
    
    func initLoading(){
        pkSender?.startListening(onUpdatePerforming: { state in
            switch state {
            case .reachable(.cellular):
                self.keeper = "4G"
                PKHomeHandle.postUpDataAppGoogleMarket()
                NotificationCenter.default.post(name: Notification.Name("loadingSuccess"), object: nil, userInfo: nil)
            case .reachable(.ethernetOrWiFi):
                self.keeper = "WIFI"
                PKHomeHandle.postUpDataAppGoogleMarket()
                NotificationCenter.default.post(name: Notification.Name("loadingSuccess"), object: nil, userInfo: nil)
                
            default:
                self.keeper = ""
            }
        })
        
    }
    
    func loadGet(place:String,
                 upping:Bool = false,
                 success:@escaping(_ suc: RunModel) -> Void,
                 failed: @escaping (_ errorMsg: String?) -> Void)
    {
        
        loadMain(place: place, dict: nil, method: .get, upping: upping,success: success, failed: failed)
    }
    
    func loadPost(place:String,
                  dict:[String:Any]?=nil,
                  upping:Bool = false,
                  success:@escaping(_ suc: RunModel) -> Void,
                  failed: @escaping (_ errorMsg: String?) -> Void)
    {
        loadMain(place: place, dict: dict, method: .post, upping: upping,success: success, failed: failed)
    }
    
    func loadMain(place:String,dict:[String:Any]?=nil,method:HTTPMethod,upping:Bool = false,success:@escaping(_ suc: RunModel) -> Void,failed: @escaping (_ errorMsg: String?) -> Void){
        
        if upping {
            SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(.clear)
        }
        let convertible = upHeader(place: place)
        AF.request(convertible,method: method,parameters: dict,encoding: JSONEncoding.default,headers: ["Content-Type": "application/json", "Accept": "application/json"]).validate().responseData { response in
            if upping {
                SVProgressHUD.dismiss()
            }
            switch response.result {
            case .success(let data):
                let jsonData = JSON(data)
                print("k--- \(convertible) \n\n \(jsonData) \n\n")
                let res = RunModel()
                
                res.runState = jsonData["XEBeCQlMariupolZsiPAoS"].intValue
                res.runMsg = jsonData["SWcJvaaChildmindSbvnrtF"].stringValue
                res.runData = jsonData["mVqENHeAllureBTcpdzp"]
                
                if res.runState == 0 {
                    success(res)
                }else if res.runState == -2 {
                    PKUserManager.pkgotoLogin()
                }else {
                    failed(res.runMsg)
                }
                
                
            case .failure(let error):
                failed(error.errorDescription)
            }
        }
        
    }
    
    func loadUpImage(place:String,dict:[String:Any]? = nil,imagData: Data,success:@escaping(_ suc: RunModel) -> Void,failed: @escaping (_ errorMsg: String?) -> Void) {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let dateString = formatter.string(from: Date())
        let picName = "am\(dateString).jpg"
        let convertible = upHeader(place: place)
        AF.upload(multipartFormData: { formData in
            formData.append(imagData, withName: "am", fileName: picName, mimeType: "image/png")
            if let dict = dict {
                for (key, value) in dict {
                    if let stringValue = value as? String, let data = stringValue.data(using: .utf8) {
                        formData.append(data, withName: key)
                    } else if let intValue = value as? Int, let data = "\(intValue)".data(using: .utf8) {
                        formData.append(data, withName: key)
                    }
                }
            }
        }, to: convertible, headers: ["Content-Type": "multipart/form-data"])
        .uploadProgress { progress in
            // print(progress)
        }
        .response { response in
            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let data):
                let jsonData = JSON(data)
                print("k--- \(convertible) \n\n \(jsonData) \n\n")
                let res = RunModel()
                
                res.runState = jsonData["XEBeCQlMariupolZsiPAoS"].intValue
                res.runMsg = jsonData["SWcJvaaChildmindSbvnrtF"].stringValue
                res.runData = jsonData["mVqENHeAllureBTcpdzp"]
                
                if res.runState == 0 {
                    success(res)
                }else if res.runState == -2 {
                    
                }else {
                    failed(res.runMsg)
                }
                
                
            case .failure(let error):
                failed(error.errorDescription)
            }
        }
    }
}
