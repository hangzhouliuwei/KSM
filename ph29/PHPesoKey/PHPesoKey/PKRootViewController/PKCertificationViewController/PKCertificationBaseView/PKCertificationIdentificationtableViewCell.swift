//
//  PKCertificationIdentificationtableViewCell.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/17.
//

import UIKit

class PKCertificationIdentificationtableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pkIdTypeLab: UITextField!
    
    @IBOutlet weak var pkIdPictureShowView: UIView!
    
    @IBOutlet weak var pkIdPictureImageView :  UIImageView!
    @IBOutlet weak var pkIdCenterImageView :  UIImageView!
    var pkCellClik:(_ index:Int) -> Void = {_  in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func pkClickType(_ sender: Any) {
        pkCellClik(0)
    }
    func setupCellData(picData:PKPhotoConfigData) {
        for itemData in picData.pkTypeItemDataArray {
            let type = itemData["rbYxXzzMichiganderEldlcxZ"].stringValue
            let value = itemData["OdGrOVQInstrumentationGiUHstg"].stringValue
            let url = itemData["GZxRhhcEthaneSXhVKFu"].stringValue
            if picData.pkTypeSelectedId == type {
                pkIdTypeLab.text = value
                if picData.pkResourceUrl.isEmpty {
                    pkIdPictureImageView.image = UIImage(named: "pk_auth_timeBg")
                    pkIdPictureImageView.kf.setImage(with: URL(string: url))
                }
            }
        }
        pkIdCenterImageView.isHidden = (!picData.pkResourceUrl.isEmpty) || (picData.pkResourceImage.size.width > 0)
        if !picData.pkResourceUrl.isEmpty {
            pkIdPictureImageView.kf.setImage(with: URL(string: picData.pkResourceUrl))
        }else if picData.pkResourceImage.size.width > 0 {
            pkIdPictureImageView.image = picData.pkResourceImage
        }
        pkIdPictureImageView.touch {
            self.pkCellClik(1)
        }
    }
    
    
}
