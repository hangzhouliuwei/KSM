//
//  XTMyControllers.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import SDWebImage
import UIKit
import YFPopView
import YYModel

private func xtMyActivate(_ constraints: [NSLayoutConstraint]) {
    NSLayoutConstraint.activate(constraints)
}

private func xtMyHexColor(_ text: String?, fallback: UIColor = XT_RGB(0x02CC56, 1.0)) -> UIColor {
    guard let text, let color = (text as NSString).xt_hexColor() else { return fallback }
    return color
}

@objcMembers
@objc(XTMyVC)
class XTMyVC: XTBaseVC {
    private let viewModel = XTMyViewModel()
    private var scrollView: UIScrollView?
    private var headView: XTMyHeadView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.xt_home { [weak self] in
            self?.xt_UI()
        } failure: {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xt_bkBtn.isHidden = true
        view.backgroundColor = XT_RGB(0xF2F5FA, 1.0)

        let setBtn = UIButton(type: .custom)
        setBtn.setImage(XT_Img("xt_my_set_logo"), for: .normal)
        setBtn.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        setBtn.translatesAutoresizingMaskIntoConstraints = false
        xt_navView.addSubview(setBtn)
        xtMyActivate([
            setBtn.rightAnchor.constraint(equalTo: xt_navView.rightAnchor),
            setBtn.centerYAnchor.constraint(equalTo: xt_bkBtn.centerYAnchor),
            setBtn.widthAnchor.constraint(equalToConstant: 56),
            setBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func openSettings() {
        navigationController?.pushViewController(XTSetVC(), animated: true)
    }

    @objc func xt_UI() {
        scrollView?.removeFromSuperview()
        headView?.removeFromSuperview()

        let headView = XTMyHeadView()
        headView.model = viewModel.myModel
        headView.block = { [weak self] in self?.goOrderVC(0) }
        headView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headView)
        self.headView = headView

        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        self.scrollView = scrollView

        view.bringSubviewToFront(xt_navView)

        xtMyActivate([
            headView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headView.topAnchor.constraint(equalTo: view.topAnchor),
            headView.heightAnchor.constraint(equalToConstant: 260),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: headView.bottomAnchor)
        ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        xtMyActivate([
            contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        var lastView: UIView = buildOrderView(in: contentView)
        if let repayment = viewModel.myModel?.repayment {
            lastView = buildRepaymentView(repayment, in: contentView, below: lastView)
        }
        lastView = buildExtendList(in: contentView, below: lastView)

        xtMyActivate([
            contentView.bottomAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 20 + XT_Tabbar_Height)
        ])
    }

    private func buildOrderView(in contentView: UIView) -> UIView {
        let orderView = UIView()
        orderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(orderView)

        let bg = UIImageView(image: XT_Img("xt_my_order_bg")?.stretchableImage(withLeftCapWidth: 30, topCapHeight: 0))
        bg.translatesAutoresizingMaskIntoConstraints = false
        orderView.addSubview(bg)

        let title = UILabel()
        title.text = "Loan Record"
        title.font = XT_Font_M(16)
        title.textColor = XT_RGB(0x161616, 1.0)
        title.translatesAutoresizingMaskIntoConstraints = false
        orderView.addSubview(title)

        let accessory = UIImageView(image: XT_Img("xt_cell_acc"))
        accessory.translatesAutoresizingMaskIntoConstraints = false
        orderView.addSubview(accessory)

        let allLabel = UILabel()
        allLabel.text = "View All Orders"
        allLabel.font = XT_Font_M(14)
        allLabel.textColor = XT_RGB(0x565656, 1.0)
        allLabel.translatesAutoresizingMaskIntoConstraints = false
        orderView.addSubview(allLabel)

        let allButton = UIButton(type: .custom)
        allButton.addTarget(self, action: #selector(openAllOrders), for: .touchUpInside)
        allButton.translatesAutoresizingMaskIntoConstraints = false
        orderView.addSubview(allButton)

        let left = buildOrderButton(icon: "xt_my_order_item_1", title: "Borrowing", action: #selector(openBorrowingOrders))
        let right = buildOrderButton(icon: "xt_my_order_item_2", title: "Order", action: #selector(openAllOrders))
        orderView.addSubview(left)
        orderView.addSubview(right)

        xtMyActivate([
            orderView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            orderView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            orderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -6),
            orderView.heightAnchor.constraint(equalToConstant: 162),

            bg.leftAnchor.constraint(equalTo: orderView.leftAnchor, constant: 7),
            bg.rightAnchor.constraint(equalTo: orderView.rightAnchor, constant: -7),
            bg.topAnchor.constraint(equalTo: orderView.topAnchor),
            bg.bottomAnchor.constraint(equalTo: orderView.bottomAnchor),

            title.leftAnchor.constraint(equalTo: orderView.leftAnchor, constant: 35),
            title.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 18),
            title.heightAnchor.constraint(equalToConstant: 19),

            accessory.rightAnchor.constraint(equalTo: orderView.rightAnchor, constant: -35),
            accessory.centerYAnchor.constraint(equalTo: title.centerYAnchor),

            allLabel.rightAnchor.constraint(equalTo: accessory.leftAnchor, constant: -3),
            allLabel.centerYAnchor.constraint(equalTo: title.centerYAnchor),

            allButton.leftAnchor.constraint(equalTo: allLabel.leftAnchor),
            allButton.rightAnchor.constraint(equalTo: orderView.rightAnchor),
            allButton.centerYAnchor.constraint(equalTo: allLabel.centerYAnchor),
            allButton.heightAnchor.constraint(equalToConstant: 30),

            left.leftAnchor.constraint(equalTo: orderView.leftAnchor),
            left.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            left.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier: 0.5),
            left.heightAnchor.constraint(equalToConstant: 113),

            right.rightAnchor.constraint(equalTo: orderView.rightAnchor),
            right.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            right.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier: 0.5),
            right.heightAnchor.constraint(equalToConstant: 113)
        ])
        return orderView
    }

    private func buildOrderButton(icon: String, title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)

        let image = UIImageView(image: XT_Img(icon))
        image.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(image)

        let label = UILabel()
        label.text = title
        label.font = XT_Font(15)
        label.textColor = XT_RGB(0x00302F, 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(label)

        xtMyActivate([
            image.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            image.topAnchor.constraint(equalTo: button.topAnchor),
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.topAnchor.constraint(equalTo: image.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        return button
    }

    private func buildRepaymentView(_ repayment: XTRepaymentModel, in contentView: UIView, below lastView: UIView) -> UIView {
        let repaymentView = UIView()
        repaymentView.layer.cornerRadius = 16
        repaymentView.clipsToBounds = true
        repaymentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(repaymentView)

        let gradient = UIView.xt_layer(
            [XT_RGB(0xFFBC9B, 1.0).cgColor, UIColor.white.cgColor],
            locations: [0, 1.0],
            startPoint: CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 0.48),
            size: CGSize(width: XT_Screen_Width - 30, height: 174)
        )
        repaymentView.layer.addSublayer(gradient)

        let logo = UIImageView()
        logo.sd_setImage(with: URL(string: repayment.xt_icon ?? ""), placeholderImage: XT_Img("xt_img_def"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        repaymentView.addSubview(logo)

        let state = UIButton.xt_btn("Overdue payment", font: XT_Font_M(12), textColor: XT_RGB(0xE83B30, 1.0), cornerRadius: 6, tag: 0)
        state.backgroundColor = XT_RGB(0xFFEEED, 1.0)
        state.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        state.translatesAutoresizingMaskIntoConstraints = false
        repaymentView.addSubview(state)

        let name = UILabel()
        name.text = repayment.xt_product_name
        name.font = XT_Font_SD(17)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        repaymentView.addSubview(name)

        let priceView = metricView(value: repayment.xt_amount, title: "Loan amount", valueFont: XT_Font_B(22))
        let dayView = metricView(value: repayment.xt_date, title: "Repayment date", valueFont: XT_Font_M(17))
        repaymentView.addSubview(priceView)
        repaymentView.addSubview(dayView)

        let refund = UIButton.xt_btn("Refund", font: XT_Font_M(20), textColor: .white, cornerRadius: 25, tag: 0)
        refund.backgroundColor = XT_RGB(0xFF0C00, 1.0)
        refund.addTarget(self, action: #selector(openRepayment), for: .touchUpInside)
        refund.translatesAutoresizingMaskIntoConstraints = false
        repaymentView.addSubview(refund)

        xtMyActivate([
            repaymentView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            repaymentView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            repaymentView.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 4),
            repaymentView.heightAnchor.constraint(equalToConstant: 174),

            logo.leftAnchor.constraint(equalTo: repaymentView.leftAnchor, constant: 8),
            logo.topAnchor.constraint(equalTo: repaymentView.topAnchor, constant: 16),
            logo.widthAnchor.constraint(equalToConstant: 24),
            logo.heightAnchor.constraint(equalToConstant: 24),

            state.rightAnchor.constraint(equalTo: repaymentView.rightAnchor, constant: -9),
            state.topAnchor.constraint(equalTo: repaymentView.topAnchor, constant: 16),
            state.heightAnchor.constraint(equalToConstant: 24),

            name.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 8),
            name.rightAnchor.constraint(lessThanOrEqualTo: state.leftAnchor, constant: -5),
            name.centerYAnchor.constraint(equalTo: logo.centerYAnchor),

            priceView.leftAnchor.constraint(equalTo: repaymentView.leftAnchor),
            priceView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 11),
            priceView.widthAnchor.constraint(equalTo: repaymentView.widthAnchor, multiplier: 0.5),
            priceView.heightAnchor.constraint(equalToConstant: 52),

            dayView.rightAnchor.constraint(equalTo: repaymentView.rightAnchor),
            dayView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 11),
            dayView.widthAnchor.constraint(equalTo: repaymentView.widthAnchor, multiplier: 0.5),
            dayView.heightAnchor.constraint(equalToConstant: 52),

            refund.centerXAnchor.constraint(equalTo: repaymentView.centerXAnchor),
            refund.bottomAnchor.constraint(equalTo: repaymentView.bottomAnchor, constant: -13),
            refund.heightAnchor.constraint(equalToConstant: 50),
            refund.widthAnchor.constraint(equalToConstant: XT_Screen_Width - 80)
        ])
        return repaymentView
    }

    private func metricView(value: String?, title: String, valueFont: UIFont) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = valueFont
        valueLabel.textColor = XT_RGB(0x030903, 1.0)
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(valueLabel)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = XT_Font(15)
        titleLabel.textColor = XT_RGB(0x676A69, 1.0)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        xtMyActivate([
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            valueLabel.topAnchor.constraint(equalTo: view.topAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 26),
            titleLabel.centerXAnchor.constraint(equalTo: valueLabel.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
        return view
    }

    private func buildExtendList(in contentView: UIView, below lastView: UIView) -> UIView {
        let extendsView = UIView()
        extendsView.backgroundColor = .white
        extendsView.layer.cornerRadius = 16
        extendsView.layer.shadowColor = UIColor(red: 193 / 255.0, green: 193 / 255.0, blue: 193 / 255.0, alpha: 0.46).cgColor
        extendsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        extendsView.layer.shadowOpacity = 1
        extendsView.layer.shadowRadius = 8
        extendsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(extendsView)

        let list = viewModel.myModel?.extendLists ?? []
        let itemHeight: CGFloat = 48
        let itemTop: CGFloat = 10
        var previous: UIView?

        for (index, model) in list.enumerated() {
            let row = UIButton(type: .custom)
            row.translatesAutoresizingMaskIntoConstraints = false
            row.tag = index
            row.addTarget(self, action: #selector(openExtendItem(_:)), for: .touchUpInside)
            extendsView.addSubview(row)

            let icon = UIImageView()
            icon.sd_setImage(with: URL(string: model.xt_icon ?? ""), placeholderImage: XT_Img("xt_img_def"))
            icon.translatesAutoresizingMaskIntoConstraints = false
            row.addSubview(icon)

            let accessory = UIImageView(image: XT_Img("xt_cell_acc"))
            accessory.translatesAutoresizingMaskIntoConstraints = false
            row.addSubview(accessory)

            let title = UILabel()
            title.text = model.xt_title
            title.font = XT_Font(14)
            title.textColor = .black
            title.translatesAutoresizingMaskIntoConstraints = false
            row.addSubview(title)

            xtMyActivate([
                row.leftAnchor.constraint(equalTo: extendsView.leftAnchor),
                row.rightAnchor.constraint(equalTo: extendsView.rightAnchor),
                row.heightAnchor.constraint(equalToConstant: itemHeight),
                row.topAnchor.constraint(equalTo: previous?.bottomAnchor ?? extendsView.topAnchor, constant: previous == nil ? itemTop : 0),

                icon.leftAnchor.constraint(equalTo: row.leftAnchor, constant: 20),
                icon.centerYAnchor.constraint(equalTo: row.centerYAnchor),
                icon.widthAnchor.constraint(equalToConstant: 21),
                icon.heightAnchor.constraint(equalToConstant: 21),

                accessory.rightAnchor.constraint(equalTo: row.rightAnchor, constant: -21),
                accessory.centerYAnchor.constraint(equalTo: row.centerYAnchor),

                title.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 13),
                title.rightAnchor.constraint(lessThanOrEqualTo: accessory.leftAnchor, constant: -8),
                title.centerYAnchor.constraint(equalTo: row.centerYAnchor)
            ])
            previous = row
        }

        xtMyActivate([
            extendsView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            extendsView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            extendsView.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 0),
            extendsView.heightAnchor.constraint(equalToConstant: itemHeight * CGFloat(list.count) + itemTop * 2)
        ])
        return extendsView
    }

    @objc private func openExtendItem(_ sender: UIButton) {
        guard let list = viewModel.myModel?.extendLists, list.indices.contains(sender.tag) else { return }
        let model = list[sender.tag]
        XTRoute.xt_share().goHtml(model.xt_url ?? "", success: nil)
    }

    @objc private func openRepayment() {
        XTRoute.xt_share().goHtml(viewModel.myModel?.repayment?.xt_url ?? "", success: nil)
    }

    @objc private func openBorrowingOrders() {
        goOrderVC(0)
    }

    @objc private func openAllOrders() {
        goOrderVC(1)
    }

    @objc(goOrderVC:)
    func goOrderVC(_ index: Int) {
        navigationController?.pushViewController(XTOrderVC(index: index), animated: true)
    }
}

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
        creatModel()
    }

    @objc func creatModel() {
        list.removeAll()
        list.append(XTCellModel.xt_cellClassName("XTSetIconCell", height: 251, model: nil))
        list.append(XTCellModel.xt_cellClassName("XTSetCell", height: 48, model: ["title": "Website", "content": "https://www.providence-lending-corp.com"]))
        list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 20, model: nil))
        list.append(XTCellModel.xt_cellClassName("XTSetCell", height: 48, model: ["title": "Email", "content": "cs@providence-lending-corp.com"]))
        list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 20, model: nil))
        list.append(XTCellModel.xt_cellClassName("XTSetCell", height: 48, model: ["title": "Edition", "content": XT_App_Version]))
        list.append(XTCellModel.xt_cellClassName("XTSpaceCell", height: 65, model: nil))

