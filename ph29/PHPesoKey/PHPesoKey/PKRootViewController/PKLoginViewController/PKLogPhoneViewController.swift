//
//  PKLogPhoneViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/14.
//

import UIKit

class PKLogPhoneViewController: UIViewController{

    @IBOutlet weak var pkPhoneTextFiled: UITextField!
    
    @IBOutlet weak var pkPrivacyLab: UILabel!
    
    @IBOutlet weak var pkSelectedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pkPhoneTextFiled.delegate = self
        pkPhoneTextFiled.keyboardType  = .numberPad
        let attStr = NSMutableAttributedString(string: "l have read and agre " + "Privacy Agreement")
        let privacyRange = (attStr.string as NSString).range(of: "Privacy Agreement")
        attStr.addAttribute(.foregroundColor, value: UIColor.init(hex: "#0622F7") ?? "", range: privacyRange)
        pkPrivacyLab.attributedText = attStr
        pkPrivacyLab.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pkLogPhoneopenPrivacy))
        pkPrivacyLab.addGestureRecognizer(tapGesture)
        
    }

    @IBAction func leftBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func protocolBtnClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func pkGoClick(_ sender: UIButton) {
        
        if !pkSelectedButton.isSelected {
            PKToast.show("Please co" + "nfirm t" + "he agreement")
            return
        }
        
        let phoneNember = pkPhoneTextFiled.text ?? ""
        if phoneNember.count < 8 {
            PKToast.show("Please fill in the c" + "orrect ph" + "one number")
            return
        }
        
        let logCodeViewController = PKLogCodeViewController()
        logCodeViewController.pkPhoneNumber = pkPhoneTextFiled.text ?? ""
        logCodeViewController.modalPresentationStyle = .fullScreen
        self.present(logCodeViewController, animated: true)
        
    }
    
    @objc func pkLogPhoneopenPrivacy() {
        let webVC = PKWebkitViewController()
        webVC.pkWebUrlStr = WebUpper + "/#/privacyAgreement"
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true)
    }
    
}

extension PKLogPhoneViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let tpyeText = (textField.text ?? "") as NSString
        let text = tpyeText.replacingCharacters(in: range, with: string)
        return text.count <= 15
    }
    
}
