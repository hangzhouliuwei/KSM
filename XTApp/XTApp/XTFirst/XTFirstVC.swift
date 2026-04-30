//
//  XTFirstVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import UIKit

@objcMembers
@objc(XTFirstVC)
class XTFirstVC: XTBaseVC, UITableViewDelegate, UITableViewDataSource {
    private let viewModel = XTFirstViewModel()
    private var listArr: [XTCellModel] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 10.0, *) {
            let refresh = UIRefreshControl()
            refresh.addTarget(self, action: #selector(goFirst), for: .valueChanged)
            tableView.refreshControl = refresh
        }
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goFirst()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xt_bkBtn.isHidden = true

        let iconImg = UIImageView(image: XT_Img("xt_login_icon"))
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        xt_navView.addSubview(iconImg)

        let appNameLab = UILabel()
        appNameLab.text = XT_App_Name
        appNameLab.font = XT_Font_SD(16)
        appNameLab.textColor = .white
        appNameLab.translatesAutoresizingMaskIntoConstraints = false
        xt_navView.addSubview(appNameLab)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        xtFirstActivate([
            iconImg.leftAnchor.constraint(equalTo: xt_navView.leftAnchor, constant: 20),
            iconImg.centerYAnchor.constraint(equalTo: xt_bkBtn.centerYAnchor),
            appNameLab.leftAnchor.constraint(equalTo: iconImg.rightAnchor, constant: 10),
            appNameLab.centerYAnchor.constraint(equalTo: xt_bkBtn.centerYAnchor),

            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: xt_navView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -XT_Tabbar_Height)
        ])

        viewModel.xt_popUpSuccess { [weak self] imgUrl, url, buttonText in
            guard let self, !NSString.xt_isEmpty(url) else { return }
            self.xt_popImg(imgUrl, url: url, text: buttonText)
        } failure: {
        }
    }

    @objc(xt_popImg:url:text:)
    func xt_popImg(_ img: String, url: String, text: String) {
        let pop = XTPopUpView(imgUrl: img, url: url, text: text)
        pop.center = view.center
        view.addSubview(pop)
        pop.closeBlock = { [weak pop] in
            pop?.removeFromSuperview()
        }
    }

    @objc func goFirst() {
        viewModel.getFirstSuccess { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
            self?.createCellModel()
        } failure: { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
        }
    }

    @objc func createCellModel() {
        guard let indexModel = viewModel.indexModel else { return }
        if let icon = indexModel.iconModel {
            XTAssistiveView.xt_share().xt_showIcon(icon.iconURL ?? "", url: icon.targetURL ?? "")
        }
        listArr.removeAll()

        if let big = indexModel.big {
            let model = XTCellModel.xt_cellClassName("XTBigCell", height: 420, model: big)
            (model.indexCell as? XTBigCell)?.nextBlock = { [weak self] in
                self?.checkApply(big.productId)
            }
            listArr.append(model)
            listArr.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 10, model: nil))
            listArr.append(XTCellModel.xt_cellClassName("XTBannerCell", height: 115, model: indexModel.bannerArr ?? []))
            listArr.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 4, model: nil))
            listArr.append(XTCellModel.xt_cellClassName("XTFirstFootCell", height: 102, model: nil))
            listArr.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 10, model: nil))
        } else {
            var height: CGFloat = 128 + 182 + 6
            if !(indexModel.lanternArr ?? []).isEmpty {
                height += 28 + 12
            }
            if !(indexModel.bannerArr ?? []).isEmpty {
                height += 115 + 12
            }
            let model = XTCellModel.xt_cellClassName("XTSmallCell", height: height, model: indexModel)
            (model.indexCell as? XTSmallCell)?.nextBlock = { [weak self] in
                self?.checkApply(indexModel.small?.productId)
            }
            listArr.append(model)

            if let notice = indexModel.noticeModel {
                listArr.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 12, model: nil))
                listArr.append(XTCellModel.xt_cellClassName("XTNoticeCell", height: 67, model: notice))
            }
            listArr.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 12, model: nil))

            for item in indexModel.productArr ?? [] {
                let product = XTCellModel.xt_cellClassName("XTProductCell", height: 113, model: item)
                (product.indexCell as? XTProductCell)?.nextBlock = { [weak self] in
                    self?.checkApply(item.productId)
                }
                listArr.append(product)
                listArr.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 12, model: nil))
            }
        }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        listArr[indexPath.row].indexCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        listArr[indexPath.row].height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc(checkApply:)
    func checkApply(_ productId: String?) {
        LoanEntryCoordinator.shared.startApplication(productId: productId, from: self, source: .home)
    }

    @objc(checkLBS:isList:)
    func checkLBS(_ block: XTBlock?, isList: Bool) {
        LoanEntryCoordinator.shared.ensureLocationAccess(from: self, skip: isList) {
            block?()
        }
    }

    @objc(goApply:)
    func goApply(_ productId: String) {
        LoanEntryCoordinator.shared.performApply(productId: productId, from: self, source: .home)
    }

    @objc(goDetail:)
    func goDetail(_ productId: String) {
        LoanFlowCoordinator.shared.continueAfterDetail(productId: productId, loadingView: view)
    }
}