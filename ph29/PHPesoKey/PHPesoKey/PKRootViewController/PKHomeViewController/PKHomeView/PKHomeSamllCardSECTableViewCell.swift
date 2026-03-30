//
//  PKHomeSamllCardSECTableViewCell.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/17.
//

import UIKit

class PKHomeSamllCardSECTableViewCell: UITableViewCell {

    @IBOutlet weak var pk_home_sec: UIImageView!
    
    var homeSamllCardSECAgreementBlock: PKStingBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        certPKHomeSamllCardSECTableViewCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func certPKHomeSamllCardSECTableViewCellUI(){
        let agreementLabel = UILabel(frame: CGRect(x: 0, y: 80, width: 235, height: 20))
        agreementLabel.backgroundColor = .clear
        agreementLabel.centerX = contentView.centerX
        agreementLabel.textColor = UIColor.init(hex: "#666666")
        agreementLabel.font = .systemFont(ofSize: 14)
        let attStr = NSMutableAttributedString(string: "Click to view the " + "Privacy Agreement")
        let privacyRange = (attStr.string as NSString).range(of: "Privacy Agreement")
        attStr.addAttribute(.foregroundColor, value: UIColor.init(hex: "#0622F7") ?? "", range: privacyRange)
        agreementLabel.attributedText = attStr
        agreementLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pkHomeBigCardTableViewCellopenPrivacy))
        agreementLabel.addGestureRecognizer(tapGesture)
        contentView.addSubview(agreementLabel)
        
        let agreementTipImageView = UIImageView()
        agreementTipImageView.image = UIImage(named: "pk_home_quest")
        contentView.addSubview(agreementTipImageView)
        agreementTipImageView.snp.makeConstraints { make in
            make.centerY.equalTo(agreementLabel.snp.centerY)
            make.left.equalTo(agreementLabel.snp.right).offset(2)
            make.width.height.equalTo(14)
        }
    }
    
    
    @objc func pkHomeBigCardTableViewCellopenPrivacy(){
        homeSamllCardSECAgreementBlock?(WebUpper + "/#/privac" + "yagreement")
    }
    
}
