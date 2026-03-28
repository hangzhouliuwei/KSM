//
//  LPRequestAPI.swift
//  LPeso
//
//  Created by Kiven on 2024/10/30.
//

import Moya

enum LPRequestAPI{
    typealias ParamsType = [String: Any]
    case home
    case homeAlert
    case mine
    case code(phone: String)
    case login(params: ParamsType)
    case loginOut
    case apply(proID:String)
    case productDetial(proID:String)
    case productPush(orderNO:String)
    case productList(type:String) // 4 order 7 Borrowing 6 Not fnished 5 Repaid
    case deviceInfo(params:ParamsType)
    case locationInfo(params:ParamsType)
    case googleId
    case basicGet(proID:String)
    case basicSave(params:ParamsType)
    case contactGet(proID:String)
    case contactSave(params:ParamsType)
    case photoGet(proID:String)
    case photoUpdate(img:UIImage,type:String)
    case photoSave(params:ParamsType)
    case faceGet(proID:String)
    case faceLimit(proID:String)
    case faceLicense
    case faceUpdate(proID:String,livenessId:String)
    case faceUpdataErr (faceErrCode:String)
    case faceSave(params:ParamsType)
    case bankGet(proID:String)
    case bankSave(params:ParamsType)
}

extension LPRequestAPI: TargetType {
    var baseURL: URL {
        let urlStr = LPBase_api+"/api"
        return URL(string: urlStr)!
    }
    
    var path: String {
        switch self {
        case .home:
            return "vnchemicalizefvs"
        case .homeAlert:
            return "vnboomslangfvs"
        case .mine:
            return "vnmudslingingfvs"
        case .code:
            return "vnfilariasisfvs"
        case .login:
            return "vnrecallfvs"
        case .loginOut:
            return "vnopeningfvs"
        case .apply:
            return "vnburefvs"
        case .productDetial:
            return "vnescorialfvs"
        case .productPush:
            return "vnpaedagogicfvs"
        case .productList:
            return "vnbelfastfvs"
        case .deviceInfo:
            return "vnsubmundanefvs"
        case .locationInfo:
            return "vnagroboyfvs"
        case .googleId:
            return "vnconnivefvs"
        case .basicGet:
            return "vnamebocytefvs"
        case .basicSave:
            return "vnparticipledfvs"
        case .contactGet:
            return "vnsillerfvs"
        case .contactSave:
            return "vnadjunctionfvs"
        case .photoGet:
            return "vnmarxistfvs"
        case .photoUpdate:
            return "vnbeachfrontfvs"
        case .photoSave:
            return "vncirrhosisfvs"
        case .faceGet:
            return "vnworkadayfvs"
        case .faceLimit:
            return "vnfourscorefvs"
        case .faceLicense:
            return "vnhyoscinefvs"
        case .faceUpdate:
            return "vndepositionalfvs"
        case .faceUpdataErr:
            return "vneudemoniafvs"
        case .faceSave:
            return "vnthermonuclearfvs"
        case .bankGet:
            return "vnhesperornisfvs"
        case .bankSave:
            return "vnmedulloblastomafvs"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .home,.homeAlert,.mine,.loginOut,.faceLicense:
            return .get
        default : return .post
        }
    }
    
    var task: Moya.Task {
        var urlParameters: ParamsType = LPTools.getUrlParams()
        var parameters: ParamsType = [:]
        
        switch self {
        case .home,.homeAlert,.mine,.loginOut,.faceLicense:
            parameters = urlParameters
            urlParameters = [:]
        case .code(let phone):
            parameters = ["PTUBludgeri": phone, "PTULargelyi": "juyttrr"]
        case .login(let params):
            parameters = params

        case .apply(let proID):
            parameters = ["PTUUlerythemai": proID, "PTUPianoi": "cakestand"]
        case .productDetial(let proID):
            parameters = ["PTUUlerythemai": proID]
        case .productPush(let orderNO):
            parameters = ["PTUHexaplariani": orderNO,"PTUTetrandriousi":"houijhyus"]
        case .productList(let type):
            parameters = ["PTUGabrieli": type,"PTUDelimei":"1","PTUMorphologisti":"20"]
            
        case .deviceInfo(let parames):
            parameters = parames
        case .locationInfo(let parames):
            parameters = parames
        case .googleId:
            parameters = ["PTUArchbishopi": Device.IDFV,"PTUTruncheoni":MarketID.IDFA,"asdfasasdgwg":"fewfdf","ATETH":"123123555"]
            
        case .basicGet(let proID):
            parameters = ["PTUUlerythemai": proID,"PTUJacobinismi":"stauistill"]
        case .basicSave(let params):
            parameters = params
        case .contactGet(let proID):
            parameters = ["PTUUlerythemai": proID,"PTUSeptipartitei":"blaalleynk"]
        case .contactSave(let params):
            parameters = params
        case .faceGet(let proID):
            parameters = ["PTUUlerythemai": proID]
        case .faceLimit(let proID):
            parameters = ["PTUUlerythemai": proID]
        case .faceUpdate(let proID,let livenessId):
            parameters = ["PTUUlerythemai": proID,"PTUSkeletoni":livenessId]
        case .faceUpdataErr(let faceErrCode):
            parameters = ["PTUMesenchymatousi":faceErrCode]
        case .faceSave(params: let params):
            parameters = params
        case .photoGet(let proID):
            parameters = ["PTUUlerythemai": proID]
        case .photoUpdate(let image,let type):
            let params:ParamsType = ["am":image,"light":type]
            let formDataArray = getFormDataArray(params: params)
            return .uploadCompositeMultipart(formDataArray, urlParameters: urlParameters)
        case .photoSave(let params):
            parameters = params
        case .bankGet(let proID):
            parameters = ["PTUUlerythemai": proID]
        case .bankSave(let params):
            parameters = params
        }
        
        if urlParameters.isEmpty {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        } else {
            return .requestCompositeParameters(bodyParameters: parameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)
        }
        
    }
    
    var headers: [String : String]? {
        var headers = ["Content-Type": "application/json"]
        switch self {
        case .photoUpdate:
            headers["Content-Type"] = "multipart/form-data"
        default:
            headers["Content-Type"] = "application/json"
        }
        return headers
    }
    
    func getFormDataArray(params: [String: Any]) -> [MultipartFormData] {
        var formData = [MultipartFormData]()
        for key in params.keys {
            let value = params[key]
            if let images = value as? [UIImage] { // image array
                for image in images {
                    if let imageData = LPTools.compressImage(orangeImg: image) {
                        formData.append(MultipartFormData(provider: .data(imageData), name: key, fileName: "file.png", mimeType: "image/png"))
                    }
                }
            } else if let image = value as? UIImage { // image
                if let imageData = LPTools.compressImage(orangeImg: image) {
                    formData.append(MultipartFormData(provider: .data(imageData), name: key, fileName: "file.png", mimeType: "image/png"))
                }
            } else if let array = value as? [Any] { // other array
                let jsonString = LPTools.getJsonFromArray(array: array)
                if let data = jsonString.data(using: .utf8) {
                    formData.append(MultipartFormData(provider: .data(data), name: key))
                }
            } else if let dict = value as? [String: Any] { // dictionary
                let jsonString = LPTools.getJsonFromDic(dict: dict)
                if let data = jsonString.data(using: .utf8) {
                    formData.append(MultipartFormData(provider: .data(data), name: key))
                }
            } else if let value = value { // other
                if let data = "\(value)".data(using: .utf8) {
                    formData.append(MultipartFormData(provider: .data(data), name: key))
                }
            }
        }
        return formData
    }

}
