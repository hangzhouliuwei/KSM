//
//  PKCertificationBasetableViewCell.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/11.
//

import UIKit

class PKCertificationBasetableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLab: UILabel!
    @IBOutlet weak var cellTextFiledLab: UITextField!
    
    var pkCellBlock:() -> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction public func cellLabClick(_ sender: Any) {
        pkCellBlock()
    }
    
    func setupCellData(cellInfo:JSON){
        cellTextFiledLab.placeholder = cellInfo["VnrwRxsDiscriminableAlAlVNh"].stringValue
        let titlestr = cellInfo["ckFFwRwEverettRLWEfVE"].stringValue
        cellTitleLab.text = titlestr
        let list = cellInfo["ewvSGHNSixtyYTGoXbt"].arrayValue
        let selectValue = cellInfo["RKLriwISustenanceLZTKKlk"].stringValue
        
        let itemClickType = cellInfo["FXimzgpMurkDMmGSPv"].stringValue
        if (itemClickType == pkdy) {
            cellTextFiledLab.text = selectValue
            return
        }
        for item in list {
            let typeStr = item["tIbeJSgActivistXYQsLuc"].stringValue
            let valueStr = item["ZCHfNtdEboniseOnEWitA"].stringValue
            if selectValue == typeStr {
                cellTextFiledLab.text = valueStr
            }
        }
    }
    
}
