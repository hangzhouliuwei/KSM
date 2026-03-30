//
//  PKPersonalViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit

class PKPersonalViewController: UIViewController {

    @IBOutlet weak var pkPersonalTabview: UITableView!
    
    var pkPersonalDataArr:[JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        pkPersonalTabview.dataSource = self
        pkPersonalTabview.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if PKUserManager.pkisLogin(){
            loadNewPkMine()
        }
        
    }
    
    
    func loadNewPkMine(){
        PKupLoadingManager.upload.loadGet(place: "/bYgtuSelectivityVfCkD") {[weak self] suc in
            guard let self = self else { return }
            //print("lw======>个人中心",suc.runData)
            self.handlePersonalData(dataArr: suc.runData["doLRvRaEatageFQarhcu"].arrayValue)
            if pKCheckString(with: suc.runData["YjLoQjTReparationsCwKJXRE"]["paJSPLtLignosulphonateKsCkIAM"].stringValue){
                self.pkPersonalTabview.tableHeaderView = certTableHeaderView(model: suc.runData["YjLoQjTReparationsCwKJXRE"])
            }else{
                self.pkPersonalTabview.tableHeaderView = nil
            }
           
        } failed: { errorMsg in
            
        }
        
    }
    
    func handlePersonalData(dataArr:[JSON]){
        var dataTbleViewArr = dataArr
        
        dataTbleViewArr = dataTbleViewArr.enumerated().map { (index, itemModel) in
            var jsonModel = itemModel
            jsonModel["itemType"] = "itemCell"
            jsonModel["itemH"] = 62
            if index == 0{
                jsonModel["fistItem"] = true
            }else if index == dataTbleViewArr.count - 1 {
                jsonModel["lastItem"] = true
            }else{
                jsonModel["fistItem"] = false
                jsonModel["lastItem"] = false
            }
            return jsonModel
        }
        
        var placeholderModel = JSON()
        placeholderModel["itemType"] = "placeholderCell"
        placeholderModel["itemH"] = 38
        dataTbleViewArr.insert(placeholderModel, at: 3)
        
        self.pkPersonalDataArr = dataTbleViewArr
        self.pkPersonalTabview.reloadData()
    }
    
    
    func certTableHeaderView(model: JSON) -> UIView{
       let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width_PK_bounds,height: 174))
        headerView.backgroundColor = .clear
        
       headerView.touch { [weak self]  in
           guard let self = self else { return }
           self.pkgotoWebView(webUrl: model["frPFiGQHarkFDGovYI"].stringValue)
       }
       
       let headerBackView = UIView()
       headerBackView.backgroundColor = .white
       headerBackView.layer.cornerRadius = 8
       headerBackView.clipsToBounds = true
       headerView.addSubview(headerBackView)
       headerBackView.snp.makeConstraints { make in
           make.top.equalTo(0)
           make.left.equalTo(0)
           make.right.equalTo(0)
           make.height.equalTo(160)
       }
       
       
       let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width:width_PK_bounds - 24, height: 54)
        gradientLayer.colors = [
           UIColor.init(hex: "#FE7A18",alpha: 0.8)?.cgColor ?? "##FE7A18",
           UIColor.init(hex: "#FFFFFF")?.cgColor ?? "#FFFFFF",
       ]
       gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
       gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
       headerBackView.layer.insertSublayer(gradientLayer, at: 0)
       
       let overduePaymentLabel = UILabel()
       overduePaymentLabel.text = "Overdue payment"
       overduePaymentLabel.textColor = .white
       overduePaymentLabel.font = .systemFont(ofSize: 12, weight: .semibold)
       overduePaymentLabel.backgroundColor = UIColor.init(hex: "#FE3232")
       overduePaymentLabel.textAlignment = .center
       overduePaymentLabel.layer.cornerRadius = 10
       overduePaymentLabel.clipsToBounds = true
       overduePaymentLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
       headerBackView.addSubview(overduePaymentLabel)
       overduePaymentLabel.snp.makeConstraints { make in
           make.right.top.equalToSuperview().offset(0)
           make.height.equalTo(20)
           make.width.equalTo(124)
       }
       
       
       let paJSPLtLignosulphonateKsCkIAMImageView = UIImageView()
       paJSPLtLignosulphonateKsCkIAMImageView.layer.cornerRadius = 2
       headerBackView.addSubview(paJSPLtLignosulphonateKsCkIAMImageView)
       paJSPLtLignosulphonateKsCkIAMImageView.snp.makeConstraints { make in
           make.top.equalTo(36)
           make.left.equalTo(20)
           make.width.height.equalTo(22)
       }
       
       paJSPLtLignosulphonateKsCkIAMImageView.kf.setImage(with: URL(string: model["paJSPLtLignosulphonateKsCkIAM"].stringValue))
       
       let pOKLjAyKhalkhasJpttneqLabel = UILabel()
       pOKLjAyKhalkhasJpttneqLabel.font = .boldSystemFont(ofSize: 14)
       pOKLjAyKhalkhasJpttneqLabel.textColor = UIColor.init(hex: "#222222")
       pOKLjAyKhalkhasJpttneqLabel.text = model["pOKLjAyKhalkhasJpttneq"].stringValue
       headerBackView.addSubview(pOKLjAyKhalkhasJpttneqLabel)
       pOKLjAyKhalkhasJpttneqLabel.snp.makeConstraints { make in
           make.centerY.equalTo(paJSPLtLignosulphonateKsCkIAMImageView.snp.centerY)
           make.left.equalTo(paJSPLtLignosulphonateKsCkIAMImageView.snp.right).offset(8)
           make.height.equalTo(16)
       }
       
       
       let vknbDuLCaseophileHlXqudILabel = UILabel()
       vknbDuLCaseophileHlXqudILabel.font = .systemFont(ofSize: 30, weight: .heavy)
       vknbDuLCaseophileHlXqudILabel.textColor = UIColor.init(hex: "#FF6600")
       vknbDuLCaseophileHlXqudILabel.text = model["vknbDuLCaseophileHlXqudI"].stringValue
       headerBackView.addSubview(vknbDuLCaseophileHlXqudILabel)
       vknbDuLCaseophileHlXqudILabel.snp.makeConstraints { make in
           make.left.equalTo(20)
           make.top.equalTo(paJSPLtLignosulphonateKsCkIAMImageView.snp.bottom).offset(30)
           make.height.equalTo(32)
       }
       
       let unrANMEDoxographerZvBpFCaLabel = UILabel()
       unrANMEDoxographerZvBpFCaLabel.textColor = UIColor.init(hex: "#888888")
       unrANMEDoxographerZvBpFCaLabel.font = .systemFont(ofSize: 12)
       unrANMEDoxographerZvBpFCaLabel.text = model["unrANMEDoxographerZvBpFCa"].stringValue
       headerBackView.addSubview(unrANMEDoxographerZvBpFCaLabel)
       unrANMEDoxographerZvBpFCaLabel.snp.makeConstraints { make in
           make.leading.equalTo(vknbDuLCaseophileHlXqudILabel.snp.leading)
           make.top.equalTo(vknbDuLCaseophileHlXqudILabel.snp.bottom).offset(4)
           make.height.equalTo(14)
       }
       
       
       let refundBtn = UIButton(type: .custom)
       refundBtn.isUserInteractionEnabled = false
       refundBtn.backgroundColor = UIColor.init(hex: "#BFFD40")
       refundBtn.titleLabel?.font = .systemFont(ofSize: 16)
       refundBtn.setTitle("Refund", for: .normal)
       refundBtn.setTitleColor(UIColor.init(hex: "#191919"), for: .normal)
       refundBtn.layer.cornerRadius = 23
       refundBtn.clipsToBounds = true
       headerBackView.addSubview(refundBtn)
       refundBtn.snp.makeConstraints { make in
           make.top.equalTo(pOKLjAyKhalkhasJpttneqLabel.snp.bottom).offset(30)
           make.right.equalTo(-20)
           make.size.equalTo(CGSize(width: 98, height: 46))
       }
        
       
       return headerView
   }

    
    //MARK: - pkgotoWebView
    func pkgotoWebView(webUrl: String){
        if pKCheckString(with: webUrl){
            let webVC = PKWebkitViewController()
            webVC.pkWebUrlStr = webUrl
            navigationController?.pushViewController(webVC, animated: true)
        }
        
    }
    
}

extension PKPersonalViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pkPersonalDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let  itemModel = self.pkPersonalDataArr[indexPath.row]
        if itemModel["itemType"].stringValue  == "placeholderCell"{
            let placeholderItem = tableView.dequeueReusableCell(withIdentifier: itemModel["itemType"].stringValue) as? PKPersonalPlaceholderCell ?? PKPersonalPlaceholderCell(style: .default, reuseIdentifier: itemModel["itemType"].stringValue)
            return placeholderItem
        }
        
        
        
        let pkPersonalTableViewItem = UINib(nibName: "PKPersonalTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as! PKPersonalTableViewCell
        pkPersonalTableViewItem.configPKPersonalTableViewCellModel(itmeModel: itemModel)
        pkPersonalTableViewItem.personalTableViewCellClickBlock = {[weak self] webUrl in
            guard let self = self else { return }
            self.pkgotoWebView(webUrl: webUrl)
        }
        return pkPersonalTableViewItem

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.pkPersonalDataArr[indexPath.row]
        return CGFloat(model["itemH"].floatValue)
    }
}
