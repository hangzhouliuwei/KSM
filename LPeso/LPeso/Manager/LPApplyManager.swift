//
//  LPApplyManager.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit

enum AuthStepType: String{
    case basic = "HYNQQQH"
    case ext = "HYNQQQE"
    case photos = "HYNQQQDF"
    case face = "HYNQQQI"
    case bank = "HYNQQQG"
    
    init?(stringValue: String) {
        switch stringValue {
        case AuthStepType.basic.rawValue:
            self = .basic
        case AuthStepType.ext.rawValue:
            self = .ext
        case AuthStepType.photos.rawValue:
            self = .photos
        case AuthStepType.face.rawValue:
            self = .face
        case AuthStepType.bank.rawValue:
            self = .bank
        default:
            return nil
        }
    }
}

class LPApplyManager: NSObject {
    
    static var shared = LPApplyManager()
    
    var proID:String?
    var orderNO:String?{
        didSet{
            print("k--- orderNO:\(orderNO)")
        }
    }

    //MARK: Access Into
    func applyNow(proID:String){
        print("k-- applyNow proID:\(proID) --")
        self.proID = proID
        Request.send(api: .apply(proID: proID), showLoading: true) { (result:LPApplyModel?) in
            if let result = result{
                self.dealApply(model: result)
            }
            
        } failure: { error in
            
        }

    }
    
    func dealApply(model:LPApplyModel){
        if model.PTUTheorematici?.int == 2{
            LPDeviceInfoManager.uploadDeviceInfo()
        }
//        guard let urlStr = model.PTUThenarditei else { return }
        if model.PTUTulipomaniai?.int == 0{
            Location.getLocationInfo {[weak self] success,locationInfo  in
                
                if success{
                    guard let locationInfo = locationInfo else { return }
                    Request.send(api: .locationInfo(params: locationInfo), showLoading: true) { (result:LPEmptyModel?) in
                        self?.nextProductDetail(model: model)
                    } failure: { error in
                        
                    }

                }else{
                    DispatchQueue.main.async {
                        Route.showLocationAlert()
                    }
                    
                }
            }
            
        }else{
            nextProductDetail(model: model)
        }
        
    }
    
    //MARK: Get Product Detail
    func nextProductDetail(model:LPApplyModel?=nil){
        if let urlStr = model?.PTUThenarditei,urlStr.hasPrefix("http"){
            Route.openUrl(urlStr: urlStr)
            return
        }
        guard let proID = self.proID else { return }
        Request.send(api: .productDetial(proID: proID),showLoading: true) { (result:LPProductDetailModel?) in
            guard let orderNo = result?.PTULikedi?.PTUEnjoyi?.string else{ return }
            self.orderNO = orderNo
            if let urlString = result?.PTUMonazitei?.excuse{
                self.jumpWithUrl(urlString: urlString)
            }else{
                self.findUrlWithOrderNo(orderNo: orderNo)
            }
            
        } failure: { error in
            
        }
        
    }
    
    //MARK: getURL by orderNo
    func findUrlWithOrderNo(orderNo:String){
        Request.send(api: .productPush(orderNO: orderNo)) { (result:LPApplyModel?) in
            if let urlStr = result?.PTUThenarditei{
                print("k-- getURL by orderNo：\(urlStr)")
                self.jumpWithUrl(urlString: urlStr)
                
            }
            
        } failure: { error in
            Route.backToHome()
        }

    }
    
    
    //MARK: jump
    func jumpWithUrl(urlString:String){
        if urlString.hasPrefix("http"){
            Route.openCloseUrl(urlStr: urlString)
            
        }else{
            guard let proID = self.proID,let orderNO = self.orderNO else { return }
            if let type = AuthStepType(stringValue: urlString){
                
                switch type {
                case .basic:
                    Route.pushClose(vc: LPAuthBasicVC(authType: type, proID: proID, orderNO: orderNO))
                case .ext:
                    Route.pushClose(vc: LPAuthContactVC(authType: type, proID: proID, orderNO: orderNO))
                case .photos:
                    Route.pushClose(vc: LPAuthIdentityVC(authType: type, proID: proID, orderNO: orderNO))
                case .face:
                    Route.pushClose(vc: LPAuthFaceVC(authType: type, proID: proID, orderNO: orderNO))
                case .bank:
                    Route.pushClose(vc: LPAuthBankVC(authType: type, proID: proID, orderNO: orderNO))
                }
                
            }else{
                Route.toast("unkown type:\(urlString)")
                print("k-- unkown type:\(urlString) ---")
            }
        }
        
    }
    
    func saveParams(vc:LPAuthBaseVC,params:[String:Any]){
        guard !params.isEmpty else { return }
        var dic = params
        dic["PTUUlerythemai"] = self.proID
        var api:LPRequestAPI
        switch vc.authType {
        case .basic:
            dic["point"] = LPTools.getPointParams(startTime: vc.startTime, sceneType: "22")
            api = .basicSave(params: dic)
        case .ext:
            dic["point"] = LPTools.getPointParams(startTime: vc.startTime, sceneType: "23")
            api = .contactSave(params: dic)
        case .photos:
            LPDeviceInfoManager.uploadDeviceInfo()
            dic["point"] = LPTools.getPointParams(startTime: vc.startTime, sceneType: "24")
            api = .photoSave(params: dic)
        case .face:
            dic["point"] = LPTools.getPointParams(startTime: vc.startTime, sceneType: "25")
            api = .faceSave(params: dic)
        case .bank:
            dic["point"] = LPTools.getPointParams(startTime: vc.startTime, sceneType: "26")
            api = .bankSave(params: dic)
        }
        Request.send(api: api, showLoading: true) { (result:LPSaveDataModel?) in
            if let excuse = result?.PTUPedophiliai?.excuse{
                self.jumpWithUrl(urlString: excuse)
            }else if let url = result?.PTUThenarditei{
                self.jumpWithUrl(urlString: url)
            }else{
                guard let orderNO = self.orderNO else { return }
                self.findUrlWithOrderNo(orderNo: orderNO)
                
            }
        } failure: { error in
            
        }

    }
    
    
}
