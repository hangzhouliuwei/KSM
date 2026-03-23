//
//  LPAuthFaceVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit
import AAILivenessSDK

class LPAuthFaceVC: LPAuthBaseVC {
    
    var faceModel : LPAuthFaceModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        getData()
    }
    
    func getData(){
        Request.send(api: .faceGet(proID: self.proID)) { (result:LPAuthFaceModel?) in
            if let result = result{
                self.faceModel = result
            }
            
        } failure: { error in
            
        }
        
    }
    
    @objc func starBtnClick() {
        if self.faceModel?.PTUDesuetudei.PTUMesenchymatousi != "" {
            saveData()
            return
        }
        
        faceLiveUI()
        faceLiveLimit()
        
    }
    
    //MARK: faceLiveLimit
    func faceLiveLimit(){

        Request.send(api: .faceLimit(proID: self.proID),showLoading: true) { (result:LPEmptyModel?) in
            
            self.getfaceLiveId()
        } failure: { error in
            
        }
        
    }
    
    //MARK: getfaceLiveId
    func getfaceLiveId(){
        
        Request.send(api: .faceLicense,showLoading: true) { (result:LPAuthFaceLimitModel?) in
            
            if let result = result{
                self.liveAAILivenessSDK(liveId: result.PTUHelicedi ?? "")
            }
            
        } failure: { error in
            
        }
        
    }
    //MARK: liveAAILivenessSDK
    func liveAAILivenessSDK(liveId: String){
       
        let checkReslt = AAILivenessSDK.configLicenseAndCheck(liveId)
        if checkReslt  ==  "SUCCESS"{
            showFaceSDK()
        }else {
            self.uploadOCRFail(faceErrCode: checkReslt)
            loadErrUI()
        }
    }
    
    //MARK: showFaceSDK
    func showFaceSDK(){
        let faceVC = AAILivenessViewController()
        faceVC.detectionSuccessBlk = { [weak self](rawVC, result) in
            let livenessId = result.livenessId
            guard let self = self else { return }
            self.updataLivenessId(livenessId: livenessId)
            rawVC.navigationController?.popViewController(animated: true)
        }
        
        faceVC.detectionFailedBlk = { [weak self](rawVC, result) in
          
            guard let self = self else { return }
            if let reson = result["key"] as? String {
                self.uploadOCRFail(faceErrCode: reson)
            }
            rawVC.navigationController?.popViewController(animated: true)
            self.loadErrUI()
        }
        self.navigationController?.pushViewController(faceVC, animated: true)
    }
    
    //MARK: updataLivenessId
    func updataLivenessId(livenessId:String){
        
        Request.send(api: .faceUpdate(proID: self.proID, livenessId: livenessId),showLoading: true) { (result:LPAuthFaceLivenIdModel?) in
            
            if let result = result{
                self.faceModel?.PTUDesuetudei.PTUMesenchymatousi = result.PTUStaggeryi
                self.saveData()
            }
            
        } failure: { error in
            self.loadErrUI()
        }
        
        
    }
    
    //MARK: uploadOCRFail
    func uploadOCRFail(faceErrCode: String){
        Request.send(api: .faceUpdataErr(faceErrCode: faceErrCode),showLoading: false) { (result:LPEmptyModel?)in

        } failure: { error in
            
        }
        
        
    }
    
    //MARK: loadErrUI
    func loadErrUI() {
        topLabel.text = "Authentication failed, please try again."
        topLabel.textColor = .rgba(228.0, 69.0, 69.0)
        
        starBtn.backgroundColor = .rgba(228.0, 69.0, 69.0)
        starBtn.setTitle("Try Again", for: .normal)
        
    }
    
    //MARK: faceLiveUI
    func faceLiveUI(){
        AAILivenessSDK.initWith(.philippines)
        AAILivenessSDK.configResultPictureSize(800.0)
        AAILivenessSDK.additionalConfig().detectionLevel = .easy
    }
    
    //MARK: saveData
    func saveData(){
        var dic: [String: Any] = [:]
        dic["PTUMercenarismi"] = self.faceModel?.PTUDesuetudei.PTUMesenchymatousi
        LPApplyManager.shared.saveParams(vc: self, params: dic)
    }
    
    //MARK: setUI
    func setUI() {
        contentV.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.left.equalTo(16.0)
            make.top.equalTo(10.0)
            make.right.equalTo(-8.0)
            make.height.equalTo(40.0)
        }
        
        let faceBackImage = UIImageView()
        faceBackImage.imgName("au_face_back")
        contentV.addSubview(faceBackImage)
        faceBackImage.snp.makeConstraints { make in
            make.left.equalTo(16.0)
            make.top.equalTo(topLabel.snp.bottom).offset(12.0)
            make.size.equalTo(CGSize(width: kWidth - 32, height: kScaleX(196.0)))
        }
        
        contentV.addSubview(starBtn)
        starBtn.snp.makeConstraints { make in
            make.left.equalTo(16.0)
            make.top.equalTo(faceBackImage.snp.bottom).offset(30.0)
            make.size.equalTo(CGSize(width: kWidth - 32, height: kScaleX(48.0)))
        }
        
        let faceErrImage = UIImageView()
        faceErrImage.imgName("au_face_tip")
        contentV.addSubview(faceErrImage)
        faceErrImage.snp.makeConstraints { make in
            make.left.equalTo(16.0)
            make.top.equalTo(starBtn.snp.bottom).offset(27.0)
            make.size.equalTo(CGSize(width: kWidth - 32, height: kScaleX(86.0)))
        }
    }
    
    
    
    //MARK: lazy
    private lazy var topLabel : UILabel = {
        let topLabel = UILabel.new(text: "To ensure it is operated by yourself, we need  to verify your identity.", textColor: black51, font: .font_PingFangSC_M(12.0), lines: 2)
        return topLabel
    }()
    
    lazy var starBtn:UIButton = {
        let starBtn = UIButton.textBtn(title: "Start",titleColor: .white,font: .font_Roboto_M(16),bgColor: mainColor38,corner: 2)
        starBtn.addTarget(self, action: #selector(starBtnClick), for: .touchUpInside)
        return starBtn
    }()
    
}
