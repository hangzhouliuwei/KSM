//
//  PKCertificationBankItemHelper.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/14.
//

class EInfoView: UIView {
    var eModeInfoShowlist = [JSON]()
    var selectType = ""
    var typeName = ""
    var acceModeInfoShowText = UITextField()
    let listeModeInfoShowView = UIView()
    let vblack = vrgba(34, 34, 34, 1)
    let vgray = vrgba(136, 136, 136, 1)
    func config(list:[JSON]) {
        
        self.eModeInfoShowlist = list
        
        let eModeInfoShowline = UIImageView(frame: CGRect(x: 12, y: 15, width: 3, height: 14))
        eModeInfoShowline.image = UIImage(named: "pk_auth_labIcon")
        self.addSubview(eModeInfoShowline)
        
        let eModeInfoShowtitle = UILabel(frame: CGRect(x: eModeInfoShowline.right + 4, y: 12, width: self.width - eModeInfoShowline.right, height: 21))
        eModeInfoShowtitle.textColor = vblack
        eModeInfoShowtitle.font = .boldSystemFont(ofSize: 14)
        eModeInfoShowtitle.text = "Select E-Wallet"
        self.addSubview(eModeInfoShowtitle)
        
        listeModeInfoShowView.frame = CGRect(x: 12, y: eModeInfoShowtitle.bottom + 10, width: self.width - 24, height:108.0)
        self.addSubview(listeModeInfoShowView)
        
        let acceModeInfoShowTitle = UILabel(frame: CGRect(x: 12, y: listeModeInfoShowView.bottom + 16, width: self.width - 24, height: 17))
        acceModeInfoShowTitle.textColor = vblack
        acceModeInfoShowTitle.font = .systemFont(ofSize: 13)
        acceModeInfoShowTitle.text = "E-wallet Account"
        self.addSubview(acceModeInfoShowTitle)
        
        acceModeInfoShowText.frame = CGRect(x: 12, y: acceModeInfoShowTitle.bottom + 6, width: self.width - 24, height: 36)
        acceModeInfoShowText.placeholder = "Please enter you bank number"
        acceModeInfoShowText.textColor = vblack
        acceModeInfoShowText.backgroundColor = vrgba(242, 242, 242, 1)
        acceModeInfoShowText.font = .systemFont(ofSize: 13)
        acceModeInfoShowText.keyboardType = .alphabet
        acceModeInfoShowText.cornerRadius = 4
        acceModeInfoShowText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 36))
        acceModeInfoShowText.leftViewMode = .always
        acceModeInfoShowText.clearButtonMode = .never
        acceModeInfoShowText.keyboardType = .numberPad
        self.addSubview(acceModeInfoShowText)
        
        let acceModeInfoShowNo = PKUserManager.phone
        if let firstChar = acceModeInfoShowNo.first, firstChar == "0" {
            acceModeInfoShowText.text = acceModeInfoShowNo
        } else {
            acceModeInfoShowText.text = "0" + acceModeInfoShowNo
        }
        
        let desceModeInfoShowTitle = UILabel(frame: CGRect(x: 12, y: acceModeInfoShowText.bottom + 12, width: self.width - 24, height: 17))
        desceModeInfoShowTitle.textColor = vgray
        desceModeInfoShowTitle.font = .systemFont(ofSize: 12)
        desceModeInfoShowTitle.text = "Please confrm the account belongs to yourself and is correct, it will be used as a receipt account to receive the funds"
        desceModeInfoShowTitle.numberOfLines = 0
        desceModeInfoShowTitle.sizeToFit()
        self.addSubview(desceModeInfoShowTitle)
        
        self.height = desceModeInfoShowTitle.bottom + 20
        
        refresUpdateViewSHowhValue()
    }
    
    func refresUpdateViewSHowhValue() {
        listeModeInfoShowView.subviews.forEach { subv in
            subv.removeFromSuperview()
        }
        
        let itemWidth = (self.listeModeInfoShowView.width - 24)/3.0
        let itemHeight = 108.0
        for (i, item) in eModeInfoShowlist.enumerated() {
            let type = item["PSAGszTConverselyEKiKyQy"].stringValue
            let name = item["ZCHfNtdEboniseOnEWitA"].stringValue
            let url = item["icon_new"].stringValue

            let itemeModeInfoShowView = UIView(frame: CGRect(x: (12.0 + itemWidth)*Double(i), y: 0, width: itemWidth, height: itemHeight))
            itemeModeInfoShowView.cornerRadius = 4
            itemeModeInfoShowView.layer.borderColor = vrgba(232, 232, 237, 1).cgColor
            itemeModeInfoShowView.layer.borderWidth = 1
            itemeModeInfoShowView.touch { [weak self] in
                self?.selectType = type
                self?.refresUpdateViewSHowhValue()
            }
            listeModeInfoShowView.addSubview(itemeModeInfoShowView)
            
            let eeModeInfoShowImage = UIImageView(frame: CGRect(x:0, y: 14, width: 32, height: 32))
            eeModeInfoShowImage.centerX = itemWidth/2
            eeModeInfoShowImage.kf.setImage(with: URL(string: url))
            itemeModeInfoShowView.addSubview(eeModeInfoShowImage)
            
            let eeModeInfoShowName = UILabel(frame: CGRect(x: 10, y: 56, width: itemWidth - 20, height: 38))
            eeModeInfoShowName.textColor = vblack
            eeModeInfoShowName.font = .systemFont(ofSize: 13)
            eeModeInfoShowName.numberOfLines = 2
            eeModeInfoShowName.textAlignment = .center
            eeModeInfoShowName.text = name
            itemeModeInfoShowView.addSubview(eeModeInfoShowName)
            
            if selectType == type {
                let eIcon = UIImageView(frame: CGRect(x:itemeModeInfoShowView.width - 20, y: 0, width: 20, height: 17))
                eIcon.image = UIImage(named: "pk_auth_wallet_select")
                typeName = name
                itemeModeInfoShowView.addSubview(eIcon)
            }
        }
    }
}

