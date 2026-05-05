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
    private var dependencyContainer: XTAppDependencyContainer?
    private var rootRouter: XTRootRouter?
    private var launchCoordinator: XTLaunchCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        self.window = window
        configureAppFlow(window: window)
        window.makeKeyAndVisible()

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

        xt_publicDisposition()
        launchCoordinator?.start()
        return true
    }

    private func configureAppFlow(window: UIWindow) {
        let dependencyContainer = XTAppDependencyContainer()
        let rootRouter = dependencyContainer.makeRootRouter(window: window)
        rootRouter.onNavigationControllerChange = { [weak self] navigationController in
            self?.xt_nv = navigationController
        }

        self.dependencyContainer = dependencyContainer
        self.rootRouter = rootRouter
        launchCoordinator = dependencyContainer.makeLaunchCoordinator(rootRouter: rootRouter)
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
        rootRouter?.setRoot(.main, animated: false)
    }

    @objc func xt_loginView() {
        rootRouter?.setRoot(.login, animated: false)
    }
}
