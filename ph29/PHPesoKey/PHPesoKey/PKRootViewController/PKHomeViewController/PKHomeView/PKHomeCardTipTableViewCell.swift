//
//  PKHomeCardTipTableViewCell.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/14.
//

import UIKit

class PKHomeCardTipTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
