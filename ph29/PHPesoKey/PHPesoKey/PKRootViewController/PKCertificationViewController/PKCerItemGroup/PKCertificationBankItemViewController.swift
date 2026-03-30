//
//  PKCertificationBankItemViewController.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/14.
//


class PKCertificationBankItemViewController :PKCertificationViewController {
    
    let epkbankIsRealCardView = EInfoView()
    let bpkbankIsRealCardView = BInfoView()
    var epkbankIsRealCardInfoList = [JSON]()
    var bpkbankIsRealCardInfoList = [JSON]()
    let topCornersBackRudisView = UIView()
    let vblack = vrgba(34, 34, 34, 1)
    let vgray = vrgba(136, 136, 136, 1)
    let etabbleCliclBarLabel = UILabel()
    let btabbleCliclBarLabel = UILabel()
    let mtabbleCliclBarline = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        pkmCreateData()
    }
    
    override func pkCertificationNextClick(_ sender: Any) {
        var dict = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending];
        
        var             pkBaseParamertypeName = ""
        if !epkbankIsRealCardView.isHidden {
            if epkbankIsRealCardView.selectType.isEmpty {
                PKToast.show("Please select E-wallet")
                return
            }
            let pkBaseParameraccount = epkbankIsRealCardView.acceModeInfoShowText.text ?? ""
            if pkBaseParameraccount.isEmpty {
                PKToast.show("Please enter E-wallet Account")
                return
            }
            if let firstChar = pkBaseParameraccount.first, firstChar == "0" {
                dict["MPWOUYuWepDJQrURb"] = pkBaseParameraccount
            } else {
                dict["MPWOUYuWepDJQrURb"] = "0" + pkBaseParameraccount
            }
            dict["VdPbSxNPerosisIyEqCbw"] = epkbankIsRealCardView.selectType
            dict["rbYxXzzMichiganderEldlcxZ"] = "2"
            
            pkBaseParamertypeName = epkbankIsRealCardView.typeName
        }
        if !bpkbankIsRealCardView.isHidden {
            if bpkbankIsRealCardView.selectType.isEmpty {
                PKToast.show("Please select Bank")
                return
            }
            let pkBaseParamerAccount = bpkbankIsRealCardView.accbModeInfoDisplayText.text ?? ""
            if pkBaseParamerAccount.isEmpty {
                PKToast.show("Please enter Bank Account")
                return
            }
            dict["MPWOUYuWepDJQrURb"] = pkBaseParamerAccount
            dict["VdPbSxNPerosisIyEqCbw"] = bpkbankIsRealCardView.selectType
            dict["rbYxXzzMichiganderEldlcxZ"] = "1"
            
            pkBaseParamertypeName = bpkbankIsRealCardView.typeName
        }
        
        let pkRejectPopalert = UIView(frame: CGRect(x: 0, y: 0, width: 284, height: 338))
        pkRejectPopalert.centerX = width_PK_bounds/2
        pkRejectPopalert.centerY = height_PK_bounds/2
        pkRejectPopalert.cornerRadius = 10
        pkRejectPopalert.backgroundColor = .white
        
        let pkRejectPopimage = UIImageView(frame: CGRect(x:0, y: 0, width: pkRejectPopalert.width, height: 110))
        pkRejectPopimage.image = UIImage(named: "pk_alert_topBg")
        pkRejectPopalert.addSubview(pkRejectPopimage)
        
        let pkRejectPoptitle = UILabel(frame: CGRect(x: 12, y: 0, width: pkRejectPopimage.width - 24, height: pkRejectPopimage.height))
        pkRejectPoptitle.textColor = vblack
        pkRejectPoptitle.font = .boldSystemFont(ofSize: 14)
        pkRejectPoptitle.text = "Please confirm your withdrawal account information belongs to yourself and is correct"
        pkRejectPoptitle.numberOfLines = 0
        pkRejectPoptitle.textAlignment = .center
        pkRejectPopimage.addSubview(pkRejectPoptitle)

        let toppkRejectPopDesc = UILabel(frame: CGRect(x: 12, y: 104, width: pkRejectPopalert.width - 24, height: 19))
        toppkRejectPopDesc.textColor = vblack
        toppkRejectPopDesc.font = .systemFont(ofSize: 13)
        toppkRejectPopDesc.text = "Channel/Bank"
        toppkRejectPopDesc.numberOfLines = 0
        pkRejectPopalert.addSubview(toppkRejectPopDesc)
        
        let typepkRejectPopText = UITextField()
        typepkRejectPopText.frame = CGRect(x: 12, y: toppkRejectPopDesc.bottom + 8, width: pkRejectPopalert.width - 24, height: 36)
        typepkRejectPopText.text =             pkBaseParamertypeName
        typepkRejectPopText.textColor = vblack
        typepkRejectPopText.backgroundColor = vrgba(242, 242, 242, 1)
        typepkRejectPopText.font = .systemFont(ofSize: 13)
        typepkRejectPopText.cornerRadius = 4
        typepkRejectPopText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 32))
        typepkRejectPopText.leftViewMode = .always
        typepkRejectPopText.clearButtonMode = .never
        typepkRejectPopText.isEnabled = false
        pkRejectPopalert.addSubview(typepkRejectPopText)
        
        let botpkRejectPopDesc = UILabel(frame: CGRect(x: 12, y: typepkRejectPopText.bottom + 20, width: pkRejectPopalert.width - 32, height: 19))
        botpkRejectPopDesc.textColor = vblack
        botpkRejectPopDesc.font = .systemFont(ofSize: 13)
        botpkRejectPopDesc.text = "Account number"
        botpkRejectPopDesc.numberOfLines = 0
        pkRejectPopalert.addSubview(botpkRejectPopDesc)
        
        let valuepkRejectPopText = UITextField()
        valuepkRejectPopText.frame = CGRect(x: 16, y: botpkRejectPopDesc.bottom + 6, width: pkRejectPopalert.width - 32, height: 36)
        valuepkRejectPopText.text = dict["MPWOUYuWepDJQrURb"]
        valuepkRejectPopText.textColor = .black
        valuepkRejectPopText.backgroundColor = vrgba(242, 242, 242, 1)
        valuepkRejectPopText.font = .systemFont(ofSize: 13)
        valuepkRejectPopText.cornerRadius = 4
        valuepkRejectPopText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 32))
        valuepkRejectPopText.leftViewMode = .always
        valuepkRejectPopText.clearButtonMode = .never
        valuepkRejectPopText.isEnabled = false
        pkRejectPopalert.addSubview(valuepkRejectPopText)
        
        let lpkRejectPopBtn = UIButton(type: .custom)
        lpkRejectPopBtn.titleLabel?.font = .systemFont(ofSize: 14)
        lpkRejectPopBtn.backgroundColor = .white
        lpkRejectPopBtn.frame = CGRect(x: 16, y: valuepkRejectPopText.bottom + 20, width: (pkRejectPopalert.width - 48)/2, height: 40)
        lpkRejectPopBtn.setTitle("Cancel", for: .normal)
        lpkRejectPopBtn.setTitleColor(.black, for: .normal)
        lpkRejectPopBtn.cornerRadius = 20
        lpkRejectPopBtn.layer.borderColor = vrgba(222, 222, 222, 1).cgColor
        lpkRejectPopBtn.layer.borderWidth = 1
        pkRejectPopalert.addSubview(lpkRejectPopBtn)
        lpkRejectPopBtn.touch {
            PKBottomFlatView.dismissed()
        }
        
        let rpkRejectPopBtn = UIButton(type: .custom)
        rpkRejectPopBtn.titleLabel?.font = .systemFont(ofSize: 14)
        rpkRejectPopBtn.backgroundColor = vrgba(191, 253, 64, 1)
        rpkRejectPopBtn.frame = CGRect(x: 16 + lpkRejectPopBtn.right, y: valuepkRejectPopText.bottom + 20, width: (pkRejectPopalert.width - 48)/2, height: 40)
        rpkRejectPopBtn.setTitle("Confirm", for: .normal)
        rpkRejectPopBtn.setTitleColor(vblack, for: .normal)
        rpkRejectPopBtn.cornerRadius = 20
        pkRejectPopalert.addSubview(rpkRejectPopBtn)
        rpkRejectPopBtn.touch { [weak self] in
            PKBottomFlatView.dismissed()
            self?.saveTowModesInfoDisplayData(dict)
        }

        PKBottomFlatView.addToFlat(infoVie: pkRejectPopalert)

    }
    
    func saveTowModesInfoDisplayData(_ dic:[String: Any]) {
        var dict:[String : Any] = dic
        let trackPar : [String : Any] = [
                        "WSyPsXwCanebrakeYgMYgls": self.timeViewDidLoad,
                        "wuFALqkMinyanZwrVpyL":cerIdForLending,
                        "YHZCZRDPostmenopausalAndODGw":"26",
                        "EYKwmOjNumismaticFcLRZjO":PKLocationManager.shardManager.pklatitude,
                        "rgUNlpgXxiQcxSeRP":PKUserManager.pkGetNowTime(),
                        "TczbtsRQuagYaOfpJi":PKAppInfo.IDFV,
                        "gVHCbxOSingularizeOaDpSvj": PKLocationManager.shardManager.pklongitude
                       ]
        
        dict["point"] = trackPar
        
        PKupLoadingManager.upload.loadPost(place: "/fnTZUDiatribeYPSLJ", dict: dict, upping: true) { suc in
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
        PKupLoadingManager.upload.loadPost(place: "/mwieGUrgeSJkWc", dict: dict, upping: true) { suc in
            self.pkmConfigTableViewData(res: suc.runData)
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
    }
    
    func pkmConfigTableViewData(res:JSON) {
        timeIntValue = res["RbkPevOPhotoprotonCgYJnds"].intValue
        timeIntValue = 10
        if timeIntValue > 0 {
            showCountTimeView()
            
        }
        self.bpkbankIsRealCardInfoList = res["jZQUaNiLabyrinthectomyNNQobfr"]["cwvMkTVReflectiveICqprBN"].arrayValue
        self.epkbankIsRealCardInfoList = res["JXWlZvFMillisecondClZxlgb"]["cwvMkTVReflectiveICqprBN"].arrayValue
        refreshUI()
    }
    
    func refreshUI() {
        
        topCornersBackRudisView.frame = CGRect(x: 12, y: 0, width: width_PK_bounds - 24, height: 80)
        topCornersBackRudisView.backgroundColor = .white
        pkCertificationContentView.addSubview(topCornersBackRudisView)
        
        etabbleCliclBarLabel.frame = CGRect(x: 0, y: 10, width: topCornersBackRudisView.width/2, height: 60)
        etabbleCliclBarLabel.textColor = vblack
        etabbleCliclBarLabel.font = UIFont.systemFont(ofSize: 14)
        etabbleCliclBarLabel.textAlignment = .center
        etabbleCliclBarLabel.text = "E-Wallet"
        topCornersBackRudisView.addSubview(etabbleCliclBarLabel)
        etabbleCliclBarLabel.touch { [weak self] in
            self?.eAboutWalletAndSomeOhtersAction()
        }
        
        btabbleCliclBarLabel.frame = CGRect(x: topCornersBackRudisView.width/2, y: 10, width: topCornersBackRudisView.width/2, height: 60)
        btabbleCliclBarLabel.textColor = vblack
        btabbleCliclBarLabel.font = UIFont.systemFont(ofSize: 14)
        btabbleCliclBarLabel.textAlignment = .center
        btabbleCliclBarLabel.text = "Bank"
        topCornersBackRudisView.addSubview(btabbleCliclBarLabel)
        btabbleCliclBarLabel.touch { [weak self] in
            self?.bAboutCardAndSomeOhtersAction()
        }
        
        mtabbleCliclBarline.frame = CGRect(x: 0, y: 55, width: 40, height: 6)
        mtabbleCliclBarline.centerX = etabbleCliclBarLabel.centerX
        mtabbleCliclBarline.cornerRadius = 2
        mtabbleCliclBarline.backgroundColor = vrgba(191, 253, 64, 1)
        topCornersBackRudisView.addSubview(mtabbleCliclBarline)

        epkbankIsRealCardView.frame = CGRect(x: 12, y: 80, width: pkCertificationContentView.width - 24, height: 0)
        epkbankIsRealCardView.config(list: epkbankIsRealCardInfoList)
        pkCertificationContentView.addSubview(epkbankIsRealCardView)
        
        topCornersBackRudisView.height = epkbankIsRealCardView.bottom + 40
        topCornersBackRudisView.cornerRadius = 12
        
        bpkbankIsRealCardView.frame = CGRect(x: 12, y: 80, width: pkCertificationContentView.width - 24, height: 0)
        bpkbankIsRealCardView.config(list: bpkbankIsRealCardInfoList)
        bpkbankIsRealCardView.isHidden = true
        pkCertificationContentView.addSubview(bpkbankIsRealCardView)
    }
    
    func eAboutWalletAndSomeOhtersAction() {
        etabbleCliclBarLabel.font = .boldSystemFont(ofSize: 14)
        btabbleCliclBarLabel.font = .systemFont(ofSize: 14)
        epkbankIsRealCardView.isHidden = false
        bpkbankIsRealCardView.isHidden = true
        topCornersBackRudisView.height = epkbankIsRealCardView.bottom + 40
        
        UIView.animate(withDuration: 0.3) {
            self.mtabbleCliclBarline.centerX = self.etabbleCliclBarLabel.centerX
        }
    }
    
    func bAboutCardAndSomeOhtersAction() {
        btabbleCliclBarLabel.font = .boldSystemFont(ofSize: 14)
        etabbleCliclBarLabel.font = .systemFont(ofSize: 14)
        bpkbankIsRealCardView.isHidden = false
        epkbankIsRealCardView.isHidden = true
        topCornersBackRudisView.height = bpkbankIsRealCardView.bottom + 40
        
        UIView.animate(withDuration: 0.3) {
            self.mtabbleCliclBarline.centerX = self.btabbleCliclBarLabel.centerX
        }
    }


   
}
