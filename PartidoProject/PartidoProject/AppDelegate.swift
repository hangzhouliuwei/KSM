//
//  AppDelegate.swift
//  PartidoProject
//
//  Created by Buller on 2025/1/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let tabVC = PartidoBaseTabBarController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let rootNavigationController = UINavigationController(rootViewController: tabVC)
        window?.rootViewController = rootNavigationController
        return true
    }


}

