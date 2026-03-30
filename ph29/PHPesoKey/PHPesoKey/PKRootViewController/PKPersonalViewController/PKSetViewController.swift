//
//  PKSetViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/13.
//

import UIKit

class PKSetViewController: UIViewController {

    @IBOutlet weak var setInfoVIew: UIView!
    @IBOutlet weak var cancelBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBut.layer.borderColor = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1.0).cgColor
        cancelBut.layer.borderWidth = 1
        
        
        let websiteTitleLabel = UILabel()
        websiteTitleLabel.font = .systemFont(ofSize: 12)
        websiteTitleLabel.textColor = UIColor.init(hex: "#999999")
        websiteTitleLabel.text = "Web" + "site"
        setInfoVIew.addSubview(websiteTitleLabel)
        websiteTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(16)
            make.height.equalTo(14)
        }
        
        let websiteLabel = UILabel()
        websiteLabel.font = .systemFont(ofSize: 14)
        websiteLabel.textColor = UIColor.init(hex: "#191919")
        websiteLabel.text = "https://www.westcoast-lending.com"
        setInfoVIew.addSubview(websiteLabel)
        websiteLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(websiteTitleLabel.snp.bottom).offset(6)
            make.height.equalTo(16)
        }
        
        let websiteLineView = UIView()
        websiteLineView.backgroundColor = UIColor.init(hex: "#E3E9F3")
        setInfoVIew.addSubview(websiteLineView)
        websiteLineView.snp.makeConstraints { make in
            make.top.equalTo(websiteLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-19)
            make.height.equalTo(1)
        }
        
        
        let emailTitleLabel = UILabel()
        emailTitleLabel.font = .systemFont(ofSize: 12)
        emailTitleLabel.textColor = UIColor.init(hex: "#999999")
        emailTitleLabel.text = "Em" + "ail"
        setInfoVIew.addSubview(emailTitleLabel)
        emailTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(websiteLineView.snp.bottom).offset(16)
            make.height.equalTo(14)
        }
        
        let emailLabel = UILabel()
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.textColor = UIColor.init(hex: "#191919")
        emailLabel.text = "support@westcoast-lending.com"
        setInfoVIew.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(6)
            make.height.equalTo(16)
        }
        
        let  emailLineView = UIView()
        emailLineView.backgroundColor = UIColor.init(hex: "#E3E9F3")
        setInfoVIew.addSubview(emailLineView)
        emailLineView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-19)
            make.height.equalTo(1)
        }
        
        
        
        let editionTitleLabel = UILabel()
        editionTitleLabel.font = .systemFont(ofSize: 12)
        editionTitleLabel.textColor = UIColor.init(hex: "#999999")
        editionTitleLabel.text = "Edi" + "tion"
        setInfoVIew.addSubview(editionTitleLabel)
        editionTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(emailLineView.snp.bottom).offset(16)
            make.height.equalTo(14)
        }
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let editionLabel = UILabel()
        editionLabel.font = .systemFont(ofSize: 14)
        editionLabel.textColor = UIColor.init(hex: "#191919")
        editionLabel.text = "V" + (version ?? "1.0.0")
        setInfoVIew.addSubview(editionLabel)
        editionLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(editionTitleLabel.snp.bottom).offset(6)
            make.height.equalTo(16)
        }
        
        
    }
    
    @IBAction func setBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func setClick(_ sender: UIButton) {
        if sender.tag == 0{//log out
            certloginPopView(type: 0)
        }else{
            certloginPopView(type: 1)
        }
    }
    
    func certloginPopView(type:Int){
        let centerImage = UIImageView(frame: CGRect(x:35.w, y: 0, width: 305.w, height: 260.w))
        centerImage.image = UIImage(named: "pk_setting_logOut")
        centerImage.isUserInteractionEnabled = true
        centerImage.centerY = height_PK_bounds/2
        
        let title = UILabel(frame: CGRect(x: 0, y: 120.w, width: centerImage.width, height: 40))
        title.textColor = UIColor.init(hex: "#282828")
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textAlignment = .center
        title.text = type == 1 ? "Are y" + "ou sure you \n want t" + "o leave the software?" : "Are y" + "ou certain  \n you wa" + "nt to sig" + "n out from this account?"
        centerImage.addSubview(title)
        
        
        let leftBorderLabel = UILabel()
        leftBorderLabel.font = .systemFont(ofSize: 14)
        leftBorderLabel.textAlignment = .center
        leftBorderLabel.backgroundColor = .white
        leftBorderLabel.frame = CGRect(x: 35.w, y: 260.w - 62.w, width: 112.w, height: 40)
        leftBorderLabel.text = "Cancel"
        leftBorderLabel.cornerRadius = 20
        leftBorderLabel.layer.borderColor = vrgba(222, 222, 222, 1).cgColor
        leftBorderLabel.layer.borderWidth = 1
        leftBorderLabel.touch {
            PKBottomFlatView.dismissed()
        }
        centerImage.addSubview(leftBorderLabel)
        
        let rightNormalLabel = UILabel()
        rightNormalLabel.font = .systemFont(ofSize: 14)
        rightNormalLabel.textAlignment = .center
        rightNormalLabel.backgroundColor = vrgba(191, 253, 64, 1)
        rightNormalLabel.frame = CGRect(x: 158.w, y: 260.w - 62.w, width: 112.w, height: 40)
        rightNormalLabel.text = "Confirm"
        rightNormalLabel.cornerRadius = 20
        rightNormalLabel.touch { [weak self]  in
            guard let self = self else { return }
            PKBottomFlatView.dismissed()
            self.getPKSetViewControllerLogin()
        }
        centerImage.addSubview(rightNormalLabel)
        
        PKBottomFlatView.addToFlat(infoVie: centerImage)
    }
    
    func getPKSetViewControllerLogin(){
        
        PKupLoadingManager.upload.loadGet(place: "/xqIIBAcredNcULl",upping: true) {[weak self] suc in
            guard let self = self else { return }
            PKUserManager.cleanUserInfo()
            self.navigationController?.popToRootViewController(animated: true)
            NotificationCenter.default.post(name: Notification.Name("pktabSelesHome"), object: nil)
        } failed: { errorMsg in
            
        }
        
    }
}
