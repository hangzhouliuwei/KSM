//
//  PKCertificationContactableViewCell.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/12.
//

import UIKit

class PKCertificationContactableViewCell: UITableViewCell {
    
    @IBOutlet weak var pkCellTitleLab: UILabel!
    
    @IBOutlet weak var relationLab: UITextField!
    @IBOutlet weak var nameLab: UITextField!
    @IBOutlet weak var numberLab: UITextField!
    var pkCellBlock:(_ itme:JSON) -> Void = {_ in}
    var cellDataInfo = JSON()
    
    var address = PkAddressManager()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func relationClick(_ sender: Any) {
        let relationValueId = cellDataInfo["KaqiIPtIntrapsychicFAZZTnx"]["JifnYPwAffineTLZCEyt"].stringValue
        let relationItemList = cellDataInfo["JifnYPwAffineTLZCEyt"].arrayValue
        let topDesc = cellDataInfo["ckFFwRwEverettRLWEfVE"].stringValue
        let infoPop = PKTouchItemAlert(list: relationItemList, selectValue: relationValueId, topDesc: topDesc, typeValue: 1)
        infoPop.chooseBack = {  str in
            self.selectType(str)
        }
        infoPop.displayAlert()
    }
    
    func selectType(_ value:String) {
        cellDataInfo["KaqiIPtIntrapsychicFAZZTnx"]["JifnYPwAffineTLZCEyt"].stringValue = value
        pkCellBlock(cellDataInfo)
    }
    
    @IBAction func contactClick(_ sender: Any) {
        address.openAddressPage()
        address.chooseBack = { value in
            self.cellDataInfo["KaqiIPtIntrapsychicFAZZTnx"]["ZCHfNtdEboniseOnEWitA"].stringValue = value["telNumber"] ?? ""
            self.cellDataInfo["KaqiIPtIntrapsychicFAZZTnx"]["cvIYGHjDoorkeeperTQWCMJQ"].stringValue = value["telToName"] ?? ""
            self.pkCellBlock(self.cellDataInfo)
        }
    }
    
    func setupCellData(cellInfo:JSON) {
        cellDataInfo = cellInfo
        pkCellTitleLab.text = cellInfo["ckFFwRwEverettRLWEfVE"].stringValue
        nameLab.text = cellInfo["KaqiIPtIntrapsychicFAZZTnx"]["ZCHfNtdEboniseOnEWitA"].stringValue
        numberLab.text = cellInfo["KaqiIPtIntrapsychicFAZZTnx"]["cvIYGHjDoorkeeperTQWCMJQ"].stringValue
        
        let relationValueId = cellInfo["KaqiIPtIntrapsychicFAZZTnx"]["JifnYPwAffineTLZCEyt"].stringValue
        let relationItemList = cellInfo["JifnYPwAffineTLZCEyt"].arrayValue
        
        for item in relationItemList {
            let pkrelationId = item["GeqIhKARadioresistanceRvuWGMu"].stringValue
            let relationName = item["ZCHfNtdEboniseOnEWitA"].stringValue
            if relationValueId == pkrelationId {
                relationLab.text = relationName
            }
        }
    }
    
}
