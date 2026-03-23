//
//  LPAuthGroupHeadView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/9.
//

import UIKit

class LPAuthGroupHeadView: UIView {
    
    var moreBlock:(_ isFlod:Bool) -> Void = {_  in}
    
    var headModel:LPAuthGoupModel

    required init(headModel: LPAuthGoupModel) {
        self.headModel = headModel
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: 32))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.headModel = LPAuthGoupModel()
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        self.backgroundColor = .clear
        
        addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview().offset(4)
        }
        if let subTitleTxt = headModel.sub_title,!isBlank(subTitleTxt){
            subTitleLab.text = subTitleTxt
            addSubview(subTitleLab)
            subTitleLab.snp.makeConstraints { make in
                make.left.equalTo(titleLab.snp.right).offset(2)
                make.centerY.equalTo(titleLab)
                make.right.equalToSuperview().offset(-50)
            }
        }
        if let hasMore = headModel.more?.bool,hasMore{
            moreTxtBtn.isSelected = headModel.isFold ?? false
            moreImgBtn.isSelected = headModel.isFold ?? false
            addSubview(moreTxtBtn)
            addSubview(moreImgBtn)
            moreImgBtn.snp.makeConstraints { make in
                make.centerY.equalTo(titleLab)
                make.right.equalToSuperview().offset(-20)
                make.size.equalTo(CGSize(width: 16, height: 16))
            }
            moreTxtBtn.snp.makeConstraints { make in
                make.centerY.equalTo(moreImgBtn)
                make.right.equalTo(moreImgBtn.snp.left).offset(-5)
                make.size.equalTo(CGSize(width: 24, height: 14))
            }
            
        }
        
    }
    
    lazy var titleLab:UILabel = {
        let titleLab = UILabel.new(text: "", textColor: black51, font: .font_PingFangSC_M(12))
        titleLab.setContentHuggingPriority(.required, for: .horizontal)
        titleLab.setContentCompressionResistancePriority(.required, for: .horizontal)
        if let titleTxt = headModel.PTUTilefishi{
            let txt = titleTxt+"*"
            let attrStr = NSMutableAttributedString(string:txt, attributes:nil)
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.red, range:NSRange(location:txt.count-1, length:1))
            titleLab.attributedText = attrStr
        }
        
        return titleLab
    }()
    
    lazy var subTitleLab:UILabel = {
        let subTitleLab = UILabel.new(text: "", textColor: gray153, font: .font_PingFangSC_R(10),isAjust: true)
        return subTitleLab
    }()
    
    lazy var moreTxtBtn:UIButton = {
        let moreTxtBtn = UIButton.textBtn(title: "More", titleColor: mainColor38, font: .font_PingFangSC_R(10))
        moreTxtBtn.setTitle("Hide", for: .selected)
        moreTxtBtn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        return moreTxtBtn
    }()
    
    lazy var moreImgBtn:UIButton = {
        let moreImgBtn = UIButton.imageBtn(imgStr: "au_more_close")
        moreImgBtn.imgName(imageName: "au_more_open",state: .selected)
        moreImgBtn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        return moreImgBtn
    }()
    
    @objc func moreClick(){
        moreBlock(moreTxtBtn.isSelected)
        
    }
    
}
