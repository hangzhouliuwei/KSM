//
//  PKCertificationContactItemViewController.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/14.
//


class PKCertificationContactItemViewController :PKCertificationViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableItemDataArray = [JSON]()
    let tableViewContainer = UITableView(frame: CGRectZero, style: .grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        pkCertificationStepImg.image = UIImage(named: "pk_auth_step2")
        showStepImage()
        pkmCreateData()
        
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        tableViewContainer.separatorColor = .clear
        pkCertificationContentView.addSubview(tableViewContainer)
        tableViewContainer.backgroundColor = .white
        tableViewContainer.showsVerticalScrollIndicator = false
        tableViewContainer.register(UINib(nibName: "PKCertificationContactableViewCell", bundle: nil), forCellReuseIdentifier: "PKCertificationContactableViewCell")
    }
    
    override func pkCertificationNextClick(_ sender: Any) {
        super.pkCertificationNextClick(sender)
        
        var dict: [String : Any] = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending]
        for itemData in tableItemDataArray {
            let userMing = itemData["KaqiIPtIntrapsychicFAZZTnx"]["ZCHfNtdEboniseOnEWitA"].stringValue
            let telNumber = itemData["KaqiIPtIntrapsychicFAZZTnx"]["cvIYGHjDoorkeeperTQWCMJQ"].stringValue
            let relationValueId = itemData["KaqiIPtIntrapsychicFAZZTnx"]["JifnYPwAffineTLZCEyt"].stringValue
            
            if userMing.isEmpty || telNumber.isEmpty || relationValueId.isEmpty {
                PKToast.show("Please complete" + " the contact " + "person selection.")
                return
            }
            let codeArr = itemData["NPpQQarPrototherianKnfekEQ"].arrayValue
            if codeArr.count < 3 {
                return
            }

            let userKey = codeArr[0]["ZCHfNtdEboniseOnEWitA"].stringValue
            let telKey = codeArr[1]["ZCHfNtdEboniseOnEWitA"].stringValue
            let codeKey = codeArr[2]["ZCHfNtdEboniseOnEWitA"].stringValue
            
            dict[userKey] = userMing
            dict[telKey] = telNumber
            dict[codeKey] = relationValueId
        }

        
        let trackPar : [String : Any] = [
                        "WSyPsXwCanebrakeYgMYgls": self.timeViewDidLoad,
                        "wuFALqkMinyanZwrVpyL":cerIdForLending,
                        "YHZCZRDPostmenopausalAndODGw":"23",
                        "EYKwmOjNumismaticFcLRZjO":PKLocationManager.shardManager.pklatitude,
                        "rgUNlpgXxiQcxSeRP":PKUserManager.pkGetNowTime(),
                        "TczbtsRQuagYaOfpJi":PKAppInfo.IDFV,
                        "gVHCbxOSingularizeOaDpSvj": PKLocationManager.shardManager.pklongitude
                       ]
        
        dict["point"] = trackPar
        
        PKupLoadingManager.upload.loadPost(place: "/AapYxTellurizeOlZkW", dict: dict, upping: true) { suc in
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
        let dict = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending, "uVrqgPOCystocarpPOqcMfQ":"blaalleynk"];
        PKupLoadingManager.upload.loadPost(place: "/NPfSmOffendREzJT", dict: dict, upping: true) { suc in
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

    }
    
    override func viewDidLayoutSubviews() {
        tableViewContainer.frame = pkCertificationContentView.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 266
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItemDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemData = tableItemDataArray[indexPath.row]
        if let cell = Bundle.main.loadNibNamed("PKCertificationContactableViewCell", owner: self, options: nil)?.first as? PKCertificationContactableViewCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            cell.contentView.backgroundColor = .white
            cell.setupCellData(cellInfo: itemData)
            cell.pkCellBlock = { item in
                self.pkItemSelectCellClick(indexPath, item: item)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func pkItemSelectCellClick(_ indexPath: IndexPath, item:JSON) {
        tableItemDataArray[indexPath.row] = item
        tableViewContainer.reloadData()
    }
}
