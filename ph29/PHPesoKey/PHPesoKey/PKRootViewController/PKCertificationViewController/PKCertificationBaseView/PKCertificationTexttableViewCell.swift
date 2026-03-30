//
//  PKCertificationTexttableViewCell.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/12.
//

import UIKit

class PKCertificationTexttableViewCell: UITableViewCell,UITextFieldDelegate {
    @IBOutlet weak var cellTextTitleLab: UILabel!
    @IBOutlet weak var cellTextField: UITextField!
    var emailTypeView = UIView()
    var isEmail = false
    var pkCellBlock:(_ str:String) -> Void = {_ in}
    var pkScrollowBlock:() -> Void = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        cellTextField.delegate = self
        cellTextField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }

    @objc func textDidChange(_ textField: UITextField){
        pkCellBlock(textField.text ?? "")
        if isEmail {
            updatePopEmailView(with: textField.text ?? "")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func setupCellData(cellInfo:JSON) {
        cellTextField.placeholder = cellInfo["VnrwRxsDiscriminableAlAlVNh"].stringValue
        cellTextField.text = cellInfo["RKLriwISustenanceLZTKKlk"].stringValue
        cellTextTitleLab.text = cellInfo["ckFFwRwEverettRLWEfVE"].stringValue
        
        let code = cellInfo["XEBeCQlMariupolZsiPAoS"].stringValue
        if code == "email" {
            isEmail = true
        }
    }
    
    func updatePopEmailView(with text: String) {
        if text.isEmpty {
            emailTypeView.isHidden = true
            return
        }
        emailTypeView.isHidden = false
        emailTypeView.subviews.forEach { v in
            v.removeFromSuperview()
        }
        
        let leadArr = text.split(separator: "@").map { String($0) }
        let emailArr = ["@gma" + "il.com", "@iclo" + "ud.com", "@yaho" + "o.com", "@outl" + "ook.com"]
        var validArr: [String] = []
        
        if leadArr.count == 1 {
            validArr = emailArr
        } else if leadArr.count == 2 {
            validArr = emailArr.filter { $0.hasPrefix("@\(leadArr[1])") }
        } else {
            emailTypeView.isHidden = true
            return
        }
        
        if validArr.isEmpty {
            emailTypeView.isHidden = true
            return
        }
        
        for (index, email) in validArr.enumerated() {
            let inputStringWithFixed = leadArr[0] + email
            let itemViewListItemRowButton = UIButton(type: .custom)
            itemViewListItemRowButton.contentHorizontalAlignment = .left
            itemViewListItemRowButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            itemViewListItemRowButton.frame = CGRect(x: 12, y: index * 30, width: Int(emailTypeView.width) - 24, height: 30)
            itemViewListItemRowButton.setTitle(inputStringWithFixed, for: .normal)
            itemViewListItemRowButton.setTitleColor(.lightGray, for: .normal)
            emailTypeView.addSubview(itemViewListItemRowButton)
            itemViewListItemRowButton.touch { [weak self] in
                self?.pkItemEmailTouchAction(inputStringWithFixed)
            }
        }
        pkScrollowBlock()
        
    }
    
    func pkItemEmailTouchAction(_ content:String) {
        self.pkCellBlock(content)
        cellTextField.text = content
        endEditing(true)
    }
}
