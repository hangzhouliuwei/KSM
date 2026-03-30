//
//  PKHomeTableViewCell.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/13.
//

import UIKit

class PKHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pk_pro_head: UIImageView!
    @IBOutlet weak var pk_pro_name: UILabel!
    @IBOutlet weak var pk_pro_amount: UILabel!
    @IBOutlet weak var pk_pro_amountTitle: UILabel!
    
    @IBOutlet weak var pk_pro_apply: UIButton!
    var homeTableViewCellModel:JSON = JSON()
    var homeTableViewCellNextClickBlock: PKStingBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        pk_pro_head.layer.cornerRadius = 4
        pk_pro_head.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func pkApplyAction(_ sender: Any) {
        self.homeTableViewCellNextClickBlock?(self.homeTableViewCellModel["PSAGszTConverselyEKiKyQy"].stringValue)
    }
    
    func configPKHomeTableViewCellModel(itemModel: JSON){
        self.homeTableViewCellModel = itemModel
        self.pk_pro_head.kf.setImage(with: URL(string: itemModel["BftJJVvRiotouslyYnnJhcv"].stringValue))
        self.pk_pro_name.text = itemModel["mycOUpLNitrobenzolXoIeLbP"].stringValue
        self.pk_pro_amount.text = itemModel["ZQuKkrnRepudiationYxaTMoZ"].stringValue
        self.pk_pro_amountTitle.text = itemModel["AUoptXoCampaignSCyMXuZ"].stringValue
        self.pk_pro_apply.setTitle(itemModel["UXCceOrUltracytochemistryHszTZVa"].stringValue, for: .normal)
        self.pk_pro_apply.backgroundColor = UIColor.init(hex: itemModel["eILiGQoHebeiFdgwaQS"].stringValue)
    }
}
