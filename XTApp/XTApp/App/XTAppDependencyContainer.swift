//
//  XTAppDependencyContainer.swift
//  XTApp
//

import UIKit

final class XTAppDependencyContainer {
    let sessionManager: SessionManaging

    init(sessionManager: SessionManaging = UserSession.shared) {
        self.sessionManager = sessionManager
    }

    func makeRootRouter(window: UIWindow?) -> XTRootRouter {
        XTRootRouter(
            window: window,
            mainViewControllerFactory: { XTTabBarController() },
            loginViewControllerFactory: { Self.makeViewController(named: "XTLoginCodeVC") }
        )
    }

    func makeLaunchCoordinator(rootRouter: XTRootRouting) -> XTLaunchCoordinator {
        XTLaunchCoordinator(sessionManager: sessionManager, rootRouter: rootRouter)
    }

    private static func makeViewController(named name: String) -> UIViewController {
        (NSClassFromString(name) as? NSObject.Type)?.init() as? UIViewController ?? UIViewController()
    }
}