        let logout = XTCellModel.xt_cellClassName("XTLoginOutCell", height: 48, model: nil)
        (logout.indexCell as? XTLoginOutCell)?.block = { [weak self] in self?.nextLoginOut() }
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

    @objc func nextLoginOut() {
        showAlt("Are you sure you want to\n leave this software?") {
            XTLogoutApi().xt_startRequestSuccess { _, _ in
                XTUserManger.xt_share().xt_loginOut()
            } failure: { _, _ in
            } error: { _ in
            }
        }
    }

    @objc func nextCancelAccount() {
        showAlt("Are you sure you want to\n cancel account?") {
            XTDelAccountApi().xt_startRequestSuccess { _, _ in
                XTUserManger.xt_share().xt_loginOut()
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

@objcMembers
@objc(XTOrderVC)
class XTOrderVC: XTBaseVC, UIScrollViewDelegate {
    private let viewTag = 1000
    private var viewIndex: Int = 0
    private lazy var segList: [NSDictionary] = [
        ["name": "Borrowing", "value": "7"] as NSDictionary,
        ["name": "Order", "value": "4"] as NSDictionary,
        ["name": "Not fnished", "value": "6"] as NSDictionary,
        ["name": "Repaid", "value": "5"] as NSDictionary
    ]
    private lazy var segView: XTSegView = {
        let view = XTSegView(
            arr: segList,
            font: XT_Font(14),
            selectFont: XT_Font_SD(15),
            color: XT_RGB(0x303030, 1.0),
            selectColor: .white,
            bgColor: .clear,
            selectBgColor: XT_RGB(0x0BB559, 1.0),
            cornerRadius: 17,
            select: viewIndex
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    convenience init() {
        self.init(index: 0)
    }

    @objc(initWithIndex:)
    init(index: Int) {
        self.viewIndex = index
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xt_navView.backgroundColor = .clear
        xt_backType = XT_BackType_B
        xt_title = "Loan Record"

        let topView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: XT_Nav_Height + 97))
        topView.layer.addSublayer(UIView.xt_layer(
            [XT_RGB(0x0BB559, 1.0).cgColor, UIColor.white.cgColor],
            locations: [0, 1.0],
            startPoint: CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 0.6),
            size: topView.size
        ))
        view.addSubview(topView)
        view.bringSubviewToFront(xt_navView)

        view.addSubview(segView)
        segView.block = { [weak self] index in
            guard let self else { return }
            self.scrollView.setContentOffset(CGPoint(x: self.scrollView.width * CGFloat(index), y: 0), animated: true)
            self.creatView(index)
        }

        view.addSubview(scrollView)
        xtMyActivate([
            segView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            segView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            segView.topAnchor.constraint(equalTo: xt_navView.bottomAnchor),
            segView.heightAnchor.constraint(equalToConstant: 34),

            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: segView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: view.width * CGFloat(segList.count), height: scrollView.height)
        scrollView.setContentOffset(CGPoint(x: scrollView.width * CGFloat(viewIndex), y: 0), animated: false)
        creatView(viewIndex)
    }

    @objc(creatView:)
    func creatView(_ index: Int) {
        if let existing = scrollView.viewWithTag(viewTag + index) as? XTOrderView {
            existing.xt_reload()
            return
        }
        let dic = segList[index]
        let orderView = XTOrderView(frame: CGRect(x: scrollView.width * CGFloat(index), y: 0, width: scrollView.width, height: scrollView.height), xt_order_type: dic["value"] as? String ?? "")
        orderView.tag = viewTag + index
        orderView.block = { [weak self] in
            guard let self,
                  let tabbar = self.navigationController?.viewControllers.first as? UITabBarController else { return }
            self.navigationController?.popToViewController(tabbar, animated: true)
            tabbar.selectedIndex = 0
        }
        scrollView.addSubview(orderView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / max(scrollView.frame.width, 1))
        viewIndex = index
        segView.reloadSeg(index)
        creatView(viewIndex)
    }
}

@objcMembers
@objc(XTOrderView)
class XTOrderView: UIView, UITableViewDelegate, UITableViewDataSource {
    dynamic var block: XTBlock?
    private var xt_order_type = ""
    private lazy var api: XTOrderListApi = {
        let api = XTOrderListApi()
        api.xt_order_type = xt_order_type
        return api
    }()
    private var list: [XTOrderModel] = []
    private let viewModel = XTVerifyViewModel()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: XT_Bottom_Height + 22, right: 0)
        if #available(iOS 10.0, *) {
            let refresh = UIRefreshControl()
            refresh.addTarget(self, action: #selector(refreshList), for: .valueChanged)
            tableView.refreshControl = refresh
        }
        return tableView
    }()
    private lazy var emptyView: UIView = {
        let view = UIView(frame: bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .clear

        let button = UIButton.xt_btn("Apply Now", font: XT_Font_M(20), textColor: XT_RGB(0x010000, 1.0), cornerRadius: 25, tag: 0)
        button.backgroundColor = XT_RGB(0x02CC56, 1.0)
        button.addTarget(self, action: #selector(applyNow), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        let title = UILabel()
        title.text = "You have no order record"
        title.font = XT_Font(18)
        title.textColor = XT_RGB(0x999999, 1.0)
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)

        let image = UIImageView(image: XT_Img("xt_order_empty_logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)

        xtMyActivate([
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            button.topAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -22),
            title.heightAnchor.constraint(equalToConstant: 25),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -22)
        ])
        view.isHidden = true
        return view
    }()

    @objc(initWithFrame:xt_order_type:)
    init(frame: CGRect, xt_order_type: String) {
        super.init(frame: frame)
        self.xt_order_type = xt_order_type
        api.xt_order_type = xt_order_type
        addSubview(tableView)
        addSubview(emptyView)
        xt_list()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(tableView)
        addSubview(emptyView)
    }

    @objc func xt_reload() {
        api.xt_page_num = 1
        xt_list()
    }

    @objc private func refreshList() {
        xt_reload()
    }

    @objc func xt_list() {
        XTUtility.xt_showProgress(self, message: "loading...")
        api.xt_startRequestSuccess { [weak self] dic, _ in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self)
            self.tableView.refreshControl?.endRefreshing()
            if self.api.xt_page_num == 1 {
                self.list.removeAll()
            }
            if let arr = dic?["xathsixosisNc"] as? [Any] {
                self.api.xt_page_num += 1
                let models = NSArray.yy_modelArray(with: XTOrderModel.self, json: arr) as? [XTOrderModel] ?? []
                self.list.append(contentsOf: models)
            }
            self.emptyView.isHidden = !self.list.isEmpty
            self.tableView.reloadData()
        } failure: { [weak self] _, str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self)
            XTUtility.xt_showTips(str, view: self)
            self.tableView.refreshControl?.endRefreshing()
        } error: { [weak self] _ in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self)
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "XTOrderCell") as? XTOrderCell)
            ?? XTOrderCell(style: .default, reuseIdentifier: "XTOrderCell")
        cell.model = list[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = list[indexPath.row]
        if NSString.xt_isValidateUrl(model.xt_loanDetailUrl ?? "") {
            XTRoute.xt_share().goHtml(model.xt_loanDetailUrl ?? "", success: nil)
            return
        }
        LoanFlowCoordinator.shared.continueAfterDetail(productId: model.xt_productId ?? "", loadingView: self)
    }

