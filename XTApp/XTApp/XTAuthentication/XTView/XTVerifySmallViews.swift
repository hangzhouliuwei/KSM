//
//  XTVerifySmallViews.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

private func xtVerifyColor(_ rgbValue: Int, alpha: CGFloat = 1.0) -> UIColor {
    UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

@objcMembers
@objc(XTVerifyHeadView)
class XTVerifyHeadView: UIView {
    @objc(initWithFrame:type:)
    init(frame: CGRect, type: XT_VerifyType) {
        super.init(frame: frame)
        setup(type: type)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(type: XT_Verify_Base)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(type: XT_Verify_Base)
    }

    private func setup(type: XT_VerifyType) {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height + 20))
        topView.backgroundColor = xtVerifyColor(0x0BB559)
        addSubview(topView)

        let img = UIImageView(image: UIImage(named: "xt_verify_head_bg"))
        if type == XT_Verify_Contact {
            img.image = UIImage(named: "xt_verify_head_contact_bg")
        } else if type == XT_Verify_Identifcation {
            img.image = UIImage(named: "xt_verify_head_ide_bg")
        }
        img.translatesAutoresizingMaskIntoConstraints = false
        addSubview(img)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            img.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor),
            img.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor),
            img.heightAnchor.constraint(equalToConstant: 67),
            img.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

@objcMembers
@objc(XTSelectViewCell)
class XTSelectViewCell: XTCell {
    weak dynamic var model: XTNoteModel? {
        didSet {
            nameLab.text = model?.xt_name
        }
    }

    dynamic var isSelect = false {
        didSet {
            bgView.isHidden = !isSelect
            nameLab.textColor = isSelect ? .black : xtVerifyColor(0xD8D8D8)
        }
    }

    private lazy var nameLab: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 15, y: 0, width: UIScreen.main.bounds.width - 30, height: 42))
        view.backgroundColor = .white
        view.isHidden = true
        let gradient = CAGradientLayer()
        gradient.colors = [xtVerifyColor(0x0BB559).cgColor, UIColor.white.cgColor]
        gradient.locations = [0, 1.0]
        gradient.startPoint = CGPoint(x: 0.04, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.frame = CGRect(origin: .zero, size: view.size)
        view.layer.addSublayer(gradient)
        return view
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
        contentView.addSubview(bgView)
        nameLab.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLab)
        NSLayoutConstraint.activate([
            nameLab.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLab.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
