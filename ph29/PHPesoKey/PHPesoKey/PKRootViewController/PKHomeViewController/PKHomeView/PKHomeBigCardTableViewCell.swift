//
//  PKHomeBigCardTableViewCell.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/13.
//

import UIKit

class PKHomeBigCardTableViewCell: UITableViewCell {
    var homeBigCardItemModel:JSON = JSON()
    var homeBigCardnextClickBlock: PKStingBlock?
    var homeBigCardnextAgreementBlock: PKStingBlock?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        certPKHomeBigCardTableViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pkHomeBigCardTableViewCellapplyBtnClick(){
        
        homeBigCardnextClickBlock?(self.homeBigCardItemModel["PSAGszTConverselyEKiKyQy"].stringValue)
            
    }
    
    @objc func pkHomeBigCardTableViewCellopenPrivacy(){
        homeBigCardnextAgreementBlock?(WebUpper + "/#/privac" + "yagreement")
    }
    
    func certPKHomeBigCardTableViewCellUI(){
       
        let pkhomeBigCardBackImageView = UIImageView()
        pkhomeBigCardBackImageView.image = UIImage(named: "pk_home_bigCardBack")
        pkhomeBigCardBackImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pkHomeBigCardTableViewCellapplyBtnClick))
        pkhomeBigCardBackImageView.addGestureRecognizer(tapGesture)
        contentView.addSubview(pkhomeBigCardBackImageView)
        pkhomeBigCardBackImageView.snp.makeConstraints { make in
            make.top.equalTo(PK_NaviH)
            make.left.right.equalToSuperview()
            make.height.equalTo(384)
        }
        
        pkhomeBigCardBackImageView.addSubview(AUoptXoCampaignSCyMXuZLabel)
        AUoptXoCampaignSCyMXuZLabel.snp.makeConstraints { make in
            make.top.equalTo(86)
            make.left.equalTo(44)
            make.height.equalTo(16)
        }
        
        pkhomeBigCardBackImageView.addSubview(ZQuKkrnRepudiationYxaTMoZLabel)
        ZQuKkrnRepudiationYxaTMoZLabel.snp.makeConstraints { make in
            make.centerX.equalTo(AUoptXoCampaignSCyMXuZLabel.snp.centerX)
            make.top.equalTo(AUoptXoCampaignSCyMXuZLabel.snp.bottom).offset(4)
            make.height.equalTo(40)
        }
        
        let  pkhomeBigCardTipImageView = UIImageView()
        pkhomeBigCardTipImageView.image = UIImage(named: "pk_home_card3")
        pkhomeBigCardBackImageView.addSubview(pkhomeBigCardTipImageView)
        pkhomeBigCardTipImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-44)
            make.top.equalToSuperview().offset(68)
            make.size.equalTo(CGSize(width: 83, height: 92))
        }
        
        let pkHomeBigCardpayImageView = UIImageView()
        pkHomeBigCardpayImageView.image = UIImage(named: "pk_home_pay")
        pkhomeBigCardBackImageView.addSubview(pkHomeBigCardpayImageView)
        pkHomeBigCardpayImageView.snp.makeConstraints { make in
            make.centerX.equalTo(ZQuKkrnRepudiationYxaTMoZLabel.snp.centerX)
            make.top.equalTo(ZQuKkrnRepudiationYxaTMoZLabel.snp.bottom).offset(44)
            make.width.height.equalTo(28)
        }
        
        pkhomeBigCardBackImageView.addSubview(ROARufGHylicismCFYjaKaLabel)
        ROARufGHylicismCFYjaKaLabel.snp.makeConstraints { make in
            make.centerX.equalTo(pkHomeBigCardpayImageView.snp.centerX)
            make.top.equalTo(pkHomeBigCardpayImageView.snp.bottom)
            make.height.equalTo(22)
        }
        
        pkhomeBigCardBackImageView.addSubview(fwpfwKUDefalcationPqqmMOyLabel)
        fwpfwKUDefalcationPqqmMOyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(ROARufGHylicismCFYjaKaLabel.snp.centerX)
            make.top.equalTo(ROARufGHylicismCFYjaKaLabel.snp.bottom)
        }
        
        
        let  pkhomeBigCardTimeimageView =  UIImageView()
        pkhomeBigCardTimeimageView.image = UIImage(named: "pk_home_time")
        pkhomeBigCardBackImageView.addSubview(pkhomeBigCardTimeimageView)
        pkhomeBigCardTimeimageView.snp.makeConstraints { make in
            make.centerX.equalTo(pkhomeBigCardTipImageView.snp.centerX)
            make.centerY.equalTo(pkHomeBigCardpayImageView.snp.centerY)
            make.width.height.equalTo(28)
        }
        
        pkhomeBigCardBackImageView.addSubview(FKDvNnMContemnJNpQZkiLabel)
        FKDvNnMContemnJNpQZkiLabel.snp.makeConstraints { make in
            make.centerX.equalTo(pkhomeBigCardTimeimageView.snp.centerX)
            make.top.equalTo(pkhomeBigCardTimeimageView.snp.bottom)
            make.height.equalTo(22)
        }
        
        pkhomeBigCardBackImageView.addSubview(DKawLYmFishwifeKNuuZWtLabel)
        DKawLYmFishwifeKNuuZWtLabel.snp.makeConstraints { make in
            make.centerX.equalTo(FKDvNnMContemnJNpQZkiLabel.snp.centerX)
            make.top.equalTo(FKDvNnMContemnJNpQZkiLabel.snp.bottom)
        }
        

        pkhomeBigCardBackImageView.addSubview(PKHomeBigCardNextBanImageView)
        let BigCardBackTapGesture = UITapGestureRecognizer(target: self, action: #selector(pkHomeBigCardTableViewCellapplyBtnClick))
        pkhomeBigCardBackImageView.addGestureRecognizer(BigCardBackTapGesture)
        PKHomeBigCardNextBanImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 313, height: 60))
        }
        
       
        PKHomeBigCardNextBanImageView.addSubview(UXCceOrUltracytochemistryHszTZVaLabel)
        UXCceOrUltracytochemistryHszTZVaLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    
        contentView.addSubview(homeBigCardAgreementLabel)
        homeBigCardAgreementLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pkhomeBigCardBackImageView.snp.bottom).offset(20)
        }
        
        let agreementTipImageView = UIImageView()
        agreementTipImageView.image = UIImage(named: "pk_home_quest")
        contentView.addSubview(agreementTipImageView)
        agreementTipImageView.snp.makeConstraints { make in
            make.centerY.equalTo(homeBigCardAgreementLabel.snp.centerY)
            make.left.equalTo(homeBigCardAgreementLabel.snp.right).offset(2)
            make.width.height.equalTo(14)
        }
    }
    
    
    func configPKHomeBigCardTableViewCellModel(itemModel: JSON){
        self.homeBigCardItemModel = itemModel
        AUoptXoCampaignSCyMXuZLabel.text = itemModel["AUoptXoCampaignSCyMXuZ"].stringValue
        ZQuKkrnRepudiationYxaTMoZLabel.text = itemModel["ZQuKkrnRepudiationYxaTMoZ"].stringValue
        UXCceOrUltracytochemistryHszTZVaLabel.text = itemModel["UXCceOrUltracytochemistryHszTZVa"].stringValue
        ROARufGHylicismCFYjaKaLabel.text = itemModel["ROARufGHylicismCFYjaKa"].stringValue
        fwpfwKUDefalcationPqqmMOyLabel.text = itemModel["fwpfwKUDefalcationPqqmMOy"].stringValue
        FKDvNnMContemnJNpQZkiLabel.text = itemModel["FKDvNnMContemnJNpQZki"].stringValue
        DKawLYmFishwifeKNuuZWtLabel.text = itemModel["DKawLYmFishwifeKNuuZWt"].stringValue
        PKHomeBigCardNextBanImageView.backgroundColor = UIColor.init(hex: itemModel["eILiGQoHebeiFdgwaQS"].stringValue)
    }
    
    //MARK: - lazy
    lazy var AUoptXoCampaignSCyMXuZLabel: UILabel = {
        let AUoptXoCampaignSCyMXuZLabel = UILabel()
        AUoptXoCampaignSCyMXuZLabel.font = .systemFont(ofSize: 14, weight: .medium)
        AUoptXoCampaignSCyMXuZLabel.textColor = UIColor.init(hex: "#FFFFFF")
        return AUoptXoCampaignSCyMXuZLabel
    }()
    
    lazy var ZQuKkrnRepudiationYxaTMoZLabel: UILabel = {
        let ZQuKkrnRepudiationYxaTMoZLabel = UILabel()
        ZQuKkrnRepudiationYxaTMoZLabel.font = Helvetica_Bold(size: 38)
        ZQuKkrnRepudiationYxaTMoZLabel.textColor = UIColor.init(hex: "#FFFFFF")
        return ZQuKkrnRepudiationYxaTMoZLabel
    }()
    
    lazy var UXCceOrUltracytochemistryHszTZVaLabel: UILabel = {
        let UXCceOrUltracytochemistryHszTZVaLabel = UILabel()
        UXCceOrUltracytochemistryHszTZVaLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        UXCceOrUltracytochemistryHszTZVaLabel.textColor = UIColor.init(hex: "#191919")
        return UXCceOrUltracytochemistryHszTZVaLabel
    }()
    
    lazy var homeBigCardAgreementLabel: UILabel = {
        let agreementLabel = UILabel(frame: CGRect(x: 0, y: 400, width: 235, height: 20))
        agreementLabel.backgroundColor = .clear
        agreementLabel.textColor = UIColor.init(hex: "#666666")
        agreementLabel.font = .systemFont(ofSize: 14)
        let attStr = NSMutableAttributedString(string: "Click to view the " + "Privacy Agreement")
        let privacyRange = (attStr.string as NSString).range(of: "Privacy Agreement")
        attStr.addAttribute(.foregroundColor, value: UIColor.init(hex: "#0622F7") ?? "", range: privacyRange)
        //attStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: privacyRange)
        agreementLabel.attributedText = attStr
        agreementLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pkHomeBigCardTableViewCellopenPrivacy))
        agreementLabel.addGestureRecognizer(tapGesture)
        
        return agreementLabel
    }()
    
    lazy var ROARufGHylicismCFYjaKaLabel: UILabel = {
        let ROARufGHylicismCFYjaKaLabel = UILabel()
        ROARufGHylicismCFYjaKaLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        ROARufGHylicismCFYjaKaLabel.textColor = .white
        return ROARufGHylicismCFYjaKaLabel
    }()
    
    lazy var fwpfwKUDefalcationPqqmMOyLabel: UILabel = {
        let fwpfwKUDefalcationPqqmMOyLabel = UILabel()
        fwpfwKUDefalcationPqqmMOyLabel.font = UIFont.systemFont(ofSize: 12)
        fwpfwKUDefalcationPqqmMOyLabel.textColor = .white
        return fwpfwKUDefalcationPqqmMOyLabel
    }()
    
    lazy var FKDvNnMContemnJNpQZkiLabel: UILabel = {
        let FKDvNnMContemnJNpQZkiLabel = UILabel()
        FKDvNnMContemnJNpQZkiLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        FKDvNnMContemnJNpQZkiLabel.textColor = .white
        return FKDvNnMContemnJNpQZkiLabel
    }()
    
    lazy var DKawLYmFishwifeKNuuZWtLabel: UILabel = {
        let DKawLYmFishwifeKNuuZWtLabel = UILabel()
        DKawLYmFishwifeKNuuZWtLabel.font = UIFont.systemFont(ofSize: 12)
        DKawLYmFishwifeKNuuZWtLabel.textColor = .white
        return DKawLYmFishwifeKNuuZWtLabel
    }()
    
    lazy var PKHomeBigCardNextBanImageView :UIView = {
        let PKHomeBigCardNextBanImageView  = UIView()
        PKHomeBigCardNextBanImageView.layer.cornerRadius = 30
        PKHomeBigCardNextBanImageView.clipsToBounds = true
        return PKHomeBigCardNextBanImageView
    }()
}
