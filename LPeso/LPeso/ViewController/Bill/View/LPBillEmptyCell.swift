//
//  LPBillEmptyCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/19.
//

import UIKit

class LPBillEmptyCell: UITableViewCell {
    
    var emptyView = UIView.empty()

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
        contentView.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let emptyImg = UIImageView.nameWith("bill_empty")
        
        let emptyTipLab1 = UILabel.new(text: "No Data", textColor: gray153, font: .systemFont(ofSize: 14),alignment: .center)
        
        let tip2Str = "Get your money within 3 minutes!"
        let emptyTipLab2 = UILabel.new(text: tip2Str, textColor: gray102, font: .systemFont(ofSize: 16),alignment: .center)
        if let range = tip2Str.range(of: "3 minutes"){
            let nsRange = NSRange(range, in: tip2Str)
            let attributedString = NSMutableAttributedString(string: tip2Str)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: mainColor38, range: nsRange)
            emptyTipLab2.attributedText = attributedString
        }
        
        let applyBtn = UIButton.textBtn(title: "Apply Now", titleColor: .white, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
        applyBtn.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        
        let agreementLabel = UILabel.new(text: "Please read our Privacy Agreement", textColor: gray102, font: .systemFont(ofSize: 12),alignment: .center)
        let attStr = NSMutableAttributedString(string: "Please read our Privacy Agreement")
        let privacyRange = (attStr.string as NSString).range(of: "Privacy Agreement")
        attStr.addAttribute(.foregroundColor, value: mainColor38, range: privacyRange)
        agreementLabel.attributedText = attStr
        agreementLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickPrivacy))
        agreementLabel.addGestureRecognizer(tapGesture)
        
        emptyView.addSubview(emptyImg)
        emptyView.addSubview(emptyTipLab1)
        emptyView.addSubview(emptyTipLab2)
        emptyView.addSubview(applyBtn)
        emptyView.addSubview(agreementLabel)
        
        emptyImg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 140, height: 140))
        }
        emptyTipLab1.snp.makeConstraints { make in
            make.top.equalTo(emptyImg.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
        }
        emptyTipLab2.snp.makeConstraints { make in
            make.top.equalTo(emptyTipLab1.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
        }
        applyBtn.snp.makeConstraints { make in
            make.top.equalTo(emptyTipLab2.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 149, height: 40))
        }
        agreementLabel.snp.makeConstraints { make in
            make.top.equalTo(applyBtn.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
        }
        
    }
    
    @objc func backToHome(){
        Route.backToHome()
    }
    
    @objc func clickPrivacy(){
        Route.openUrl(urlStr: LP_Privacy)
    }

}
