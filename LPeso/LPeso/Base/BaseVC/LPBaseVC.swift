//
//  LPBaseVC.swift
//  LPeso
//
//  Created by Kiven on 2024/10/31.
//

import UIKit
import SnapKit

class LPBaseVC: UIViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    var startTime:String = ""
    
    var pro_id:String = ""
    
    var lp_title:String = ""{
        didSet{
            navigationView.titleStr = lp_title
        }
    }
    
    var hasLeftButton:Bool = true{
        didSet{
            navigationView.hasLeftButton = hasLeftButton
        }
    }
    
    var hasBackButton:Bool = true{
        didSet{
            navigationView.hasBackButton = hasBackButton
        }
    }
    
    var hasRightButton:Bool = true{
        didSet{
            navigationView.hasRightButton = hasRightButton
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.interactivePopGestureRecognizer?.delegate = self;
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        navigationController?.isNavigationBarHidden = true
        navigationController?.delegate = self
        setupNavi()
        setupContentV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.delegate = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
                backBtnAction()
                return false
        }
        return true
    }
    
    private func setupNavi(){
        view.addSubview(self.navigationView)
        navigationView.backBlock = {[weak self] in
            self?.backBtnAction()
        }
        if let model = LPDataManager.shared.customModel{
            self.setCustomModel(model: model)
        }
    }
    
    private func setupContentV(){
        view.addSubview(contentV)
        contentV.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private lazy var navigationView:LPNaviBar = {
        let navigationView = LPNaviBar()
        return navigationView
    }()
    
    lazy var contentV:UIView = {
        let contentV = UIView.empty()
        return contentV
    }()
    
    func backBtnAction() {
        if let _ = self.presentingViewController{
            self.dismiss(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    @objc func backToHome(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func pushVC(vc:UIViewController, animated:Bool = true) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func preVC(vc:UIViewController, animated:Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: animated, completion: nil)
    }
    
    public func setCustomModel(model:LPHomeIconModel?){
        self.navigationView.setCustomModel(model: model)
    }
    
}

