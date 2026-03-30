//
//  BioLStartBearMent.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/16.
//


class PKTouchItemAlert: UIView {
    var chooseBack:PKStingBlock?
    let grayBgSceenView = UIView()
    var chooseValueType = ""
    var topShowString = ""
    var tileSlectorArray = [JSON]()
    var typeIndex = 0
    init(list:[JSON], selectValue: String, topDesc:String, typeValue:Int = 0) {
        super.init(frame: CGRect(x: 0, y: 0, width: width_PK_bounds, height: height_PK_bounds))
        chooseValueType = selectValue
        topShowString = topDesc
        tileSlectorArray = list
        typeIndex = typeValue
        loadShowView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadShowView() {
        grayBgSceenView.backgroundColor = .clear
        grayBgSceenView.frame = self.frame
        addSubview(grayBgSceenView)
        grayBgSceenView.touch {
            PKBottomFlatView.dismissed()
        }
        
        let mainPopView = UILabel()
        mainPopView.isUserInteractionEnabled = true
        mainPopView.backgroundColor = .white
        mainPopView.frame = CGRect(x: 0, y: self.height - 400 - safe_PK_bottom, width:width_PK_bounds, height: 400 + safe_PK_bottom)
        mainPopView.layer.cornerRadius = 16
        mainPopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addSubview(mainPopView)

        let topViewShow = UILabel(frame: CGRect(x: 15, y: 12, width: width_PK_bounds - 80, height: 44))
        topViewShow.font = .boldSystemFont(ofSize: 16)
        topViewShow.textColor = vrgba(25, 25, 25, 1)
        topViewShow.text = topShowString
        topViewShow.numberOfLines = 2
        mainPopView.addSubview(topViewShow)

        let dismissBtn = UIButton(frame: CGRect(x: width_PK_bounds - 50, y: 0, width: 50, height: 50))
        dismissBtn.setImage(UIImage(named: "pk_dismissbtn"), for: .normal)
        dismissBtn.touch {
            PKBottomFlatView.dismissed()
        }
        mainPopView.addSubview(dismissBtn)
        
        let contentPanView = UIScrollView(frame: CGRect(x: 0, y: 78, width: width_PK_bounds, height: 251))
        contentPanView.showsVerticalScrollIndicator = false
        contentPanView.contentSize = CGSize(width: contentPanView.width, height: Double(50)*Double(tileSlectorArray.count))
        mainPopView.addSubview(contentPanView)
        
        var typeKey = "tIbeJSgActivistXYQsLuc"
        var valueKey = "ZCHfNtdEboniseOnEWitA"
        
        if typeIndex == 1 {
            typeKey = "GeqIhKARadioresistanceRvuWGMu"
            valueKey = "ZCHfNtdEboniseOnEWitA"
        }else if typeIndex == 2 {
            typeKey = "rbYxXzzMichiganderEldlcxZ"
            valueKey = "OdGrOVQInstrumentationGiUHstg"
        }else if typeIndex == 3 {
            typeKey = "PSAGszTConverselyEKiKyQy"
            valueKey = "ZCHfNtdEboniseOnEWitA"
        }

        for (i, item) in tileSlectorArray.enumerated() {
            let type = item[typeKey].stringValue
            let value = item[valueKey].stringValue
            
            let itemContentV = UIButton(type: .custom)
            itemContentV.touch { [weak self] in
                self?.selectNewAction(type: type)
            }
            itemContentV.frame = CGRect(x: 0, y: 50*i, width: Int(contentPanView.width), height: 50)
            itemContentV.setTitle(value, for: .normal)
            itemContentV.titleLabel?.font = .systemFont(ofSize: 14)
            contentPanView.addSubview(itemContentV)
            if type == chooseValueType {
                itemContentV.setTitleColor(.black, for: .normal)
                var offsetY = 50.0*Double(i) - 100.0
                if (offsetY + contentPanView.height) > contentPanView.contentSize.height {
                    offsetY = contentPanView.contentSize.height - contentPanView.height
                }
                if offsetY < 0 {
                    offsetY = 0
                }
                contentPanView.contentOffset = CGPoint(x: 0, y: offsetY)
                
                let topHorView = UIView(frame: CGRect(x: 15, y: itemContentV.bottom - 49, width: contentPanView.width - 30, height: 1))
                topHorView.backgroundColor = vrgba(241, 241, 241, 1)
                contentPanView.addSubview(topHorView)
                
                let bottomHorView = UIView(frame: CGRect(x: 15, y: itemContentV.bottom - 1, width: contentPanView.width - 30, height: 1))
                bottomHorView.backgroundColor = vrgba(241, 241, 241, 1)
                contentPanView.addSubview(bottomHorView)
                
            }else {
                itemContentV.setTitleColor(vrgba(150, 150, 150, 1), for: .normal)
            }
        }
    }
    
    func selectNewAction(type:String) {
        PKBottomFlatView.dismissed()
        self.chooseBack?(type)
    }

    func displayAlert() {
        PKBottomFlatView.addToFlat(infoVie: self)
    }
}


class PKTouchDateAlert: UIView {
    var chooseDateToBack:PKStingBlock?
    let grayBgSceenView = UIView()
    var chooseValueType = ""
    var topShowString = ""
    init(selectValue: String, topDesc:String) {
        super.init(frame: CGRect(x: 0, y: 0, width: width_PK_bounds, height: height_PK_bounds))
        chooseValueType = selectValue
        topShowString = topDesc
        loadShowView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadShowView() {
        grayBgSceenView.backgroundColor = .clear
        grayBgSceenView.frame = self.frame
        addSubview(grayBgSceenView)
        grayBgSceenView.touch {
            PKBottomFlatView.dismissed()
        }
        
        let mainPopView = UILabel()
        mainPopView.isUserInteractionEnabled = true
        mainPopView.backgroundColor = .white
        mainPopView.frame = CGRect(x: 0, y: self.height - 400 - safe_PK_bottom, width:width_PK_bounds, height: 400 + safe_PK_bottom)
        mainPopView.layer.cornerRadius = 16
        mainPopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addSubview(mainPopView)

        let topViewShow = UILabel(frame: CGRect(x: 15, y: 12, width: width_PK_bounds - 30, height: 44))
        topViewShow.font = .boldSystemFont(ofSize: 17)
        topViewShow.textColor = vrgba(51, 51, 51, 1)
        topViewShow.text = topShowString
        topViewShow.numberOfLines = 2
        topViewShow.textAlignment = .center
        mainPopView.addSubview(topViewShow)

        let dissMissLabel = UILabel(frame: CGRect(x: 0, y: 12, width: 96, height: 44))
        dissMissLabel.text = "Cancel"
        dissMissLabel.font = .systemFont(ofSize: 16)
        dissMissLabel.textColor = vrgba(107, 96, 121, 1)
        dissMissLabel.textAlignment = .center
        dissMissLabel.touch { [weak self] in
            PKBottomFlatView.dismissed()
        }
        mainPopView.addSubview(dissMissLabel)

        let selectDecivedeLabel = UILabel(frame: CGRect(x: width_PK_bounds - 96, y: 17, width: 80, height: 34))
        selectDecivedeLabel.backgroundColor = vrgba(191, 253, 64, 1)
        selectDecivedeLabel.text = "Confirm"
        selectDecivedeLabel.font = .systemFont(ofSize: 16)
        selectDecivedeLabel.textColor = .black
        selectDecivedeLabel.textAlignment = .center
        selectDecivedeLabel.cornerRadius = 17
        selectDecivedeLabel.touch { [weak self] in
            PKBottomFlatView.dismissed()
            self?.chooseDateToBack?(self?.chooseValueType ?? "")
        }
        mainPopView.addSubview(selectDecivedeLabel)
        
        
        let datePick = UIDatePicker(frame: CGRect(x: 0, y: 78, width: width_PK_bounds, height: 251))
        if #available(iOS 13.4, *) {
            datePick.preferredDatePickerStyle = .wheels
        }
        datePick.locale = Locale(identifier: "en-AU")
        datePick.datePickerMode = .date

        let minTime = transForBirthOrItherDataChange(inTsht: "01-01-1960", ofcaost: "dd-MM-yyyy")
        let maxTime = transForBirthOrItherDataChange(inTsht: "31-12-2040", ofcaost: "dd-MM-yyyy")
        let minDate = Date(timeIntervalSince1970: minTime)
        let maxDate = Date(timeIntervalSince1970: maxTime)
        datePick.minimumDate = minDate
        datePick.maximumDate = maxDate
        datePick.frame = CGRect(x: 15, y: 78, width: width_PK_bounds - 30, height: 251)
        datePick.addTarget(self, action: #selector(dateChooseNewItem(_:)), for: .valueChanged)

        if chooseValueType.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            chooseValueType = dateFormatter.string(from: Date())
        }

        let times = transForBirthOrItherDataChange(inTsht: chooseValueType, ofcaost: "dd-MM-yyyy")
        let selectedDate = Date(timeIntervalSince1970: TimeInterval(times))
        datePick.setDate(selectedDate, animated: true)
        mainPopView.addSubview(datePick)

        
    }
    
