//
//  LPHomeProductCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/4.
//

import UIKit

class LPHomeProductCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImgV: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var applyBtn: UIButton!
    
    var clickBlock:() -> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.borderColor = gray224
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func applyClick(_ sender: Any) {
        clickBlock()
    }
    
    func updateWithModel(model:LPHomeItemModel){
        iconImgV.setImage(urlString: model.PTUTalofibulari)
        titleLab.text = model.PTUTrimonthlyi ?? ""
        
        priceLab.text = model.PTUTaeniai?.string
        
        applyBtn.setTitle(model.PTUTirosi ?? "", for: .normal)
        if let color = model.PTUJuglandaceousi{
            applyBtn.backgroundColor = UIColor(hex: color)
        }
    }
    
}
