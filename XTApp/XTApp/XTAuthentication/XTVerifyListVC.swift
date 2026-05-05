//
//  XTVerifyListVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import UIKit

@objcMembers
@objc(XTVerifyListVC)
class XTVerifyListVC: XTBaseVC {
    private let viewModel = XTVerifyViewModel()
    private var productId = ""
    private var orderId = ""
    private var scrollView: UIScrollView?

    @objc(initWithProductId:)
    init(productId: String) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xt_detail(false, showProgress: false)
    }

    @objc(xt_detail:showProgress:)
    func xt_detail(_ goNext: Bool, showProgress: Bool) {
        if showProgress {
            XTUtility.xt_showProgress(view, message: "loading...")
        }
        viewModel.xt_detail(productId, success: { [weak self] code, orderId in
            guard let self else { return }
            if showProgress {
                XTUtility.xt_atHideProgress(self.view)
            }
            self.orderId = orderId ?? ""
            self.xt_UI()
            if goNext, !NSString.xt_isEmpty(code) {
                XTRoute.xt_share().goVerifyItem(code ?? "", productId: self.productId, orderId: self.orderId, success: nil)
            } else if goNext {
                self.xt_push()
            }
        }, failure: { [weak self] in
            guard let self else { return }
            if showProgress {
                XTUtility.xt_atHideProgress(self.view)
            }
        })
    }

    @objc func xt_push() {
        XTLoanFlowCoordinator.shared.openPush(orderId: orderId, loadingView: view, removeCurrentController: self)
    }

    @objc func xt_UI() {
        scrollView?.removeFromSuperview()
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        scrollView = scroll
        xtVerifyActivate([
            scroll.leftAnchor.constraint(equalTo: view.leftAnchor),
            scroll.rightAnchor.constraint(equalTo: view.rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.topAnchor.constraint(equalTo: xt_navView.bottomAnchor)
        ])

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        xtVerifyActivate([
            stack.leftAnchor.constraint(equalTo: scroll.contentLayoutGuide.leftAnchor),
            stack.rightAnchor.constraint(equalTo: scroll.contentLayoutGuide.rightAnchor),
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -20 - XT_Bottom_Height),
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])

        let top = UIImageView(image: XT_Img("xt_verify_list_top_bg"))
        top.backgroundColor = XT_RGB(0x0BB559, 1.0)
        top.contentMode = .scaleAspectFill
        xtVerifyAddHeight(top, 150)
        stack.addArrangedSubview(top)

        var haveSuccess = false
        for (index, model) in (viewModel.list ?? []).enumerated() {
            let row = XTVerifyListRow(index: index + 1, model: model)
            row.tag = index
            row.addTarget(self, action: #selector(listRowTap(_:)), for: .touchUpInside)
            xtVerifyAddHeight(row, 92)
            stack.addArrangedSubview(row)
            if model.frllsixyNc {
                haveSuccess = true
            }
        }

        let submit = UIButton.xt_btn("Apply", font: XT_Font_B(20), textColor: .white, cornerRadius: 24, tag: 0)
        submit.backgroundColor = haveSuccess ? XT_RGB(0x02CC56, 1.0) : XT_RGB(0xD9D9D9, 1.0)
        submit.addTarget(self, action: #selector(applyTap), for: .touchUpInside)
        xtVerifyAddHeight(submit, 48)
        let padded = UIView()
        submit.translatesAutoresizingMaskIntoConstraints = false
        padded.addSubview(submit)
        xtVerifyActivate([
            submit.leftAnchor.constraint(equalTo: padded.leftAnchor, constant: 20),
            submit.rightAnchor.constraint(equalTo: padded.rightAnchor, constant: -20),
            submit.topAnchor.constraint(equalTo: padded.topAnchor, constant: 18),
            submit.heightAnchor.constraint(equalToConstant: 48),
            padded.heightAnchor.constraint(equalToConstant: 84)
        ])
        stack.addArrangedSubview(padded)
    }

    private func xtVerifyAddHeight(_ view: UIView, _ height: CGFloat) {
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    @objc private func applyTap() {
        xt_detail(true, showProgress: true)
    }

    @objc private func listRowTap(_ sender: UIButton) {
        guard let list = viewModel.list, list.indices.contains(sender.tag) else { return }
        let model = list[sender.tag]
        if model.frllsixyNc {
            XTRoute.xt_share().goVerifyItem(model.noassixsessabilityNc ?? "", productId: productId, orderId: orderId, success: nil)
        } else {
            xt_detail(true, showProgress: true)
        }
    }
}

private final class XTVerifyListRow: UIButton {
    init(index: Int, model: XTVerifyListModel) {
        super.init(frame: .zero)
        backgroundColor = .clear

        let bg = UIImageView(image: XT_Img("xt_verify_list_item_bg"))
        bg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bg)

        let logo = UIImageView()
        logo.sd_setImage(with: URL(string: model.doabsixleNc ?? ""), placeholderImage: XT_Img("xt_img_def"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logo)

        let accessory = UIImageView(image: XT_Img(model.frllsixyNc ? "xt_cell_sure" : "xt_cell_acc"))
        accessory.translatesAutoresizingMaskIntoConstraints = false
        addSubview(accessory)

        let label = UILabel()
        label.text = "\(index).\(model.fldgsixeNc ?? "")"
        label.font = XT_Font_M(16)
        label.textColor = XT_RGB(0x161616, 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        xtVerifyActivate([
            bg.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            bg.rightAnchor.constraint(equalTo: rightAnchor, constant: -7),
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            logo.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            logo.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            logo.widthAnchor.constraint(equalToConstant: 42),
            logo.heightAnchor.constraint(equalToConstant: 42),
            accessory.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
            accessory.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            label.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 15),
            label.rightAnchor.constraint(equalTo: accessory.leftAnchor, constant: -5),
            label.centerYAnchor.constraint(equalTo: logo.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}