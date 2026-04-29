//
//  XTVerifyBaseVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import UIKit

@objcMembers
@objc(XTVerifyBaseVC)
class XTVerifyBaseVC: XTBaseVC, UITableViewDelegate, UITableViewDataSource {
    private let viewModel = XTVerifyViewModel()
    private var productId = ""
    private var orderId = ""
    private var startTime = ""
    private var cellList: [UITableViewCell] = []
    private lazy var tableView = xtVerifyTable(style: .grouped)
    private lazy var submitBtn: UIButton = xtVerifySubmitButton(title: "Next", target: self, action: #selector(goSubmit))

    @objc(initWithProductId:orderId:)
    init(productId: String, orderId: String) {
        self.productId = productId
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xtVerifyEnsureLocation()
        startTime = XTUtility.xt_share().xt_nowTimeStamp()
        xt_title = "Basic"
        xt_title_color = .white
        view.backgroundColor = XT_RGB(0xF7F7F7, 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        xtVerifySetupTable(tableView, submitButton: submitBtn, headerType: XT_Verify_Base)
        viewModel.xt_person(productId, success: { [weak self] in
            self?.creatCell()
            self?.tableView.reloadData()
        }, failure: {
        })
    }

    @objc func creatCell() {
        cellList.removeAll()
        for section in viewModel.baseModel?.items ?? [] {
            if section.xt_more {
                section.hiddenChild = true
            }
            for model in section.list ?? [] {
                let cell: UITableViewCell
                if model.xt_cate == "AASIXTENBG" || model.xt_cate == "AASIXTENBL" {
                    cell = XTTextCell(style: .default, reuseIdentifier: nil)
                } else {
                    cell = XTSelectCell(style: .default, reuseIdentifier: nil)
                }
                model.cell = cell
                cellList.append(cell)
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.baseModel?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = viewModel.baseModel?.items?[section]
        if sectionModel?.xt_more == true && sectionModel?.hiddenChild == true {
            return 0
        }
        return sectionModel?.list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel.baseModel?.items?[indexPath.section].list?[indexPath.row] else {
            return XTCell(style: .default, reuseIdentifier: nil)
        }
        if let cell = model.cell as? XTTextCell {
            cell.model = model
            return cell
        }
        let cell = (model.cell as? XTSelectCell) ?? XTSelectCell(style: .default, reuseIdentifier: nil)
        cell.model = model
        weak var weakCell: UITableViewCell? = cell
        cell.selectBlock = { [weak self, weak model] block in
            guard let self, let model else { return }
            let completion: XTDicBlock = { dic in
                if let weakCell {
                    self.xt_nextCell(weakCell)
                }
                block?(dic)
            }
            if model.xt_cate == "AASIXTENBJ" {
                self.xt_selectDay(model, block: completion)
            } else {
                self.xt_select(model, block: completion)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = viewModel.baseModel?.items?[section]
        let view = UIView()
        view.backgroundColor = section == 0 ? self.view.backgroundColor : .clear
        let label = UILabel()
        label.font = XT_Font_M(sectionModel?.xt_more == true ? 14 : 12)
        label.textColor = sectionModel?.xt_more == true ? XT_RGB(0xF8FFC7, 1.0) : XT_RGB(0x02CC56, 1.0)
        label.text = sectionModel?.xt_title
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        xtVerifyActivate([
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        if sectionModel?.xt_more == true {
            view.backgroundColor = XT_RGB(0x02CC56, 1.0)
            label.attributedText = NSString.xt_strs(
                [sectionModel?.xt_title ?? "", sectionModel?.xt_sub_title ?? ""],
                fonts: [XT_Font_M(14), XT_Font(9)],
                colors: [XT_RGB(0xF8FFC7, 1.0), .black]
            )
            let more = UIButton.xt_btn(sectionModel?.hiddenChild == true ? "More" : "Hidden", font: XT_Font_M(12), textColor: .black, cornerRadius: 5, tag: section)
            more.backgroundColor = XT_RGB(0xFDFF00, 1.0)
            more.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
            more.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(more)
            xtVerifyActivate([
                more.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                more.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                more.widthAnchor.constraint(equalToConstant: 50),
                more.heightAnchor.constraint(equalToConstant: 26)
            ])
        }
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionModel = viewModel.baseModel?.items?[section] else { return 0.01 }
        if section == 0 { return 32 }
        return sectionModel.xt_more ? 40 : 22
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.01
    }

    @objc private func toggleSection(_ sender: UIButton) {
        guard let sectionModel = viewModel.baseModel?.items?[sender.tag] else { return }
        sectionModel.hiddenChild.toggle()
        for item in sectionModel.list ?? [] {
            item.isHiddenCell = sectionModel.hiddenChild
        }
        tableView.reloadData()
    }

    @objc(xt_selectDay:block:)
    func xt_selectDay(_ model: XTListModel, block: XTDicBlock?) {
        let select = XTSelectDayView(tit: model.xt_title ?? "")
        select.xt_value(model.value)
        select.closeBlock = { [weak select] in select?.removeFromSuperview() }
        select.sureBlock = block
        xtVerifyShowOverlay(select, from: view)
    }

    @objc(xt_select:block:)
    func xt_select(_ model: XTListModel, block: XTDicBlock?) {
        let select = XTSelectView(tit: model.xt_title ?? "", arr: model.noteList ?? [])
        select.xt_value(model.value)
        select.closeBlock = { [weak select] in select?.removeFromSuperview() }
        select.sureBlock = block
        xtVerifyShowOverlay(select, from: view)
    }

    @objc(xt_nextCell:)
    func xt_nextCell(_ indexCell: UITableViewCell) {
        guard let index = cellList.firstIndex(of: indexCell), index + 1 < cellList.count else { return }
        let nextCell = cellList[index + 1]
        if let select = nextCell as? XTSelectCell, select.model?.isHiddenCell == false, NSString.xt_isEmpty(select.model?.value) {
            select.becomeFirst()
        } else if let text = nextCell as? XTTextCell, text.model?.isHiddenCell == false, NSString.xt_isEmpty(text.model?.value) {
            text.becomeFirst()
        }
    }

    override func xt_back() {
        xtVerifyConfirmLeave()
    }

    @objc func goSubmit() {
        var dic: [String: Any] = [:]
        for section in viewModel.baseModel?.items ?? [] {
            for model in section.list ?? [] {
                if !model.xt_optional && NSString.xt_isEmpty(model.value) {
                    XTUtility.xt_showTips(model.xt_subtitle, view: view)
                    return
                }
                if !NSString.xt_isEmpty(model.value) {
                    dic[XT_Object_To_Stirng(model.xt_code)] = XT_Object_To_Stirng(model.value)
                }
            }
        }
        dic["lietsixusNc"] = XT_Object_To_Stirng(productId)
        dic["point"] = xtVerifyPoint(productId: productId, startTime: startTime, type: "22")
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_person_next(NSDictionary(dictionary: dic), success: { [weak self] str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.goNext(str)
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    @objc(goNext:)
    func goNext(_ str: String?) {
        LoanFlowCoordinator.shared.routeNext(code: str, productId: productId, orderId: orderId, loadingView: view, removeCurrentController: self)
    }
}