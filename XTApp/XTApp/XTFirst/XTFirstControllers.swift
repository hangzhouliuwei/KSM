//
//  XTFirstControllers.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import SDWebImage
import TYCyclePagerView
import UIKit
import YYText

private let xtFirstLanternLabelTag = 10001
private let xtFirstLanternH: CGFloat = 28
private var xtFirstLanternW: CGFloat { XT_Screen_Width - 55 - 33 }

private func xtFirstActivate(_ constraints: [NSLayoutConstraint]) {
    NSLayoutConstraint.activate(constraints)
}

private func xtFirstHexColor(_ text: String?, fallback: UIColor = XT_RGB(0x02CC56, 1.0)) -> UIColor {
    guard let text, let color = (text as NSString).xt_hexColor() else { return fallback }
    return color
}

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
            self?.creatCellModel()
        } failure: { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
        }
    }

    @objc func creatCellModel() {
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

@objcMembers
@objc(XTBigCell)
class XTBigCell: XTCell {
    dynamic var nextBlock: XTBlock?
    private var model: CardModel?
    private let nameLab = UILabel()
    private let img = UIImageView()
    private let priceLab = UILabel()
    private let descLab = UILabel()
    private let item1TitLab = UILabel()
    private let item1Lab = UILabel()
    private let item2TitLab = UILabel()
    private let item2Lab = UILabel()
    private let submitBtn = UIButton.xt_btn("", font: XT_Font_M(20), textColor: .black, cornerRadius: 24, tag: 0)
    private let altLab = YYLabel()

    override var xt_data: Any? {
        didSet {
            guard let model = xt_data as? CardModel else { return }
            self.model = model
            nameLab.text = model.productName
            img.sd_setImage(with: URL(string: model.logo ?? ""), placeholderImage: XT_Img("xt_img_def"))
            priceLab.text = model.amountText
            descLab.text = model.descriptionText
            item1TitLab.text = model.primaryMetricTitle
            item1Lab.text = model.primaryMetricValue
            item2TitLab.text = model.secondaryMetricTitle
            item2Lab.text = model.secondaryMetricValue
            submitBtn.setTitle(model.buttonText, for: .normal)
            submitBtn.backgroundColor = xtFirstHexColor(model.actionColorHex)
        }
    }

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let wrapper = UIView()
        wrapper.clipsToBounds = true
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wrapper)
        wrapper.layer.addSublayer(UIView.xt_layer(
            [XT_RGB(0x0BB559, 1.0).cgColor, UIColor.white.cgColor],
            locations: [0, 1.0],
            startPoint: CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 0.48),
            size: CGSize(width: XT_Screen_Width, height: 420)
        ))

        let topBg = UIImageView(image: XT_Img("xt_first_top_bg"))
        topBg.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(topBg)

        let contentImg = UIImageView(image: XT_Img("xt_first_top_content_bg")?.stretchableImage(withLeftCapWidth: 30, topCapHeight: 0))
        contentImg.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(contentImg)

        [nameLab, img, priceLab, descLab, item1TitLab, item1Lab, item2TitLab, item2Lab, submitBtn, altLab].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            wrapper.addSubview($0)
        }

        nameLab.font = XT_Font(13)
        nameLab.textColor = XT_RGB(0x797979, 1.0)
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        priceLab.font = XT_Font_B(40)
        priceLab.textColor = .black
        descLab.font = XT_Font_M(9)
        descLab.textColor = XT_RGB(0x3B3B3B, 1.0)
        [item1TitLab, item2TitLab].forEach {
            $0.font = XT_Font_M(9)
            $0.textColor = XT_RGB(0xAEAEAE, 1.0)
            $0.textAlignment = .center
        }
        [item1Lab, item2Lab].forEach {
            $0.font = XT_Font_SD(14)
            $0.textColor = XT_RGB(0x0BB559, 1.0)
            $0.textAlignment = .center
        }
        submitBtn.addTarget(self, action: #selector(submitTap), for: .touchUpInside)
        setupPrivacyText()

        let line = UIView()
        line.backgroundColor = XT_RGB(0x979797, 1.0)
        line.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(line)

        xtFirstActivate([
            wrapper.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            wrapper.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            wrapper.topAnchor.constraint(equalTo: contentView.topAnchor),
            wrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            topBg.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            topBg.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 15),

            contentImg.leftAnchor.constraint(equalTo: wrapper.leftAnchor, constant: 14),
            contentImg.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: -14),
            contentImg.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
            contentImg.heightAnchor.constraint(equalToConstant: 277),

            nameLab.leftAnchor.constraint(equalTo: contentImg.leftAnchor, constant: 20),
            nameLab.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 15),
            nameLab.heightAnchor.constraint(equalToConstant: 17),

            img.leftAnchor.constraint(equalTo: contentImg.leftAnchor, constant: 60),
            img.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 52),
            img.widthAnchor.constraint(equalToConstant: 56),
            img.heightAnchor.constraint(equalToConstant: 56),

            priceLab.leftAnchor.constraint(equalTo: img.rightAnchor, constant: 19),
            priceLab.rightAnchor.constraint(equalTo: contentImg.rightAnchor, constant: -10),
            priceLab.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 30),
            priceLab.heightAnchor.constraint(equalToConstant: 76),

            descLab.leftAnchor.constraint(equalTo: priceLab.leftAnchor),
            descLab.rightAnchor.constraint(equalTo: contentImg.rightAnchor, constant: -10),
            descLab.bottomAnchor.constraint(equalTo: priceLab.bottomAnchor),
            descLab.heightAnchor.constraint(equalToConstant: 10),

            line.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            line.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 24),
            line.widthAnchor.constraint(equalToConstant: 1),
            line.heightAnchor.constraint(equalToConstant: 34),

            item1TitLab.leftAnchor.constraint(equalTo: wrapper.leftAnchor),
            item1TitLab.rightAnchor.constraint(equalTo: line.leftAnchor),
            item1TitLab.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 24),
            item1TitLab.heightAnchor.constraint(equalToConstant: 13),
            item1Lab.leftAnchor.constraint(equalTo: wrapper.leftAnchor),
            item1Lab.rightAnchor.constraint(equalTo: line.leftAnchor),
            item1Lab.topAnchor.constraint(equalTo: item1TitLab.bottomAnchor, constant: 5),
            item1Lab.heightAnchor.constraint(equalToConstant: 20),

            item2TitLab.leftAnchor.constraint(equalTo: line.rightAnchor),
            item2TitLab.rightAnchor.constraint(equalTo: wrapper.rightAnchor),
            item2TitLab.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 24),
            item2TitLab.heightAnchor.constraint(equalToConstant: 13),
            item2Lab.leftAnchor.constraint(equalTo: line.rightAnchor),
            item2Lab.rightAnchor.constraint(equalTo: wrapper.rightAnchor),
            item2Lab.topAnchor.constraint(equalTo: item2TitLab.bottomAnchor, constant: 5),
            item2Lab.heightAnchor.constraint(equalToConstant: 20),

            submitBtn.leftAnchor.constraint(equalTo: wrapper.leftAnchor, constant: 25),
            submitBtn.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: -25),
            submitBtn.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 17),
            submitBtn.heightAnchor.constraint(equalToConstant: 48),

            altLab.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            altLab.topAnchor.constraint(equalTo: submitBtn.bottomAnchor, constant: 12),
            altLab.heightAnchor.constraint(equalToConstant: 17)
        ])
    }

    private func setupPrivacyText() {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Click to view the", attributes: [.font: XT_Font_M(12), .foregroundColor: UIColor.black]))
        let privacy = "Privacy Agreement"
        text.append(NSAttributedString(string: privacy, attributes: [.font: XT_Font_M(12), .foregroundColor: XT_RGB(0x02CC56, 1.0), .underlineStyle: NSUnderlineStyle.single.rawValue]))
        text.yy_setTextHighlight(NSRange(location: text.length - privacy.count, length: privacy.count), color: XT_RGB(0x02CC56, 1.0), backgroundColor: .clear) { _, _, _, _ in
            XTRoute.xt_share().goHtml(XT_Privacy_Url, success: nil)
        }
        altLab.attributedText = text
    }

    @objc private func submitTap() {
        guard model?.isActionEnabled == true else { return }
        nextBlock?()
    }
}

