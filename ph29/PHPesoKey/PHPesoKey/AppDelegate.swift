//
//  AppDelegate.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        for family in UIFont.familyNames {
//            print("Family: \(family)")
//            for fontName in UIFont.fontNames(forFamilyName: family) {
//                print(" \(fontName)")
//            }
//        }
        PKupLoadingManager.upload.initLoading()
        
        return true
    }

    


}

