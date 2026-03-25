//
//  LPAuthWalletView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/13.
//

import UIKit

class LPAuthWalletView: UIView, UITextFieldDelegate {
    
    var walletModel:LPAuthBankGroupModel?
    var currentSelect:Int = 0
    
    public var channelNo:String = ""
    public var channelStr:String = ""
    public var accountStr:String = ""

    required init(walletModel: LPAuthBankGroupModel?=nil) {
        self.walletModel = walletModel
        super.init(frame:.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .clear
        
        let titleLab1 = UILabel.new(text: "Select your recipient E-wallet", textColor: gray128, font: .font_PingFangSC_R(12))
        let lineView = UIView.lineView(color: gray195)
        let titleLab2 = UILabel.new(text: "E-wallet Account", textColor: gray128, font: .font_PingFangSC_R(12))
        let titleLab3 = UILabel.new(text: "Please confirm the account belongs to yourself and be correct, it will be used as a receipt account to receice the funds.", textColor: gray128, font: .font_PingFangSC_R(11),lines: 0)
        addSubview(titleLab1)
        addSubview(lineView)
        addSubview(titleLab2)
        addSubview(titleLab3)
        addSubview(walletTableV)
        addSubview(inputV)
        inputV.addSubview(accountFiled)
        
        titleLab1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(18)
            make.top.equalToSuperview().offset(22)
            make.height.equalTo(20)
        }
        walletTableV.snp.makeConstraints { make in
            make.top.equalTo(titleLab1.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(168)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(walletTableV.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
        }
        titleLab2.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(20)
        }
        inputV.snp.makeConstraints { make in
            make.top.equalTo(titleLab2.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(14)
            make.height.equalTo(48)
        }
        accountFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        titleLab3.snp.makeConstraints { make in
            make.top.equalTo(inputV.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(14)
        }
        
    }
    
    
    //MARK: lazy
    private lazy var walletTableV: UITableView = {
        let walletTableV = UITableView(frame: .zero, style: .plain)
        walletTableV.backgroundColor = .white
        walletTableV.separatorStyle = .none
        walletTableV.showsVerticalScrollIndicator = false
        walletTableV.showsHorizontalScrollIndicator = false
        walletTableV.delegate = self
        walletTableV.dataSource = self
        return walletTableV
    }()
    
    private lazy var inputV:UIView = {
        let inputV = UIView.lineView()
        inputV.corners = 4
        inputV.borderColor = gray153
        inputV.borderWidth = 1
        return inputV
    }()
    
    private lazy var accountFiled:LPTxtField = {
        let accountFiled = LPTxtField()
        accountFiled.text = ""
        accountFiled.placeholder = "Please enter your E-wallet account"
        accountFiled.textColor = black51
        accountFiled.backgroundColor = .clear
        accountFiled.font = .font_PingFangSC_R(15)
        accountFiled.keyboardType = .numberPad
        accountFiled.delegate = self
        
        return accountFiled
    }()
    
    func findIndex(for value: String, in list: [LPAuthBankItemModel]) -> Int {
        for (index, model) in list.enumerated() {
            if model.PTUProfanei?.string == value {
                return min(index, 1)
            }
        }
        return 0
    }
    
    
    //MARK: configModel
    public func configModel(model:LPAuthBankGroupModel){
        walletModel = model
        currentSelect = 0
        
        accountStr = UserSession.getWalletPhone()
        channelNo = model.PTURadiogoniometryi?.first?.PTUProfanei?.string ?? ""
        
        if let filed = model.PTUMechanotheropyi{
            
            channelNo = filed.PTUPenitentiaryi?.string ?? model.PTURadiogoniometryi?.first?.PTUProfanei?.string ?? ""
            if !isBlank(channelNo),let list = model.PTURadiogoniometryi{
                currentSelect = findIndex(for: channelNo, in: list)
            }

            if let account = filed.PTUSpringharei,!isBlank(account){
                accountStr = account
            }

        }
        channelStr = model.PTURadiogoniometryi?[currentSelect].PTUCarmarthenshirei ?? ""
        
        accountFiled.text = accountStr
        walletTableV.reloadData()
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        accountStr = textField.text ?? ""
    }

}


//MARK: UITableViewDelegate,UITableViewDataSource
extension LPAuthWalletView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletModel?.PTURadiogoniometryi?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = walletModel?.PTURadiogoniometryi?[indexPath.row] else {
            return UITableViewCell()
        }
        if let cell = Bundle.main.loadNibNamed("LPAuthWalletSelectCell", owner: self, options: nil)?.first as? LPAuthWalletSelectCell {
            cell.configModel(model: model)
            cell.selectBtn.isSelected = currentSelect == indexPath.row
            cell.clickBlock = {
                if self.currentSelect != indexPath.row{
                    self.channelNo = model.PTUProfanei?.string ?? ""
                    self.channelStr = model.PTUCarmarthenshirei ?? ""
                }
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentSelect != indexPath.row{
            currentSelect = indexPath.row
            channelNo = walletModel?.PTURadiogoniometryi?[indexPath.row].PTUProfanei?.string ?? ""
            channelStr = walletModel?.PTURadiogoniometryi?[indexPath.row].PTUCarmarthenshirei ?? ""
            tableView.reloadData()
        }
    }
    
}
