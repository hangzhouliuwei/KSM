//
//  PKWebkitViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/11.
//

import UIKit
import WebKit
import StoreKit

class PKWebkitViewController: UIViewController,WKNavigationDelegate, WKUIDelegate , WKScriptMessageHandler,UIGestureRecognizerDelegate{

    @IBOutlet weak var pkWebTitle: UILabel!
    @IBOutlet weak var pkProgress: UIProgressView!
    @IBOutlet weak var pkShowView: UIView!
    
    @IBAction func pkBackAction(_ sender: Any) {
        pkBackNavigation()
    }
    
    private enum MessageHandler: String, CaseIterable {
            case getDeviceInfo = "irtgbefgvwfvc1"
            case callbackHandler = "irtgbefgvwfvc12"
            case phoneCall = "irtgbefgvwfvc13"
            case navigateToRoot = "irtgbefgvwfvc14"
            case requestReview = "irtgbefgvwfvc15"
            case openExternalURL = "irtgbefgvwfvc16"
            case unknown17 = "irtgbefgvwfvc17"
        }
    
    var pkWebUrlStr:String = ""
    var pkWKwebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let pkWebViewConfig = WKWebViewConfiguration()
        pkWebViewConfig.preferences.javaScriptEnabled = true
        pkWebViewConfig.preferences.javaScriptCanOpenWindowsAutomatically = false

        let pkwkUserContentController = WKUserContentController()
        pkWebViewConfig.userContentController = pkwkUserContentController
        pkwkUserContentController.add(self, name: "irtgbefgvwfvc" + "1")
        pkwkUserContentController.add(self, name: "irtgbefgvwfvc" + "12")
        pkwkUserContentController.add(self, name: "irtgbefgvwfvc" + "13")
        pkwkUserContentController.add(self, name: "irtgbefgvwfvc" + "14")
        pkwkUserContentController.add(self, name: "irtgbefgvwfvc" + "15")
        pkwkUserContentController.add(self, name: "irtgbefgvwfvc" + "16")
        pkwkUserContentController.add(self, name: "irtgbefgvwfvc" + "17")
        pkWKwebView = WKWebView(frame: .zero, configuration: pkWebViewConfig)
        pkWKwebView.uiDelegate = self
        pkWKwebView.navigationDelegate = self

        pkShowView.addSubview(pkWKwebView)
        pkWKwebView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        pkWKwebView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        pkWKwebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        pkProgress.tintColor = UIColor.init(hex: "#083AF8")
        pkProgress.trackTintColor = .white
        pkProgress.transform = CGAffineTransform(scaleX: 1, y: 0.7)
        loadWebPage()
        
    }
    
    func loadWebPage() {
        print("URL: \(pkWebUrlStr)")
        pkWebUrlStr = generateFinalURL()
        print("Open URL: \(pkWebUrlStr)")
        guard let url = URL(string: pkWebUrlStr) else { return }
        pkWKwebView.load(URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60))
    }
    
    func generateFinalURL() -> String {
          let separator = pkWebUrlStr.contains("?") ? "&" : "?"
          return "\(pkWebUrlStr)\(separator)\(PKupLoadingManager.upload.getHeader())".replacingOccurrences(of: " ", with: "")
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func pkBackNavigation() {
            if pkWKwebView.canGoBack {
                pkWKwebView.goBack()
            } else {
                if self.presentingViewController != nil {
                    self.dismiss(animated: true)
                } else {
                    navigationController?.popViewController(animated: true)
                }
               
            }
        }
        
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            pkBackNavigation()
            return false
        }
        
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
           
           let name = message.name
           if name.contains("irtgbefgvwfvc1") {
               let webKitVCinfo:[String : Any] = [
                   "EYKwmOjNumismaticFcLRZjO":PKLocationManager.shardManager.pklatitude,
                   "TczbtsRQuagYaOfpJi":PKAppInfo.IDFV,
                   "gVHCbxOSingularizeOaDpSvj": PKLocationManager.shardManager.pklongitude,
                   "AWhegFBBeidaiheTaaByzb":""
               ]
               let data = try? JSONSerialization.data(withJSONObject: webKitVCinfo, options: .prettyPrinted)
               let str = String(data: data!, encoding: String.Encoding.utf8) ?? ""
               
               pkWKwebView.evaluateJavaScript("irtgbefgvwfvc12(\(str))") { _, error in
                  
               }
           }else if name.contains("irtgbefgvwfvc13") {
               if let phone = URL(string: "tel:\(message.body)") {
                   UIApplication.shared.open(phone)
               }
           }else if name.contains("irtgbefgvwfvc14") {
               DispatchQueue.main.async {
                   self.navigationController?.popToRootViewController(animated: true)
                   NotificationCenter.default.post(name: Notification.Name("pktabSelesHome"), object: nil)
               }
           }else if name.contains("irtgbefgvwfvc15") {
               if #available(iOS 14.0, *) {
                   if  let sceneWindow = self.view.window?.windowScene {
                       SKStoreReviewController.requestReview(in: sceneWindow)
                   }
               } else {
                   SKStoreReviewController.requestReview()
               }
           }else if name.contains("irtgbefgvwfvc16") {
               if let url = URL(string: "\(message.body)") {
                   UIApplication.shared.open(url)
               }
           }
       }
       
       
       override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == "title" {
               pkWebTitle.text = pkWKwebView.title
           } else if keyPath == "estimatedProgress" {
               if let newProgress = change?[.newKey] as? Double {
                   DispatchQueue.main.async {
                       self.pkProgress.setProgress(Float(newProgress), animated: true)

                       if newProgress >= 1.0 {
                           UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut) {
                               self.pkProgress.alpha = 0.0
                           } completion: { _ in
                               self.pkProgress.isHidden = true
                               self.pkProgress.setProgress(0.0, animated: false)
                           }
                       } else {
                           self.pkProgress.alpha = 1.0
                           self.pkProgress.isHidden = false
                       }
                   }
               }
           } else {
               super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
           }
       }
    
}


