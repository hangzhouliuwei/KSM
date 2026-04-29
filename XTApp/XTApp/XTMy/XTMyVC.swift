//
//  XTMyVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import SDWebImage
import UIKit

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