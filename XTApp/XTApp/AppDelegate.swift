//
//  AppDelegate.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import AppTrackingTransparency
import IQKeyboardManager
import UIKit

@main
@objc(AppDelegate)
class AppDelegate: UIResponder, UIApplicationDelegate {
    @objc var window: UIWindow?
    @objc var xt_nv: XTNavigationController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        XTDevice.xt_share().xt_checkNetWork { haveNetwork in
            guard haveNetwork else { return }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if #available(iOS 14.0, *) {
                    XTDevice.fixTrackingAuthorization { _ in
                        self.reportIdfa()
                    }
                } else {
                    self.reportIdfa()
                }
            }
        }

        if XTUserManger.xt_isLogin() {
            xt_mainView()
        } else {
            xt_loginView()
        }

        xt_publicDisposition()
        return true
    }

    private func reportIdfa() {
        XTDevice.xt_getIdfaShowAlt(true) { idfa in
            XTRequestCenter.xt_share().xt_market(idfa)
        }
    }

    private func xt_publicDisposition() {
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnabled = true

        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        UITableView.appearance().estimatedSectionHeaderHeight = 0
        UITableView.appearance().estimatedSectionFooterHeight = 0
    }

    @objc func xt_mainView() {
        let mainVC = XTTabBarController()
        let navigationController = XTNavigationController(rootViewController: mainVC)
        window?.rootViewController = navigationController
        xt_nv = navigationController
    }

    @objc func xt_loginView() {
        xt_nv = nil
        let codeVC = XTLoginCodeVC()
        let navigationController = XTNavigationController(rootViewController: codeVC)
        window?.rootViewController = navigationController
    }
}
