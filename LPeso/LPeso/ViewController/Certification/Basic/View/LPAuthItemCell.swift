//
//  LPAuthItemCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/9.
//

import UIKit
import SnapKit

class LPAuthItemCell: UITableViewCell, UITextFieldDelegate {
    
    var clickBlock:() -> Void = {}
    var endEditBlcok:(_ txt:String) -> Void = {_  in}
    
    private var itemModel: LPAuthItemModel?
    private var emailView: UIView?
    private weak var tableView: UITableView?
    private var offseted:CGFloat = 0
    private var emailSiffix: [String] = ["gmail.com", "icloud.com", "yahoo.com", "outlook.com"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        bgView.addSubview(inputfiled)
        bgView.addSubview(selectBtn)
        inputfiled.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(9)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-50)
        }
        selectBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
    }
    
    lazy var bgView:UIView = {
        let bgView = UIView.lineView()
        bgView.corners = 2
        bgView.borderWidth = 1
        bgView.borderColor = gray224
        let tpas = UITapGestureRecognizer(target: self, action: #selector(selectClick))
        bgView.addGestureRecognizer(tpas)
        bgView.isUserInteractionEnabled = true
        return bgView
    }()
    
    lazy var inputfiled:LPTxtField = {
        let inputfiled = LPTxtField()
        inputfiled.textColor = black51
        inputfiled.backgroundColor = .clear
        inputfiled.font = .font_PingFangSC_R(14)
        inputfiled.keyboardType = .numberPad
        inputfiled.delegate = self
        inputfiled.isEnabled = false
        inputfiled.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        return inputfiled
    }()
    
    lazy var selectBtn:UIButton = {
        let selectBtn = UIButton.imageBtn(imgStr: "au_cell_click")
        selectBtn.addTarget(self, action: #selector(selectClick), for: .touchUpInside)
        return selectBtn
    }()
    
    @objc func selectClick(){
        clickBlock()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        offseted = 0
        
        endEditBlcok(textField.text ?? "")
        hideEmailAlert()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let type = itemModel?.PTUTilefishi,type.equalsIgnoreCase("Email"){
            showEmailAlert(txt: textField.text)
        }
        
    }
    
    func showEmailAlert(txt:String?){
        guard let tableV = tableView,let inputTxt = txt,!isBlank(txt) else { return }
        var tipList: [String] = []
        var resultTxt = inputTxt
        
        if let atRange = inputTxt.range(of: "@"){
            let enteredDomain = String(inputTxt[atRange.upperBound...].split(separator: "@").first ?? "")
            resultTxt = String(inputTxt[..<atRange.lowerBound])
            
            tipList = emailSiffix.filter { $0.hasPrefix(enteredDomain) }.map { resultTxt + "@" + $0 }
        }else {
            tipList = emailSiffix.map { resultTxt + "@" + $0 }
        }
        
        if emailView == nil{
            emailView = UIView()
            emailView?.backgroundColor = mainColor241
            emailView?.layer.cornerRadius = 2
            tableV.addSubview(emailView!)
        }else {
            emailView?.removeAllSubviews()
        }
        
        let emailBtnH:CGFloat = 44
        if let emailView = emailView {
            for (index, sufTxt) in tipList.enumerated() {
                let btn = UIButton.textBtn(title: sufTxt, titleColor: mainColor38, font: .font_PingFangSC_R(16))
                btn.contentHorizontalAlignment = .left
                btn.addTarget(self, action: #selector(emailAlertClcik(_:)), for: .touchUpInside)
                btn.frame = CGRect(x: 18, y: CGFloat(index) * emailBtnH, width: inputfiled.frame.width-32, height: emailBtnH)
                emailView.addSubview(btn)
            }
            
            let txtInTableV = inputfiled.convert(inputfiled.bounds, to: tableV)
            emailView.frame = CGRect(x: 16,y: txtInTableV.origin.y + inputfiled.frame.height+2,width: kWidth-32,height: CGFloat(tipList.count) * emailBtnH)
            
        }
        
        let fixedHeight: CGFloat = CGFloat(tipList.count) * emailBtnH
        let contentOffset = tableV.contentOffset.y + fixedHeight-offseted
        offseted = fixedHeight
        tableV.setContentOffset(CGPoint(x: 0, y: max(contentOffset, 0)), animated: true)
        
    }
    
    @objc func emailAlertClcik(_ sender: UIButton){
        guard let emailStr = sender.title(for: .normal) else { return }
        inputfiled.text = emailStr
        inputfiled.resignFirstResponder()
    }
    
    func hideEmailAlert(){
        emailView?.removeAllSubviews()
        emailView?.removeFromSuperview()
        emailView = nil
    }
    
    func configModel(itemModel:LPAuthItemModel,tabview:UITableView){
        self.tableView = tabview
        self.itemModel = itemModel
        
        inputfiled.isEnabled = itemModel.PTUCockadei == .txt
        selectBtn.isHidden = itemModel.PTUCockadei == .txt
         
        if let str = itemModel.PTUTilefishi, str.equalsIgnoreCase("Email"){
            inputfiled.placeholder = itemModel.PTUAntehalli ?? ""
        }else{
            inputfiled.placeholder = itemModel.PTUTilefishi ?? ""
        }
        inputfiled.keyboardType = itemModel.PTUPeltryi?.int==1 ? .numberPad : .default
        
        if let value = itemModel.PTUMesenchymatousi?.string,!isBlank(value){
            if itemModel.PTUCockadei == .enums{
                if let modelList = itemModel.PTUPosi{
                    for selectModel in modelList{
                        if value == selectModel.type?.string{
                            inputfiled.text = selectModel.name ?? ""
                        }
                    }
                    
                }else{
                    inputfiled.text = ""
                }
                
            }else{
                inputfiled.text = value
            }
            
        }else{
            inputfiled.text = itemModel.PTUMesenchymatousi?.string ?? ""
        }
        
        
    }
    
    
}
