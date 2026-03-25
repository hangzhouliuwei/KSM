//
//  LPRouteManager.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit

let Route = LPRouteManager.share

class LPRouteManager{
    
    static let share = LPRouteManager()
    
    var window: UIWindow? {
        return (UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .last?.windows
            .filter({ $0.isKeyWindow })
            .last) ?? UIApplication.shared.windows.first ?? UIWindow()
    }
    
    var currentVC: UIViewController? {
        get {
            guard let window = window else { return nil }
            let rootVC = window.rootViewController
            if let tabBarVC = rootVC as? UITabBarController {
                if let navigationVC = tabBarVC.selectedViewController as? UINavigationController {
                    return navigationVC.topViewController
                } else {
                    return tabBarVC.selectedViewController
                }
            } else if let navigationVC = rootVC as? UINavigationController {
                return navigationVC.topViewController
            } else {
                return rootVC?.presentedViewController
            }
        }
    }
    
    func reSetRootVC(){
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: LPHomeVC())
    }
    
    func backToHome(animated:Bool = true){
        currentVC?.navigationController?.popToRootViewController(animated: animated)
    }
    
    func pushVC(vc:UIViewController, animated:Bool = true) {
        currentVC?.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func pushClose(vc:UIViewController, animated:Bool = true) {
        guard let currentVC = self.currentVC else { return }
        currentVC.navigationController?.pushViewController(vc, animated: animated)
        if let count = currentVC.navigationController?.viewControllers.count, count > 2{
            currentVC.navigationController?.viewControllers.remove(at: count - 2)
        }
        
    }
    
    
    func preVC(vc:UIViewController, animated:Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        currentVC?.present(vc, animated: animated, completion: nil)
    }
    
    func dismissAll() {
        currentVC?.dismiss(animated: true, completion: nil)
        
    }
    
    func showMyCenter(){
        if UserSession.isLogin(){
            let myCenter = LPMyView()
            window?.addSubview(myCenter)
        }
    }
    
    func showLogin(){
        preVC(vc: LPLoginVC())
    }
    
    func openSys(){
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    func openUrl(urlStr:String){
        let webV = LPBaseWebVC()
        webV.url = urlStr
        currentVC?.navigationController?.pushViewController(webV, animated: true)
    }
    
    func openCloseUrl(urlStr:String){
        guard let currentVC = self.currentVC else { return }
        let webV = LPBaseWebVC()
        webV.url = urlStr
        currentVC.navigationController?.pushViewController(webV, animated: true)
        if let count = currentVC.navigationController?.viewControllers.count, count > 2{
            currentVC.navigationController?.viewControllers.remove(at: count - 2)
        }
    }
    
    func toast(_ title:String? ,delay:CGFloat = 1.5){
        guard !isBlank(title) else { return }
        hideLoading()
        let toastView = LPToastView(title: title! ,delay: delay)
        window?.addSubview(toastView)
    }
    
    func loading(duration: TimeInterval = 30) {
        if let window = self.window{
            if let _ = window.viewWithTag(54686) {
            
            }else{
                let loadingView = UIView.empty()
                loadingView.tag = 54686
                loadingView.isUserInteractionEnabled = true
                window.addSubview(loadingView)
                loadingView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                
                let showView = UIView.lineView(color: .black.withAlphaComponent(0.8))
                showView.corners = 12
                loadingView.addSubview(showView)
                showView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.size.equalTo(CGSizeMake(100, 100))
                }
                
                let indicatorView = UIActivityIndicatorView(style: .large)
                indicatorView.color = .white
                indicatorView.startAnimating()
                showView.addSubview(indicatorView)
                indicatorView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.hideLoading()
                }
                
            }
            
        }
    }
    
    func hideLoading() {
        if let window = self.window {
            if let loadingView = window.viewWithTag(54686) {
                loadingView.removeFromSuperview()
            }
        }
    }

    func showHomeAlertView(){
        guard !isBlank(UserSession.phone) else { return }
        
        let isAlert = LPDataManager.shared.homeAlertDict[UserSession.phone] ?? false
        if !isAlert{
            Request.send(api: .homeAlert) { (result:LPHomeAlertModel?) in
                if let imgUrl = result?.PTUImitablei{
                    let alertView = LPHomeAlertView(imgUrl: imgUrl,clickUrl: result?.PTUThenarditei)
                    self.window?.addSubview(alertView)
                    
                    LPDataManager.shared.homeAlertDict[UserSession.phone] = true
                }
            } failure: { error in
                
            }
            
        }
        
    }
    
    
    func showSetupAlert(tags:Int){
        let contentTxt = tags == 11 ? "Are you sure you want to log out?" : "Are you sure you want to cancel this account?"
        let alertView = LPAlertView(titleTxt: "Set up", contentTxt: contentTxt, cancelTxt: "Cancel", confirmTxt: "Confirm", alertType: .Setup)
        alertView.confirmBlock = {
            UserSession.logOut()
        }
        window?.addSubview(alertView)
    }
    
    func showLocationAlert(){
        let alertView = LPAlertView(titleTxt: "Notice", contentTxt: "We use your location data and your phone's code to determin your eligibility for our services. We need your permission to continue the process.",cancelTxt: "Agree", alertType: .sigleButton)
        alertView.cancelBlock = {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.openSys()
            }
            
        }
        window?.addSubview(alertView)
    }
    
    func showBasicAuthAlert(itemModel:LPAuthItemModel,result:@escaping((String)->Void)){
        guard let itemList = itemModel.PTUPosi else { return }
        let dialogView = LPDialogAlertView(dialogType: .sigleClick, titleTxt: itemModel.PTUTilefishi ?? "", itemList: itemList, valueType: itemModel.PTUMesenchymatousi?.string)
        dialogView.submitBlock = { valueType in
            result(valueType)
        }
        window?.addSubview(dialogView)
    }
    
    func showAuthAlert(titleTxt:String,itemList:[LPAuthSelectModel],valueType:String?=nil,result:@escaping((String)->Void)){
        let dialogView = LPDialogAlertView(dialogType: .sigleClick, titleTxt: titleTxt, itemList: itemList, valueType: valueType)
        dialogView.submitBlock = { valueType in
            result(valueType)
        }
        window?.addSubview(dialogView)
    }
    
    
    func showRetentionPopView(type:AuthStepType,result:@escaping(()->Void)){
        let titleTxt = "Are you sure you want to leave?"
        var remindTxt = ""
        var remindImg = ""
        switch type {
        case .basic:
            remindTxt = "Complete the form to apply for a loan, and we'll tailor a loan amount just for you."
            remindImg = "auth_retention_basic"
        case .ext:
            remindTxt = "Enhance your loan approval chances by providing your emergency contact information now."
            remindImg = "auth_retention_contact"
        case .photos:
            remindTxt = "Complete your identification now for a chance to increase your loan limit."
            remindImg = "auth_retention_identity"
        case .face:
            remindTxt = "Boost your credit score by completing facial recognition now."
            remindImg = "auth_retention_face"
        case .bank:
            remindTxt = "Take the final step to apply for your loan—submitting now will enhance your approval rate."
            remindImg = "auth_retention_bank"
        }
        let retentionView = LPDialogAlertView(dialogType: .remind, titleTxt: titleTxt, remindTxt: remindTxt, remindImg: remindImg, itemList: [])
        retentionView.confirmBlock = {
            result()
        }
        window?.addSubview(retentionView)
        
    }
    
    
    func showDatePicker(dateString:String?=nil,titleTxt:String?=nil,result:@escaping((String)->Void)){
        let datePicker = LPDatePickerView(dateString: dateString,titleTxt: titleTxt)
        datePicker.onDateSelected = { dateString in
            print("Selected date: \(dateString)")
            result(dateString)
        }
        window?.addSubview(datePicker)
        
    }
    

    func showPhotoAlertView(result:@escaping((Int)->Void)){
        let photoAlert = LPPhotoAlertView(cancelTxt: "Shoot Now", confirmTxt: "Local Album", imageName: "au_identity_photoAlert")
        window?.addSubview(photoAlert)
        photoAlert.clickBlock = { tags in
            result(tags)
        }
        
    }
    
    func showBankAlertView(channelStr:String,accountStr:String,result:@escaping(()->Void)){
        let bankAlert = LPAlertView(titleTxt: "Notice", contentTxt: "Please confirm your withdrawal account information belongs to yourself and is correct", cancelTxt: "Back",confirmTxt: "Confirm",channelStr: channelStr,accountStr: accountStr,alertType: .Bank)
        window?.addSubview(bankAlert)
        bankAlert.confirmBlock = {
            result()
        }
        
    }
    
}
