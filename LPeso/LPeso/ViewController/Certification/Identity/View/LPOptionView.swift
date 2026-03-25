//
//  LPOptionView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/13.
//

import UIKit

class LPOptionView: UIView {
    
    var clickBlock:() -> Void = {}
    
    private var titleTxt:String = ""

    required init(titleTxt: String = "") {
        self.titleTxt = titleTxt
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .clear
        self.corners = 2
        self.borderWidth = 1
        self.borderColor = gray224
        let tpas = UITapGestureRecognizer(target: self, action: #selector(viewTap))
        self.addGestureRecognizer(tpas)
        self.isUserInteractionEnabled = true
        
        addSubview(stateBtn)
        addSubview(optionLab)
        stateBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        optionLab.snp.makeConstraints { make in
            make.left.equalTo(stateBtn.snp.right).offset(8)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
        }
        
    }
    
    lazy var optionLab:UILabel = {
        let optionLab = UILabel.new(text: titleTxt, textColor: gray153, font: .systemFont(ofSize: 14),isAjust: true)
        return optionLab
    }()
    
    lazy var stateBtn:UIButton = {
        let stateBtn = UIButton.imageBtn(imgStr: "base_select_off")
        stateBtn.imgName(imageName: "base_select_on", state: .selected)
        stateBtn.addTarget(self, action: #selector(viewTap), for: .touchUpInside)
        return stateBtn
    }()
    
    @objc private func viewTap() {
        if !stateBtn.isSelected{
            stateBtn.isSelected = true
            clickBlock()
        }
        
    }
    
    public func setOptionTxt(str:String){
        optionLab.text = str
    }
    
    public func setState(_ isSelect:Bool){
        stateBtn.isSelected = isSelect
    }

}
