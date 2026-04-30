//
//  XTMyHeadView.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

private func xtHeadColor(_ rgbValue: Int, alpha: CGFloat = 1.0) -> UIColor {
    UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

private var xtHeadStatusHeight: CGFloat {
    UIApplication.shared.statusBarFrame.size.height
}

private func xtHeadLabel(text: String, font: UIFont, color: UIColor, alignment: NSTextAlignment = .left) -> UILabel {
    let label = UILabel(frame: .zero)
    label.text = text
    label.font = font
    label.textColor = color
    label.textAlignment = alignment
    return label
}

private func xtPhonePrivacy(_ phone: String?) -> String {
    guard let phone, phone.count >= 7 else {
        return phone ?? ""
    }
    let prefix = phone.prefix(3)
    let suffix = phone.suffix(3)
    return "\(prefix)\(String(repeating: "*", count: phone.count - 6))\(suffix)"
}

@objcMembers
@objc(XTMyHeadView)
class XTMyHeadView: UIView {
    weak dynamic var model: XTMyModel? {
        didSet {
            if model?.xt_memberUrl?.isEmpty ?? true {
                tagLab.text = "Hello, New User"
            } else {
                tagLab.text = "Hello, Esteemed Member"
            }
        }
    }

    dynamic var block: XTBlock?

    private lazy var tagLab = xtHeadLabel(
        text: "Hello, Esteemed Member",
        font: .systemFont(ofSize: 15, weight: .medium),
        color: .white
    )

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 166 + xtHeadStatusHeight))
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = xtHeadColor(0x0BB559)

        let statusView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: xtHeadStatusHeight))
        statusView.backgroundColor = xtHeadColor(0x0BB559)
        addSubview(statusView)

        let logoImg = UIImageView(image: UIImage(named: "xt_my_head_logo"))
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImg)
        NSLayoutConstraint.activate([
            logoImg.topAnchor.constraint(equalTo: topAnchor, constant: -9 + xtHeadStatusHeight),
            logoImg.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            logoImg.widthAnchor.constraint(equalToConstant: 91),
            logoImg.heightAnchor.constraint(equalToConstant: 96)
        ])

        let phoneLab = xtHeadLabel(
            text: xtPhonePrivacy(UserSession.shared.currentUser?.phone),
            font: .systemFont(ofSize: 20, weight: .semibold),
            color: .white
        )
        phoneLab.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneLab)
        NSLayoutConstraint.activate([
            phoneLab.topAnchor.constraint(equalTo: topAnchor, constant: 18 + xtHeadStatusHeight),
            phoneLab.leftAnchor.constraint(equalTo: logoImg.rightAnchor, constant: 8),
            phoneLab.heightAnchor.constraint(equalToConstant: 28)
        ])

        tagLab.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tagLab)
        NSLayoutConstraint.activate([
            tagLab.topAnchor.constraint(equalTo: phoneLab.bottomAnchor, constant: 7),
            tagLab.leftAnchor.constraint(equalTo: logoImg.rightAnchor, constant: 8),
            tagLab.heightAnchor.constraint(equalToConstant: 21)
        ])

        let footBgImg = UIImageView(image: UIImage(named: "xt_my_foot_bg"))
        footBgImg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(footBgImg)
        NSLayoutConstraint.activate([
            footBgImg.leftAnchor.constraint(equalTo: leftAnchor),
            footBgImg.rightAnchor.constraint(equalTo: rightAnchor),
            footBgImg.bottomAnchor.constraint(equalTo: bottomAnchor),
            footBgImg.heightAnchor.constraint(equalToConstant: 80)
        ])

        let iconImg = UIImageView(image: UIImage(named: "xt_my_head_list_logo"))
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImg)
        NSLayoutConstraint.activate([
            iconImg.leftAnchor.constraint(equalTo: leftAnchor, constant: 35),
            iconImg.topAnchor.constraint(equalTo: footBgImg.topAnchor, constant: 17),
            iconImg.widthAnchor.constraint(equalToConstant: 21),
            iconImg.heightAnchor.constraint(equalToConstant: 21)
        ])

        let nameLab = xtHeadLabel(
            text: "My list",
            font: .systemFont(ofSize: 18, weight: .medium),
            color: xtHeadColor(0x161616)
        )
        nameLab.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLab)
        NSLayoutConstraint.activate([
            nameLab.leftAnchor.constraint(equalTo: iconImg.rightAnchor, constant: 9),
            nameLab.centerYAnchor.constraint(equalTo: iconImg.centerYAnchor),
            nameLab.heightAnchor.constraint(equalToConstant: 21)
        ])

        let subLab = xtHeadLabel(
            text: "Click to view my order status",
            font: .systemFont(ofSize: 12),
            color: xtHeadColor(0x888888)
        )
        subLab.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subLab)
        NSLayoutConstraint.activate([
            subLab.leftAnchor.constraint(equalTo: iconImg.leftAnchor),
            subLab.topAnchor.constraint(equalTo: iconImg.bottomAnchor, constant: 4),
            subLab.heightAnchor.constraint(equalToConstant: 17)
        ])

        let btn = UIButton(type: .custom)
        btn.setTitle("Click enter", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.setTitleColor(xtHeadColor(0x010000), for: .normal)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(tapEnter), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(btn)
        NSLayoutConstraint.activate([
            btn.rightAnchor.constraint(equalTo: rightAnchor, constant: -28),
            btn.topAnchor.constraint(equalTo: footBgImg.topAnchor, constant: 22),
            btn.widthAnchor.constraint(equalToConstant: 120),
            btn.heightAnchor.constraint(equalToConstant: 32)
        ])

        let gradient = CAGradientLayer()
        gradient.colors = [xtHeadColor(0x02CC56).cgColor, xtHeadColor(0xC6FF95).cgColor]
        gradient.locations = [0, 1.0]
        gradient.startPoint = CGPoint(x: 0.54, y: 0.85)
        gradient.endPoint = CGPoint(x: 0.54, y: 0)
        gradient.frame = CGRect(x: 0, y: 0, width: 120, height: 32)
        btn.layer.insertSublayer(gradient, at: 0)
    }

    @objc private func tapEnter() {
        block?()
    }
}
