//
//  LPAuthBaseVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/8.
//

import UIKit

class LPAuthBaseVC: UIViewController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {
    
    var lp_title:String = ""{
        didSet{
            navigationView.titleStr = lp_title
        }
    }
    var startTime:String = ""
    
    var authType:AuthStepType
    var proID:String
    var orderNO:String
    
    init(authType: AuthStepType, proID: String, orderNO: String) {
        self.authType = authType
        self.proID = proID
        self.orderNO = orderNO
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.authType = .basic
        self.proID = ""
        self.orderNO = ""
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.interactivePopGestureRecognizer?.delegate = self;
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        navigationController?.isNavigationBarHidden = true
        navigationController?.delegate = self
        
        startTime = LPTools.currentTime()
        
        setupNavi()
        view.addSubview(contentV)
        
        switch self.authType {
        case .basic,.ext,.photos,.bank:
            view.addSubview(stepView)
            view.addSubview(nextView)
            nextView.addSubview(nextBtn)
            nextView.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(68+Device.bottomSafe)
            }
            nextBtn.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(48)
            }
            contentV.snp.makeConstraints { make in
                make.top.equalTo(stepView.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(nextView.snp.top)
            }
            
            if self.authType == .bank{
                stepView.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(Device.topNaviBar)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(0)
                }
                stepView.timeOutBlcok = {
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else { return }
                        stepView.snp.remakeConstraints { make in
                            make.top.equalToSuperview().offset(Device.topNaviBar)
                            make.left.right.equalToSuperview()
                            make.height.equalTo(0)
                        }
                    }
                }
            }else{
                stepView.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(Device.topNaviBar)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(72)
                }
                stepView.timeOutBlcok = {
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else { return }
                        stepView.snp.remakeConstraints { make in
                            make.top.equalToSuperview().offset(Device.topNaviBar)
                            make.left.right.equalToSuperview()
                            make.height.equalTo(71)
                        }
                    }
                }
            }
            
            
        case .face:
            contentV.snp.makeConstraints { make in
                make.top.equalTo(navigationView.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.delegate = nil
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self{
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let topViewController = self.navigationController?.topViewController {
            if topViewController is LPAuthBasicVC
                || topViewController is LPAuthContactVC
                || topViewController is LPAuthIdentityVC
                || topViewController is LPAuthFaceVC
                || topViewController is LPAuthBankVC{
                backBtnAction()
                return false
            }
        }
        return true
    }
    
    private func setupNavi(){
        view.addSubview(self.navigationView)
        
        navigationView.backBlock = {[weak self] in
            self?.backBtnAction()
        }
        if let model = LPDataManager.shared.customModel{
            self.navigationView.setCustomModel(model: model)
        }
        
        switch self.authType {
        case .basic:
            self.lp_title = "Basic Information"
        case .ext:
            self.lp_title = "Contact"
        case .photos:
            self.lp_title = "Identity information"
        case .face:
            self.lp_title = "Facial Recognition"
        case .bank:
            self.lp_title = "Withdrawal account"
        }
    }

    lazy var navigationView:LPNaviBar = {
        let navigationView = LPNaviBar()
        return navigationView
    }()
    
    lazy var contentV:UIView = {
        let contentV = UIView.empty()
        return contentV
    }()
    
    lazy var stepView:LPAuthStepView = {
        let stepView = LPAuthStepView(step: self.authType)
        stepView.layer.masksToBounds = true
        return stepView
    }()
    
    lazy var nextView:UIView = {
        let nextView = UIView.empty()
        return nextView
    }()
    
    lazy var nextBtn:UIButton = {
        let nextBtn = UIButton.textBtn(title: "Next",titleColor: .white,font: .font_Roboto_M(16),bgColor: mainColor38,corner: 2)
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        return nextBtn
    }()
    
    private func backBtnAction() {
        view.endEditing(true)
        Route.showRetentionPopView(type: self.authType) {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                if let _ = self.presentingViewController{
                    self.dismiss(animated: true)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    
    @objc func nextClick(){
      
    }
    
    func setCountDown(lastTime:String){
        if let times = Int(lastTime),times > 0{
            self.stepView.startCountDownWith(times: times)
            
            switch self.authType {
            case .basic,.ext,.photos:
                stepView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(Device.topNaviBar)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(140)
                }
            default:
                stepView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(Device.topNaviBar)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(58)
                }
            }
            
        }else{
            print("k-- timeString erorr:\(lastTime)")
        }
        
        
    }
    

}
