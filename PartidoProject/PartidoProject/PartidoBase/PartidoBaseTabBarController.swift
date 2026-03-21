//
//  PartidoBaseTabBarController.swift
//  PartidoProject
//
//  Created by liuwei on 2025/1/21.
//

import UIKit

class PartidoBaseTabBarController: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        initAppSDK()
        initAppTabPages()
        
    }
    
    func initAppSDK () {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.resignOnTouchOutside = true
    }
    
    func initAppTabPages(){
        self.tabBar.backgroundColor = .white
        self.viewControllers = Tab.allCases.map { $0.viewController }
        
    }

}


extension PartidoBaseTabBarController {
    enum Tab: CaseIterable {
        case home
        case mine

        var viewController: UIViewController {
            switch self {
            case .home:
                let vc = PartidoHomeViewController()
                vc.tabBarItem = UITabBarItem(
                    title: nil,
                    image: UIImage(named: "tab1")?.withRenderingMode(.alwaysOriginal),
                    selectedImage: UIImage(named: "tabs1")?.withRenderingMode(.alwaysOriginal)
                )
                return vc

            case .mine:
                let vc = PartidoMineViewController()
                vc.tabBarItem = UITabBarItem(
                    title: nil,
                    image: UIImage(named: "tab3")?.withRenderingMode(.alwaysOriginal),
                    selectedImage: UIImage(named: "tabs3")?.withRenderingMode(.alwaysOriginal)
                )
                return vc
            }
        }
    }
}
