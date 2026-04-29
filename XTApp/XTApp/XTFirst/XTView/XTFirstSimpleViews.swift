//
//  XTFirstSimpleViews.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import SDWebImage
import UIKit

@objcMembers
@objc(XTBannerChildCell)
class XTBannerChildCell: UICollectionViewCell {
    var model: BannerModel? {
        didSet {
            bgImg.sd_setImage(with: URL(string: model?.displayImageURL ?? ""), placeholderImage: UIImage(named: "xt_img_def"))
        }
    }

    private lazy var bgImg: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImage()
    }

    private func setupImage() {
        bgImg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bgImg)
        NSLayoutConstraint.activate([
            bgImg.leftAnchor.constraint(equalTo: leftAnchor),
            bgImg.rightAnchor.constraint(equalTo: rightAnchor),
            bgImg.topAnchor.constraint(equalTo: topAnchor),
            bgImg.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

@objcMembers
@objc(XTPopUpView)
class XTPopUpView: UIView {
    dynamic var closeBlock: XTBlock?
    private var routeURL = ""

    @objc(initImg:url:text:)
    init(imgUrl: String, url: String, text: String) {
        super.init(frame: UIScreen.main.bounds)
        setupUI(imgUrl: imgUrl, url: url)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(imgUrl: "", url: "")
    }

    private func setupUI(imgUrl: String, url: String) {
        routeURL = url
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(close), for: .touchUpInside)
        addSubview(btn)
        NSLayoutConstraint.activate([
            btn.leftAnchor.constraint(equalTo: leftAnchor),
            btn.rightAnchor.constraint(equalTo: rightAnchor),
            btn.topAnchor.constraint(equalTo: topAnchor),
            btn.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "xt_img_def"))
        img.translatesAutoresizingMaskIntoConstraints = false
        addSubview(img)
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: centerXAnchor),
            img.centerYAnchor.constraint(equalTo: centerYAnchor),
            img.widthAnchor.constraint(equalToConstant: 292),
            img.heightAnchor.constraint(equalToConstant: 287)
        ])

        let closeImg = UIImageView(image: UIImage(named: "xt_first_close"))
        closeImg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(closeImg)
        NSLayoutConstraint.activate([
            closeImg.centerXAnchor.constraint(equalTo: centerXAnchor),
            closeImg.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 7)
        ])

        let tapBtn = UIButton(type: .custom)
        tapBtn.translatesAutoresizingMaskIntoConstraints = false
        tapBtn.addTarget(self, action: #selector(openPopupURL), for: .touchUpInside)
        addSubview(tapBtn)
        NSLayoutConstraint.activate([
            tapBtn.leftAnchor.constraint(equalTo: img.leftAnchor),
            tapBtn.rightAnchor.constraint(equalTo: img.rightAnchor),
            tapBtn.topAnchor.constraint(equalTo: img.topAnchor),
            tapBtn.bottomAnchor.constraint(equalTo: img.bottomAnchor)
        ])
    }

    @objc private func close() {
        closeBlock?()
    }

    @objc private func openPopupURL() {
        XTRoute.xt_share().goHtml(routeURL, success: nil)
        closeBlock?()
    }
}

@objcMembers
@objc(XTNoticeCell)
class XTNoticeCell: XTCell {
    private var model: RepayModel?

    private lazy var bgImg: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    override var xt_data: Any? {
        didSet {
            guard let repayModel = xt_data as? RepayModel else { return }
            model = repayModel
            bgImg.sd_setImage(with: URL(string: repayModel.noticeImageURL ?? ""), placeholderImage: UIImage(named: "xt_img_def"))
        }
    }

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        bgImg.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bgImg)
        NSLayoutConstraint.activate([
            bgImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            bgImg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            bgImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(openNotice), for: .touchUpInside)
        contentView.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            btn.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            btn.topAnchor.constraint(equalTo: contentView.topAnchor),
            btn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc private func openNotice() {
        XTRoute.xt_share().goHtml(model?.routeURL ?? "", success: nil)
    }
}
