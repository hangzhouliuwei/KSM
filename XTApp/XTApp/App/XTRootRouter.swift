//
//  XTRootRouter.swift
//  XTApp
//

import UIKit

enum XTAppRootDestination {
    case login
    case main
}

protocol XTRootRouting: AnyObject {
    var navigationController: XTNavigationController? { get }
    func setRoot(_ destination: XTAppRootDestination, animated: Bool)
}

final class XTRootRouter: XTRootRouting {
    private weak var window: UIWindow?
    private let mainViewControllerFactory: () -> UIViewController
    private let loginViewControllerFactory: () -> UIViewController

    var onNavigationControllerChange: ((XTNavigationController?) -> Void)?

    private(set) var navigationController: XTNavigationController? {
        didSet {
            onNavigationControllerChange?(navigationController)
        }
    }

    init(
        window: UIWindow?,
        mainViewControllerFactory: @escaping () -> UIViewController,
        loginViewControllerFactory: @escaping () -> UIViewController
    ) {
        self.window = window
        self.mainViewControllerFactory = mainViewControllerFactory
        self.loginViewControllerFactory = loginViewControllerFactory
    }

    func setRoot(_ destination: XTAppRootDestination, animated: Bool) {
        guard let window else { return }

        let rootController = makeNavigationController(for: destination)
        navigationController = destination == .main ? rootController : nil

        let installRootController = {
            window.rootViewController = rootController
            window.makeKeyAndVisible()
        }

        guard animated, window.rootViewController != nil else {
            installRootController()
            return
        }

        UIView.transition(
            with: window,
            duration: 0.25,
            options: [.transitionCrossDissolve, .allowAnimatedContent],
            animations: installRootController
        )
    }

    private func makeNavigationController(for destination: XTAppRootDestination) -> XTNavigationController {
        let rootViewController: UIViewController

        switch destination {
        case .login:
            rootViewController = loginViewControllerFactory()
        case .main:
            rootViewController = mainViewControllerFactory()
        }

        return XTNavigationController(rootViewController: rootViewController)
    }
}