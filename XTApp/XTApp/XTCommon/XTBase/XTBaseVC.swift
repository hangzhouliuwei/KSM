//
//  XTBaseVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

private let baseNavBarHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 44.0 : 50.0

private var baseNavHeight: CGFloat {
    UIApplication.shared.statusBarFrame.size.height + baseNavBarHeight
}

class XTBaseVC: UIViewController {

    // MARK: - Nav View

    lazy var xt_navView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: baseNavHeight))
        view.backgroundColor = XT_RGB(0x0BB559)
        return view
    }()

    lazy var xt_bkBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let img = UIImageView(image: UIImage(named: "xt_nav_back_w"))
        img.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(img)
        backImageView = img
        NSLayoutConstraint.activate([
            img.leftAnchor.constraint(equalTo: btn.leftAnchor, constant: 16),
            img.centerYAnchor.constraint(equalTo: btn.centerYAnchor)
        ])
        btn.addTarget(self, action: #selector(xt_back), for: .touchUpInside)
        return btn
    }()

    var xt_title: String? {
        didSet { titleLabel.text = xt_title }
    }

    var xt_title_color: UIColor? {
        didSet { titleLabel.textColor = xt_title_color }
    }

    var xt_backType: NavBackType = .white {
        didSet {
            if xt_backType == .black {
                backImageView?.image = UIImage(named: "xt_nav_back_b")
            }
        }
    }

    // MARK: - Private

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private weak var backImageView: UIImageView?

    // MARK: - Lifecycle

    deinit {
        XTLog("dealloc:", NSStringFromClass(type(of: self)))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let hiddenTypes: [XTBaseVC.Type] = [XTHtmlVC.self, XTLoginCodeVC.self]
        let shouldHide = hiddenTypes.contains { isKind(of: $0) }
        XTAssistiveView.shared.isHidden = shouldHide
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
    }

    // MARK: - Navigation

    @objc func xt_back() {
        if navigationController?.popViewController(animated: true) == nil {
            dismiss(animated: true)
        }
    }

    // MARK: - Private setup

    private func setupNavigation() {
        view.addSubview(xt_navView)

        xt_bkBtn.translatesAutoresizingMaskIntoConstraints = false
        xt_navView.addSubview(xt_bkBtn)
        NSLayoutConstraint.activate([
            xt_bkBtn.leftAnchor.constraint(equalTo: xt_navView.leftAnchor),
            xt_bkBtn.bottomAnchor.constraint(equalTo: xt_navView.bottomAnchor),
            xt_bkBtn.widthAnchor.constraint(equalToConstant: 60),
            xt_bkBtn.heightAnchor.constraint(equalToConstant: baseNavBarHeight)
        ])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        xt_navView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: xt_bkBtn.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: xt_navView.centerXAnchor)
        ])
    }
}

// MARK: - Present helper

extension XTBaseVC {
    func xt_presentViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?,
        modalPresentationStyle: UIModalPresentationStyle
    ) {
        viewController.modalPresentationStyle = modalPresentationStyle
        present(viewController, animated: animated, completion: completion)
    }
}
