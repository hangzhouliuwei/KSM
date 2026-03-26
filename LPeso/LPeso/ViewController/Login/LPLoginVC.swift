//
//  LPLoginVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/1.
//

import UIKit

class LPLoginVC: LPBaseVC, UITextFieldDelegate {

    var lastSendPhone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hasLeftButton = false
        hasRightButton = false
        lp_title = "Login"
        
        setupUI()
    }
    
    func setupUI(){
        let scrollV = UIScrollView()
        scrollV.showsVerticalScrollIndicator = false
        contentV.addSubview(scrollV)
        scrollV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let imgV1 = UIImageView()
        imgV1.imgName("login_img1")
        let imgV2 = UIImageView()
        imgV2.imgName("login_img2")
        let imgV3 = UIImageView()
        imgV3.imgName("login_img4")
        let imgV4 = UIImageView()
        imgV4.imgName("login_img3")
        
        scrollV.addSubview(imgV1)
        scrollV.addSubview(imgV2)
        scrollV.addSubview(imgV3)
        scrollV.addSubview(imgV4)
        
        imgV1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScaleX(163), height: kScaleX(172)))
        }
        imgV2.snp.makeConstraints { make in
            make.top.equalTo(imgV1.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScaleX(311), height: kScaleX(72)))
        }
        
        
        //MARK: inputView
        let inputView = UIView.empty()
        inputView.borderColor = gray204
        inputView.borderWidth = 1.0
        inputView.corners = 2
        scrollV.addSubview(inputView)
        inputView.snp.makeConstraints { make in
            make.top.equalTo(imgV2.snp.bottom).offset(23)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScaleX(311), height: kScaleX(48)))
        }
        
        let phoneHeadLab = UILabel.new(text: "+63", textColor: black51, font: .font_Roboto_M(16),alignment: .center)
        inputView.addSubview(phoneHeadLab)
        
        let lineView = UIView.lineView(color: gray224)
        inputView.addSubview(lineView)
        
        inputView.addSubview(phoneTextfiled)
        
        phoneHeadLab.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
            make.right.equalTo(lineView.snp.left)
        }
        lineView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(52)
            make.size.equalTo(CGSize(width: 1, height: 16))
        }
        phoneTextfiled.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(lineView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        let tipsLab = UILabel.new(text: "Example phone number: 09123456789", textColor: gray102, font: .systemFont(ofSize: 12))
        scrollV.addSubview(tipsLab)
        tipsLab.snp.makeConstraints { make in
            make.top.equalTo(inputView.snp.bottom).offset(8)
            make.left.equalTo(inputView)
            make.height.equalTo(16)
        }
        
        scrollV.addSubview(loginBtn)
        scrollV.addSubview(checkBtn)
        scrollV.addSubview(agreementLabel)
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(tipsLab.snp.bottom).offset(16)
            make.height.equalTo(48)
            make.left.right.equalTo(inputView)
        }
        
        agreementLabel.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(18)
            make.height.equalTo(16)
        }
        checkBtn.snp.makeConstraints { make in
            make.centerY.equalTo(agreementLabel)
            make.right.equalTo(agreementLabel.snp.left).offset(-8)
            make.size.equalTo(CGSizeMake(20, 20))
        }
        
        imgV3.snp.makeConstraints { make in
            make.top.equalTo(agreementLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScaleX(311), height: kScaleX(89)))
        }
        imgV4.snp.makeConstraints { make in
            make.top.equalTo(imgV3.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: kScaleX(311), height: kScaleX(81)))
        }
        
        let totalH:CGFloat = 10+172+23+72+23+48+38+48+46+81+15+89+28
        scrollV.contentSize = CGSize(width: kWidth, height: kScaleX(totalH))
    }
    
    //MARK: UITextField
    lazy var phoneTextfiled:UITextField = {
        let phoneTextfiled = UITextField()
        phoneTextfiled.placeholder = "phone number"
        phoneTextfiled.textColor = black51
        phoneTextfiled.backgroundColor = .clear
        phoneTextfiled.font = .font_Roboto_M(16)
        phoneTextfiled.keyboardType = .numberPad
        phoneTextfiled.delegate = self
        phoneTextfiled.clearButtonMode = .always
        return phoneTextfiled
    }()
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let phoneStr = phoneTextfiled.text else{ return }
        loginBtn.isEnabled = phoneStr.count >= 8
        loginBtn.backgroundColor = phoneStr.count >= 8 ? mainColor38 : gray102
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let phoneStr = phoneTextfiled.text else{ return }
        loginBtn.isEnabled = phoneStr.count >= 8
        loginBtn.backgroundColor = phoneStr.count >= 8 ? mainColor38 : gray102
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currText = (textField.text ?? "") as NSString
        let newText = currText.replacingCharacters(in: range, with: string)
        return newText.count <= maxLength
    }
    
    lazy var loginBtn:UIButton = {
        let loginBtn = UIButton.textBtn(title: "Login", titleColor: .white, font: .font_Roboto_M(16), bgColor: gray102, corner: 2)
        loginBtn.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        loginBtn.isEnabled = false
        return loginBtn
    }()
    
    lazy var checkBtn:UIButton = {
        let checkBtn = UIButton.imageBtn(imgStr: "login_selected_no")
        checkBtn.imgName(imageName: "login_selected_yes",state: .selected)
        checkBtn.isSelected = true
        checkBtn.addTarget(self, action: #selector(checkClick), for: .touchUpInside)
        return checkBtn
    }()
    
    lazy var agreementLabel: UILabel = {
        let agreementTxt = "I agree to Privacy Agreement"
        let agreementLabel = UILabel.new(text: agreementTxt, textColor: gray153, font: .systemFont(ofSize: 12),alignment: .center)
        let attStr = NSMutableAttributedString(string: agreementTxt)
        let privacyRange = (attStr.string as NSString).range(of: "Privacy Agreement")
        attStr.addAttribute(.foregroundColor, value: mainColor38, range: privacyRange)
        agreementLabel.attributedText = attStr
        agreementLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickPrivacy))
        agreementLabel.addGestureRecognizer(tapGesture)
        return agreementLabel
    }()
    
    
    //MARK: function
    @objc func toLogin(){
        guard let phoneStr = phoneTextfiled.text, phoneStr.count >= 8 else{ return }
        if !checkBtn.isSelected{
            Route.toast("Please confirm the agreement")
            return
        }
        getCodeReq(phone: phoneStr)
    }
    
    @objc func checkClick(){
        checkBtn.isSelected = !checkBtn.isSelected
    }
    
    @objc func clickPrivacy(){
        let webV = LPBaseWebVC()
        webV.url = LP_Privacy
        preVC(vc: webV)
    }
    
    func getCodeReq(phone:String){
        if UserSession.countdownTime > 0,UserSession.lastPhone == phone{
            toCodeVC()
        }else{
            Request.send(api: .code(phone: phone),showLoading: true, showResult: true) { (result:LPLoginModel?) in
                UserSession.countdownTime = 0
                self.toCodeVC()
            } failure: { _ in
                
            }
        }
        

    }
    
    func toCodeVC(){
        guard let phoneStr = phoneTextfiled.text, phoneStr.count >= 8 else{ return }
        UserSession.lastPhone = phoneStr
        UserSession.stopCountDown()
        
        let vc = LPLoginCodeVC()
        vc.phoneStr = phoneStr
        self.preVC(vc: vc)
    }
    



}