@objcMembers
@objc(XTProductCell)
class XTProductCell: XTCell {
    dynamic var nextBlock: XTBlock?
    private var model: ProductModel?
    private let iconImg = UIImageView()
    private let priceLab = UILabel()
    private let nameLab = UILabel()
    private let descLab = UILabel()
    private let submitBtn = UIButton.xt_btn("", font: XT_Font_M(12), textColor: .black, cornerRadius: 14, tag: 0)

    override var xt_data: Any? {
        didSet {
            guard let model = xt_data as? ProductModel else { return }
            self.model = model
            iconImg.sd_setImage(with: URL(string: model.logo ?? ""))
            nameLab.text = model.productName
            priceLab.text = model.amountText
            descLab.text = model.descriptionText
            submitBtn.setTitle(model.buttonText, for: .normal)
            submitBtn.backgroundColor = xtFirstHexColor(model.actionColorHex)
        }
    }

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.layer.shadowColor = UIColor(red: 193 / 255.0, green: 193 / 255.0, blue: 193 / 255.0, alpha: 0.46).cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowOpacity = 1
        container.layer.shadowRadius = 8
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)

        [iconImg, priceLab, nameLab, descLab, submitBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }
        iconImg.clipsToBounds = true
        iconImg.contentMode = .scaleAspectFill
        nameLab.font = XT_Font_SD(16)
        nameLab.textColor = XT_RGB(0x333333, 1.0)
        priceLab.font = XT_Font_B(16)
        priceLab.textAlignment = .right
        descLab.font = XT_Font_SD(11)
        descLab.textColor = XT_RGB(0x9C9C9C, 1.0)
        submitBtn.addTarget(self, action: #selector(submitTap), for: .touchUpInside)

        let line = UIImageView(image: XT_Img("xt_img_line"))
        line.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(line)
        let itemBg = UIImageView(image: XT_Img("xt_first_item_bg"))
        itemBg.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(itemBg)
        addSmallInfo(to: itemBg, icon: "xt_first_item_icon_1", text: "Recommended products with low interest rates", color: XT_RGB(0x0FB158, 1.0), top: 2)
        addSmallInfo(to: itemBg, icon: "xt_first_item_icon_2", text: "Products recommended by many people", color: XT_RGB(0xFFA93B, 1.0), top: 20)

        xtFirstActivate([
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            iconImg.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10),
            iconImg.topAnchor.constraint(equalTo: container.topAnchor, constant: 14),
            iconImg.widthAnchor.constraint(equalToConstant: 36),
            iconImg.heightAnchor.constraint(equalToConstant: 36),
            priceLab.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -17),
            priceLab.topAnchor.constraint(equalTo: container.topAnchor, constant: 18),
            priceLab.heightAnchor.constraint(equalToConstant: 28),
            nameLab.leftAnchor.constraint(equalTo: iconImg.rightAnchor, constant: 7),
            nameLab.rightAnchor.constraint(equalTo: priceLab.leftAnchor, constant: -5),
            nameLab.topAnchor.constraint(equalTo: container.topAnchor, constant: 11),
            nameLab.heightAnchor.constraint(equalToConstant: 22),
            descLab.leftAnchor.constraint(equalTo: iconImg.rightAnchor, constant: 7),
            descLab.rightAnchor.constraint(equalTo: priceLab.leftAnchor, constant: -5),
            descLab.topAnchor.constraint(equalTo: nameLab.bottomAnchor, constant: 2),
            descLab.heightAnchor.constraint(equalToConstant: 16),
            line.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10),
            line.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10),
            line.topAnchor.constraint(equalTo: iconImg.bottomAnchor, constant: 7),
            line.heightAnchor.constraint(equalToConstant: 1),
            itemBg.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10),
            itemBg.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            itemBg.widthAnchor.constraint(equalToConstant: 210),
            itemBg.heightAnchor.constraint(equalToConstant: 39),
            submitBtn.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -15),
            submitBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15),
            submitBtn.widthAnchor.constraint(equalToConstant: 88),
            submitBtn.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func addSmallInfo(to parent: UIView, icon: String, text: String, color: UIColor, top: CGFloat) {
        let image = UIImageView(image: XT_Img(icon))
        image.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(image)
        let label = UILabel()
        label.text = text
        label.font = XT_Font(8)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(label)
        xtFirstActivate([
            image.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: 7),
            image.topAnchor.constraint(equalTo: parent.topAnchor, constant: top),
            label.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 6),
            label.centerYAnchor.constraint(equalTo: image.centerYAnchor)
        ])
    }

    @objc private func submitTap() {
        guard model?.isActionEnabled == true else { return }
        nextBlock?()
    }
}

