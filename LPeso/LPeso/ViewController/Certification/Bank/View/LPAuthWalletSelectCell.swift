//
//  LPAuthWalletSelectCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/13.
//

import UIKit

class LPAuthWalletSelectCell: UITableViewCell {
    
    var clickBlock:() -> Void = {}

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func btnClick(_ sender: Any) {
        clickBlock()
    }
    
    func configModel(model:LPAuthBankItemModel){
        imgV.setImage(urlString: model.PTUTictoci)
        titleLab.text = model.PTUCarmarthenshirei ?? ""
    }
    

}
