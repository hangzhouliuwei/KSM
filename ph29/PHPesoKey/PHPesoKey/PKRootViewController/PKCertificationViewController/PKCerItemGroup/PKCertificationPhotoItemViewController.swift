//
//  PKCertificationPhotoItemViewController.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/14.
//


class PKCertificationPhotoItemViewController :PKCertificationViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableItemDataArray = [JSON]()
    var picData = PKPhotoConfigData()
    let tableViewContainer = UITableView(frame: CGRectZero, style: .grouped)
    var isFold = true
    override func viewDidLoad() {
        super.viewDidLoad()
        pkCertificationStepImg.image = UIImage(named: "pk_auth_step3")
        showStepImage()
        pkmCreateData()
        pkCertificationNextBut.isHidden = true
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        tableViewContainer.separatorColor = .clear
        pkCertificationContentView.addSubview(tableViewContainer)
        tableViewContainer.backgroundColor = .white
        tableViewContainer.showsVerticalScrollIndicator = false
        tableViewContainer.register(UINib(nibName: "PKCertificationIdentificationtableViewCell", bundle: nil), forCellReuseIdentifier: "PKCertificationIdentificationtableViewCell")
        tableViewContainer.register(UINib(nibName: "PKCertificationBasetableViewCell", bundle: nil), forCellReuseIdentifier: "PKCertificationBasetableViewCell")
        tableViewContainer.register(UINib(nibName: "PKCertificationTexttableViewCell", bundle: nil), forCellReuseIdentifier: "PKCertificationTexttableViewCell")
    }
    
    override func pkCertificationNextClick(_ sender: Any) {
        super.pkCertificationNextClick(sender)
        
        if picData.pkResourceId.isEmpty {
            return
        }
        pkUpDataDeviceinfo()
        
        var dict:[String : Any] = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending, "CRBNyeHRoofedVdwDoDR": picData.pkResourceId]
        for itemData in tableItemDataArray {
            let pkoptKeyOhterCode = itemData["QoNjhnFBaudelaireanPgQZPQO"].intValue
            let pkvalueKeyOhterCode = itemData["RKLriwISustenanceLZTKKlk"].stringValue
            let pkcodeKeyOhterCode = itemData["XEBeCQlMariupolZsiPAoS"].stringValue
            if pkoptKeyOhterCode != 1 && pkvalueKeyOhterCode.isEmpty {
                PKToast.show("Please " + "complete the " + "certification items.")
                return
            }
            dict[pkcodeKeyOhterCode] = pkvalueKeyOhterCode
        }
        
        let trackPar : [String : Any] = [
                        "WSyPsXwCanebrakeYgMYgls": self.timeViewDidLoad,
                        "wuFALqkMinyanZwrVpyL":cerIdForLending,
                        "YHZCZRDPostmenopausalAndODGw":"24",
                        "EYKwmOjNumismaticFcLRZjO":PKLocationManager.shardManager.pklatitude,
                        "rgUNlpgXxiQcxSeRP":PKUserManager.pkGetNowTime(),
                        "TczbtsRQuagYaOfpJi":PKAppInfo.IDFV,
                        "gVHCbxOSingularizeOaDpSvj": PKLocationManager.shardManager.pklongitude
                       ]
        
        dict["point"] = trackPar
        
        PKupLoadingManager.upload.loadPost(place: "/AwzNOGlochidiaFFDjl", dict: dict, upping: true) { suc in
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
        let dict = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending];
        PKupLoadingManager.upload.loadPost(place: "/qYKJPBradshawHfzRO", dict: dict, upping: true) { suc in
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
        tableItemDataArray = res["JlFVsSQSubzoneAMQJutB"]["wxEXRPPPrudenceAHcCpFJ"].arrayValue
        
        picData.pkTypeItemDataArray = res["JlFVsSQSubzoneAMQJutB"]["ewvSGHNSixtyYTGoXbt"].arrayValue
        picData.pkResourceUrl = res["JlFVsSQSubzoneAMQJutB"]["frPFiGQHarkFDGovYI"].stringValue
        picData.pkTypeSelectedId = res["JlFVsSQSubzoneAMQJutB"]["aDfoMEsLaurelledXYuVjxM"].stringValue
        picData.pkResourceId = res["JlFVsSQSubzoneAMQJutB"]["RKLriwISustenanceLZTKKlk"].stringValue
        
        tableViewContainer.frame = pkCertificationContentView.bounds
        tableViewContainer.reloadData()
        
        if !picData.pkResourceId.isEmpty {
            pkCertificationNextBut.isHidden = false
        }
        
        if picData.pkTypeSelectedId.isEmpty {
            pkItemSelectTypeCellClick()
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableViewContainer.frame = pkCertificationContentView.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 320
        }
        return 77
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return tableItemDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = Bundle.main.loadNibNamed("PKCertificationIdentificationtableViewCell", owner: self, options: nil)?.first as? PKCertificationIdentificationtableViewCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .white
                cell.contentView.backgroundColor = .white
                cell.setupCellData(picData: picData)
                cell.pkCellClik = { value in
                    if value == 0 {
                        self.pkItemSelectTypeCellClick()
                    }else if value == 1 {
                        self.pkItemSelectSourceCellClick()
                    }
                }
                return cell
            }
        }else if indexPath.section == 1 {
            let itemData = tableItemDataArray[indexPath.row]
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
        }
        return UITableViewCell()
    }
    
    func pkItemSelectCellClick(_ indexPath: IndexPath) {
        view.endEditing(true)
        let itemData = tableItemDataArray[indexPath.row]
        let itemClickType = itemData["FXimzgpMurkDMmGSPv"].stringValue
        let list = itemData["ewvSGHNSixtyYTGoXbt"].arrayValue
        let topViewDesc = itemData["ckFFwRwEverettRLWEfVE"].stringValue
        let selectValue = itemData["RKLriwISustenanceLZTKKlk"].stringValue
        if itemClickType == pkdy {
            let infoPop = PKTouchDateAlert(selectValue: selectValue, topDesc: topViewDesc)
            infoPop.chooseDateToBack = {  str in
                self.selectType(str, indexPath)
            }
            infoPop.displayAlert()
        }else {
            let infoPop = PKTouchItemAlert(list: list, selectValue: selectValue, topDesc: topViewDesc)
            infoPop.chooseBack = {  str in
                self.selectType(str, indexPath)
            }
            infoPop.displayAlert()
        }
    }
    
    func pkItemSelectTypeCellClick() {
        if !picData.pkResourceId.isEmpty {
            return
        }
        let infoPop = PKTouchItemAlert(list: picData.pkTypeItemDataArray, selectValue: picData.pkTypeSelectedId, topDesc: "Select" + " ID Type", typeValue: 2)
        infoPop.chooseBack = {  str in
            self.selectCardType(str)
        }
        infoPop.displayAlert()
    }

    func pkItemSelectSourceCellClick() {
        if !picData.pkResourceId.isEmpty {
            return
        }
        if picData.pkTypeSelectedId.isEmpty {
            
            let infoPop = PKTouchItemAlert(list: picData.pkTypeItemDataArray, selectValue: picData.pkTypeSelectedId, topDesc: "Select" + " ID Type", typeValue: 2)
            infoPop.chooseBack = {  str in
                self.selectCardType(str)
            }
            infoPop.displayAlert()
            return
        }
        ImageSourceSelectorPage.pkUserChooseSource() { [weak self] result in
            if let image = result as? UIImage {
                self?.uploadImage(image:image)
            }
        }
    }

    func selectCardType(_ value:String) {
        picData.pkTypeSelectedId = value
        tableViewContainer.reloadData()
    }
    
    func selectType(_ value:String, _ indexPath: IndexPath) {
        var itemData = tableItemDataArray[indexPath.row]
        itemData["RKLriwISustenanceLZTKKlk"].stringValue = value
        tableItemDataArray[indexPath.row] = itemData
        tableViewContainer.reloadData()
    }
    
    func pkItemTextCellClick(_ indexPath: IndexPath, value:String) {
        var itemData = tableItemDataArray[indexPath.row]
        itemData["RKLriwISustenanceLZTKKlk"].stringValue = value
        tableItemDataArray[indexPath.row] = itemData
    }
    
    func uploadImage(image:UIImage) {
        let dic = ["light":picData.pkTypeSelectedId]
        let data = image.jpegData(compressionQuality: 0.2)
        if data == nil {
            return
        }
        PKupLoadingManager.upload.loadUpImage(place: "siWvHZygospermXznHE", dict: dic, imagData: data!) { suc in
            self.pkWithUploadResult(res: suc.runData, image: image)
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
    }
    
    func pkWithUploadResult(res:JSON, image:UIImage) {
        picData.pkResourceId = res["qsLgdmICorollaceousHrxauDQ"].stringValue
        tableItemDataArray = res["wxEXRPPPrudenceAHcCpFJ"].arrayValue
        picData.pkResourceImage = image
        tableViewContainer.reloadData()
        pkCertificationNextBut.isHidden = false
    }
}
