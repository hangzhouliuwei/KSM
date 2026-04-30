//
//  XTVerifyShared.swift
//  XTApp
//

import UIKit

func xtVerifyActivate(_ constraints: [NSLayoutConstraint]) {
    NSLayoutConstraint.activate(constraints)
}

func xtVerifyPoint(productId: String, startTime: String, type: String) -> [String: Any] {
    [
        "deamsixatoryNc": XT_Object_To_Stirng(startTime),
        "munisixumNc": XT_Object_To_Stirng(productId),
        "hyrasixrthrosisNc": type,
        "boomsixofoNc": XT_Object_To_Stirng(XTLocationManager.shared.xt_latitude),
        "unulsixyNc": XT_Object_To_Stirng(XTUtility.xt_share().xt_nowTimeStamp()),
        "cacosixtomyNc": XT_Object_To_Stirng(XTDevice.xt_share().xt_idfv),
        "unevsixoutNc": XT_Object_To_Stirng(XTLocationManager.shared.xt_longitude)
    ]
}

func xtVerifyEnsureLocation() {
    if NSString.xt_isEmpty(XTLocationManager.shared.xt_longitude) || NSString.xt_isEmpty(XTLocationManager.shared.xt_latitude) {
        XTLocationManager.shared.xt_startLocation()
    }
}

func xtVerifyShowOverlay(_ overlay: UIView, from view: UIView) {
    let host = XT_AppDelegate?.window ?? view
    overlay.frame = host.bounds
    host.addSubview(overlay)
}

extension XTBaseVC {
    func xtVerifySetupTable(_ tableView: UITableView, submitButton: UIButton, headerType: XT_VerifyType) {
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        xtVerifyActivate([
            submitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -XT_Bottom_Height - 20),
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: xt_navView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20)
        ])
        tableView.tableHeaderView = XTVerifyHeadView(frame: CGRect(x: 0, y: 0, width: view.width, height: 94), type: headerType)
    }

    func xtVerifyConfirmLeave() {
        view.endEditing(true)
        let alert = UIAlertController(title: nil, message: "Are you sure you want to\n leave?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }

    func xtVerifyRemoveSelf() {
        guard var controllers = navigationController?.viewControllers else { return }
        controllers.removeAll { $0 === self }
        navigationController?.viewControllers = controllers
    }
}

func xtVerifyTable(style: UITableView.Style) -> UITableView {
    let tableView = UITableView(frame: .zero, style: style)
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.estimatedRowHeight = 50
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.tableFooterView = UIView(frame: .zero)
    tableView.showsHorizontalScrollIndicator = false
    tableView.showsVerticalScrollIndicator = false
    return tableView
}

func xtVerifySubmitButton(title: String, target: Any, action: Selector) -> UIButton {
    let button = UIButton.xt_btn(title, font: XT_Font_B(title == "Start" ? 20 : 24), textColor: .white, cornerRadius: 24, tag: 0)
    button.backgroundColor = XT_RGB(0x02CC56, 1.0)
    button.addTarget(target, action: action, for: .touchUpInside)
    return button
}