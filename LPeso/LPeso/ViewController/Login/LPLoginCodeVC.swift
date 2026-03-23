//
//  LPLoginCodeVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/1.
//

import UIKit

class LPLoginCodeVC: LPBaseVC, UITextFieldDelegate {
    
    var phoneStr:String = ""
    var codeModel:LPLoginModel?
    
    private var textFieldArr: [LPCodeField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        lp_title = "Login"
        hasRightButton = false
        
        Location.startLocation()
        setupUI()
        startCountDown()
        
    }
    
    func setupUI(){
        let imgV = UIImageView()
        imgV.imgName("login_img4")
        contentV.addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-44)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScaleX(311), height: kScaleX(81)))
        }
        
        contentV.addSubview(tipsLab)
        tipsLab.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(32)
            make.height.equalTo(20)
        }
        
        contentV.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.top.equalTo(tipsLab.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        contentV.addSubview(resendBtn)
        resendBtn.snp.makeConstraints { make in
            make.top.equalTo(codeView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(48)
        }
        
        setCodeField()
    }

    
    lazy var tipsLab:UILabel = {
        let txt1 = phoneStr.modify()
        let txt2 = "Verify code has been sent to \(txt1)" //Verify code has been sent to your number
        let tipsLab = UILabel.new(text: txt2, textColor: gray102, font: .systemFont(ofSize: 12))
        if let range = txt2.range(of: txt1) {
            let nsRange = NSRange(range, in: txt2)
            var attrStr = NSMutableAttributedString(string: txt2)
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: black51, range: nsRange)
            attrStr.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: nsRange)
            tipsLab.attributedText = attrStr
        }
        return tipsLab
    }()
    
    lazy var resendBtn:UIButton = {
        let resendBtn = UIButton.textBtn(title: "Send（60s）", titleColor: reSendColor, font: .font_Roboto_M(16),corner: 2,bordW: 2,bordColor: reSendColor)
        resendBtn.addTarget(self, action: #selector(resend), for: .touchUpInside)
        resendBtn.isEnabled = false
        return resendBtn
    }()
    
    lazy var codeView:UIView = {
        let codeView = UIView.empty()
        return codeView
    }()
    
    
    //MARK: CodeField
    private func setCodeField() {
        let digitWidth: CGFloat = 36
        let digitheight: CGFloat = 46
        let spacing: CGFloat = 16
        let codeDigits = 6
        let leftMar = (kWidth - CGFloat(codeDigits)*(digitWidth+spacing) + spacing)/2
        
        for i in 0..<codeDigits {
            let frames = CGRect(x: leftMar+CGFloat(i)*(digitWidth+spacing), y: 0, width: digitWidth, height: digitheight)
            let singleCode = LPCodeField(frame: frames)
            singleCode.layer.masksToBounds = true
            singleCode.layer.cornerRadius = 1
            singleCode.keyboardType = .numberPad
            singleCode.textAlignment = .center
            singleCode.delegate = self
            singleCode.borderWidth = 2
            singleCode.borderColor = gray224
            singleCode.backgroundColor = gray249
            singleCode.textColor = black51
            singleCode.font = .font_Roboto_M(16)
            singleCode.tag = i
            
            let btn = UIButton.emptyBtn()
            btn.addTarget(self, action: #selector(textFiledClick), for: .touchUpInside)
            btn.frame = frames
            codeView.addSubview(singleCode)
            codeView.addSubview(btn)
            textFieldArr.append(singleCode)
            if singleCode.tag == 0{
                singleCode.becomeFirstResponder()
            }
            singleCode.backwardBlock = {
                if singleCode.tag > 0{
                    let str = singleCode.text ?? ""
                    if str == "" {
                        let previousTextField = self.textFieldArr[singleCode.tag-1]
                        previousTextField.text = ""
                        previousTextField.becomeFirstResponder()
                    }
                    
                }
            }
        }
    }
    
    @objc func textFiledClick(){
        
        for codeField in textFieldArr{
            if codeField.text?.isEmpty ?? true {
                codeField.becomeFirstResponder()
                return
            }
        }
        
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for codeField in textFieldArr{
            codeField.textColor = codeField == textField ? mainColor38 : black51
            codeField.borderColor = codeField == textField ? mainColor38 : gray224
            codeField.backgroundColor = codeField == textField ? mainColor241 : gray249
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textColor = black51
        textField.borderColor = gray224
        textField.backgroundColor = gray249
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location > 0{
            textField.text = ""
        }
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count ?? 0 >= 1 {
            var tg = textField.tag
            if tg == textFieldArr.count-1{
                if !checkSubmit(textField){
                    for texF in textFieldArr{
                        if texF.text?.count ?? 0 == 0{
                            texF.becomeFirstResponder()
                            break
                        }
                    }
                }
            }else{
                while textFieldArr[tg].text?.count ?? 0 > 0{
                    if tg >= textFieldArr.count-1{
                        break
                    }
                    tg += 1
                }
                
                if tg == textFieldArr.count-1,textFieldArr[tg].text?.count ?? 0 > 0{
                    if !checkSubmit(textField){
                        for texF in textFieldArr{
                            if texF.text?.count ?? 0 == 0{
                                texF.becomeFirstResponder()
                                break
                            }
                        }
                    }
                }else{
                    let nextTextField = textFieldArr[tg]
                    nextTextField.becomeFirstResponder()
                }
                
            }
            
        }
        
    }

    func checkSubmit(_ textField:UITextField?=nil) ->Bool{
        var codeStr = ""
        for texF in textFieldArr{
            if let txt = texF.text{
                codeStr += txt
            }
        }
        if codeStr.count == textFieldArr.count{
            textField?.resignFirstResponder()
            login(code: codeStr)
            return true
        }
        
        return false
    }
    
    //MARK: count down
    @objc private func startCountDown() {
        UserSession.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onCountDown), userInfo: nil, repeats: true)
        if UserSession.countdownTime <= 0{
            UserSession.countdownTime = 60
        }
        setButtonStyle(isCountDown: true)
    }
    
    @objc private func onCountDown() {
        UserSession.countdownTime -= 1
        resendBtn.setTitle("Send (\(UserSession.countdownTime)s)", for: .normal)
        if UserSession.countdownTime <= 0 { recovery() }
    }
    
    private func recovery() {
        setButtonStyle(isCountDown: false)
        stopCountDown()
    }
    
    private func setButtonStyle(isCountDown: Bool) {
        resendBtn.setTitle(isCountDown ? "Send (\(UserSession.countdownTime)s)" : "Resend", for: .normal)
//        resendBtn.borderColor = isCountDown ? UIColor.systemGray : resendColor
//        resendBtn.setTitleColor(isCountDown ? UIColor.systemGray : resendColor, for: .normal)
        resendBtn.isEnabled = !isCountDown
    }
    
    private func stopCountDown() {
        guard UserSession.timer != nil else { return }
        UserSession.timer?.invalidate()
        UserSession.timer = nil
    }
    
    //MARK: function
    @objc func resend(){
        Request.send(api: .code(phone: phoneStr),showLoading: true, showResult: true) { (result:LPLoginModel?) in
            self.startCountDown()
        } failure: { _ in
            
        }

    }
    
    func login(code:String){
        let pointDict:[String:Any] = LPTools.getPointParams(startTime: self.startTime, sceneType: "21")
        Request.send(api: .login(params: ["PTUListedi": phoneStr,"PTUNeglectfullyi": code,"PTUGalvanisei": "duiuyiton","point": pointDict]),showLoading: true, showResult: true) { (result:LPLoginModel?) in
            
            if let name = result?.PTUGotoi?.PTUListedi,let id = result?.PTUGotoi?.PTUSkittlei{
                UserSession.phone = name
                UserSession.id = id
                Route.dismissAll()
            }
            
        } failure: { error in
            
            for texF in self.textFieldArr{
                texF.text = ""
            }
            self.textFieldArr.first?.becomeFirstResponder()
            
        }

        
    }
    
    override func backBtnAction() {
        stopCountDown()
        if UserSession.countdownTime>0{
            UserSession.continueCountDown()
        }
        self.dismiss(animated: true)
    }
}
