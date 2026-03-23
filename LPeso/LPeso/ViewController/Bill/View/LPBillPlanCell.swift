//
//  LPBillPlanCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/19.
//

import UIKit

class LPBillPlanCell: UITableViewCell {
    
    @IBOutlet weak var periodsLab: UILabel!
    
    @IBOutlet weak var dateLab: UILabel!
    
    @IBOutlet weak var amountLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configModel(model:LPBillPlanModel){
        let color = UIColor(hex: model.PTUPolysemyi ?? "#333333") ?? black51
        
        periodsLab.textColor = color
        dateLab.textColor = color
        amountLab.textColor = color
        
        periodsLab.text = model.PTUCopremiai?.string ?? ""
        dateLab.text = model.PTUHousemaidi ?? ""
        amountLab.text = String(format: "₱%@", model.PTUWaxingi?.string ?? "0")
        
    }
    
}
