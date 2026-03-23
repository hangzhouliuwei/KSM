//
//  LPHomeLargeCardView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/4.
//

import UIKit

class LPHomeLargeCardView: UIView {
    
    var cardClick:() -> Void = {}
    
    var cardModel:LPHomeItemModel?
    
    required init(cardModel:LPHomeItemModel?=nil) {
        self.cardModel = cardModel
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: 260))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-9)
        }
        
        let lineView = UIView.lineView(color: gray224)
        
        bgView.addSubview(lineView)
        bgView.addSubview(iconImg)
        bgView.addSubview(titleLab)
        bgView.addSubview(amountTitle)
        bgView.addSubview(amountLab)
        bgView.addSubview(dateLab)
        bgView.addSubview(rateLab)
        bgView.addSubview(applyBtn)
        
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.size.equalTo(CGSize(width: 1, height: 36))
            make.centerX.equalToSuperview()
        }
        iconImg.snp.makeConstraints { make in
            make.centerY.equalTo(lineView)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 38, height: 38))
        }
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImg)
            make.left.equalTo(iconImg.snp.right).offset(4)
            make.right.equalTo(lineView.snp.left).offset(-4)
        }
        amountTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(lineView.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        amountLab.snp.makeConstraints { make in
            make.top.equalTo(amountTitle.snp.bottom).offset(2)
            make.left.equalTo(lineView.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(38)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        dateLab.snp.makeConstraints { make in
            make.bottom.equalTo(applyBtn.snp.top).offset(-20)
            make.left.equalToSuperview().offset(24)
            make.right.equalTo(rateLab.snp.left).offset(-16)
            make.width.equalTo(rateLab.snp.width)
            make.height.equalTo(40)
        }
        rateLab.snp.makeConstraints { make in
            make.bottom.equalTo(dateLab)
            make.right.equalToSuperview().offset(-24)
            make.left.equalTo(dateLab.snp.right).offset(16)
            make.width.equalTo(dateLab.snp.width)
            make.height.equalTo(40)
        }
        if let cardModel = cardModel{
            self.setCardWithModel(model: cardModel)
        }
    }
    
    lazy var bgView:UIView = {
        let bgView = UIView.lineView()
        bgView.corners = 2
        bgView.borderColor = gray224
        bgView.borderWidth = 1
        return bgView
    }()
    
    lazy var iconImg:UIImageView = {
        let iconImg = UIImageView()
        iconImg.imgName("LPeso_logo")
        iconImg.corners = 19
        iconImg.addShadow()
        return iconImg
    }()
    
    lazy var titleLab:UILabel = {
        let titleLab = UILabel.new(text: "LPeso", textColor: black51, font: .font_HelveticaNeue_BI(25),isAjust: true)
        
        return titleLab
    }()
    
    lazy var amountTitle:UILabel = {
        let amountTitle = UILabel.new(text: "Loan Amount (₱)", textColor: gray102, font: .systemFont(ofSize: 14),alignment: .center)
        
        return amountTitle
    }()
    
    lazy var amountLab:UILabel = {
        let amountLab = UILabel.new(text: "", textColor: black51, font: .font_Helvetica_B(32),alignment: .center,isAjust: true)
        
        return amountLab
    }()
    
    lazy var dateLab:UILabel = { //91 Days
        let dateLab = UILabel.new(text: "", textColor: mainColor38, font: .font_Roboto_M(14),alignment: .center,isAjust: true)
        dateLab.backgroundColor = mainColor241
        dateLab.corners = 2
        return dateLab
    }()
    
    lazy var rateLab:UILabel = { //0.05% interest/day
        let rateLab = UILabel.new(text: "", textColor: mainColor38, font: .font_Roboto_M(14),alignment: .center,isAjust: true)
        rateLab.backgroundColor = mainColor241
        rateLab.corners = 2
        return rateLab
    }()
    
    lazy var applyBtn:UIButton = {
        let applyBtn = UIButton.textBtn(title: "", titleColor: .white, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
        applyBtn.addTarget(self, action: #selector(applyClick), for: .touchUpInside)
        return applyBtn
    }()

    @objc func applyClick(){
        applyBtn.isUserInteractionEnabled = false
        cardClick()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            guard let self = self else { return }
            self.applyBtn.isUserInteractionEnabled = true
        }
    }
    
    public func setCardWithModel(model:LPHomeItemModel){
        iconImg.setImage(urlString: model.PTUTalofibulari)
        titleLab.text = model.PTUTrimonthlyi ?? ""
        
        amountTitle.text = model.PTUMeconici ?? ""
        amountLab.text = model.PTUTaeniai?.string
        
        dateLab.text = model.PTUCrenationi?.string
        rateLab.text = model.PTUReedlingi?.string
        
        applyBtn.setTitle(model.PTUTirosi ?? "", for: .normal)
        if let color = model.PTUJuglandaceousi{
            applyBtn.backgroundColor = UIColor(hex: color)
        }
        
    }
    
}
