//
//  XTBaseApi.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation
import YTKNetwork

private let xtBaseApiTimeout: TimeInterval = 30.0
private let xtBaseApiURL = "https://api-16i.ph.dev.ksmdev.top/api"
private let xtBaseApiLocalityPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? "") + "/Locality_Url.txt"
private let xtJsonSerializerType = YTKRequestSerializerType(rawValue: 1)!

private func xtBaseString(_ value: Any?) -> String {
    guard let value, !(value is NSNull) else { return "" }
    if let string = value as? String {
        return string
    }
    return "\(value)"
}

private func xtBaseURLEncode(_ value: String) -> String {
    value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
}

@objcMembers
@objc(XTBaseApi)
class XTBaseApi: YTKRequest {
    private var headerStorage: NSMutableDictionary?
    private var requestURLStorage: String?

    deinit {
        requestTask.cancel()
        clearCompletionBlock()
    }

    private var headerDic: NSMutableDictionary {
        if headerStorage == nil {
            let dic = NSMutableDictionary()
            XTDevice.xt_getIdfaShowAlt(false) { idfa in
                dic["spdisixlleNc"] = xtBaseString(idfa)
            }
            dic["saursixnicNc"] = "ios"
            dic["andisixcNc"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            dic["penisixsetumNc"] = xtBaseString(XTDevice.xt_share().xt_mobileStyle)
            dic["exepsixtionalNc"] = xtBaseString(XTDevice.xt_share().xt_idfv)
            dic["dedesixningNc"] = xtBaseString(XTDevice.xt_share().xt_sysVersion)
            dic["feicsixidalNc"] = "ph"
            dic["prgnsixenoloneNc"] = Bundle.main.bundleIdentifier ?? ""
            let session = UserSession.shared
            if session.isLoggedIn {
                dic["ghstsixNc"] = xtBaseString(session.currentUser?.xt_userSessionid)
                dic["raiosixiodineNc"] = xtBaseString(session.currentUser?.phone)
            }
            headerStorage = dic
        }
        return headerStorage!
    }

    override func requestSerializerType() -> YTKRequestSerializerType {
        xtJsonSerializerType
    }

    override func requestHeaderFieldValueDictionary() -> [String: String]? {
        var headers: [String: String] = [:]
        headerDic.forEach { key, value in
            headers[xtBaseString(key)] = xtBaseString(value)
        }
        return headers
    }

    @objc func responseHeadersFieldValueDictionary() -> [String: String]? {
        responseHeaders as? [String: String]
    }

    override func baseUrl() -> String {
        xt_request_url
    }

    private var xt_request_url: String {
        if requestURLStorage == nil {
            let localURL = (try? String(contentsOfFile: xtBaseApiLocalityPath, encoding: .utf8))?.trimmingCharacters(in: .whitespacesAndNewlines)
            requestURLStorage = (localURL?.isEmpty == false) ? localURL : xtBaseApiURL
        }
        return requestURLStorage ?? xtBaseApiURL
    }

    override func requestTimeoutInterval() -> TimeInterval {
        xtBaseApiTimeout
    }

    @objc func queryParameter() -> NSDictionary? {
        nil
    }

    @objc func requestUrlToBeAddQueryParameter() -> String? {
        nil
    }

    override func requestUrl() -> String {
        urlAppendQueryParameter(toUrl: requestUrlToBeAddQueryParameter() ?? "")
    }

    @objc(urlAppendQueryParameterToUrl:)
    func urlAppendQueryParameter(toUrl url: String) -> String {
        XTBaseApi.urlAppendDic(toUrl: url, dic: headerDic)
    }

    @objc(urlAppendDicToUrl:dic:)
    class func urlAppendDic(toUrl url: String?, dic: NSDictionary?) -> String {
        guard let url, let dic else {
            return url ?? ""
        }
        let query = dic.allKeys.map { key -> String in
            "\(xtBaseString(key))=\(xtBaseString(dic[key]))"
        }.joined(separator: "&")
        if !url.contains("?") {
            return XTUtility.xt_urlEncode("\(url)?\(query)")
        }
        return XTUtility.xt_urlEncode("\(url)&\(query)")
    }

    @objc(webUrlAppendQueryParameterToUrl:)
    func webUrlAppendQueryParameter(toUrl url: String) -> String {
        XTBaseApi.webUrlAppendDic(toUrl: url, dic: headerDic)
    }

    @objc(webUrlAppendDicToUrl:dic:)
    class func webUrlAppendDic(toUrl url: String?, dic: NSDictionary?) -> String {
        guard let url, let dic else {
            return url ?? ""
        }
        let query = dic.allKeys.map { key -> String in
            "\(xtBaseString(key))=\(xtBaseString(dic[key]))"
        }.joined(separator: "&")
        let encodedQuery = xtBaseURLEncode(query)
        if !url.contains("?") {
            return "\(url)?\(encodedQuery)"
        }
        return "\(url)&\(encodedQuery)"
    }

    @objc(xt_startRequestSuccess:failure:error:)
    func xt_startRequestSuccess(_ success: XTDicAndStrBlock?, failure: XTDicAndStrBlock?, error: ((NSError?) -> Void)?) {
        let acceptableContentTypes: Set<String> = [
            "application/json",
            "text/json",
            "text/javascript",
            "text/plain",
            "text/html",
            "text/css",
            "image/jpeg",
            "image/png",
            "application/octet-stream"
        ]
        YTKNetworkAgent.shared().setValue(acceptableContentTypes, forKeyPath: "jsonResponseSerializer.acceptableContentTypes")

        startWithCompletionBlock(success: { [weak self] request in
            guard let self else { return }
            let resultDic = request.responseObject as? [AnyHashable: Any]
            self.printLogTitle("请求成功", request: request)
            DispatchQueue.main.async {
                guard let resultDic else {
                    error?(nil)
                    return
                }
                let code = xtBaseString(resultDic["imeasixsurabilityNc"])
                if code == "00" || code == "0" {
                    success?(resultDic["viussixNc"] as? [AnyHashable: Any], xtBaseString(resultDic["frwnsixNc"]))
                    return
                }
                if code == "-2" {
                    error?(nil)
                    XTUtility.xt_login(nil)
                    return
                }
                failure?(resultDic["viussixNc"] as? [AnyHashable: Any], xtBaseString(resultDic["frwnsixNc"]))
            }
        }, failure: { [weak self] request in
            self?.printLogTitle("请求失败", request: request)
            XTUtility.xt_showTips(request.error?.localizedDescription ?? "", view: nil)
            error?(request.error as NSError?)
        })
    }

    private func printLogTitle(_ title: String, request: YTKBaseRequest) {
        #if DEBUG
        let requestURL = "\(baseUrl())/\(requestUrl())"
        let requestArgument = requestArgument().map { "\($0)" } ?? ""
        let responseHeaders = responseHeadersFieldValueDictionary() ?? [:]
        let responseData = request.responseString ?? ""
        fputs(
            "\n\n======== 数据请求\(title)(\(NSStringFromClass(type(of: self)))): ========\n" +
            "-- RequestUrl: \(requestURL)\n" +
            "-- Type: \(requestType())\n" +
            "-- RequestHeader: \(requestHeaderFieldValueDictionary() ?? [:])\n" +
            "-- Params: \(requestArgument)\n" +
            "-- ResponseHeaders: \(responseHeaders)\n" +
            "-- ResponseData: \(responseData)\n" +
            "================================================\n\n",
            stderr
        )
        #endif
    }

    private func requestType() -> String {
        switch requestMethod().rawValue {
        case 0:
            return "Get"
        case 1:
            return "Post"
        case 2:
            return "Head"
        case 3:
            return "Put"
        case 4:
            return "Delete"
        case 5:
            return "Patch"
        default:
            return ""
        }
    }
}
