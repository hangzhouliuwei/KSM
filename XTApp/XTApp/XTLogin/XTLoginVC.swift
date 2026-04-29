//
//  XTLoginVC.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import CRBoxInputView
import UIKit

@objcMembers
@objc(XTLoginVC)
class XTLoginVC: XTBaseVC, UITextFieldDelegate {
    dynamic var resendBlock: XTBlock?
    dynamic var loginBlock: XTBlock?

    private var phone = ""
    private var countDown = ""
    private var startTime = ""
    private let countDownBtn = UIButton.xt_btn("", font: XT_Font_M(14), textColor: .white, cornerRadius: 16, tag: 0)
    private lazy var codeInputView: CRBoxInputView = {
        let itemHeight: CGFloat = 48
        let itemSpacing: CGFloat = 5
        let codeLength = 6

        let property = CRBoxInputCellProperty()
        property.cellCursorColor = XT_RGB(0x0BB559, 1.0)
        property.cornerRadius = 1
        property.borderWidth = 1
        property.cellBorderColorFilled = XT_RGB(0x0BB559, 1.0)
        property.cellBorderColorSelected = XT_RGB(0x0BB559, 1.0)
        property.cellBorderColorNormal = XT_RGB(0x0BB559, 1.0)
        property.cellFont = XT_Font_M(31)
        property.cellTextColor = XT_RGB(0x0BB559, 1.0)

        let inputView = CRBoxInputView(codeLength: codeLength)!
        inputView.frame = CGRect(x: 0, y: 0, width: (itemHeight + itemSpacing) * CGFloat(codeLength) - itemSpacing, height: itemHeight)
        inputView.boxFlowLayout?.itemSize = CGSize(width: itemHeight, height: itemHeight)
        inputView.boxFlowLayout?.minLineSpacing = Int(itemSpacing)
        inputView.customCellProperty = property
        inputView.keyBoardType = .numberPad
        inputView.loadAndPrepare(withBeginEdit: true)
        inputView.textDidChangeblock = { [weak self] text, isFinished in
            guard isFinished else { return }
            self?.goLogin(phone: self?.phone ?? "", code: text ?? "")
        }
        return inputView
    }()

    @objc(initPhone:countDown:)
    init(phone: String, countDown: String) {
        self.phone = XT_Object_To_Stirng(phone)
        self.countDown = XT_Object_To_Stirng(countDown)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startTime = XTUtility.xt_share().xt_nowTimeStamp()
        XTLocationManger.xt_share().xt_startLocation()
        xt_bkBtn.isHidden = true
        xt_navView.backgroundColor = .clear
        setupUI()
        reloadCountDown(countDown)
    }

    private func setupUI() {
        let panel = UIView(frame: CGRect(x: 0, y: 190, width: view.width, height: 305))
        panel.backgroundColor = .white
        panel.layer.cornerRadius = 20
        panel.clipsToBounds = true
        view.addSubview(panel)

        let back = UIButton(type: .custom)
        back.setImage(XT_Img("xt_login_back"), for: .normal)
        back.frame = CGRect(x: 8, y: 12, width: 44, height: 44)
        back.addTarget(self, action: #selector(xt_back), for: .touchUpInside)
        panel.addSubview(back)

        let title = UILabel(frame: CGRect(x: 27, y: 52, width: view.width - 54, height: 56))
        title.attributedText = NSString.xt_strs(
            ["Please\n", "enter verification code"],
            fonts: [XT_Font_M(31), XT_Font_M(17)],
            colors: [XT_RGB(0x0BB559, 1.0), .black]
        )
        title.numberOfLines = 0
        panel.addSubview(title)

        let codeView = UIView(frame: CGRect(x: (panel.width - codeInputView.width) / 2, y: 128, width: codeInputView.width, height: codeInputView.height))
        codeView.addSubview(codeInputView)
        panel.addSubview(codeView)

        let sub = UILabel(frame: CGRect(x: 20, y: 205, width: panel.width - 120, height: 40))
        sub.numberOfLines = 2
        sub.attributedText = NSString.xt_strs(
            ["SMS verification code has been sent to\n", phone],
            fonts: [XT_Font_M(13), XT_Font_M(13)],
            colors: [.black, XT_RGB(0x0BB559, 1.0)]
        )
        panel.addSubview(sub)

        countDownBtn.frame = CGRect(x: panel.width - 92, y: 209, width: 72, height: 32)
        countDownBtn.backgroundColor = XT_RGB(0x02CC56, 1.0)
        countDownBtn.addTarget(self, action: #selector(resend), for: .touchUpInside)
        panel.addSubview(countDownBtn)
    }

    @objc(reloadCountDown:)
    func reloadCountDown(_ countDown: String) {
        self.countDown = countDown
        if (Int(countDown) ?? 0) > 0 {
            countDownBtn.isUserInteractionEnabled = false
            countDownBtn.setTitle("\(countDown)s", for: .normal)
        } else {
            countDownBtn.isUserInteractionEnabled = true
            countDownBtn.setTitle("Resend", for: .normal)
        }
    }

    @objc private func resend() {
        resendBlock?()
    }

    private func goLogin(phone: String, code: String) {
        XTLoginFlowCoordinator.shared.login(phone: phone, code: code, startTime: startTime, loadingView: view) { [weak self] in
            guard let self else { return }
            XTLoginFlowCoordinator.shared.finishLogin(from: self, loginBlock: self.loginBlock)
        } failure: { [weak self] in
            self?.codeInputView.clearAll()
        }
    }
}