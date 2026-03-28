//
//  LPRequestManager.swift
//  LPeso
//
//  Created by Kiven on 2024/10/30.
//

import Moya
import Alamofire

let Request = LPRequestManager.shared

class LPRequestManager {
    
    static let shared = LPRequestManager()
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    private var provider: MoyaProvider<LPRequestAPI>!
    
    private init() {
        let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<LPRequestAPI>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 30
                done(.success(request))
            } catch {
                print("error message：\(error)")
            }
        }
        
        self.provider = MoyaProvider<LPRequestAPI>(requestClosure: requestClosure)
    }
    
    
    func send<T: Codable>(api: LPRequestAPI,
                             showLoading:Bool = false,
                             showResult:Bool = false,
                             success: @escaping ((_ result: T?) -> Void),
                             failure: @escaping ((String?) -> Void)){

        if showLoading{
            Route.loading()
        }

        self.provider.request(api) { result in
            
            switch result {
            case let .success(response):
                do {
                    guard let json = try response.mapJSON() as? [String: Any] else {
                        failure("not json data")
                        if showLoading{
                            Route.toast("not json data")
                        }
                        return
                    }
                    print("\n \(response.request?.url?.absoluteString ?? "") \n \(json) \n")
                } catch {
                    print(error.localizedDescription)
                    if showLoading{
                        Route.toast(error.localizedDescription)
                    }
                }
                do {
                    let model = try JSONDecoder().decode(LPBaseModel<T>.self, from: response.data)
                    guard let code = model.code else {
                        print("code is empty")
                        failure(nil)
                        if showLoading{
                            Route.toast("code is empty")
                        }
                        return
                    }
                    if api.path != "vnbeachfrontfvs" && (showLoading || showResult){
                        Route.hideLoading()
                    }
                    switch code.int {
                    case 0:
                        if showResult{
                            Route.toast(model.message)
                        }
                        success(model.data)
                    case -2:
                        if showLoading{
                            Route.toast(model.message)
                        }
                        UserSession.clearUserData()
                        Route.showLogin()
                        print("k--- -2 ⚠️ ⚠️ ⚠️ \(model.message ?? "")")
                        failure(model.message)
                        
                    default:
                        if showLoading{
                            Route.toast(model.message)
                        }
                        print(model.message ?? "")
                        failure(model.message)
                        
                    }
                } catch {
                    if showLoading{
                        Route.toast(error.localizedDescription)
                    }
                    print(error)
                    failure(error.localizedDescription)
                }
            case let .failure(error):
                print(error)
                failure(error.errorDescription)
                if showLoading{
                    Route.toast(error.errorDescription)
                }
            }
        }
        
    }
    
    
    
    func reachNetwork(){
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .reachable(.ethernetOrWiFi),.reachable(.cellular):
                print("k-- networkStatus:wifi")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    MarketID.getStart()
                }
            case .notReachable,.unknown:
                break
                
            }
        })
        
        
    }
    
}



