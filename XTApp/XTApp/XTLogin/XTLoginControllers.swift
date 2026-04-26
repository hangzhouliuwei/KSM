//
//  XTLoginControllers.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import CRBoxInputView
import UIKit
import YFPopView

@objcMembers
@objc(XTLoginCodeVC)
class XTLoginCodeVC: XTBaseVC, UITextFieldDelegate {
    dynamic var loginBlock: XTBlock?

    private var countDown = "0"
    private var phone = ""
    private weak var loginVC: XTLoginVC?
    private weak var textField: UITextField?
    private weak var agreementButton: UIButton?
    private var codeTimer: DispatchSourceTimer?
    private var environmentTapCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        xt_bkBtn.isHidden = true
        xt_navView.backgroundColor = .clear
        setupHeader()
        setupForm()
    }

    deinit {
        codeTimer?.cancel()
    }

    private func setupHeader() {
        let icon = UIImageView(image: XT_Img("xt_login_icon"))
        icon.frame = CGRect(x: 20, y: XT_StatusBar_Height + 8, width: 28, height: 28)
        xt_navView.addSubview(icon)

        let name = UILabel(frame: CGRect(x: 58, y: icon.y, width: 180, height: 28))
        name.text = XT_App_Name
        name.font = XT_Font_SD(16)
        name.textColor = .white
        xt_navView.addSubview(name)

        let top = UIImageView(image: XT_Img("xt_login_code_top_bg"))
        top.frame = CGRect(x: 0, y: 0, width: view.width, height: 220)
        top.contentMode = .scaleAspectFill
        view.insertSubview(top, belowSubview: xt_navView)
    }

    private func setupForm() {
        let panel = UIView(frame: CGRect(x: 0, y: 190, width: view.width, height: 305))
        panel.backgroundColor = .white
        panel.layer.cornerRadius = 20
        panel.clipsToBounds = true
        view.addSubview(panel)
        view.bringSubviewToFront(xt_navView)

        let title = UILabel(frame: CGRect(x: 27, y: 23, width: view.width - 54, height: 72))
        title.numberOfLines = 0
        title.attributedText = NSString.xt_strs(
            ["Log in\n", "to experience personal loan services now"],
            fonts: [XT_Font_M(31), XT_Font_M(17)],
            colors: [XT_RGB(0x0BB559, 1.0), .black]
        )
        panel.addSubview(title)

        let codeView = UIView(frame: CGRect(x: 20, y: 116, width: panel.width - 40, height: 52))
        codeView.backgroundColor = .white
        codeView.layer.cornerRadius = 26
        codeView.layer.shadowColor = UIColor.black.withAlphaComponent(0.11).cgColor
        codeView.layer.shadowOffset = CGSize(width: 0, height: 1)
        codeView.layer.shadowOpacity = 1
        codeView.layer.shadowRadius = 4
        panel.addSubview(codeView)

        let prefix = UILabel(frame: CGRect(x: 26, y: 0, width: 42, height: 52))
        prefix.text = "+63"
        prefix.font = XT_Font_M(17)
        prefix.textColor = XT_RGB(0x0BB559, 1.0)
        codeView.addSubview(prefix)

        let phoneField = UITextField(frame: CGRect(x: 92, y: 0, width: codeView.width - 112, height: 52))
        phoneField.placeholder = "Phone number"
        phoneField.font = XT_Font_M(14)
        phoneField.keyboardType = .numberPad
        phoneField.delegate = self
        phoneField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        codeView.addSubview(phoneField)
        textField = phoneField

        let readBtn = UIButton(type: .custom)
        readBtn.frame = CGRect(x: 36, y: 193, width: 210, height: 25)
        readBtn.setTitle(" I have read and agree with the", for: .normal)
        readBtn.setTitleColor(.black, for: .normal)
        readBtn.titleLabel?.font = XT_Font(12)
        readBtn.setImage(XT_Img("xt_login_code_select_yes"), for: .selected)
        readBtn.setImage(XT_Img("xt_login_code_select_no"), for: .normal)
        readBtn.isSelected = true
        readBtn.addTarget(self, action: #selector(toggleRead(_:)), for: .touchUpInside)
        panel.addSubview(readBtn)
        agreementButton = readBtn

        let privacy = UIButton(type: .custom)
        privacy.frame = CGRect(x: readBtn.frame.maxX, y: 193, width: 130, height: 25)
        privacy.setAttributedTitle(NSAttributedString(
            string: "Privacy Agreement",
            attributes: [
                .font: XT_Font_B(12),
                .foregroundColor: XT_RGB(0x02CC56, 1.0),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        ), for: .normal)
        privacy.addTarget(self, action: #selector(openPrivacy), for: .touchUpInside)
        panel.addSubview(privacy)

        let codeBtn = UIButton.xt_btn("Let’s Go", font: XT_Font_B(20), textColor: .white, cornerRadius: 24, tag: 0)
        codeBtn.backgroundColor = XT_RGB(0x02CC56, 1.0)
        codeBtn.frame = CGRect(x: 20, y: 248, width: panel.width - 40, height: 48)
        codeBtn.addTarget(self, action: #selector(letGoTapped), for: .touchUpInside)
        panel.addSubview(codeBtn)

        let testBtn = UIButton(type: .custom)
        testBtn.frame = CGRect(x: view.width - 50, y: view.height - 50 - XT_Bottom_Height, width: 50, height: 50 + XT_Bottom_Height)
        testBtn.addTarget(self, action: #selector(environmentButtonTapped), for: .touchUpInside)
        view.addSubview(testBtn)
    }

    @objc private func letGoTapped() {
        guard agreementButton?.isSelected == true else {
            showAltView()
            return
        }
        checkCode()
    }

    @objc private func toggleRead(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

    @objc private func openPrivacy() {
        navigationController?.pushViewController(XTHtmlVC(url: XT_Privacy_Url), animated: true)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 15 {
            textField.text = String(textField.text?.prefix(15) ?? "")
        }
    }

    private func showAltView() {
        let altView = XTCodeAltView()
        altView.center = view.center
        guard let popView = YFPopView(animationView: altView) else { return }
        popView.animationStyle = .fade
        popView.autoRemoveEnable = true
        popView.show(on: view)
    }

    @objc private func environmentButtonTapped() {
        environmentTapCount += 1
        guard environmentTapCount == 5 else { return }
        environmentTapCount = 0
        showEnvironmentPasswordAlert()
    }

    private func showEnvironmentPasswordAlert() {
        let alert = UIAlertController(title: "switch_environment", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "switch_environment"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [weak self, weak alert] _ in
            guard alert?.textFields?.first?.text == "ksm2023" else {
                XTUtility.xt_showTips("Password error!", view: nil)
                return
            }
            self?.showEnvironmentInputAlert()
        })
        xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }

    private func showEnvironmentInputAlert() {
        let alert = UIAlertController(title: "Environment", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Environment"
            textField.keyboardType = .URL
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [weak alert] _ in
            let text = alert?.textFields?.first?.text ?? ""
            guard text.hasPrefix("http://") || text.hasPrefix("https://") else {
                XTUtility.xt_showTips("Please enter the correct domain name", view: nil)
                return
            }
            let url = text + XT_Api_api
            try? url.write(toFile: XT_Locality_Url_Path, atomically: true, encoding: .utf8)
        })
        xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }

    @objc func checkCode() {
        let text = XT_Object_To_Stirng(textField?.text)
        guard (8...15).contains(text.count) else {
            XTUtility.xt_showTips("Please enter a valid phone number", view: view)
            return
        }
        if phone == text && (Int(countDown) ?? 0) > 0 {
            nextLoginVC()
            return
        }
        phone = text
        getCodeNumber { [weak self] in
            self?.nextLoginVC()
        }
    }

    @objc(getCodeNumber:)
    func getCodeNumber(_ block: XTBlock?) {
        let api = XTPhoneCodeApi(phone: phone)
        XTUtility.xt_showProgress(view, message: "loading...")
        api.xt_startRequestSuccess { [weak self] dic, str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            XTUtility.xt_showTips(str, view: nil)
            if let codeInfo = dic?["gugosixyleNc"] as? [AnyHashable: Any] {
                self.countDown = XT_Object_To_Stirng(codeInfo["tedisixurnalNc"])
                self.goCountDown()
                block?()
            }
        } failure: { [weak self] _, str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            XTUtility.xt_showTips(str, view: nil)
        } error: { [weak self] _ in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        }
    }

    private func goCountDown() {
        codeTimer?.cancel()
        var timeout = Int(countDown) ?? 0
        let timer = DispatchSource.makeTimerSource(queue: .global())
        codeTimer = timer
        timer.schedule(deadline: .now(), repeating: 1)
        timer.setEventHandler { [weak self] in
            guard let self else {
                timer.cancel()
                return
            }
            if timeout <= 0 {
                timer.cancel()
                self.countDown = "0"
            } else {
                timeout -= 1
                self.countDown = "\(timeout)"
            }
            DispatchQueue.main.async {
                self.loginVC?.reloadCountDown(self.countDown)
            }
        }
        timer.resume()
    }

    private func nextLoginVC() {
        let vc = XTLoginVC(phone: phone, countDown: countDown)
        vc.loginBlock = loginBlock
        loginVC = vc
        vc.resendBlock = { [weak self] in
            self?.getCodeNumber(nil)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

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
    private let viewModel = XTLoginViewModel()

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
        let point: [String: Any] = [
            "deamsixatoryNc": XT_Object_To_Stirng(startTime),
            "munisixumNc": "1",
            "hyrasixrthrosisNc": "21",
            "boomsixofoNc": XT_Object_To_Stirng(XTLocationManger.xt_share().xt_latitude),
            "unulsixyNc": XT_Object_To_Stirng(XTUtility.xt_share().xt_nowTimeStamp()),
            "cacosixtomyNc": XT_Object_To_Stirng(XTDevice.xt_share().xt_idfv),
            "unevsixoutNc": XT_Object_To_Stirng(XTLocationManger.xt_share().xt_longitude)
        ]
        let dic: [String: Any] = [
            "stwasixrdessNc": phone,
            "firosixticNc": code,
            "latesixscencyNc": "duiuyiton",
            "point": point
        ]
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.getLogin(dic as NSDictionary) { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.loginBlock?()
            if XT_AppDelegate?.xt_nv != nil {
                self.navigationController?.dismiss(animated: true)
            } else {
                XT_AppDelegate?.xt_mainView()
            }
        } failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.codeInputView.clearAll()
        }
    }
}
