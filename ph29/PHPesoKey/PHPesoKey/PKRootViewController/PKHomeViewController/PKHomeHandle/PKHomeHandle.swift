//
//  PKHomeHandle.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/13.
//

import UIKit

let homePageData = "/yyQKH" + "ConsociateHmaax"

class PKHomeHandle{
    var homeDataArray:[JSON] = []
    func getPKHomePageModel(result: @escaping PKDoubleBoolBlock,sionViewData: @escaping PKJSonBlock){
        
        PKupLoadingManager.upload.loadGet(place: homePageData) {[weak self] suc in
            guard let self = self else { return }
            
            self.handleHomePageModel(homeModel: suc.runData, result: result)
            sionViewData(suc.runData["paJSPLtLignosulphonateKsCkIAM"])
            
        } failed: { errorMsg in
            result(false,false)
        }

    }
    
    func handleHomePageModel(homeModel: JSON ,result:@escaping PKDoubleBoolBlock){

        let homedataArr = homeModel["wxEXRPPPrudenceAHcCpFJ"].arrayValue
        if homedataArr.count == 0 {
            result(false,false)
            return
        }
        
        self.homeDataArray.removeAll()
        var isPKShowSmallCard = false
        homedataArr.forEach { itemModel in
            let itemTypeStr = itemModel["tIbeJSgActivistXYQsLuc"].stringValue
            if itemTypeStr == "WEYKEWQFVLUHPOL"{//big card
                var jsonModel : JSON = itemModel["unoBYBSShoppyMwSzwtV"].arrayValue.first!
                jsonModel["itemType"].stringValue = itemTypeStr
                jsonModel["itemHeight"].intValue = Int(440 + PK_NaviH)
                jsonModel["grade"].intValue = 1
                self.homeDataArray.append(jsonModel)
            }else if itemTypeStr == "PNAXDHJIWWMFQBW"{//samll card
                isPKShowSmallCard = true
                var jsonModel : JSON = itemModel["unoBYBSShoppyMwSzwtV"].arrayValue.first!
                jsonModel["itemType"].stringValue = itemTypeStr
                jsonModel["itemHeight"].intValue = 195
                jsonModel["grade"].intValue = 2
                self.homeDataArray.append(jsonModel)
            } else if itemTypeStr == "DVXVGCHGBQPCJXX"{// banner
                var jsonModel : JSON = itemModel
                jsonModel["itemType"].stringValue = itemTypeStr
                jsonModel["itemHeight"].intValue = Int(140 + safe_PK_top)
                jsonModel["grade"].intValue = 0
                self.homeDataArray.append(jsonModel)
            }else if itemTypeStr == "YWKYGPLCDNUPFIP"{//RepayMent
                var jsonModel : JSON = itemModel["unoBYBSShoppyMwSzwtV"].arrayValue.first!
                jsonModel["itemType"].stringValue = itemTypeStr
                jsonModel["itemHeight"].intValue = 96
                jsonModel["grade"].intValue = 3
                self.homeDataArray.append(jsonModel)
                
            }else if itemTypeStr == "IMNCUBAJXEIEYDF"{//list
                let jsonModel = itemModel["unoBYBSShoppyMwSzwtV"].arrayValue
                jsonModel.forEach { itemJson  in
                    var itemjson = itemJson
                    itemjson["itemType"].stringValue = itemTypeStr
                    itemjson["itemHeight"].intValue = 206
                    itemjson["grade"].intValue = 4
                    self.homeDataArray.append(itemjson)
                }
                
            }
            
        }
        
        self.homeDataArray.sort {( $0["grade"].intValue <  $1["grade"].intValue)}
        self.homeDataArray.forEach{itemModel in
            if !isPKShowSmallCard && itemModel["itemType"].stringValue == "DVXVGCHGBQPCJXX"{
                self.homeDataArray.remove(at: 0)
                return
            }
           
        }
        
        if !isPKShowSmallCard {//big card
            var jsonModel = JSON()
            jsonModel["itemType"] = "unoBYBSShoppyMwSzwtVip"
            jsonModel["itemHeight"].intValue = 860
            self.homeDataArray.append(jsonModel)
        }
        
        if isPKShowSmallCard {// samll card
            var jsonModel = JSON()
            jsonModel["itemType"] = "PNAXDHJIWWMFQBWVip"
            jsonModel["itemHeight"].intValue = 114
            self.homeDataArray.append(jsonModel)
        }
        
        result(true, isPKShowSmallCard)
    }
    
   
    func getPKHomePagePOPViewData(result: @escaping (JSON) -> Void) {
        PKupLoadingManager.upload.loadGet(place: "/CWgDvAutorotationVfktn") { suc in
            result(suc.runData)
        } failed: { errorMsg in
           
        }

    }
    
    func postPKHomePageApplyData(eRPMeBJSpeciateMyfFjzI: String, result: @escaping PKJSonBlock){
        let dic:[String : String] = [
                                     "eRPMeBJSpeciateMyfFjzI" : eRPMeBJSpeciateMyfFjzI,
                                     "nVDWDMIYucatecOjxJMkU" : "12nenwnbwewnw98" + "2jenjbnwnwencen"
                                    ]
        PKupLoadingManager.upload.loadPost(place: "/LmmmQHomelikeToEkq", dict: dic,upping: true) { suc in
            result(suc.runData)
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }


    }
    
    func postPKHomePageProductdetailData(eRPMeBJSpeciateMyfFjzI: String,result: @escaping PKStingBlock){

        let dic:[String : String] = [
                                     "eRPMeBJSpeciateMyfFjzI" : eRPMeBJSpeciateMyfFjzI
                                    ]
        PKupLoadingManager.upload.loadPost(place: "/uhLMYUrubuQpgkc", dict: dic,upping: true) { suc in
            result(suc.runData["IdgByDgPacifarinKirYEnX"]["excuse"].stringValue)
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }

    }
    
    func postPKHomePageupLoadLocationData(LoadLocationDic:Dictionary<String, Any>,result: @escaping PKNoneBlock){
        PKupLoadingManager.upload.loadPost(place: "/lWBYABiogeocoenoseKwipT", dict: LoadLocationDic,upping: true) { suc in
            result()
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }


    }
    
    
    static func postUpDataAppGoogleMarket(){
        
        PKupLoadingManager.upload.loadPost(place: "/enVLMPasuruanLSeRT", dict:["GQzSYrEPlaybusQZWzbrk":PKAppInfo.IDFV, "yrFpRPwLaudablenessLKLGqMe":""],upping: false) { suc in
          
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
        
    }
    
}
