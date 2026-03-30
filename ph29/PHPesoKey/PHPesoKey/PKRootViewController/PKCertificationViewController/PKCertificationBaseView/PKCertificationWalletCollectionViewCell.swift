//
//  PKCertificationWalletCollectionViewCell.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/12.
//

import UIKit

class PKCertificationWalletCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBgView.layer.borderWidth = 1
        cellBgView.layer.borderColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 237/255.0, alpha: 1.0).cgColor
    }

}
