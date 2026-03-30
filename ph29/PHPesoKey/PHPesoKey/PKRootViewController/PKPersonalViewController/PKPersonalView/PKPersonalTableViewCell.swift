//
//  PKPersonalTableViewCell.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/11.
//

import UIKit

class PKPersonalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pkPersonalIconImg: UIImageView!
    @IBOutlet weak var pkPersonalTitle: UILabel!
    @IBOutlet weak var baView: UIView!
    
    var personalTableViewCellClickBlock: PKStingBlock?
    var itmeModel:JSON = JSON()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func pkPersonalCellClick(_ sender: Any) {
        self.personalTableViewCellClickBlock?(self.itmeModel["frPFiGQHarkFDGovYI"].stringValue)
        
    }
    
    func configPKPersonalTableViewCellModel(itmeModel: JSON){
        self.itmeModel = itmeModel
        pkPersonalIconImg.kf.setImage(with: URL(string: itmeModel["paJSPLtLignosulphonateKsCkIAM"].stringValue))
        pkPersonalTitle.text = itmeModel["ckFFwRwEverettRLWEfVE"].stringValue
        if itmeModel["fistItem"].boolValue{
            baView.layer.masksToBounds = true
            baView.layer.cornerRadius = 8
            baView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }else if itmeModel["lastItem"].boolValue{
            baView.layer.masksToBounds = true
            baView.layer.cornerRadius = 8
            baView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }else{
            baView.layer.cornerRadius = 0
        }
//        if index == 1{
//            baView.layer.masksToBounds = true
//            baView.layer.cornerRadius = 8
//            baView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        }else if index == 2{
//            baView.layer.masksToBounds = true
//            baView.layer.cornerRadius = 8
//            baView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        }else{
//            baView.layer.cornerRadius = 0
//        }
    }
    
}
