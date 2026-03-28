//
//  LPAuthBankView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/13.
//

import UIKit

class LPAuthBankView: UIView ,UITextFieldDelegate {
    
    private var bankModel:LPAuthBankGroupModel?
    
    public var channelNo:String = ""
    public var channelStr:String = ""
    public var accountStr:String = ""

    required init(walletModel: LPAuthBankGroupModel?=nil) {
        self.bankModel = walletModel
        super.init(frame:.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .clear
        
        let titleLab1 = UILabel.new(text: "Select Bank", textColor: gray128, font: .font_PingFangSC_R(14))
        let titleLab2 = UILabel.new(text: "Bank", textColor: gray128, font: .font_PingFangSC_R(12))
        let titleLab3 = UILabel.new(text: "Bank Account", textColor: gray128, font: .font_PingFangSC_R(12))
        let titleLab4 = UILabel.new(text: "Please confirm the account belongs to yourself and be correct, it will be used as a receipt account to receice the funds.", textColor: gray153, font: .font_PingFangSC_R(11),lines: 0)
        
        let inputV1ImgV = UIImageView.nameWith("au_cell_click")
        
        addSubview(titleLab1)
        addSubview(titleLab2)
        addSubview(titleLab3)
        addSubview(titleLab4)
        addSubview(inputV1)
        inputV1.addSubview(bankFiled)
        inputV1.addSubview(inputV1ImgV)
        addSubview(inputV2)
        inputV2.addSubview(accountFiled)
        
        titleLab1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(18)
            make.top.equalToSuperview().offset(19)
            make.height.equalTo(20)
        }
        titleLab2.snp.makeConstraints { make in
            make.top.equalTo(titleLab1.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(20)
        }
        
        inputV1.snp.makeConstraints { make in
            make.top.equalTo(titleLab2.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(14)
            make.height.equalTo(48)
        }
        bankFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalTo(inputV1ImgV.snp.left).offset(-10)
        }
        inputV1ImgV.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        titleLab3.snp.makeConstraints { make in
            make.top.equalTo(inputV1.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(20)
        }
        
        inputV2.snp.makeConstraints { make in
            make.top.equalTo(titleLab3.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(14)
            make.height.equalTo(48)
        }
        accountFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        
        titleLab4.snp.makeConstraints { make in
            make.top.equalTo(inputV2.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(14)
        }
        
    }
    
    
    //MARK: lazy
    private lazy var inputV1:UIView = {
        let inputV = UIView.lineView()
        inputV.corners = 4
        inputV.borderColor = gray153
        inputV.borderWidth = 1
        let tpas = UITapGestureRecognizer(target: self, action: #selector(bankClick))
        inputV.isUserInteractionEnabled = true
        inputV.addGestureRecognizer(tpas)
        return inputV
    }()
    
    private lazy var bankFiled:UITextField = {
        let bankFiled = UITextField()
        bankFiled.placeholder = "Please select your bank"
        bankFiled.textColor = black51
        bankFiled.backgroundColor = .clear
        bankFiled.font = .font_PingFangSC_R(15)
        bankFiled.isEnabled = false
        return bankFiled
    }()
    
    private lazy var inputV2:UIView = {
        let inputV = UIView.lineView()
        inputV.corners = 4
        inputV.borderColor = gray153
        inputV.borderWidth = 1
        return inputV
    }()
    
    private lazy var accountFiled:UITextField = {
        let accountFiled = UITextField()
        accountFiled.placeholder = "Please enter your bank account number"
        accountFiled.textColor = black51
        accountFiled.backgroundColor = .clear
        accountFiled.font = .font_PingFangSC_R(15)
//        accountFiled.keyboardType = .numberPad
        accountFiled.delegate = self
        return accountFiled
    }()
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        accountStr = textField.text ?? ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == accountFiled{
            let maxLength = 20
            let currText = (textField.text ?? "") as NSString
            let newText = currText.replacingCharacters(in: range, with: string)
            return newText.count <= maxLength
        }
        return true
    }
    
    //MARK: bankClick
    @objc private func bankClick() {
        endEditing(true)
        guard let list = self.bankModel?.PTURadiogoniometryi else { return }
        var itemList:[LPAuthSelectModel] = []
        for item in list{
            if let name = item.PTUCarmarthenshirei,let type = item.PTUProfanei{
                itemList.append(LPAuthSelectModel(name: name, type: type))
            }
            
        }
        
        guard itemList.count == list.count else { return }
        Route.showAuthAlert(titleTxt: "Select your bank", itemList: itemList, valueType: channelNo) { type in
            self.bankResultWith(type: type)
        }
        
    }
    
    func bankResultWith(type:String){
        channelNo = type
        if let list = bankModel?.PTURadiogoniometryi{
            let name = list
                .first(where: { $0.PTUProfanei?.string == type })?
                .PTUCarmarthenshirei
            if !isBlank(name){
                bankFiled.text = name
                channelStr = name!
            }
            
        }
        channelNo = type
    }
    
    
    //MARK: configModel
    public func configModel(model:LPAuthBankGroupModel){
        bankModel = model
        channelNo = ""
        channelStr = ""
        accountStr = ""
        bankFiled.text = ""
        if let filed = model.PTUMechanotheropyi{
            
            channelNo = filed.PTUPenitentiaryi?.string ?? ""
            accountStr = filed.PTUSpringharei ?? ""
            
            if !isBlank(channelNo),let list = model.PTURadiogoniometryi{
                let name = list
                    .first(where: { $0.PTUProfanei?.string == channelNo })?
                    .PTUCarmarthenshirei
                if !isBlank(name){
                    bankFiled.text = name
                    channelStr = name!
                }
            }
        }
        
        accountFiled.text = accountStr
           
    }
    
    

}


