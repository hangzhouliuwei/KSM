//
//  XTWalletCell.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import SDWebImage
import UIKit

@objcMembers
@objc(XTWalletCell)
class XTWalletCell: XTCell {
    weak dynamic var model: XTNoteModel? {
        didSet {
            icon.sd_setImage(with: URL(string: model?.xt_icon ?? ""), placeholderImage: UIImage(named: "xt_img_def"))
            titLab.text = model?.xt_name
        }
    }

    dynamic var isSelect = false {
        didSet {
            containerView.backgroundColor = isSelect ? .clear : .white
            accImg.image = UIImage(named: isSelect ? "xt_verify_wallet_select_1" : "xt_verify_wallet_select_0")
        }
    }

    private let containerView = UIView()
    private lazy var icon = UIImageView()
    private lazy var accImg = UIImageView(image: UIImage(named: "xt_verify_wallet_select_0"))
    private lazy var titLab: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(red: 0x33 / 255.0, green: 0x33 / 255.0, blue: 0x33 / 255.0, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        let view = containerView
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(red: 0xdd / 255.0, green: 0xdd / 255.0, blue: 0xdd / 255.0, alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -14),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.heightAnchor.constraint(equalToConstant: 64)
        ])

        icon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 28),
            icon.heightAnchor.constraint(equalToConstant: 28)
        ])

        accImg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(accImg)
        NSLayoutConstraint.activate([
            accImg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            accImg.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        titLab.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titLab)
        NSLayoutConstraint.activate([
            titLab.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8),
            titLab.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
