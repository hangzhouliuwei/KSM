//
//  LPBaseWebVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/4.
//

import UIKit
import WebKit
import StoreKit

class LPBaseWebVC: LPBaseVC {
    
    var url: String = "" {
        didSet {
            let encondingStr = LPWebTools.getEncodingString()
            if url.hasSuffix("?") {
                finalUrl = url + encondingStr
            } else if url.contains("?") {
                finalUrl = url + "&" + "\(encondingStr)"
            }else {
                finalUrl = url + "?" + "\(encondingStr)"
            }
            print("load url:  " + (finalUrl ?? "url nil"))
        }
    }
    
    private var finalUrl: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hasRightButton = false
        setUI()
    }
    
    func setUI(){
        contentV.addSubview(webView)
        contentV.addSubview(progressView)
        
        if let url = URL(string: finalUrl ?? "") {
            self.webView.load(URLRequest(url: url))
        } else{
            fatalError("Webview url is nil!!!")
        }

        
    }
    
    lazy var webView:WKWebView = {
        let webView: WKWebView = WKWebView(frame: CGRectMake(0, 0, kWidth,kHeigth-Device.topNaviBar), configuration: configuration)
        webView.navigationDelegate = self
        webView.backgroundColor = .white
        webView.scrollView.backgroundColor = .white
        webView.uiDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        return webView
    }()
    
    lazy var configuration:WKWebViewConfiguration = {
        let configuration: WKWebViewConfiguration = WKWebViewConfiguration()
        configuration.websiteDataStore = .nonPersistent()
        configuration.userContentController = contentController
        return configuration
    }()
    
    
    //MARK: - scriptMessageHandler
    lazy var contentController:WKUserContentController = {
        let contentController = WKUserContentController()
        contentController.add(self, name: "dfvchju001")//getPoint
        contentController.add(self, name: "dfvchju002")//receivePoint
        contentController.add(self, name: "dfvchju003")//callPhoneMethod
        contentController.add(self, name: "dfvchju004")//jumpToHome
        contentController.add(self, name: "dfvchju005")//toGrade
        contentController.add(self, name: "dfvchju006")//openAppstore
        contentController.add(self, name: "dfvchju007")//jump
        
        return contentController
    }()
    
    lazy var progressView:UIProgressView = {
        let progressView: UIProgressView = UIProgressView(frame: CGRectMake(0, 0, kWidth, 0.5))
        progressView.tintColor = mainColor38
        progressView.trackTintColor = .white
        progressView.transform = CGAffineTransformMakeScale(1, 0.5)
        return progressView
    }()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress", object as? WKWebView === webView {
            progressView.progress = Float(webView.estimatedProgress)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.progressView.alpha = 0.0
                })
            } else {
                self.progressView.alpha = 1.0
            }
        }
    }
    
    override func backBtnAction() {
        if webView.canGoBack{
            webView.goBack()
            return
        }
        if let _ = self.presentingViewController{
            self.dismiss(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
}

// MARK: - WKNavigationDelegate
extension LPBaseWebVC: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.title") {(resultString: Any?, _: (any Error)?) in
            if let titleStr = resultString as? String{
                DispatchQueue.main.async {
                    self.lp_title = titleStr
                }
            }
            
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("k--- webView Loading Failed:\(error.localizedDescription)")
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let newUrlString = navigationAction.request.url?.absoluteString ?? ""
        if LPWebTools.isKnownScheme(to: newUrlString) {
            LPWebTools.openApp(to: newUrlString)
            decisionHandler(.cancel)
        } else if navigationAction.navigationType == .linkActivated {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            decisionHandler(.allow)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}


// MARK: - WKUIDelegate
extension LPBaseWebVC: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("k--- message=\(message)")
        completionHandler()
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let newUrl = navigationAction.request.url {
            let newUrlString = newUrl.absoluteString
            print("k--- newUrlString = \(newUrlString)")
            if let url = LPWebTools.getNormalUrl(with: newUrlString) {
                webView.load(URLRequest(url: url))
            }
        }
        return nil
    }
}


//MARK: - WKScriptMessageHandler
extension LPBaseWebVC:WKScriptMessageHandler{

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let body = message.body;
        switch message.name {
        case "dfvchju001":
            let dic: [String:Any] = [
                "PTUOutfalli":Location.lp_latitude,
                "PTUAnisodonti":Location.lp_longitude,
                "PTUSangi":Device.IDFV,
                "PTUColumnai": MarketID.IDFA]
            let jsonString = "dfvchju002(\(LPTools.jsonFromDic(dictionary:dic) ?? ""))"
            self.webView.evaluateJavaScript(jsonString) { _, error in
                
            }
        case "dfvchju003":
            if let phone = URL(string: "tel:\(body)") {
                UIApplication.shared.open(phone)
            }
                       
        case "dfvchju004":
            DispatchQueue.main.async {
                Route.backToHome()
            }
        case "dfvchju005":
            if #available(iOS 14.0, *) {
                if  let scene = self.view.window?.windowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
               } else {
                   SKStoreReviewController.requestReview()
               }

        case "dfvchju006":
            if let url = URL(string: "\(body)") {
                UIApplication.shared.open(url)
            }
        default:
            print("web didReceive:\(message.name)")
        }
    }
    
}





