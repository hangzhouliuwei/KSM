//
//  LPHomeFootView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/4.
//

import UIKit
import SnapKit

class LPHomeFootView: UIView {
    
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: 162))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        let imgV = UIImageView()
        imgV.imgName("home_img2")
        addSubview(imgV)
        addSubview(agreementLabel)
        
        imgV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(9)
            make.size.equalTo(CGSize(width: kScaleX(343), height: kScaleX(80)))
        }
        agreementLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(14)
        }
        
    }
    
    lazy var agreementLabel: UILabel = {
        let agreementLabel = UILabel.new(text: "Please read our Privacy Agreement", textColor: gray102, font: .systemFont(ofSize: 12),alignment: .center)
        let attStr = NSMutableAttributedString(string: "Please read our Privacy Agreement")
        let privacyRange = (attStr.string as NSString).range(of: "Privacy Agreement")
        attStr.addAttribute(.foregroundColor, value: mainColor38, range: privacyRange)
        agreementLabel.attributedText = attStr
        agreementLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickPrivacy))
        agreementLabel.addGestureRecognizer(tapGesture)
        return agreementLabel
    }()
    
    @objc func clickPrivacy(){
        Route.openUrl(urlStr: LP_Privacy)
    }

}
