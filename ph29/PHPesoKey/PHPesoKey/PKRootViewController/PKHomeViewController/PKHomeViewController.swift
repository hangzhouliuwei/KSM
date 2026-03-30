//
//  PKHomeViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit
import IQKeyboardManagerSwift

var sionView = PKHomeViewControllerSionView.shared

class PKHomeViewController: UIViewController {

    @IBOutlet weak var homeTbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.resignOnTouchOutside = true
        cretPKHomeBigCardTableViewCellBackground()
        homeTbView.backgroundColor = .clear
        homeTbView.dataSource = self
        homeTbView.delegate = self
        
        homeTbView.snp.remakeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(-(safe_PK_bottom + 60 * PK_Scale))
        }
        
        
        view.addSubview(topView)
        NotificationCenter.default.addObserver(self, selector: #selector(homeLoading), name: NSNotification.Name("loadingSuccess"), object: nil)
        if PKUserManager.pkisLogin(){
            getPopPKHomeViewControllerViewData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            sionView.frame = CGRect(x: width_PK_bounds - 60, y: safe_PK_top, width: 40, height: 36)
            UIApplication.shared.windows.first?.addSubview(sionView)
            sionView.isHidden = true
        }
//        let btn = UIButton()
//        btn.backgroundColor = UIColor.init(hex: "#000000")
//        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
//        view.addSubview(btn)
//        btn.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.height.equalTo(60)
//        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeLoading()
    }
    
    func cretPKHomeBigCardTableViewCellBackground() {
            let gradientLayer = CAGradientLayer()
             gradientLayer.frame = CGRect(x: 0, y: 0, width:width_PK_bounds, height: 294)
             gradientLayer.colors = [
                UIColor.init(hex: "#D1D6FF")?.cgColor ?? "#D1D6FF",
                UIColor.init(hex: "#9DF1FF")?.cgColor ?? "#9DF1FF",
                UIColor.init(hex: "#9DF1FF",alpha: 0.5)?.cgColor ?? "#9DF1FF",
                UIColor.init(hex: "#9DF1FF",alpha: 0.1)?.cgColor ?? "#9DF1FF",
            ]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            self.view.layer.insertSublayer(gradientLayer, at: 0)
        }
    
    @objc func btnClick(){
//        PKToast.show("Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!")
//        PKUserManager.goLogin()
        
        let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController
        let vc = PKCertificationBasicItemViewController()
        vc.sortIndex = 0
        vc.cerIdForLending = "1"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func homeLoading() {
        homeHandle.getPKHomePageModel {[weak self] result, isPKShowSmallCard in
            guard let self = self else { return }
            if(result){
                self.homeTbView.reloadData()
                self.pkhomeKefuTipImageView.isHidden = isPKShowSmallCard
            }
        } sionViewData: {[weak self] result in
            guard let self = self else { return }
            if PKUserManager.pkisLogin() && pKCheckString(with: result["WLOXErIPungleOdxNTdW"].stringValue){
                sionView.sioniocnImgView.kf.setImage(with: URL(string: result["WLOXErIPungleOdxNTdW"].stringValue),placeholder: UIImage(named: "pk_home_sionViewBack")) { result in
                    switch result {
                          case .success(let value):
                           sionView.isHidden = false
                           sionView.sioniocnImgView.image = value.image
                           case .failure(_):
                            sionView.isHidden = true
                          }
               }
            }else{
                sionView.isHidden = true
            }
            
            sionView.tapActionBlock = {
                self.pkgotoWebView(webUrl: result["FGgWiiWJulyPFGsgAj"].stringValue)
            }
            
        }
    }
    
    func getPopPKHomeViewControllerViewData() {
        homeHandle.getPKHomePagePOPViewData { result in
            if pKCheckString(with: result["TNyxqSeThermonukePsrZfLM"].stringValue){
                let homePopUPView =  PKHomePopUPView(jsonModel: result)
                homePopUPView.show()
                homePopUPView.confirmBlock = {[weak self] url in
                    guard let self = self else { return }
                    self.pkgotoWebView(webUrl: url)
                }
                
            }
        }
        
    }
    
    //MARK: - pkgotoWebView
    func pkgotoWebView(webUrl: String){
        if pKCheckString(with: webUrl){
            let webVC = PKWebkitViewController()
            webVC.pkWebUrlStr = webUrl
            navigationController?.pushViewController(webVC, animated: true)
        }
        
    }
    
    //MARK: - pkgotoproductApply
    func pkgotoProductApply(product_id: String){
        if PKUserManager.pkisLogin(){
            pkgotoProductApplyData(product_id: product_id)
        }else{
            PKUserManager.pkgotoLogin()
        }
    }
    
    func pkgotoProductApplyData(product_id: String){
        homeHandle.postPKHomePageApplyData(eRPMeBJSpeciateMyfFjzI: product_id) {[weak self] result in
            guard let self = self else { return }
            if result["XQhVVjIFenitrothionDpryiLT"].boolValue{
                
                if result["psNJhSBSinaiIbToMht"].intValue == 2{
                    pkUpDataDeviceinfo()
                }
                if result["frPFiGQHarkFDGovYI"].stringValue.hasPrefix("http"){
                    self.pkgotoWebView(webUrl:result["frPFiGQHarkFDGovYI"].stringValue)
                }else{
                    self.pkHomePagegotoProductApply(product_id: product_id)
                }
            }else {
                if result["psNJhSBSinaiIbToMht"].intValue == 2{
                    pkUpDataDeviceinfo()
                }
                PKLocationManager.shardManager.startLocation { isCanLoca in
                    if isCanLoca{
                        PKLocationManager.shardManager.getlocationInformation { locationDic in
                            self.homeHandle.postPKHomePageupLoadLocationData(LoadLocationDic: locationDic) {
                                
                                if result["frPFiGQHarkFDGovYI"].stringValue.hasPrefix("http"){
                                    self.pkgotoWebView(webUrl:result["frPFiGQHarkFDGovYI"].stringValue)
                                }else{
                                    self.pkHomePagegotoProductApply(product_id: product_id)
                                }
                            }
                        }
                    }else{
                        self.pkHomePageShowLocationsTipView()
                        
                    }
                }
                
            }
            
        }
    }
    
    func pkHomePagegotoProductApply(product_id: String){
        self.homeHandle.postPKHomePageProductdetailData(eRPMeBJSpeciateMyfFjzI: product_id) { result in
            if pKCheckString(with: result){
                PKCertificationViewController.judgeCerPageStepWithInfo(cerId: product_id, cerType: result)
            }
        }
    }
    
    
    func pkHomePageShowLocationsTipView(){
        
        let alertController = UIAlertController(
            title: "Tips",
            message: "To be able to use our app, please turn on your device location services.",
            preferredStyle: .alert
        )
        let sureAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        
        alertController.addAction(sureAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true) {
            alertController.modalPresentationStyle = .fullScreen
        }
        
    }
    
    //MARK: - lazy
    lazy var homeHandle: PKHomeHandle = {
        let homeHandle = PKHomeHandle()
        return homeHandle
    }()
    
    lazy var topView: UIView = {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: width_PK_bounds, height: PK_NaviH))
        topView.backgroundColor = .clear
        topView.addSubview(pkhomeAppLogoImageView)
        topView.addSubview(pkhomeKefuTipImageView)
        
        pkhomeAppLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(safe_PK_top + 12)
            make.left.equalToSuperview().offset(14)
            make.size.equalTo(CGSize(width: 105, height: 19))
        }
        
        pkhomeKefuTipImageView.snp.makeConstraints { make in
            make.centerY.equalTo(pkhomeAppLogoImageView.snp.centerY)
            make.right.equalTo(-56)
            make.size.equalTo(CGSize(width: 149, height: 30))
        }
        return topView
    }()
    
    lazy var pkhomeAppLogoImageView: UIImageView = {
        let pkhomeAppLogoImageView = UIImageView()
        pkhomeAppLogoImageView.image = UIImage(named: "pk_home_card1")
        return pkhomeAppLogoImageView
    }()
    
    lazy var pkhomeKefuTipImageView: UIImageView = {
        let pkhomeKefuTipImageView = UIImageView()
        pkhomeKefuTipImageView.image = UIImage(named: "pk_home_card2")
        return pkhomeKefuTipImageView
    }()

}

