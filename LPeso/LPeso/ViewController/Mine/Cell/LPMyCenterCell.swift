//
//  LPMyCenterCell.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit

class LPMyCenterCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImgV: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func loadBill(){
        iconImgV.image = UIImage(named: "my_bill")
        titleLab.text = "My Bill"
    }
    
    public func reloadWithItem(_ item:LPMineItemModel){
        iconImgV.setImage(urlString: item.PTUTictoci)
        titleLab.text = item.PTUTilefishi
    }

}