    @objc func dateChooseNewItem(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.string(from: datePicker.date)
        chooseValueType = date
    }
    
    func chooseDateItemWithTouch(type:String) {
        PKBottomFlatView.dismissed()
        self.chooseDateToBack?(type)
    }

    func displayAlert() {
        PKBottomFlatView.addToFlat(infoVie: self)
    }
}


class PKBottomFlatView {
    static var bgBlackpVIew = UIButton(type: .custom)
    
    static func addToFlat(infoVie:UIView) {
        dismissed()
        if Thread.isMainThread {
            createAlertView(SuypViecon: infoVie)
        }else{
            DispatchQueue.main.async {
                createAlertView(SuypViecon: infoVie)
            }
        }
        func createAlertView(SuypViecon:UIView) {
            let window = UIApplication.shared.windows.first!
            bgBlackpVIew = UIButton(frame: window.bounds)
            bgBlackpVIew.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            bgBlackpVIew.addTarget(self, action:  #selector(dismissed), for: .touchUpInside)
            window.addSubview(bgBlackpVIew)
            bgBlackpVIew.addSubview(SuypViecon)
        }
    }
    @objc static func dismissed() {
        UIView.animate(withDuration: 0.3) {
            bgBlackpVIew.alpha = 0
            bgBlackpVIew.removeFromSuperview()
        } completion: { finished in
        }
    }
}
