//
//  PKCertificationBasicItemViewController.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/14.
//


class PKCertificationBasicItemViewController :PKCertificationViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableItemDataArray = [JSON]()
    var emailTypeView = UIView()
    let tableViewContainer = UITableView(frame: CGRectZero, style: .grouped)
    var isFold = true
    override func viewDidLoad() {
        super.viewDidLoad()
        pkCertificationStepImg.image = UIImage(named: "pk_auth_step1")
        showStepImage()
        pkmCreateData()
        
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        tableViewContainer.separatorColor = .clear
        pkCertificationContentView.addSubview(tableViewContainer)
        tableViewContainer.backgroundColor = .white
        tableViewContainer.showsVerticalScrollIndicator = false
        tableViewContainer.register(UINib(nibName: "PKCertificationBasetableViewCell", bundle: nil), forCellReuseIdentifier: "PKCertificationBasetableViewCell")
        tableViewContainer.register(UINib(nibName: "PKCertificationTexttableViewCell", bundle: nil), forCellReuseIdentifier: "PKCertificationTexttableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        emailTypeView.isHidden = true
    }
    
    override func pkCertificationNextClick(_ sender: Any) {
        super.pkCertificationNextClick(sender)
        
        var dict: [String : Any] = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending]
        for sectionData in tableItemDataArray {
            let rowList = sectionData["wxEXRPPPrudenceAHcCpFJ"].arrayValue
            for rowData in rowList {
                let optional = rowData["QoNjhnFBaudelaireanPgQZPQO"].intValue
                let value = rowData["RKLriwISustenanceLZTKKlk"].stringValue
                let code = rowData["XEBeCQlMariupolZsiPAoS"].stringValue
                if optional != 1 && value.isEmpty {
                    PKToast.show("Please complete th" + "e certification items.")
                    return
                }
                dict[code] = value
            }
        }
        
        let trackPar : [String : Any] = [
                        "WSyPsXwCanebrakeYgMYgls": self.timeViewDidLoad,
                        "wuFALqkMinyanZwrVpyL":cerIdForLending,
                        "YHZCZRDPostmenopausalAndODGw":"22",
                        "EYKwmOjNumismaticFcLRZjO":PKLocationManager.shardManager.pklatitude,
                        "rgUNlpgXxiQcxSeRP":PKUserManager.pkGetNowTime(),
                        "TczbtsRQuagYaOfpJi":PKAppInfo.IDFV,
                        "gVHCbxOSingularizeOaDpSvj": PKLocationManager.shardManager.pklongitude
                       ]
        
        dict["point"] = trackPar
        
        PKupLoadingManager.upload.loadPost(place: "/IXIwPDesignateNlvoa", dict: dict, upping: true) { suc in
            self.toDeletePkPageWhenDismiss = true
            var gotoPageString = suc.runData["MjbjoWFSnippyRjwWwBz"]["excuse"].stringValue
            if gotoPageString.isEmpty {
                gotoPageString = suc.runData["frPFiGQHarkFDGovYI"].stringValue
            }
            PKCertificationViewController.judgeCerPageStepWithInfo(cerId: self.cerIdForLending, cerType: gotoPageString)
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
    }
    
    func pkmCreateData() {
        let dict = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending, "dReEmmbScienterBFlOIry":"stauistill"];
        PKupLoadingManager.upload.loadPost(place: "/uSXhJBattueXwHDz", dict: dict, upping: true) { suc in
            self.pkmConfigTableViewData(res: suc.runData)
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
    }
    
    func pkmConfigTableViewData(res:JSON) {
        timeIntValue = res["RbkPevOPhotoprotonCgYJnds"].intValue
        if timeIntValue > 0 {
            showCountTimeView()
            
        }
        tableItemDataArray = res["AVBZJOuLiberte,egalite,fraterniteWJfCSjT"].arrayValue
        
        tableViewContainer.frame = pkCertificationContentView.bounds
        tableViewContainer.reloadData()
        
        var emailY = 0
        for itemData in tableItemDataArray {
            let rowArr = itemData["wxEXRPPPrudenceAHcCpFJ"].arrayValue
            emailY = emailY + 53
            for rowData in rowArr {
                emailY = emailY + 77
                let code = rowData["XEBeCQlMariupolZsiPAoS"].stringValue
                if code == "email" {
                    emailTypeView.frame = CGRect(x: 12, y: emailY + 20, width: Int(width_PK_bounds) - 24, height: 120)
                    emailTypeView.isHidden = true
                    emailTypeView.backgroundColor = .white
                    emailTypeView.cornerRadius = 5
                    emailTypeView.layer.shadowColor = UIColor.black.cgColor
                    emailTypeView.layer.shadowOpacity = 0.1
                    emailTypeView.layer.shadowOffset = CGSize(width: 5, height: 5)
                    emailTypeView.layer.shadowRadius = 5
                    emailTypeView.layer.masksToBounds = false
                    self.tableViewContainer.addSubview(emailTypeView)
                    break
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableViewContainer.frame = pkCertificationContentView.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableItemDataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: width_PK_bounds, height: 53))
            header.backgroundColor = .white
            
            let verline = UIImageView(frame: CGRect(x: 12, y: 23, width: 3, height: 14))
            verline.image = UIImage(named: "pk_auth_labIcon")
            header.addSubview(verline)
            
            let title = UILabel(frame: CGRect(x: 21, y: 20, width: 200, height: 20))
            title.textColor = vrgba(34, 34, 34, 1)
            title.font = UIFont.boldSystemFont(ofSize: 14)
            title.textAlignment = .left
            title.text = "Optional"
            title.sizeToFit()
            title.height = 20
            header.addSubview(title)
            
            let titleRightArrow =  UIButton(frame: CGRect(x: title.right, y: 20, width: 20, height: 20))
            titleRightArrow.setImage(UIImage(named: isFold ? "pk_auth_optionalArrow" : "pk_auth_optionalArrowup"), for: .normal)
            header.addSubview(titleRightArrow)
            
            let rightTips = UILabel(frame: CGRect(x: 12, y: 20, width: width_PK_bounds - 24, height: 20))
            rightTips.textColor = vrgba(136, 136, 136, 1)
            rightTips.font = UIFont.systemFont(ofSize: 12)
            rightTips.textAlignment = .right
            rightTips.text = tableItemDataArray[section]["sub_title"].stringValue
            rightTips.height = 20
            rightTips.touch {
                self.isFold = !self.isFold
                self.tableViewContainer.reloadData()
            }
            header.addSubview(rightTips)

            return header
        }
        let header = UIView(frame: CGRect(x: 0, y: 0, width: width_PK_bounds, height: 53))
        header.backgroundColor = .white
        
        let verline = UIImageView(frame: CGRect(x: 12, y: 23, width: 3, height: 14))
        verline.image = UIImage(named: "pk_auth_labIcon")
        header.addSubview(verline)
        
        let title = UILabel(frame: CGRect(x: 21, y: 20, width: 200, height: 20))
        title.textColor = vrgba(34, 34, 34, 1)
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textAlignment = .left
        title.text = tableItemDataArray[section]["ckFFwRwEverettRLWEfVE"].stringValue
        header.addSubview(title)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 && isFold {
            return 0
        }
        return 77
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = tableItemDataArray[section]["wxEXRPPPrudenceAHcCpFJ"].arrayValue
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemData = tableItemDataArray[indexPath.section]["wxEXRPPPrudenceAHcCpFJ"][indexPath.row]
        let itemClickType = itemData["FXimzgpMurkDMmGSPv"].stringValue
        if itemClickType == pktx {
            if let cell = Bundle.main.loadNibNamed("PKCertificationTexttableViewCell", owner: self, options: nil)?.first as? PKCertificationTexttableViewCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .white
                cell.contentView.backgroundColor = .white
                cell.setupCellData(cellInfo: itemData)
                cell.pkCellBlock = { value in
                    self.pkItemTextCellClick(indexPath, value: value)
                }
                let code = itemData["XEBeCQlMariupolZsiPAoS"].stringValue
                if code == "email" {
                    cell.emailTypeView = emailTypeView
                    cell.pkScrollowBlock = {
                        self.tableViewContainer.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
                return cell
            }
        }else {
            if let cell = Bundle.main.loadNibNamed("PKCertificationBasetableViewCell", owner: self, options: nil)?.first as? PKCertificationBasetableViewCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .white
                cell.contentView.backgroundColor = .white
                cell.setupCellData(cellInfo: itemData)
                cell.pkCellBlock = {
                    self.pkItemSelectCellClick(indexPath)
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func pkItemSelectCellClick(_ indexPath: IndexPath) {
        view.endEditing(true)
        let itemData = tableItemDataArray[indexPath.section]["wxEXRPPPrudenceAHcCpFJ"][indexPath.row]
        let itemClickType = itemData["FXimzgpMurkDMmGSPv"].stringValue
        let list = itemData["ewvSGHNSixtyYTGoXbt"].arrayValue
        let topViewDesc = itemData["ckFFwRwEverettRLWEfVE"].stringValue
        let selectValue = itemData["RKLriwISustenanceLZTKKlk"].stringValue
        if itemClickType == pkeum {
            let infoPop = PKTouchItemAlert(list: list, selectValue: selectValue, topDesc: topViewDesc)
            infoPop.chooseBack = {  str in
                self.selectType(str, indexPath)
            }
            infoPop.displayAlert()
        }else if itemClickType == pkdy {
            let infoPop = PKTouchDateAlert(selectValue: selectValue, topDesc: topViewDesc)
            infoPop.chooseDateToBack = {  str in
                self.selectType(str, indexPath)
            }
            infoPop.displayAlert()
        }
    }
    
    func selectType(_ value:String, _ indexPath: IndexPath) {
        var itemData = tableItemDataArray[indexPath.section]["wxEXRPPPrudenceAHcCpFJ"][indexPath.row]
        itemData["RKLriwISustenanceLZTKKlk"].stringValue = value
        tableItemDataArray[indexPath.section]["wxEXRPPPrudenceAHcCpFJ"][indexPath.row] = itemData
        tableViewContainer.reloadData()
        
        checkNextCerSelector(indexPath)
    }
    
    func checkNextCerSelector(_ indexPath: IndexPath) {
        
        let currentSection = indexPath.section
        let currentRow = indexPath.row
        var nextPath: IndexPath?

        if (currentRow + 1) < tableViewContainer.numberOfRows(inSection: currentSection) {
            nextPath = IndexPath(row: currentRow + 1, section: currentSection)
        } else {
            nextPath = IndexPath(row: 0, section: currentSection + 1)
        }

        if (currentSection + 1) < tableViewContainer.numberOfSections, tableViewContainer.numberOfRows(inSection: currentSection) > 0 {
            let nextData = tableItemDataArray[nextPath!.section]["wxEXRPPPrudenceAHcCpFJ"][nextPath!.row]
            let nextValue = nextData["RKLriwISustenanceLZTKKlk"].stringValue
            if !nextValue.isEmpty {
                return
            }
            if let cell = tableViewContainer.cellForRow(at: nextPath!) as? PKCertificationBasetableViewCell {
                cell.cellLabClick(cell.cellTitleLab as Any)
                tableViewContainer.scrollToRow(at: nextPath!, at: .top, animated: true)
            }
        }
    }
    
    func pkItemTextCellClick(_ indexPath: IndexPath, value:String) {
        var itemData = tableItemDataArray[indexPath.section]["wxEXRPPPrudenceAHcCpFJ"][indexPath.row]
        itemData["RKLriwISustenanceLZTKKlk"].stringValue = value
        tableItemDataArray[indexPath.section]["wxEXRPPPrudenceAHcCpFJ"][indexPath.row] = itemData
    }
    
}
