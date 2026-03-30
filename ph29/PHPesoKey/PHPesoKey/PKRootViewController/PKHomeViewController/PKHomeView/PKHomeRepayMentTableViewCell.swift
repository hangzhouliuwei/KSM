//
//  PKHomeRepayMentTableViewCell.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/17.
//

import UIKit

class PKHomeRepayMentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var home_RepayMent_image: UIImageView!
    var homeRepayMentItemModel:JSON = JSON()
    var homeRepayMentClickBlock: PKStingBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        home_RepayMent_image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(homeRepayMentImageViewClick))
        home_RepayMent_image.addGestureRecognizer(tapGesture)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configPKHomeRepayMentTableViewCellModel(itemModel:JSON){
        self.homeRepayMentItemModel = itemModel
        self.home_RepayMent_image.kf.setImage(with: URL(string: itemModel["SWcJvaaChildmindSbvnrtF"].stringValue))
    }
    
    @objc func homeRepayMentImageViewClick(){
        self.homeRepayMentClickBlock?(self.homeRepayMentItemModel["frPFiGQHarkFDGovYI"].stringValue)
    }
    
}
