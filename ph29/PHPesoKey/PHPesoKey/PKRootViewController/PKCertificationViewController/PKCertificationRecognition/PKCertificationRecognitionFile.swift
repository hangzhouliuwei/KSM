//
//  PKCertificationRecognitionFile.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/12.
//

import UIKit

class PKCertificationRecognitionFile: UIViewController, UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var pkButtonH: NSLayoutConstraint!
    @IBOutlet weak var pkFacialButton: UIButton!
    
    var cerIdForLending = ""
    var sortIndex = 0
    var timeViewDidLoad = ""
    var toDeletePkPageWhenDismiss = false
    var pkPeopleFaceId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        timeViewDidLoad = PKUserManager.pkGetNowTime()
        resetButH()
        pkmCreateData()
    }
    
    func pkmCreateData() {
        let dict = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending];
        PKupLoadingManager.upload.loadPost(place: "/IPWJrStellulatePffjh", dict: dict, upping: true) { suc in
            self.pkPeopleFaceId = suc.runData["YUnySnNYetorofuGQgKuIW"]["RKLriwISustenanceLZTKKlk"].stringValue
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if toDeletePkPageWhenDismiss {
            if let navigationController = self.navigationController,
               !navigationController.viewControllers.contains(self) {
                return
            }
            if let navigationController = self.navigationController {
                navigationController.viewControllers.removeAll { $0 === self }
            }
        }
    }
    
    func resetButH(){
        if pkFacialButton.isSelected{
            pkButtonH.constant = (width_PK_bounds-60)/327*412
        }else{
            pkButtonH.constant = (width_PK_bounds-60)/327*382
        }
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        pkFacialBack(UIButton())
        return false
    }

    @IBAction func pkFacialBack(_ sender: Any) {
        let iconArr = ["pk_auth_leave1", "pk_auth_leave2", "pk_auth_leave3", "pk_auth_leave4", "pk_auth_leave5"]
            
        let contentArr = ["Complete the " + "form to apply for a" + " loan, and we'll " + "tailor a loan amount" + " just for you.", "Enhance " + "your loan approval chances " + "by providing your " + "emergency contact information " + "now.", "Complete your identification" + " now for a chance to increase" + " your loan limit.", "Boost" + " your credit score by " + "completing facial recognition now.", "Take" + " the final step to apply for your " + "loan—submitting now will enhance" + " your approval rate."]
        
        let centerImage = UIImageView(frame: CGRect(x:35.w, y: 0, width: 305.w, height: 320.w))
        centerImage.image = UIImage(named: iconArr[sortIndex])
        centerImage.isUserInteractionEnabled = true
        centerImage.centerY = height_PK_bounds/2
        
        let title = UILabel(frame: CGRect(x: 0, y: 135.w, width: centerImage.width, height: 20))
        title.textColor = vrgba(40, 40, 40, 1)
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textAlignment = .center
        title.text = "Are " + "you sure you " + "want to " + "leave?"
        centerImage.addSubview(title)
        
        let middleText = UILabel(frame: CGRect(x: 35, y: 172.w, width: centerImage.width - 70, height: 20))
        middleText.textColor = vrgba(40, 40, 40, 1)
        middleText.font = UIFont.systemFont(ofSize: 12)
        middleText.textAlignment = .center
        middleText.text = contentArr[sortIndex]
        middleText.numberOfLines = 0
        middleText.sizeToFit()
        centerImage.addSubview(middleText)
        
        let leftBorderLabel = UILabel()
        leftBorderLabel.font = .systemFont(ofSize: 14)
        leftBorderLabel.textAlignment = .center
        leftBorderLabel.backgroundColor = .white
        leftBorderLabel.frame = CGRect(x: 35.w, y: 320.w - 62.w, width: 112.w, height: 40)
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
        rightNormalLabel.frame = CGRect(x: 158.w, y: 320.w - 62.w, width: 112.w, height: 40)
        rightNormalLabel.text = "Confirm"
        rightNormalLabel.cornerRadius = 20
        rightNormalLabel.touch {
            PKBottomFlatView.dismissed()
            self.navigationController?.popViewController(animated: true)
        }
        centerImage.addSubview(rightNormalLabel)
        
        PKBottomFlatView.addToFlat(infoVie: centerImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.delegate = nil
    }

    @IBAction func pkStartFacail(_ sender: UIButton) {
        if !pkPeopleFaceId.isEmpty {
            pkLiveStatusStepWith9()
            return;
        }
        let dict = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending]
        
        PKupLoadingManager.upload.loadPost(place: "/VSPjGCitrullineEmdTA", dict: dict, upping: true) { suc in
            self.pkLiveStatusStepWith1()
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
    }
    
    func pkLiveStatusStepWith9() {
        var dict:[String : Any] = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending, "gAmquenLunisolarCDbGpEj": pkPeopleFaceId]
        let trackPar : [String : Any] = [
                        "WSyPsXwCanebrakeYgMYgls": self.timeViewDidLoad,
                        "wuFALqkMinyanZwrVpyL":cerIdForLending,
                        "YHZCZRDPostmenopausalAndODGw":"25",
                        "EYKwmOjNumismaticFcLRZjO":PKLocationManager.shardManager.pklatitude,
                        "rgUNlpgXxiQcxSeRP":PKUserManager.pkGetNowTime(),
                        "TczbtsRQuagYaOfpJi":PKAppInfo.IDFV,
                        "gVHCbxOSingularizeOaDpSvj": PKLocationManager.shardManager.pklongitude
                       ]
        
        dict["point"] = trackPar
        
        PKupLoadingManager.upload.loadPost(place: "/ZoNduAnglomaniaXEuFQ", dict: dict, upping: true) { suc in
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
    
    func pkLiveStatusStepWith1() {
        
        PKupLoadingManager.upload.loadPost(place: "/tKzbqAllophaneGHmRF", dict: nil, upping: true) { suc in
            let lid = suc.runData["cnPBRKXPentalphaHmpNegO"].stringValue
            self.pkLiveStatusStepWith2(lid)
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
    }
    
    func pkLiveStatusStepWith2(_ lid:String) {
        AAILivenessSDK.initWith(AAILivenessMarket.philippines)
        AAILivenessSDK.configDetectOcclusion(true)
        AAILivenessSDK.additionalConfig().detectionLevel = .easy
        AAILivenessSDK.configResultPictureSize(800)
        let authStatus = AAILivenessSDK.configLicenseAndCheck(lid)
        if authStatus == "SUCCESS" {
            let vc = AAILivenessViewController()
            vc.prepareTimeoutInterval = 100
            vc.detectionSuccessBlk = { [weak self] rawVC, result in
                let faceId = result.livenessId
                pkLiveStatusStepWithRemove()
                if !faceId.isEmpty {
                    self?.pkLiveStatusStepWith3(faceId)
                } else {
                    self?.pkFailed()
                    PKToast.show("Authentication failed, Please re-authenticate.")
                }
            }
            vc.detectionFailedBlk = { rawVC, errorInfo in
                pkLiveStatusStepWithWrongTips(authStatus)
                self.pkFailed()
                pkLiveStatusStepWithRemove()
            }
            pkLiveStatusStepWithAdd(vc: vc)
        } else{
            self.pkFailed()
            pkLiveStatusStepWithWrongTips(authStatus)
            PKToast.show("Authentication failed, Please re-authenticate.")
        }
    }
    
    func pkLiveStatusStepWith3(_ faceId:String) {
        let dict = ["eRPMeBJSpeciateMyfFjzI":cerIdForLending, "lJWyBZASwarajEOzKadG":faceId]

        PKupLoadingManager.upload.loadPost(place: "/zZsZzRhabdomereXZcXg", dict: dict, upping: true) { suc in
            self.pkPeopleFaceId = suc.runData["qsLgdmICorollaceousHrxauDQ"].stringValue
            self.pkLiveStatusStepWith9()
        } failed: { errorMsg in
            PKToast.show(errorMsg ?? "")
        }
    }
    
    func pkFailed(errorStr:String?=nil){
        pkFacialButton.isSelected = true
        resetButH()
        if let errorStr = errorStr{
            PKToast.show(errorStr)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is AAILivenessViewController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}


func pkLiveStatusStepWithRemove() {
    let topFile = UIApplication.shared.windows.first!.rootViewController as! UINavigationController
    topFile.popViewController(animated: true)
}

func pkLiveStatusStepWithAdd(vc:UIViewController) {
    let topFile = UIApplication.shared.windows.first!.rootViewController as! UINavigationController
    topFile.pushViewController(vc, animated: true)
}

func pkLiveStatusStepWithWrongTips(_ err:String) {
    PKupLoadingManager.upload.loadPost(place: "/TdAzQCockshotFuDXb", dict: ["RKLriwISustenanceLZTKKlk":err], upping: true) { suc in
    } failed: { errorMsg in
    }
}
