//
//  XTVerifyBankVC.swift
//  XTApp
//

import UIKit

@objcMembers
@objc(XTVerifyBankVC)
class XTVerifyBankVC: XTBaseVC {
    private let viewModel = XTVerifyViewModel()
    private var productId = ""
    private var orderId = ""
    private var startTime = ""
    private lazy var submitBtn: UIButton = xtVerifySubmitButton(title: "Next", target: self, action: #selector(goCheck))
    private let segList: [NSDictionary] = [
        ["value": "2", "name": "E-Wallet"] as NSDictionary,
        ["value": "1", "name": "Bank"] as NSDictionary
    ]
    private var walletView = XTWalletView()
    private var bankView = XTBankView()

    @objc(initWithProductId:orderId:)
    init(productId: String, orderId: String) {
        self.productId = productId
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xtVerifyEnsureLocation()
        startTime = XTUtility.xt_share().xt_nowTimeStamp()
        xt_title = "Withdrawal account"
        xt_title_color = .white
        view.backgroundColor = XT_RGB(0xF2F5FA, 1.0)
        viewModel.xt_card(productId, success: { [weak self] in
            self?.xt_UI()
        }, failure: {
        })
    }

    @objc func xt_UI() {
        let topView = UIView(frame: CGRect(x: 0, y: xt_navView.frame.maxY, width: view.width, height: 2))
        topView.backgroundColor = XT_RGB(0x0BB559, 1.0)
        view.addSubview(topView)
        let topBG = UIImageView(image: XT_Img("xt_verify_bank_top_bg"))
        topBG.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBG)
        let title = UILabel()
        title.text = "You can use E-wallet / bank account / over the counter to repay the bills."
        title.font = XT_Font(14)
        title.textColor = XT_RGB(0x333333, 1.0)
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)

        var index = 0
        if !NSString.xt_isEmpty(viewModel.bankModel?.bankModel?.xt_channel) {
            index = 1
        }
        let seg = XTSegView(arr: segList, font: XT_Font_SD(15), selectFont: XT_Font_SD(15), color: XT_RGB(0x01A652, 1.0), selectColor: .white, bgColor: .white, selectBgColor: XT_RGB(0x0BB559, 1.0), select: index)
        seg.layer.borderColor = XT_RGB(0x0BB559, 1.0).cgColor
        seg.layer.borderWidth = 1
        seg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seg)
        walletView = XTWalletView()
        walletView.model = viewModel.bankModel?.walletModel
        bankView = XTBankView()
        bankView.model = viewModel.bankModel?.bankModel
        walletView.isHidden = index == 1
        bankView.isHidden = index == 0
        bankView.block = { [weak self] block in
            guard let self else { return }
            self.select(self.viewModel.bankModel?.bankModel?.note ?? [], tit: "Select Bank", value: self.bankView.value, block: block)
        }
        [submitBtn, walletView, bankView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        seg.block = { [weak self] (_: Int) in
            guard let self else { return }
            self.walletView.isHidden.toggle()
            self.bankView.isHidden.toggle()
        }
        xtVerifyActivate([
            topBG.leftAnchor.constraint(equalTo: view.leftAnchor),
            topBG.rightAnchor.constraint(equalTo: view.rightAnchor),
            topBG.topAnchor.constraint(equalTo: topView.bottomAnchor),
            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            title.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14),
            title.topAnchor.constraint(equalTo: topBG.bottomAnchor, constant: 20),
            seg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            seg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14),
            seg.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            seg.heightAnchor.constraint(equalToConstant: 42),
            submitBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            submitBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            submitBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -XT_Bottom_Height - 20),
            submitBtn.heightAnchor.constraint(equalToConstant: 48),
            walletView.leftAnchor.constraint(equalTo: view.leftAnchor),
            walletView.rightAnchor.constraint(equalTo: view.rightAnchor),
            walletView.topAnchor.constraint(equalTo: seg.bottomAnchor, constant: 20),
            walletView.bottomAnchor.constraint(equalTo: submitBtn.topAnchor, constant: -20),
            bankView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bankView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bankView.topAnchor.constraint(equalTo: seg.bottomAnchor, constant: 20),
            bankView.bottomAnchor.constraint(equalTo: submitBtn.topAnchor, constant: -20)
        ])
    }

    override func xt_back() {
        xtVerifyConfirmLeave()
    }

    @objc(select:tit:value:block:)
    func select(_ arr: [XTNoteModel], tit: String?, value: String?, block: XTDicBlock?) {
        let select = XTSelectView(tit: tit ?? "", arr: arr)
        select.xt_value(value)
        select.closeBlock = { [weak select] in select?.removeFromSuperview() }
        select.sureBlock = block
        xtVerifyShowOverlay(select, from: view)
    }

    @objc func goCheck() {
        let type: Int
        let title: String
        let name: String?
        let value: String?
        let account: String?
        if !walletView.isHidden {
            guard let indexModel = walletView.indexModel else {
                XTUtility.xt_showTips("Please Select E-Wallet", view: view)
                return
            }
            guard !NSString.xt_isEmpty(walletView.textField?.text) else {
                XTUtility.xt_showTips("Please Enter E-wallet Account", view: view)
                return
            }
            type = 2
            title = "Channel"
            name = indexModel.xt_name
            value = indexModel.xt_type
            account = walletView.textField?.text
        } else {
            guard !NSString.xt_isEmpty(bankView.value) else {
                XTUtility.xt_showTips("Please Select Bank", view: view)
                return
            }
            guard !NSString.xt_isEmpty(bankView.accountTextField.text) else {
                XTUtility.xt_showTips("Please Enter Bank Account", view: view)
                return
            }
            type = 1
            title = "Bank"
            name = bankView.name
            value = bankView.value
            account = bankView.accountTextField.text
        }

        let alert = XTBankAltView(tit: title, name: name ?? "", account: account ?? "")
        alert.center = view.center
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        overlay.addSubview(alert)
        view.addSubview(overlay)
        alert.cancelBlock = { [weak overlay] in overlay?.removeFromSuperview() }
        alert.submitBlock = { [weak self] in
            self?.goSubmit([
                "ceNcsix": "\(type)",
                "blthsixelyNc": XT_Object_To_Stirng(value),
                "ovrcsixutNc": XT_Object_To_Stirng(account)
            ])
        }
    }

    @objc(goSubmit:)
    func goSubmit(_ parameter: [AnyHashable: Any]) {
        var dic = parameter
        dic["lietsixusNc"] = XT_Object_To_Stirng(productId)
        dic["point"] = xtVerifyPoint(productId: productId, startTime: startTime, type: "26")
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_card_next(NSDictionary(dictionary: dic), success: { [weak self] str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.goNext(str)
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    @objc(goNext:)
    func goNext(_ str: String?) {
        XTLoanFlowCoordinator.shared.routeNext(code: str, productId: productId, orderId: orderId, loadingView: view, removeCurrentController: self)
    }
}