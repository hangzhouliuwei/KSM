//
//  AppDelegate.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        let homeVC = UINavigationController(rootViewController: LPHomeVC())
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
        
        Request.reachNetwork()
        
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        LPDataManager.shared.dealDomains(userActivity: userActivity)
        return true
    }
}