    @objc(xt_push_productId:orderId:)
    func xt_push_productId(_ productId: String?, orderId: String?) {
        LoanFlowCoordinator.shared.openPush(orderId: orderId ?? "", loadingView: self)
    }

    @objc private func applyNow() {
        block?()
    }
}

@objcMembers
@objc(XTOrderCell)
class XTOrderCell: XTCell {
    dynamic var model: XTOrderModel? {
        didSet { reloadModel() }
    }

    private let container = UIView()
    private let icon = UIImageView()
    private let nameLab = UILabel()
    private let stateBtn = UIButton.xt_btn("", font: XT_Font_M(12), textColor: XT_RGB(0xE83B30, 1.0), cornerRadius: 6, tag: 0)
    private let priceView = UIView()
    private let priceLab = UILabel()
    private let priceSubLab = UILabel()
    private let dateView = UIView()
    private let dateLab = UILabel()
    private let dateSubLab = UILabel()
    private let submitBtn = UIButton.xt_btn("", font: XT_Font_M(20), textColor: .white, cornerRadius: 25, tag: 0)

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 12
        container.layer.shadowColor = UIColor(red: 234 / 255.0, green: 235 / 255.0, blue: 238 / 255.0, alpha: 0.4).cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowOpacity = 1
        container.layer.shadowRadius = 4
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)

        let bg = UIView()
        bg.clipsToBounds = true
        bg.layer.cornerRadius = 12
        bg.layer.addSublayer(UIView.xt_layer(
            [XT_RGB(0xF3FF9B, 1.0).cgColor, UIColor.white.cgColor],
            locations: [0, 1.0],
            startPoint: CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 0.48),
            size: CGSize(width: XT_Screen_Width - 30, height: 210)
        ))
        bg.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(bg)

        [icon, stateBtn, nameLab, priceView, dateView, submitBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }

        nameLab.font = XT_Font_SD(20)
        nameLab.textColor = .black
        stateBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        stateBtn.backgroundColor = .white
        stateBtn.isUserInteractionEnabled = false

        configureMetric(view: priceView, valueLabel: priceLab, titleLabel: priceSubLab, title: "Loan amount", valueFont: XT_Font_B(22))
        configureMetric(view: dateView, valueLabel: dateLab, titleLabel: dateSubLab, title: "Repayment date", valueFont: XT_Font_M(17))
        submitBtn.isUserInteractionEnabled = false

        xtMyActivate([
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            bg.leftAnchor.constraint(equalTo: container.leftAnchor),
            bg.rightAnchor.constraint(equalTo: container.rightAnchor),
            bg.topAnchor.constraint(equalTo: container.topAnchor),
            bg.bottomAnchor.constraint(equalTo: container.bottomAnchor),

            icon.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 8),
            icon.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),

            stateBtn.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -9),
            stateBtn.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stateBtn.heightAnchor.constraint(equalToConstant: 24),

            nameLab.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8),
            nameLab.rightAnchor.constraint(lessThanOrEqualTo: stateBtn.leftAnchor, constant: -5),
            nameLab.centerYAnchor.constraint(equalTo: icon.centerYAnchor),

            priceView.leftAnchor.constraint(equalTo: container.leftAnchor),
            priceView.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 16),
            priceView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5),
            priceView.heightAnchor.constraint(equalToConstant: 80),

            dateView.rightAnchor.constraint(equalTo: container.rightAnchor),
            dateView.topAnchor.constraint(equalTo: priceView.topAnchor),
            dateView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5),
            dateView.heightAnchor.constraint(equalToConstant: 80),

            submitBtn.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 25),
            submitBtn.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -25),
            submitBtn.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 6),
            submitBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            submitBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureMetric(view: UIView, valueLabel: UILabel, titleLabel: UILabel, title: String, valueFont: UIFont) {
        valueLabel.font = valueFont
        valueLabel.textColor = .black
        valueLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.font = XT_Font(15)
        titleLabel.textColor = XT_RGB(0x676A69, 1.0)
        [valueLabel, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        xtMyActivate([
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            valueLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            valueLabel.heightAnchor.constraint(equalToConstant: 26),
            titleLabel.centerXAnchor.constraint(equalTo: valueLabel.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    private func reloadModel() {
        guard let model else { return }
        icon.sd_setImage(with: URL(string: model.xt_productLogo ?? ""), placeholderImage: XT_Img("xt_img_def"))
        nameLab.text = model.xt_productName
        if NSString.xt_isEmpty(model.xt_orderStatusDesc) {
            stateBtn.isHidden = true
        } else {
            stateBtn.isHidden = false
            stateBtn.setTitle(model.xt_orderStatusDesc, for: .normal)
            stateBtn.setTitleColor(xtMyHexColor(model.xt_orderStatusColor, fallback: XT_RGB(0xE83B30, 1.0)), for: .normal)
        }
        priceLab.text = model.xt_orderAmount
        dateView.isHidden = NSString.xt_isEmpty(model.xt_repayTime)
        dateLab.text = model.xt_repayTime
        submitBtn.isHidden = NSString.xt_isEmpty(model.xt_buttonText)
        submitBtn.setTitle(model.xt_buttonText, for: .normal)
        submitBtn.backgroundColor = xtMyHexColor(model.xt_buttonBackground)
    }
}