class BInfoView: UIView {
    var listbModeInfoDisplay = [JSON]()
    var selectType = ""
    var typeName = ""
    var typebModeInfoDisplayText = UITextField()
    var accbModeInfoDisplayText = UITextField()
    let vblack = vrgba(34, 34, 34, 1)
    let vgray = vrgba(136, 136, 136, 1)
    func config(list:[JSON]) {
        
        self.listbModeInfoDisplay = list
        
        let bModeInfoDisplayline = UIImageView(frame: CGRect(x: 12, y: 15, width: 3, height: 14))
        bModeInfoDisplayline.image = UIImage(named: "pk_auth_labIcon")
        self.addSubview(bModeInfoDisplayline)
        
        let bModeInfoDisplaytitle = UILabel(frame: CGRect(x: bModeInfoDisplayline.right + 4, y: 12, width: self.width - bModeInfoDisplayline.right, height: 21))
        bModeInfoDisplaytitle.textColor = vblack
        bModeInfoDisplaytitle.font = .boldSystemFont(ofSize: 14)
        bModeInfoDisplaytitle.text = "Select Bank"
        self.addSubview(bModeInfoDisplaytitle)
        
        let bModeInfoDisplaytypeTitle = UILabel(frame: CGRect(x: 12, y: bModeInfoDisplaytitle.bottom + 10, width: self.width - 24, height: 17))
        bModeInfoDisplaytypeTitle.textColor = vblack
        bModeInfoDisplaytypeTitle.font = .systemFont(ofSize: 13)
        bModeInfoDisplaytypeTitle.text = "Bank"
        self.addSubview(bModeInfoDisplaytypeTitle)
        
        typebModeInfoDisplayText.frame = CGRect(x: 12, y: bModeInfoDisplaytypeTitle.bottom + 6, width: self.width - 24, height: 36)
        typebModeInfoDisplayText.placeholder = "Please select you bank"
        typebModeInfoDisplayText.textColor = vblack
        typebModeInfoDisplayText.backgroundColor = vrgba(242, 242, 242, 1)
        typebModeInfoDisplayText.font = .systemFont(ofSize: 13)
        typebModeInfoDisplayText.cornerRadius = 4
        typebModeInfoDisplayText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 36))
        typebModeInfoDisplayText.leftViewMode = .always
        typebModeInfoDisplayText.clearButtonMode = .never
        typebModeInfoDisplayText.isEnabled = false
        self.addSubview(typebModeInfoDisplayText)
        
        let bModeInfoDisplayicon = UIButton(type: .custom)
        bModeInfoDisplayicon.isUserInteractionEnabled = false
        bModeInfoDisplayicon.frame = CGRect(x: typebModeInfoDisplayText.width - typebModeInfoDisplayText.height, y: 0, width: typebModeInfoDisplayText.height, height: typebModeInfoDisplayText.height)
        bModeInfoDisplayicon.setImage(UIImage(named: "pk_down_arrow"), for: .normal)
        typebModeInfoDisplayText.addSubview(bModeInfoDisplayicon)
        
        let bModeInfoDisplaybtn = UIButton(frame: typebModeInfoDisplayText.frame)
        bModeInfoDisplaybtn.touch { [weak self] in
            UIApplication.shared.windows.first?.endEditing(true)
            self?.showbModeInfoDisplayAlert()
        }
        self.addSubview(bModeInfoDisplaybtn)
        
        let bModeInfoDisplayaccTitle = UILabel(frame: CGRect(x: 12, y: typebModeInfoDisplayText.bottom + 12, width: self.width - 24, height: 17))
        bModeInfoDisplayaccTitle.textColor = vblack
        bModeInfoDisplayaccTitle.font = .systemFont(ofSize: 12)
        bModeInfoDisplayaccTitle.text = "Bank Account"
        self.addSubview(bModeInfoDisplayaccTitle)
        
        accbModeInfoDisplayText.frame = CGRect(x: 12, y: bModeInfoDisplayaccTitle.bottom + 6, width: self.width - 24, height: 32)
        accbModeInfoDisplayText.placeholder = "Please enter you bank number"
        accbModeInfoDisplayText.textColor = vblack
        accbModeInfoDisplayText.backgroundColor = vrgba(242, 242, 242, 1)
        accbModeInfoDisplayText.font = .systemFont(ofSize: 13)
        accbModeInfoDisplayText.keyboardType = .alphabet
        accbModeInfoDisplayText.cornerRadius = 4
        accbModeInfoDisplayText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 36))
        accbModeInfoDisplayText.leftViewMode = .always
        accbModeInfoDisplayText.clearButtonMode = .never
        self.addSubview(accbModeInfoDisplayText)
        
        let descbModeInfoDisplayTitle = UILabel(frame: CGRect(x: 12, y: accbModeInfoDisplayText.bottom + 12, width: self.width - 24, height: 17))
        descbModeInfoDisplayTitle.textColor = vgray
        descbModeInfoDisplayTitle.font = .systemFont(ofSize: 12)
        descbModeInfoDisplayTitle.text = "Please confrm the account belongs to yourself and is correct, it will be used as a receipt account to receive the funds"
        descbModeInfoDisplayTitle.numberOfLines = 0
        descbModeInfoDisplayTitle.sizeToFit()
        self.addSubview(descbModeInfoDisplayTitle)
        
        self.height = descbModeInfoDisplayTitle.bottom + 20
        
        pkUpdateDisplayValue()
    }
    
    func pkUpdateDisplayValue() {
        for item in listbModeInfoDisplay {
            let type = item["PSAGszTConverselyEKiKyQy"].stringValue
            let name = item["ZCHfNtdEboniseOnEWitA"].stringValue
            if selectType == type {
                typebModeInfoDisplayText.text = name
                typeName = name
            }
        }
    }
    
    func showbModeInfoDisplayAlert() {
        let infoPop = PKTouchItemAlert(list: listbModeInfoDisplay, selectValue: selectType, topDesc: "Select Bank", typeValue: 3)
        infoPop.chooseBack = {  str in
            self.selectType = str
            self.pkUpdateDisplayValue()
        }
        infoPop.displayAlert()
    }
}
