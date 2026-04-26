//
//  XTHtmlVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import StoreKit
import UIKit
import WebKit

@objcMembers
@objc(XTHtmlVC)
class XTHtmlVC: XTBaseVC, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    private var url = ""
    private let viewModel = XTFirstViewModel()
    private let jslist = ["six001", "six002", "six003", "six004", "six005", "six006", "six007"]
    private var titleObservation: NSKeyValueObservation?
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: xt_navView.frame.maxY, width: view.width, height: view.height - xt_navView.frame.maxY - XT_Bottom_Height))
        webView.uiDelegate = self
        webView.navigationDelegate = self
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        titleObservation = webView.observe(\.title, options: .new) { [weak self] webView, _ in
            self?.xt_title = webView.title
        }
        return webView
    }()
    private lazy var progress: XTWebViewProgressView = {
        let progress = XTWebViewProgressView(frame: CGRect(x: 0, y: xt_navView.height - 2, width: xt_navView.width, height: 2))
        progress.useWebView(webView)
        progress.progressColor = XT_RGB(0xF3FF9B, 1.0)
        return progress
    }()

    @objc(initUrl:)
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        titleObservation?.invalidate()
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jslist.forEach { webView.configuration.userContentController.add(self, name: $0) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        jslist.forEach { webView.configuration.userContentController.removeScriptMessageHandler(forName: $0) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if NSString.xt_isEmpty(XTLocationManger.xt_share().xt_longitude) || NSString.xt_isEmpty(XTLocationManger.xt_share().xt_latitude) {
            XTLocationManger.xt_share().xt_startLocation()
        }
        view.addSubview(webView)
        xt_navView.addSubview(progress)
        let targetURL = XTBaseApi().webUrlAppendQueryParameter(toUrl: url)
        if let url = URL(string: targetURL) {
            webView.load(URLRequest(url: url))
        }
    }

    override func xt_back() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
           let scheme = url.scheme,
           (scheme.contains("whatsapp") || scheme.contains("mailto")),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let parameter = XT_Object_To_Stirng(message.body)
        switch message.name {
        case "six001":
            XTDevice.xt_getIdfaShowAlt(false) { [weak self] idfa in
                let dic: [String: Any] = [
                    "boomsixofoNc": XT_Object_To_Stirng(XTLocationManger.xt_share().xt_latitude),
                    "cacosixtomyNc": XT_Object_To_Stirng(XTDevice.xt_share().xt_idfv),
                    "unevsixoutNc": XT_Object_To_Stirng(XTLocationManger.xt_share().xt_longitude),
                    "spdisixlleNc": XT_Object_To_Stirng(idfa)
                ]
                let js = "six002(\(XTUtility.xt_objectToJSONString(dic) ?? "{}"))"
                self?.webView.evaluateJavaScript(js)
            }
        case "six003":
            if let url = URL(string: "tel:\(parameter)") {
                UIApplication.shared.open(url, options: [:])
            }
        case "six004":
            popHome()
        case "six005":
            if #available(iOS 14.0, *), let scene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: scene)
            } else if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        case "six006":
            if let url = URL(string: parameter) {
                UIApplication.shared.open(url, options: [:])
            }
        case "six007":
            handleNativeJump(parameter)
        default:
            break
        }
    }

    private func handleNativeJump(_ parameter: String) {
        if NSString.xt_isValidateUrl(parameter) {
            XTRoute.xt_share().goHtml(parameter, success: nil)
        } else if parameter.contains("zzsixzy") {
            navigationController?.pushViewController(XT_Controller_Init("XTSetVC"), animated: true)
        } else if parameter.contains("zzsixzz") {
            popHome()
        } else if parameter.contains("zzsixzx") {
            XTUtility.xt_login(nil)
        } else if parameter.contains("zzsixzw") {
            navigationController?.pushViewController(XT_Controller_Init("XTOrderVC"), animated: true)
        } else if parameter.contains("zzsixzv"),
                  let productId = parameter.components(separatedBy: "lietsixusNc=").last {
            checkApply(productId)
        }
    }

    private func popHome() {
        guard let first = navigationController?.viewControllers.first else { return }
        (first as? UITabBarController)?.selectedIndex = 0
        navigationController?.popToViewController(first, animated: true)
    }

    private func checkApply(_ productId: String) {
        guard !NSString.xt_isEmpty(productId) else { return }
        guard XTUserManger.xt_isLogin() else {
            XTUtility.xt_login { [weak self] in
                self?.checkApply(productId)
            }
            return
        }
        if XTUserManger.xt_share().xt_user?.xt_is_aduit == true {
            goApply(productId)
            return
        }
        guard XTLocationManger.xt_share().xt_canLocation() else {
            let alert = UIAlertController(title: "Tips", message: "To be able to use our app, please turn on your device location services.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:])
                }
            })
            xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
            return
        }
        XTUtility.xt_showProgress(view, message: "loading...")
        XTRequestCenter.xt_share().xt_location { [weak self] success in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            if success {
                self.goApply(productId)
            }
        }
    }

    private func goApply(_ productId: String) {
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_apply(productId) { [weak self] uploadType, url, _ in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            if uploadType == 2 {
                XTRequestCenter.xt_share().xt_device()
            }
            if NSString.xt_isValidateUrl(url) {
                XTRoute.xt_share().goHtml(url, success: nil)
            } else {
                self.goDetail(productId)
            }
        } failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        }
    }

    private func goDetail(_ productId: String) {
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_detail(productId) { [weak self] code, orderId in
            guard let self else { return }
            if !NSString.xt_isEmpty(code) {
                XTUtility.xt_atHideProgress(self.view)
                XTRoute.xt_share().goVerifyItem(code ?? "", productId: productId, orderId: orderId ?? "", success: nil)
            } else if let orderId {
                self.viewModel.xt_push(orderId) { url in
                    XTUtility.xt_atHideProgress(self.view)
                    XTRoute.xt_share().goHtml(url ?? "", success: nil)
                } failure: {
                    XTUtility.xt_atHideProgress(self.view)
                }
            }
        } failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        }
    }
}