extension PKHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.homeHandle.homeDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let homeCellId = "PERABEEMiaCellID"
        let homeCell = UITableViewCell(style: .default, reuseIdentifier: homeCellId)
        if (indexPath.row > self.homeHandle.homeDataArray.count){
            return homeCell
        }
        
        let itemModel = self.homeHandle.homeDataArray[indexPath.row]
        if itemModel["itemType"].stringValue == "WEYKEWQFVLUHPOL" {
            let pkHomeBgCardItem = tableView.dequeueReusableCell(withIdentifier: itemModel["itemType"].stringValue) as? PKHomeBigCardTableViewCell ?? PKHomeBigCardTableViewCell(style: .default, reuseIdentifier: itemModel["itemType"].stringValue)
            pkHomeBgCardItem.configPKHomeBigCardTableViewCellModel(itemModel: itemModel)
            pkHomeBgCardItem.homeBigCardnextClickBlock = { [weak self] PSAGszTConverselyEKiKyQy in
                guard let self = self else { return }
                self.pkgotoProductApply(product_id: PSAGszTConverselyEKiKyQy)
                
            }
            
            pkHomeBgCardItem.homeBigCardnextAgreementBlock = { [weak self] agreementUrl in
                guard let self = self else { return }
                self.pkgotoWebView(webUrl: agreementUrl)
                
            }
            return pkHomeBgCardItem
        }else if itemModel["itemType"].stringValue == "unoBYBSShoppyMwSzwtVip"{
            let pkHomeCardTipItem = UINib(nibName: "PKHomeCardTipTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as! PKHomeCardTipTableViewCell
            return pkHomeCardTipItem
        }else if itemModel["itemType"].stringValue == "PNAXDHJIWWMFQBW"{
            let pkHomeSamllCardItem = tableView.dequeueReusableCell(withIdentifier: itemModel["itemType"].stringValue) as? PKHomeSmallCardTableViewCell ?? PKHomeSmallCardTableViewCell(style: .default, reuseIdentifier: itemModel["itemType"].stringValue)
            pkHomeSamllCardItem.configPKHomeSmallCardTableViewCellModel(itemModel: itemModel)
            pkHomeSamllCardItem.homeSmallCardnextClickBlock = { [weak self] PSAGszTConverselyEKiKyQy in
                guard let self = self else { return }
                self.pkgotoProductApply(product_id: PSAGszTConverselyEKiKyQy)
            }
            
            return pkHomeSamllCardItem
            
        }else if itemModel["itemType"] == "DVXVGCHGBQPCJXX"{
            let pkHomeBannerItem = tableView.dequeueReusableCell(withIdentifier: itemModel["itemType"].stringValue) as? PKHomeBannerTableViewCell ?? PKHomeBannerTableViewCell(style: .default, reuseIdentifier: itemModel["itemType"].stringValue)
            pkHomeBannerItem.configPKHomeBannerTableViewCellModel(itemModel: itemModel)
            pkHomeBannerItem.homebannerClickBlock = { [weak self] bannerUrl in
             guard let self = self else { return }
             self.pkgotoWebView(webUrl: bannerUrl)
                
            }
            return pkHomeBannerItem
        }else if itemModel["itemType"] == "IMNCUBAJXEIEYDF" {
            let pkHomeTableViewItem = UINib(nibName: "PKHomeTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as! PKHomeTableViewCell
            pkHomeTableViewItem.configPKHomeTableViewCellModel(itemModel: itemModel)
            pkHomeTableViewItem.homeTableViewCellNextClickBlock = { [weak self] PSAGszTConverselyEKiKyQy in
                guard let self = self else { return }
                self.pkgotoProductApply(product_id: PSAGszTConverselyEKiKyQy)
            }
            
            return pkHomeTableViewItem
            
        }else if itemModel["itemType"] == "PNAXDHJIWWMFQBWVip"{
            let pkHomeSamllCardSECTableViewItem = UINib(nibName: "PKHomeSamllCardSECTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as! PKHomeSamllCardSECTableViewCell
            pkHomeSamllCardSECTableViewItem.homeSamllCardSECAgreementBlock = { [weak self] agreementUrl in
                guard let self = self else { return }
                self.pkgotoWebView(webUrl: agreementUrl)
            }
            return pkHomeSamllCardSECTableViewItem
            
        }else if itemModel["itemType"] == "YWKYGPLCDNUPFIP"{
            let pkHomeRepayMentTableViewCellItem = UINib(nibName: "PKHomeRepayMentTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as! PKHomeRepayMentTableViewCell
            pkHomeRepayMentTableViewCellItem.configPKHomeRepayMentTableViewCellModel(itemModel: itemModel)
            pkHomeRepayMentTableViewCellItem.homeRepayMentClickBlock = { [weak self] repayMentUrl in
             guard let self = self else { return }
                self.pkgotoWebView(webUrl: repayMentUrl)
            }
            return pkHomeRepayMentTableViewCellItem
            
        }
        
        return homeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.homeHandle.homeDataArray[indexPath.row]
        return CGFloat(model["itemHeight"].floatValue)
    }
    
}




class PKHomeViewControllerSionView: UIView {
    // MARK: - shared
    @objc static let shared = PKHomeViewControllerSionView(frame: CGRect(x:width_PK_bounds - 70, y: 70, width: 52, height: 36))
    
    var pan: UIPanGestureRecognizer?
    @objc var sioniocnImgView: UIImageView!
    @objc var tapActionBlock: PKNoneBlock?
    
    // MARK:
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupPERABEEMainWidgetSionViewUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setupPERABEEMainWidgetSionViewUI() {
       
        self.pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        if let pan = self.pan {
            self.addGestureRecognizer(pan)
        }
        
        self.sioniocnImgView = UIImageView()
        
        self.sioniocnImgView.frame = CGRect(x: 12, y: 0, width: 36, height: 36)
        self.addSubview(self.sioniocnImgView)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
    }
    
   
    @objc func tapAction() {
        if let clickBlock = tapActionBlock {
            clickBlock()
        }
    }
    
    // MARK: -handlePanGesture
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let superview = self.superview else { return }
        
        if gesture.state == .changed {
            let translatePoint = gesture.translation(in: superview)
            self.center = CGPoint(x: self.center.x + translatePoint.x, y: self.center.y + translatePoint.y)
            gesture.setTranslation(.zero, in: superview)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            var originY = self.frame.origin.y
            var left: CGFloat
            
            
            if self.center.x > superview.bounds.width / 2 {
                left = superview.bounds.width - self.frame.width
            } else {
                left = 0
            }
            
            if originY < 0 {
                originY = 0
            } else if originY > superview.bounds.height - self.frame.height {
                originY = superview.bounds.height - self.frame.height
            }
            
           
            UIView.animate(withDuration: 0.3) {
                self.frame = CGRect(x: left, y: originY, width: self.frame.width, height: self.frame.height)
            }
        }
    }
  

}
