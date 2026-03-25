//
//  LPAuthBankVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit

class LPAuthBankVC: LPAuthBaseVC {
    
    var dataModel:LPAuthBankModel?
    
    let channelView = LPChannelSelectView(titleList: ["E-Wallet","Bank"])
    let walletView = LPAuthWalletView()
    let bankView = LPAuthBankView()
    
    var currentCardType:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBankUI()
        getData()
    }
    
    func setBankUI(){
        contentV.backgroundColor = tabBgColor
        bankView.isHidden = true
        contentV.addSubview(channelView)
        contentV.addSubview(walletView)
        contentV.addSubview(bankView)
        walletView.snp.makeConstraints { make in
            make.top.equalTo(channelView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        bankView.snp.makeConstraints { make in
            make.top.equalTo(channelView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        channelView.channelBlock = { tags in
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.view.endEditing(true)
                currentCardType = tags
                walletView.isHidden = currentCardType==2
                bankView.isHidden = currentCardType==1
            }
            
        }
        
    }
    
    func getData(){
        Request.send(api: .bankGet(proID: self.proID)) { (result:LPAuthBankModel?) in
            
            guard let result = result else { return }
            self.refreshUI(model: result)
            
        } failure: { error in
            
        }
        
    }
    
    func refreshUI(model:LPAuthBankModel){
        self.dataModel = model
        if let countdown = self.dataModel?.PTUKickouti?.string{
            setCountDown(lastTime: countdown)
        }
        guard let walletModel = model.PTUSubmucosai,let bankModel = model.PTUInterlaboratoryi else { return }
        walletView.configModel(model: walletModel)
        bankView.configModel(model: bankModel)
        if let _ = walletModel.PTUMechanotheropyi?.PTUSpringharei{
            currentCardType = 1
            channelView.changeIndex(index: 0)
        }else if let _ = bankModel.PTUMechanotheropyi?.PTUSpringharei{
            currentCardType = 2
            channelView.changeIndex(index: 1)
        }
        
    }
    
    override func nextClick() {
        var currentChannelNo = ""
        var currentChannelStr = ""
        var currentAccount = ""
        var saveCardType = ""
        if currentCardType == 1{
            saveCardType = "2"
            currentChannelNo = walletView.channelNo
            currentChannelStr = walletView.channelStr
            currentAccount = walletView.accountStr
        }else if currentCardType == 2{
            saveCardType = "1"
            currentChannelNo = bankView.channelNo
            currentChannelStr = bankView.channelStr
            currentAccount = bankView.accountStr
        }
        
        if isBlank(currentChannelNo){
            Route.toast("Please select")
            return
        }
        if isBlank(currentAccount){
            Route.toast("Please fill in your account number")
            return
        }else if currentAccount.count < 5{
            Route.toast("The account number must be at least four digits.")
            return
        }
        
        Route.showBankAlertView(channelStr: currentChannelStr, accountStr: currentAccount) {
            let dic:[String:Any] = [
                "PTUEroductioni":saveCardType,
                "PTUPenitentiaryi":currentChannelNo,
                "PTUSpringharei":currentAccount
            ]
            LPApplyManager.shared.saveParams(vc: self, params: dic)
        }
        
    }


}
