//
//  XTBasicMyCells.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

private func xtBasicCellColor(_ rgbValue: Int, alpha: CGFloat = 1.0) -> UIColor {
    UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

@objcMembers
@objc(XTMyCell)
class XTMyCell: XTCell {
}

@objcMembers
@objc(XTCancelCell)
class XTCancelCell: XTCell {
    dynamic var block: XTBlock?

    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Cancel Account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = xtBasicCellColor(0x0BB559)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapSubmit), for: .touchUpInside)
        return button
    }()

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubmitButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubmitButton()
    }

    private func setupSubmitButton() {
        contentView.addSubview(submitBtn)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitBtn.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            submitBtn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            submitBtn.topAnchor.constraint(equalTo: contentView.topAnchor),
            submitBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc private func tapSubmit() {
        block?()
    }
}

@objcMembers
@objc(XTLoginOutCell)
class XTLogoutCell: XTCell {
    dynamic var block: XTBlock?

    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Log out", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapSubmit), for: .touchUpInside)
        return button
    }()

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubmitButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubmitButton()
    }

    private func setupSubmitButton() {
        contentView.addSubview(submitBtn)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitBtn.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            submitBtn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            submitBtn.topAnchor.constraint(equalTo: contentView.topAnchor),
            submitBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc private func tapSubmit() {
        block?()
    }
}
