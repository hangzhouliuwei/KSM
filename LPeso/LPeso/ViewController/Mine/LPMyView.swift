//
//  LPMyView.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit
import SnapKit

struct my_item{
    var icon:String
    var title:String
}

class LPMyView: UIView, UITextViewDelegate {

    private var itemList:[LPMineItemModel] = []
//    [
//        my_item(icon: "my_bill", title: "My Bill"),
//        my_item(icon: "my_account", title: "Account"),
//        my_item(icon: "my_coupon", title: "Coupon"),
//        my_item(icon: "my_contact", title: "Contact Us"),
//        my_item(icon: "my_sercurity", title: "Security"),
//        my_item(icon: "my_fq", title: "F&Q"),
//        my_item(icon: "my_visit", title: "Visit: loanpeso.vip"),
//    ]
    
    private let my_placeW:CGFloat = 95
    private let my_appearTime = 0.3
    private let my_color:UIColor = mainColor38

    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeigth))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        self.itemList = LPDataManager.shared.centerList
        NotificationCenter.default.addObserver(self, selector: #selector(reloadList), name: Mine_noti, object: nil)
        
        self.backgroundColor = transColor
        self.addSubview(contentV)
        self.addSubview(closeBtn)
        
        //MARK: head
        let logoImgV = UIImageView()
        logoImgV.corners = 18
        logoImgV.image = UIImage(named: "LPeso_logo")
        contentV.addSubview(logoImgV)
        logoImgV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(24+Device.topBar)
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        
        let phoneLab = UILabel.new(text: UserSession.phone.modify(), textColor: .white, font: .boldSystemFont(ofSize: 20))
        contentV.addSubview(phoneLab)
        phoneLab.snp.makeConstraints { make in
            make.left.equalTo(logoImgV.snp.right).offset(10)
            make.centerY.equalTo(logoImgV)
        }
        
        let versionLab = UILabel.new(text: "Version: \(Device.appVersion)", textColor: .white, font: UIFont.systemFont(ofSize: 12))
        contentV.addSubview(versionLab)
        versionLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(logoImgV.snp.bottom).offset(10)
        }
        
        let lineV1 = UIView.lineView()
        contentV.addSubview(lineV1)
        lineV1.snp.makeConstraints { make in
            make.top.equalTo(versionLab.snp.bottom).offset(13)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(0.5)
        }
        
        //MARK: foot
        contentV.addSubview(outBtn)
        contentV.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24-Device.bottomSafe)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        outBtn.snp.makeConstraints { make in
            make.bottom.equalTo(cancelBtn.snp.top).offset(-9)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        
        contentV.addSubview(agreementLab)
        agreementLab.snp.makeConstraints { make in
            make.bottom.equalTo(outBtn.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        
        let lineV2 = UIView.lineView()
        contentV.addSubview(lineV2)
        lineV2.snp.makeConstraints { make in
            make.bottom.equalTo(agreementLab.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(0.5)
        }
        
        //MARK: items
        contentV.addSubview(itemCollectV)
        itemCollectV.snp.makeConstraints { make in
            make.top.equalTo(lineV1)
            make.bottom.equalTo(lineV2)
            make.left.right.equalToSuperview()
        }
        
        UIView.animate(withDuration: my_appearTime) {
            self.contentV.transform = CGAffineTransformMakeTranslation(kWidth-self.my_placeW, 0)
        }
        
        if itemList.count == 0{
            LPDataManager.shared.reloadMineData()
        }
        
    }
    
    //MARK: lazy
    lazy var contentV: UIView = {
        let contentV = UIView.lineView(color: my_color)
        contentV.frame = CGRect(x: -(kWidth-self.my_placeW), y: 0, width: kWidth-self.my_placeW, height: kHeigth)
        return contentV
    }()
    
    lazy var itemCollectV:UICollectionView = {
        let collectionLay = UICollectionViewFlowLayout()
        collectionLay.itemSize = CGSize(width: kWidth-my_placeW-48, height: 24)
        collectionLay.minimumLineSpacing = 32
        collectionLay.minimumInteritemSpacing = 0
        collectionLay.scrollDirection = .vertical
        collectionLay.sectionInset = UIEdgeInsets(top: 32, left: 24, bottom: 32, right: 24)
        
        var itemCollectV = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLay)
        itemCollectV.delegate = self
        itemCollectV.dataSource = self
        itemCollectV.backgroundColor = .clear
        itemCollectV.register(UINib.init(nibName: "LPMyCenterCell", bundle: nil), forCellWithReuseIdentifier: "LPMyCenterCell")
        return itemCollectV
    }()
    
    lazy var closeBtn: UIButton = {
        let closeBtn = UIButton.emptyBtn()
        closeBtn.frame = CGRect(x: kWidth-self.my_placeW, y: 0, width: self.my_placeW, height: kHeigth)
        closeBtn.addTarget(self, action: #selector(hideView), for: .touchUpInside)
        return closeBtn
    }()
    
    lazy var outBtn: UIButton = {
        let outBtn = UIButton.textBtn(title: "Sign Out", font: UIFont.systemFont(ofSize: 14), corner: 2, bordW: 1, bordColor: .rgba(241, 247, 254, 1))
        outBtn.tag = 11
        outBtn.addTarget(self, action: #selector(logOut(sender:)), for: .touchUpInside)
        return outBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton.textBtn(title: "Cancel Account", font: UIFont.systemFont(ofSize: 14), corner: 2, bordW: 1, bordColor: .rgba(241, 247, 254, 1))
        cancelBtn.tag = 22
        cancelBtn.addTarget(self, action: #selector(logOut(sender:)), for: .touchUpInside)
        return cancelBtn
    }()
    
    let attriStr = NSAttributedString(string: "Try using a volce verifcation code?", attributes: [
        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
    ])
    
    lazy var agreementLab: UILabel = {
        let agreementLabel = UILabel.new(text: "Please read our Privacy Agreement", textColor: .white, font: .boldSystemFont(ofSize: 12),alignment: .center)
        let attStr = NSMutableAttributedString(string: "Please read our Privacy Agreement")
        let privacyRange = (attStr.string as NSString).range(of: "Privacy Agreement")
        attStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: privacyRange)
        agreementLabel.attributedText = attStr
        agreementLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickPrivacy))
        agreementLabel.addGestureRecognizer(tapGesture)
        return agreementLabel
    }()
    
    @objc func clickPrivacy(){
        self.removeFromSuperview()
        Route.openUrl(urlStr: LP_Privacy)
    }
    
    
    //MARK: func
    @objc func hideView(){
        UIView.animate(withDuration: my_appearTime) {
            self.contentV.transform = .identity
        }completion: { isdone in
            self.removeFromSuperview()
        }
        
    }
    
    @objc func logOut(sender:UIButton){
        Route.showSetupAlert(tags: sender.tag)
    }
    
    @objc func reloadList(){
        self.itemList = LPDataManager.shared.centerList
        self.itemCollectV.reloadData()
    }
    
}

extension LPMyView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LPMyCenterCell", for: indexPath) as? LPMyCenterCell{
            if indexPath.row == 0{
                cell.loadBill()
            }else{
                cell.reloadWithItem(itemList[indexPath.row-1])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            hideView()
            Route.pushVC(vc: LPBillListVC())
        }else{
            let item = itemList[indexPath.row-1]
            print("k--- click: \(item.PTUTilefishi ?? "--") jump:\(item.PTUThenarditei ?? "--")")
            if let url = item.PTUThenarditei{
                hideView()
                Route.openUrl(urlStr: url)
            }
        }
        
    }
  
}