@objcMembers
@objc(XTSmallCell)
class XTSmallCell: XTCell, XTMarqueeViewDelegate, TYCyclePagerViewDataSource, TYCyclePagerViewDelegate {
    dynamic var nextBlock: XTBlock?
    private var small: CardModel?
    private let contentImg = UIImageView()
    private let nameLab = UILabel()
    private let img = UIImageView()
    private let priceLab = UILabel()
    private let descLab = UILabel()
    private let rightImg = UIImageView()
    private let submitBtn = UIButton.xt_btn("", font: XT_Font_M(20), textColor: .black, cornerRadius: 24, tag: 0)
    private let lanternView = UIView()
    private let marqueeView = XTMarqueeView(frame: CGRect(x: 40, y: 0, width: xtFirstLanternW, height: xtFirstLanternH))
    private var lanternArray: [LanternModel] = []
    private let bannerView = UIView()
    private let banner = TYCyclePagerView(frame: CGRect(x: 15, y: 0, width: XT_Screen_Width - 30, height: 115))
    private var bannerList: [BannerModel] = []

    override var xt_data: Any? {
        didSet {
            guard let model = xt_data as? IndexModel, let small = model.small else { return }
            self.small = small
            nameLab.text = small.productName
            img.sd_setImage(with: URL(string: small.logo ?? ""), placeholderImage: XT_Img("xt_img_def"))
            priceLab.text = small.amountText
            descLab.text = small.descriptionText
            rightImg.sd_setImage(with: URL(string: small.badgeImageURL ?? ""))
            submitBtn.setTitle(small.buttonText, for: .normal)
            submitBtn.backgroundColor = xtFirstHexColor(small.actionColorHex)

            lanternArray = model.lanternArr ?? []
            lanternView.isHidden = lanternArray.isEmpty
            marqueeView.reloadData()
            if !lanternArray.isEmpty {
                marqueeView.start()
            }

            bannerList = model.bannerArr ?? []
            bannerView.isHidden = bannerList.isEmpty
            banner.autoScrollInterval = bannerList.count > 1 ? 3 : 0
            banner.reloadData()
        }
    }

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let bg = UIImageView(image: XT_Img("xt_first_small_bg"))
        bg.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bg)
        let top = UIImageView(image: XT_Img("xt_first_top_bg"))
        top.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(top)
        contentImg.image = XT_Img("xt_first_top_content_small_bg")?.stretchableImage(withLeftCapWidth: 30, topCapHeight: 0)
        contentImg.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentImg)
        let tag = UIImageView(image: XT_Img("xt_first_tag"))
        tag.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tag)

        [nameLab, img, priceLab, descLab, rightImg, submitBtn, lanternView, bannerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        nameLab.font = XT_Font(13)
        nameLab.textColor = XT_RGB(0x797979, 1.0)
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        priceLab.font = XT_Font_B(40)
        descLab.font = XT_Font_M(9)
        descLab.textColor = XT_RGB(0x3B3B3B, 1.0)
        submitBtn.addTarget(self, action: #selector(submitTap), for: .touchUpInside)

        lanternView.backgroundColor = XT_RGB(0x0BB559, 1.0)
        lanternView.layer.cornerRadius = 14
        let lanternIcon = UIImageView(image: XT_Img("xt_first_lantern_icon"))
        lanternIcon.translatesAutoresizingMaskIntoConstraints = false
        lanternView.addSubview(lanternIcon)
        marqueeView.backgroundColor = .clear
        marqueeView.delegate = self
        marqueeView.timeIntervalPerScroll = 2
        marqueeView.timeDurationPerScroll = 1
        lanternView.addSubview(marqueeView)

        banner.isInfiniteLoop = false
        banner.dataSource = self
        banner.delegate = self
        banner.register(XTBannerChildCell.self, forCellWithReuseIdentifier: "XTBannerChildCell")
        bannerView.addSubview(banner)

        xtFirstActivate([
            bg.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bg.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            top.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            top.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14),
            contentImg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -14),
            contentImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 128),
            contentImg.heightAnchor.constraint(equalToConstant: 182),
            tag.rightAnchor.constraint(equalTo: contentImg.rightAnchor, constant: -16),
            tag.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 10),

            nameLab.leftAnchor.constraint(equalTo: contentImg.leftAnchor, constant: 16),
            nameLab.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 12),
            nameLab.heightAnchor.constraint(equalToConstant: 17),
            img.leftAnchor.constraint(equalTo: contentImg.leftAnchor, constant: 66),
            img.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 48),
            img.widthAnchor.constraint(equalToConstant: 56),
            img.heightAnchor.constraint(equalToConstant: 56),
            priceLab.leftAnchor.constraint(equalTo: img.rightAnchor, constant: 19),
            priceLab.rightAnchor.constraint(equalTo: contentImg.rightAnchor, constant: -10),
            priceLab.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 26),
            priceLab.heightAnchor.constraint(equalToConstant: 76),
            descLab.leftAnchor.constraint(equalTo: priceLab.leftAnchor),
            descLab.rightAnchor.constraint(equalTo: contentImg.rightAnchor, constant: -10),
            descLab.bottomAnchor.constraint(equalTo: priceLab.bottomAnchor),
            descLab.heightAnchor.constraint(equalToConstant: 10),
            rightImg.rightAnchor.constraint(equalTo: contentImg.rightAnchor, constant: -15),
            rightImg.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 10),
            rightImg.heightAnchor.constraint(equalToConstant: 21),
            submitBtn.leftAnchor.constraint(equalTo: contentImg.leftAnchor, constant: 25),
            submitBtn.rightAnchor.constraint(equalTo: contentImg.rightAnchor, constant: -25),
            submitBtn.topAnchor.constraint(equalTo: contentImg.topAnchor, constant: 117),
            submitBtn.heightAnchor.constraint(equalToConstant: 48),

            lanternView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            lanternView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            lanternView.topAnchor.constraint(equalTo: contentImg.bottomAnchor, constant: 12),
            lanternView.heightAnchor.constraint(equalToConstant: 28),
            lanternIcon.leftAnchor.constraint(equalTo: lanternView.leftAnchor, constant: 13),
            lanternIcon.centerYAnchor.constraint(equalTo: lanternView.centerYAnchor),

            bannerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bannerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bannerView.topAnchor.constraint(equalTo: lanternView.bottomAnchor, constant: 12),
            bannerView.heightAnchor.constraint(equalToConstant: 115)
        ])
    }

    @objc private func submitTap() {
        guard small?.isActionEnabled == true else { return }
        nextBlock?()
    }

    func numberOfVisibleItems(for marqueeView: XTMarqueeView) -> UInt {
        1
    }

    func numberOfData(for marqueeView: XTMarqueeView) -> UInt {
        UInt(lanternArray.count)
    }

    func createItemView(_ itemView: UIView, for marqueeView: XTMarqueeView) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: xtFirstLanternW, height: xtFirstLanternH))
        label.font = XT_Font_M(13)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.tag = xtFirstLanternLabelTag
        itemView.addSubview(label)
    }

    func updateItemView(_ itemView: UIView, at index: UInt, for marqueeView: XTMarqueeView) {
        guard Int(index) < lanternArray.count,
              let label = itemView.viewWithTag(xtFirstLanternLabelTag) as? UILabel else { return }
        let model = lanternArray[Int(index)]
        label.textColor = xtFirstHexColor(model.textColorHex, fallback: .white)
        label.text = model.text
    }

    func itemViewHeight(at index: UInt, for marqueeView: XTMarqueeView) -> CGFloat {
        xtFirstLanternH
    }

    func itemViewWidth(at index: UInt, for marqueeView: XTMarqueeView) -> CGFloat {
        xtFirstLanternW
    }

    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: banner.width, height: banner.height)
        layout.itemSpacing = 10
        layout.itemHorizontalCenter = true
        return layout
    }

    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        bannerList.count
    }

    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "XTBannerChildCell", for: index) as? XTBannerChildCell
            ?? XTBannerChildCell()
        cell.model = bannerList[index]
        return cell
    }

    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        XTRoute.xt_share().goHtml(bannerList[index].routeURL ?? "", success: nil)
    }
}

