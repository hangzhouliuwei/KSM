//
//  XTOrderVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import SDWebImage
import UIKit
import YYModel

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
            self.createView(index)
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
        createView(viewIndex)
    }

    @objc(createView:)
    func createView(_ index: Int) {
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
        createView(viewIndex)
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