//
//  LPAuthGroupCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/12.
//

import SnapKit

class LPAuthGroupCell: UITableViewCell, UITextFieldDelegate {
    
    var clickBlock:() -> Void = {}
    var optionBlock:(_ tags:Int) -> Void = {_  in}
    var endEditBlcok:(_ txt:String) -> Void = {_  in}
    
    let leftOptionView = LPOptionView()
    let rightOptionView = LPOptionView()
    
    private var itemModel: LPAuthItemModel?
    
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
        contentView.addSubview(titleLab)
        contentView.addSubview(bgView)
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(20)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        bgView.addSubview(inputfiled)
        bgView.addSubview(selectBtn)
        inputfiled.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(selectBtn.snp.left).offset(-10)
        }
        selectBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        //option
        leftOptionView.isHidden = true
        rightOptionView.isHidden = true
        contentView.addSubview(leftOptionView)
        contentView.addSubview(rightOptionView)
        leftOptionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(titleLab.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalTo(rightOptionView.snp.left).offset(-15)
            make.width.equalTo(rightOptionView.snp.width)
        }
        rightOptionView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.bottom.equalTo(leftOptionView)
            make.left.equalTo(leftOptionView.snp.right).offset(15)
            make.width.equalTo(leftOptionView.snp.width)
        }
        leftOptionView.clickBlock = {
            self.optionBlock(0)
        }
        rightOptionView.clickBlock = {
            self.optionBlock(1)
        }
    }
    
    lazy var titleLab:UILabel = {
        let titleLab = UILabel.new(text: "", textColor: gray102, font: .font_PingFangSC_R(14))
        return titleLab
    }()
    
    lazy var bgView:UIView = {
        let bgView = UIView.empty()
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
        return inputfiled
    }()
    
    lazy var selectBtn:UIButton = {
        let selectBtn = UIButton.imageBtn(imgStr: "au_cell_click")
        selectBtn.addTarget(self, action: #selector(selectClick), for: .touchUpInside)
        selectBtn.isHidden = true
        return selectBtn
    }()
    
    @objc func selectClick(){
        clickBlock()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !isBlank(textField.text){
            endEditBlcok(textField.text!)
        }
    }
    
   
    func configModel(itemModel:LPAuthItemModel){
        self.itemModel = itemModel
        
        bgView.isHidden = itemModel.PTUCockadei == .option
//        bgView.isUserInteractionEnabled = (itemModel.PTUCockadei == .enums || itemModel.PTUCockadei == .day)
        
        selectBtn.isHidden = (itemModel.PTUCockadei == .txt || itemModel.PTUCockadei == .option)
         
        inputfiled.isEnabled = itemModel.PTUCockadei == .txt
        inputfiled.isHidden = itemModel.PTUCockadei == .option
        inputfiled.placeholder = itemModel.PTUAntehalli ?? ""
        inputfiled.keyboardType = itemModel.PTUPeltryi?.int==1 ? .numberPad : .default
        
        leftOptionView.isHidden = itemModel.PTUCockadei != .option
        rightOptionView.isHidden = itemModel.PTUCockadei != .option
        
        
        titleLab.text = itemModel.PTUTilefishi ?? itemModel.PTUAntehalli ?? ""
        
        if itemModel.PTUCockadei == .enums{
            if let value = itemModel.PTUMesenchymatousi?.string,!isBlank(value){
                if let modelList = itemModel.PTUPosi{
                    for selectModel in modelList{
                        if value == selectModel.type?.string{
                            inputfiled.text = selectModel.name ?? ""
                        }
                    }
                    
                }else{
                    inputfiled.text = ""
                }
            }
            
        }else if itemModel.PTUCockadei == .option{
            if let modelList = itemModel.PTUPosi{
                for (index,items) in modelList.enumerated() {
                    if index == 0{
                        leftOptionView.setOptionTxt(str: items.name ?? "")
                    }else if index == 1{
                        rightOptionView.setOptionTxt(str: items.name ?? "")
                    }
                }
                
                if let value = itemModel.PTUMesenchymatousi?.string,!isBlank(value){
                    if let index = findIndex(for: value, in: modelList){
                        leftOptionView.setState(index == 0)
                        rightOptionView.setState(index == 1)
                    }else{
                        leftOptionView.setState(false)
                        rightOptionView.setState(false)
                    }
                }
                
            }
            
        }else{
            inputfiled.text = itemModel.PTUMesenchymatousi?.string ?? ""
        }
        
    }
    
    func findIndex(for value: String, in list: [LPAuthSelectModel]) -> Int? {
        for (index, model) in list.enumerated() where index <= 1 {
            if model.type?.string == value {
                return index
            }
        }
        return nil
    }
    
    
}