@objc enum XTMarqueeViewDirection: UInt {
    case upward = 0
    case leftward = 1
}

@objc protocol XTMarqueeViewDelegate: AnyObject {
    @objc(numberOfDataForMarqueeView:)
    func numberOfData(for marqueeView: XTMarqueeView) -> UInt

    @objc(createItemView:forMarqueeView:)
    func createItemView(_ itemView: UIView, for marqueeView: XTMarqueeView)

    @objc(updateItemView:atIndex:forMarqueeView:)
    func updateItemView(_ itemView: UIView, at index: UInt, for marqueeView: XTMarqueeView)

    @objc optional func numberOfVisibleItems(for marqueeView: XTMarqueeView) -> UInt
    @objc(itemViewWidthAtIndex:forMarqueeView:) optional func itemViewWidth(at index: UInt, for marqueeView: XTMarqueeView) -> CGFloat
    @objc(itemViewHeightAtIndex:forMarqueeView:) optional func itemViewHeight(at index: UInt, for marqueeView: XTMarqueeView) -> CGFloat
    @objc(didTouchItemViewAtIndex:forMarqueeView:) optional func didTouchItemView(at index: UInt, for marqueeView: XTMarqueeView)
}

@objcMembers
@objc(XTMarqueeView)
class XTMarqueeView: UIView {
    weak dynamic var delegate: XTMarqueeViewDelegate?
    dynamic var timeIntervalPerScroll: TimeInterval = 4
    dynamic var timeDurationPerScroll: TimeInterval = 1
    dynamic var useDynamicHeight = false
    dynamic var scrollSpeed: Float = 40
    dynamic var itemSpacing: Float = 20
    dynamic var stopWhenLessData = false
    dynamic var touchEnabled = false
    dynamic var direction: XTMarqueeViewDirection = .upward

