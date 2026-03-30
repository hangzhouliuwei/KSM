//
//  PKLogCodeViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/14.
//

import UIKit
import KeenCodeUnit

class PKLogCodeViewController: UIViewController {

    @IBOutlet weak var pkPhoneLba: UILabel!
    
    @IBOutlet weak var pkSendBut: UIButton!
    
    @IBOutlet weak var pkCodeInputView: UIView!
    
    var pkloginCodeUnit: KeenCodeUnit!
    
    var pkLogCodeTimer: Timer?
    var pageStartTime:String = ""
    var pkPhoneNumber:String = ""
    var pkLogCodetimeIntValue = 0
    var pkisLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PKLocationManager.shardManager.startLocation { result in }
        pkPhoneLba.text = pkPhoneNumber
        pageStartTime = PKUserManager.pkGetNowTime()
        pkSendBut.layer.cornerRadius = 18
        pkSendBut.layer.borderWidth = 1
        pkSendBut.layer.borderColor = UIColor.init(hex: "#DEDEDE")?.cgColor
        pkSendBut.backgroundColor = .clear
        
        
        let rect = CGRect(x: 10, y: 0, width: width_PK_bounds - 20, height: 44)
        var attr = KeenCodeUnitAttributes()
        attr.style = .splitline
        attr.textFont = .boldSystemFont(ofSize: 20)
        attr.textColor = .black
        attr.cursorColor = .black
        attr.lineColor = UIColor.init(hex: "#666666") ?? .black
        attr.lineHighlightedColor = UIColor.init(hex: "#666666") ?? .black
        attr.isSingleAlive = true
        attr.viewBackColor = .clear
        pkloginCodeUnit = KeenCodeUnit(
            frame: rect,
            attributes: attr
        ).addViewTo(view)
        
        pkloginCodeUnit.callback = { (codeText, complete) in
            if complete {
                self.loadPKLoginphoneLogin(pkCode: codeText)
            }
        }
        
        pkCodeInputView.addSubview(pkloginCodeUnit)
        
        loadPKLogCodeViewControllerCode()
    }

    @IBAction func pkBacke(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func pkResend(_ sender: UIButton) {
        if pkLogCodetimeIntValue > 0{
            return
        }
        loadPKLogCodeViewControllerCode()
    }
    
    
    
    func loadPKLogCodeViewControllerCode(){
        
        PKupLoadingManager.upload.loadPost(place: "/weRMqNethermorePifPZ", dict: ["AvrKcheArrearJclFqzz":pkPhoneNumber ,"ysCKMceComplanateAjvDArg": "Msxfedb" + "djndjebfegee"],upping: true) { [weak self] suc in
            guard let self = self else { return }
            if suc.runMsg.count>0{
                PKToast.show(suc.runMsg)
            }
            let couts = suc.runData["unoBYBSShoppyMwSzwtV"]["UEIzRfqCovertureYgAHoiE"].intValue
            self.updataDownTime(downTime: couts)
            
        } failed: { errorMsg in
            if errorMsg?.count ?? 0 > 0 {
                PKToast.show(errorMsg ?? "")
            }
        }
    }
    
    
    func loadPKLoginphoneLogin(pkCode: String){
        if pkisLoad {
            return
        }
        let loginPointDic : [String : Any] = [
                        "WSyPsXwCanebrakeYgMYgls": self.pageStartTime,
                        "wuFALqkMinyanZwrVpyL":"",
                        "YHZCZRDPostmenopausalAndODGw":"21",
                        "EYKwmOjNumismaticFcLRZjO":PKLocationManager.shardManager.pklatitude,
                        "rgUNlpgXxiQcxSeRP":PKUserManager.pkGetNowTime(),
                        "TczbtsRQuagYaOfpJi":PKAppInfo.IDFV,
                        "gVHCbxOSingularizeOaDpSvj": PKLocationManager.shardManager.pklongitude
                       ]
        
        let  loginDic: [String : Any] = [
                   "ocFehOsUrethrotomyMFdQkGM":pkPhoneNumber,
                   "VxnJdJpCoopHLUNiGH":pkCode,
                   "vLaSImtExheredationMZyGfDM":"duiuyiton",
                   "point":loginPointDic
                  ]
        pkisLoad = true
        PKupLoadingManager.upload.loadPost(place: "/OttdZEmbroilmentTwnzu", dict: loginDic,upping: true) { [weak self] suc in
            guard let self = self else { return }
            self.pkisLoad = true
            PKUserManager.phone = suc.runData["unoBYBSShoppyMwSzwtV"]["ocFehOsUrethrotomyMFdQkGM"].stringValue
            PKUserManager.sessionid = suc.runData["unoBYBSShoppyMwSzwtV"]["vEQlLmrCarcanetXvNyGgb"].stringValue
            self.presentingViewController?.presentingViewController?.dismiss(animated: true)
        } failed: {[weak self] errorMsg in
            guard let self = self else { return }
            self.pkisLoad = false
            pkloginCodeUnit.verifyErrorAction()
            if errorMsg?.count ?? 0 > 0 {
                PKToast.show(errorMsg ?? "")
            }
        }
        
        
    }
    
    func updataDownTime(downTime:Int){
        if downTime > 0{
            pkLogCodeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(downTimeDown), userInfo: nil, repeats: true)
            pkLogCodetimeIntValue = downTime
        }
    }
    
    
    @objc func downTimeDown(){
        
        if pkLogCodetimeIntValue == 0 {
            pkSendBut.setTitle("Resend", for: .normal)
            pkLogCodeTimer?.invalidate()
            pkLogCodeTimer = nil
            return
        }
        pkLogCodetimeIntValue -= 1
        pkSendBut.setTitle(JSON(pkLogCodetimeIntValue).stringValue + "s", for: .normal)
        
    }
    
}


