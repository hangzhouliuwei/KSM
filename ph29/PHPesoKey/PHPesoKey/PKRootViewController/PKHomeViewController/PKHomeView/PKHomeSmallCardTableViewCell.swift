//
//  PKHomeSmallCardTableViewCell.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/14.
//

import UIKit

class PKHomeSmallCardTableViewCell: UITableViewCell {

    var homeSmallCardItemModel:JSON = JSON()
    var homeSmallCardnextClickBlock: PKStingBlock?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        certPKHomeSmallCardTableViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pkHomeBigCardTableViewCellapplyBtnClick(){
        
        homeSmallCardnextClickBlock?(self.homeSmallCardItemModel["PSAGszTConverselyEKiKyQy"].stringValue)
            
    }
    
    func certPKHomeSmallCardTableViewCellUI(){
        let pkHomeSmallCardBackImageView = UIImageView()
        pkHomeSmallCardBackImageView.image = UIImage(named: "pk_home_smallCardBack")
        pkHomeSmallCardBackImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pkHomeBigCardTableViewCellapplyBtnClick))
        pkHomeSmallCardBackImageView.addGestureRecognizer(tapGesture)
        contentView.addSubview(pkHomeSmallCardBackImageView)
        pkHomeSmallCardBackImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(182)
            make.left.equalTo(12)
            make.right.equalTo(-12)
        }
        
        pkHomeSmallCardBackImageView.addSubview(AUoptXoCampaignSCyMXuZLabel)
        AUoptXoCampaignSCyMXuZLabel.snp.makeConstraints { make in
            make.top.equalTo(26)
            make.left.equalTo(32)
            make.height.equalTo(16)
        }
        
        pkHomeSmallCardBackImageView.addSubview(ZQuKkrnRepudiationYxaTMoZLabel)
        ZQuKkrnRepudiationYxaTMoZLabel.snp.makeConstraints { make in
            make.top.equalTo(AUoptXoCampaignSCyMXuZLabel.snp.bottom).offset(2)
            make.centerX.equalTo(AUoptXoCampaignSCyMXuZLabel.snp.centerX)
            make.height.equalTo(40)
        }
        
        let  pkhomeSamllCardTipImageView = UIImageView()
        pkhomeSamllCardTipImageView.image = UIImage(named: "pk_home_card3")
        pkHomeSmallCardBackImageView.addSubview(pkhomeSamllCardTipImageView)
        pkhomeSamllCardTipImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 83, height: 92))
        }
        
        pkHomeSmallCardBackImageView.addSubview(PKHomeSmallCardapplyBtnLabel)
        PKHomeSmallCardapplyBtnLabel.snp.makeConstraints { make in
            make.top.equalTo(pkhomeSamllCardTipImageView.snp.bottom).offset(18)
            make.left.equalTo(26)
            make.right.equalTo(-26)
            make.height.equalTo(46)
        }
        
    }
    
    func configPKHomeSmallCardTableViewCellModel(itemModel:JSON){
        self.homeSmallCardItemModel = itemModel
        AUoptXoCampaignSCyMXuZLabel.text = itemModel["AUoptXoCampaignSCyMXuZ"].stringValue
        ZQuKkrnRepudiationYxaTMoZLabel.text = itemModel["ZQuKkrnRepudiationYxaTMoZ"].stringValue
        PKHomeSmallCardapplyBtnLabel.backgroundColor = UIColor.init(hex: itemModel["eILiGQoHebeiFdgwaQS"].stringValue)
        PKHomeSmallCardapplyBtnLabel.text = itemModel["UXCceOrUltracytochemistryHszTZVa"].stringValue
    }
    
    @objc func pkHomeSmallCardBackImageViewapplyBtnClick(){
        
    }
    
    lazy var AUoptXoCampaignSCyMXuZLabel: UILabel = {
        let AUoptXoCampaignSCyMXuZLabel = UILabel()
        AUoptXoCampaignSCyMXuZLabel.textColor = .white
        AUoptXoCampaignSCyMXuZLabel.font = .systemFont(ofSize: 14, weight: .medium)
        return AUoptXoCampaignSCyMXuZLabel
    }()
    
    lazy var ZQuKkrnRepudiationYxaTMoZLabel: UILabel = {
        let ZQuKkrnRepudiationYxaTMoZLabel = UILabel()
        ZQuKkrnRepudiationYxaTMoZLabel.textColor = .white
        ZQuKkrnRepudiationYxaTMoZLabel.font = Helvetica_Bold(size: 38)
        return ZQuKkrnRepudiationYxaTMoZLabel
    }()
    
    lazy var PKHomeSmallCardapplyBtnLabel :UILabel = {
        let PKHomeSmallCardapplyBtnLabel = UILabel()
        PKHomeSmallCardapplyBtnLabel.textColor = UIColor.init(hex:"#191919")
        PKHomeSmallCardapplyBtnLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        PKHomeSmallCardapplyBtnLabel.textAlignment = .center
        PKHomeSmallCardapplyBtnLabel.layer.cornerRadius = 23
        PKHomeSmallCardapplyBtnLabel.clipsToBounds = true
        return PKHomeSmallCardapplyBtnLabel
    }()

}