    private let contentView = UIView()
    private var itemView = UUMarqueeItemView()
    private var dataIndex: UInt = 0
    private var timer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc(initWithDirection:)
    init(direction: XTMarqueeViewDirection) {
        self.direction = direction
        super.init(frame: .zero)
        setup()
    }

    @objc(initWithFrame:direction:)
    init(frame: CGRect, direction: XTMarqueeViewDirection) {
        self.direction = direction
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.clipsToBounds = true
        addSubview(contentView)
        NotificationCenter.default.addObserver(self, selector: #selector(pause), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(start), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
        itemView.frame = bounds
    }

    deinit {
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }

    @objc func reloadData() {
        timer?.invalidate()
        timer = nil
        dataIndex = 0
        itemView.removeFromSuperview()
        itemView = UUMarqueeItemView(frame: bounds)
        contentView.addSubview(itemView)
        delegate?.createItemView(itemView, for: self)
        showCurrentItem()
    }

    @objc func start() {
        guard timer == nil, (delegate?.numberOfData(for: self) ?? 0) > 0 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: timeIntervalPerScroll, repeats: true) { [weak self] _ in
            self?.advance()
        }
    }

    @objc func pause() {
        timer?.invalidate()
        timer = nil
    }

    private func advance() {
        let count = delegate?.numberOfData(for: self) ?? 0
        guard count > 0 else { return }
        dataIndex = (dataIndex + 1) % count
        let oldFrame = itemView.frame
        UIView.animate(withDuration: timeDurationPerScroll, animations: {
            self.itemView.frame = self.direction == .leftward
                ? oldFrame.offsetBy(dx: -oldFrame.width, dy: 0)
                : oldFrame.offsetBy(dx: 0, dy: -oldFrame.height)
        }, completion: { _ in
            self.itemView.frame = self.bounds
            self.showCurrentItem()
        })
    }

    private func showCurrentItem() {
        guard (delegate?.numberOfData(for: self) ?? 0) > 0 else { return }
        delegate?.updateItemView(itemView, at: dataIndex, for: self)
    }
}

@objcMembers
@objc(XTMarqueeViewTouchReceiver)
class XTMarqueeViewTouchReceiver: UIView {
    weak dynamic var touchDelegate: AnyObject?
}

@objcMembers
@objc(UUMarqueeItemView)
class UUMarqueeItemView: UIView {
    dynamic var didFinishCreate = false
    dynamic var itemWidth: CGFloat = 0
    dynamic var itemHeight: CGFloat = 0

    @objc func clear() {
        subviews.forEach { $0.removeFromSuperview() }
        didFinishCreate = false
    }
}
