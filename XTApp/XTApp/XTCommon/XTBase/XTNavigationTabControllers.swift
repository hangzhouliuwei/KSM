//
//  XTNavigationTabControllers.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

class XTNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    weak var xt_currentVC: UIViewController?

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        xt_currentVC = navigationController.viewControllers.count == 1 ? nil : viewController
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            let className = visibleViewController.map { NSStringFromClass(type(of: $0)) } ?? ""
            if ["XTVerifyBaseVC", "XTVerifyContactVC", "XTOCRVC", "XTVerifyBankVC", "XTHtmlVC"].contains(className) {
                (visibleViewController as? XTBaseVC)?.xt_back()
                return false
            }
            return xt_currentVC == topViewController
        }
        return true
    }
}

class XTTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let unSelectColor = xtColor(0xA1DEC5, alpha: 1.0)
        let selectColor = xtColor(0x32B986, alpha: 1.0)

        UITabBarItem.appearance().setTitleTextAttributes([
            .foregroundColor: unSelectColor,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([
            .foregroundColor: selectColor,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ], for: .selected)

        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        tabBar.tintColor = selectColor
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = unSelectColor
        }
        UITabBar.appearance().backgroundColor = .white

        viewControllers = [
            xt_childVC(with: xtController("XTFirstVC"), title: nil, normalImg: "xt_tabbar_item_first_no", selectedImg: "xt_tabbar_item_first_yes"),
            xt_childVC(with: xtController("XTMyVC"), title: nil, normalImg: "xt_tabbar_item_my_no", selectedImg: "xt_tabbar_item_my_yes")
        ]
    }

    func xt_childVC(with vc: UIViewController, title: String?, normalImg: String, selectedImg: String) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: normalImg)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImg)?.withRenderingMode(.alwaysOriginal)
        return vc
    }

    private func xtController(_ name: String) -> UIViewController {
        (NSClassFromString(name) as? NSObject.Type)?.init() as? UIViewController ?? UIViewController()
    }

    private func xtColor(_ rgbValue: Int, alpha: CGFloat) -> UIColor {
        UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
