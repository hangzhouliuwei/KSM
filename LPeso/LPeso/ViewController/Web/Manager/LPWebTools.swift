//
//  LPWebTools.swift
//  LPeso
//
//  Created by Kiven on 2024/11/20.
//

import UIKit
import Alamofire

class LPWebTools: NSObject {

    static func getEncodingString() ->String{
        let urlencode = URLEncoding.default
        return urlencode.publicQuery(LPTools.getUrlParams())
    }
    
    static func isKnownScheme(to schemeUrlString: String) -> Bool {
        let kSchemes: [String] = ["tel", "whatsapp", "sms", "mailto"]
        if let schemeUrl = URL(string: schemeUrlString) {
            if let scheme = schemeUrl.scheme {
                return kSchemes.contains(scheme)
            }
        }
        return false
    }
    
    static func openApp(to schemeUrlString: String) {
        if let schemeUrl = URL(string: schemeUrlString) {
            if UIApplication.shared.canOpenURL(schemeUrl) {
                UIApplication.shared.open(schemeUrl)
            }
        }
    }
    
    static func getNormalUrl(with urlString: String) -> URL? {
        guard let newUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        let resultUrlString = newUrlString.replacingOccurrences(of: "%23", with: "#")
        return URL(string: resultUrlString)
    }
    
    
    
}

extension URLEncoding {
    func publicQuery(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
