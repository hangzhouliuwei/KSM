//
//  PKTabBarViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit

class PKTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.layer.cornerRadius = 25
        tabBar.layer.masksToBounds = true
        NotificationCenter.default.addObserver(self, selector:  #selector(pktabSelesHome(_:)), name: Notification.Name("pktabSelesHome"), object: nil)

    }

    override func viewDidLayoutSubviews() {
        var frame = self.tabBar.frame
        frame.size.height = 50
        frame.origin.y = self.view.frame.size.height - frame.size.height - 16 - safe_PK_bottom
        frame.origin.x = 12
        frame.size.width = self.view.frame.size.width - 24
        self.tabBar.frame = frame
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.4
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        tabBar.layer.shadowRadius = 5
    }
    
    @objc func pktabSelesHome(_ notification: Notification) {
        
        DispatchQueue.main.async {
            self.selectedIndex = 0
        }
    }
    
}

extension PKTabBarViewController: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let pageClass = type(of: viewController)
        if PKUserManager.pkisLogin() {
            return true
        }else {
            if pageClass == PKOrderViewController.self || pageClass == PKPersonalViewController.self {
                PKUserManager.pkgotoLogin()
                return false
            }else {
                return true
            }
        }
    }
    
}
