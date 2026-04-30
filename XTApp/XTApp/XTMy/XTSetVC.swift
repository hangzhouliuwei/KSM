//
//  XTSetVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import UIKit
import YFPopView

@objcMembers
@objc(XTSetVC)
class XTSetVC: XTBaseVC, UITableViewDelegate, UITableViewDataSource {
    private var list: [XTCellModel] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        xt_backType = XT_BackType_B
        xt_navView.backgroundColor = .clear
        xt_title = "Set Up"

        let topBG = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 97 + XT_Nav_Height))
        topBG.backgroundColor = .white
        topBG.layer.addSublayer(UIView.xt_layer(
            [XT_RGB(0x0BB559, 1.0).cgColor, UIColor.white.cgColor],
            locations: [0, 1.0],
            startPoint: CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 0.6),
            size: topBG.size
        ))
        view.addSubview(topBG)
        view.bringSubviewToFront(xt_navView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        xtMyActivate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: xt_navView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        createModel()
    }

    @objc func createModel() {
        list.removeAll()
        list.append(XTCellModel.xt_cellClassName("XTSetIconCell", height: 251, model: nil))
        list.append(XTCellModel.xt_cellClassName("XTSetCell", height: 48, model: ["title": "Website", "content": "https://www.providence-lending-corp.com"]))
        list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 20, model: nil))
        list.append(XTCellModel.xt_cellClassName("XTSetCell", height: 48, model: ["title": "Email", "content": "cs@providence-lending-corp.com"]))
        list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 20, model: nil))
        list.append(XTCellModel.xt_cellClassName("XTSetCell", height: 48, model: ["title": "Edition", "content": XT_App_Version]))
        list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 65, model: nil))

        let logout = XTCellModel.xt_cellClassName("XTLoginOutCell", height: 48, model: nil)
        (logout.indexCell as? XTLogoutCell)?.block = { [weak self] in self?.confirmLogout() }
        list.append(logout)
        list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 22, model: nil))

        let cancel = XTCellModel.xt_cellClassName("XTCancelCell", height: 48, model: nil)
        (cancel.indexCell as? XTCancelCell)?.block = { [weak self] in self?.nextCancelAccount() }
        list.append(cancel)
        list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 20, model: nil))
        if XT_Bottom_Height > 0 {
            list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: XT_Bottom_Height, model: nil))
        }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        list[indexPath.row].indexCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        list[indexPath.row].height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func confirmLogout() {
        showAlt("Are you sure you want to\n leave this software?") {
            XTLogoutApi().xt_startRequestSuccess { _, _ in
                UserSession.shared.logout()
            } failure: { _, _ in
            } error: { _ in
            }
        }
    }

    @objc func nextCancelAccount() {
        showAlt("Are you sure you want to\n cancel account?") {
            XTDelAccountApi().xt_startRequestSuccess { _, _ in
                UserSession.shared.logout()
            } failure: { _, _ in
            } error: { _ in
            }
        }
    }

    @objc(showAlt:block:)
    func showAlt(_ alt: String, block: XTBlock?) {
        let altView = XTSetAltView(alt: alt)
        altView.center = view.center
        let popView = YFPopView(animationView: altView)
        popView?.animationStyle = .fade
        popView?.autoRemoveEnable = true
        popView?.show(on: view)
        altView.sureBlock = {
            popView?.removeSelf()
            popView?.didDismiss = { _ in block?() }
        }
        altView.cancelBlock = {
            popView?.removeSelf()
        }
    }
}