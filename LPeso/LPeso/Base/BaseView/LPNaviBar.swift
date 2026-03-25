//
//  LPNaviBar.swift
//  LPeso
//
//  Created by Kiven on 2024/10/31.
//

import UIKit
import SnapKit

class LPNaviBar: UIView {
    
    var backBlock:() -> Void = {}
    
    private var rightModel:LPHomeIconModel?

    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: Device.topNaviBar))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = .white
        self.addSubview(self.titleLab)
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(self.lineView)
        
        leftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSizeMake(24, 24))
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(leftBtn)
            make.height.equalTo(20)
        }
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(leftBtn)
            make.size.equalTo(CGSizeMake(24, 24))
        }
        lineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }
    
    
    //MARK: lazy
    private lazy var lineView:UIView = {
        let lineView = UIView.lineView(color: gray204)
        return lineView
    }()
    
    private lazy var titleLab:UILabel = {
        let titleLab = UILabel.new(text: "", textColor: black51, font: .font_Roboto_M(16),alignment: .center)
        titleLab.isHidden = true
        return titleLab
    }()
    
    private lazy var leftBtn:UIButton = {
        let leftBtn = UIButton.imageBtn(imgStr: "base_black_back")
        leftBtn.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return leftBtn
    }()
    
    private lazy var rightBtn:UIButton = {
        let rightBtn = UIButton.imageBtn(imgStr: "home_service")
        rightBtn.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        rightBtn.isHidden = true
        return rightBtn
    }()
    
    @objc func leftButtonClick(){
        if hasBackButton{
            self.backBlock()
        }else{
            leftBtn.isUserInteractionEnabled = false
            Route.showMyCenter()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.leftBtn.isUserInteractionEnabled = true
            }
            
        }
        
    }
    
    @objc func rightButtonClick(){
        guard let urlStr = self.rightModel?.url else { return }
        Route.openUrl(urlStr: urlStr)
    }
    
    //MARK: interface
    public var hasLeftButton:Bool = true{
        didSet{
            leftBtn.isHidden = !hasLeftButton
        }
    }
    
    public var hasBackButton:Bool = true{
        didSet{
            if hasBackButton{
                leftBtn.setImage(UIImage(named: "base_black_back"), for: .normal)
            }else{
                leftBtn.setImage(UIImage(named: "home_mine"), for: .normal)
            }
            
        }
        
    }
    
    public var hasRightButton:Bool = true{
        didSet{
            rightBtn.isHidden = !hasRightButton
        }
        
    }
    
    public var titleStr:String{
        set{
            titleLab.text = newValue
            titleLab.isHidden = isBlank(titleStr)
        }
        get{
            titleLab.text ?? ""
        }
        
    }
    
    public func setCustomModel(model:LPHomeIconModel?){
        rightModel = model
        if let model = model,let png = model.png,let _ = model.url{
            rightBtn.isHidden = false
            rightBtn.setImg(imgUrl: png,placeholder: "home_service")
        }else{
            rightBtn.isHidden = true
        }
        
    }
    
}
