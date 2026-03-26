//
//  LPAlertView.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit
import SnapKit

enum AlertType{
    case sigleButton,twiceButton,Setup,Bank
}

class LPAlertView: UIView {
    
    var confirmBlock:() -> Void = {}
    var cancelBlock:() -> Void = {}
    
    private var alertType:AlertType = .sigleButton
    
    private var titleTxt: String = ""
    private var contentTxt: String = ""
    
    private var cancelTxt: String = "Cancel"
    private var confirmTxt: String = "Confirm"
    
    private var channelStr: String = ""
    private var accountStr: String = ""
    
    private var titleH: CGFloat = 48
    private var contentH: CGFloat = 141
    private var clickH: CGFloat = 74

    required init(titleTxt: String ,contentTxt : String, cancelTxt:String, confirmTxt:String = "Confirm",channelStr:String="",accountStr:String="",alertType:AlertType = .sigleButton) {
        self.titleTxt = titleTxt
        self.contentTxt = contentTxt
        self.cancelTxt = cancelTxt
        self.confirmTxt = confirmTxt
        self.alertType = alertType
        self.channelStr = channelStr
        self.accountStr = accountStr
        switch alertType {
        case .sigleButton:
            self.contentH = 141
        case .twiceButton:
            self.contentH = 114
        case .Setup:
            self.contentH = 114
        case .Bank:
            self.contentH = 144
        }
        
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeigth))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        self.backgroundColor = transColor
        
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(28)
            make.centerY.equalToSuperview().offset(-20)
            make.height.equalTo(titleH+contentH+clickH)
        }
        
        let titleView = UIView.lineView(color: gray249)
        titleView.borderColor = gray224
        titleView.borderWidth = 1
        titleView.corners = 2
        let contentView = UIView.empty()
        let clickView = UIView.empty()
        bgView.addSubview(titleView)
        bgView.addSubview(contentView)
        bgView.addSubview(clickView)
        
        titleView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(titleH)
        }
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom)
            make.bottom.equalTo(clickView.snp.top)
        }
        clickView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(clickH)
        }
        
        //titleView
        let titleLab = UILabel.new(text: titleTxt, textColor: black13, font: .font_Roboto_M(16))
        let closeBtn = UIButton.imageBtn(imgStr: "base_close_btn")
        closeBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        titleView.addSubview(titleLab)
        titleView.addSubview(closeBtn)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(closeBtn.snp.left).offset(-4)
            make.centerY.equalToSuperview()
        }
        closeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSizeMake(24, 24))
        }
        
        //contentView
        let contentLab = UILabel.new(text: contentTxt, textColor: black51, font: .font_Roboto_M(16),alignment: .center,lines: 0,isAjust: true)
        contentView.addSubview(contentLab)
        

        switch self.alertType {
        case .sigleButton:
            //MARK: sigleButton
            contentLab.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8)
            }
            
            clickView.borderColor = gray224
            clickView.borderWidth = 1
            clickView.corners = 2
            
            let cancelBtn = UIButton.textBtn(title: cancelTxt, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
            cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
            clickView.addSubview(cancelBtn)
            cancelBtn.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(16)
            }
            
        case .twiceButton:
            //MARK: twiceButton
            contentLab.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8)
            }
            
            let cancelBtn = UIButton.textBtn(title: cancelTxt, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
            cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
            clickView.addSubview(cancelBtn)
            let confirmBtn = UIButton.textBtn(title: confirmTxt,titleColor: mainColor38, font: .font_Roboto_M(16), corner: 2,bordW: 1,bordColor: mainColor38)
            confirmBtn.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
            clickView.addSubview(confirmBtn)
            confirmBtn.snp.makeConstraints { make in
                make.left.bottom.equalToSuperview().inset(15)
                make.right.equalTo(cancelBtn.snp.left).offset(-16)
                make.width.equalTo(cancelBtn.snp.width)
                make.height.equalTo(42)
            }
            cancelBtn.snp.makeConstraints { make in
                make.right.bottom.equalToSuperview().inset(15)
                make.left.equalTo(confirmBtn.snp.right).offset(16)
                make.width.equalTo(confirmBtn.snp.width)
                make.height.equalTo(42)
            }
            
        case .Setup:
            //MARK: Setup
            let cancelBtn = UIButton.textBtn(title: cancelTxt, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
            cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
            clickView.addSubview(cancelBtn)
            let confirmBtn = UIButton.textBtn(title: confirmTxt,titleColor: mainColor38, font: .font_Roboto_M(16), corner: 2,bordW: 1,bordColor: mainColor38)
            confirmBtn.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
            clickView.addSubview(confirmBtn)
            confirmBtn.snp.makeConstraints { make in
                make.left.bottom.equalToSuperview().inset(15)
                make.right.equalTo(cancelBtn.snp.left).offset(-16)
                make.width.equalTo(cancelBtn.snp.width)
                make.height.equalTo(42)
            }
            cancelBtn.snp.makeConstraints { make in
                make.right.bottom.equalToSuperview().inset(15)
                make.left.equalTo(confirmBtn.snp.right).offset(16)
                make.width.equalTo(confirmBtn.snp.width)
                make.height.equalTo(42)
            }
            
            let setuplImgV = UIImageView()
            setuplImgV.imgName("login_img1")
            contentView.addSubview(setuplImgV)
            contentLab.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-18)
                make.left.top.equalToSuperview().offset(26)
                make.right.equalTo(setuplImgV.snp.left).offset(-28)
            }
            setuplImgV.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-28)
                make.bottom.equalToSuperview()
                make.size.equalTo(CGSizeMake(98, 104))
            }
            
        case .Bank:
            //MARK: - Bank
            contentLab.font = .font_Roboto_R(14)
            contentLab.textAlignment = .left
            contentLab.snp.makeConstraints { make in
                make.left.right.top.equalToSuperview().inset(16)
                make.height.equalTo(34)
            }
            
            //bankinfo
            let infoView = UIView.lineView(color: mainColor241)
            infoView.corners = 4
            contentView.addSubview(infoView)
            infoView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.top.equalTo(contentLab.snp.bottom).offset(14)
                make.height.equalTo(60)
            }
            
            let typeTitle = UILabel.new(text: "Channel/Bank", textColor: black51, font: .font_Roboto_R(14))
            let typeStr = UILabel.new(text: channelStr, textColor: black51, font: .font_Roboto_R(14),alignment: .right,isAjust: true)
            let accountTitle = UILabel.new(text: "Account number", textColor: black51, font: .font_Roboto_R(14))
            let accountStr = UILabel.new(text: accountStr, textColor: black51, font: .font_Roboto_R(14),alignment: .right)
            infoView.addSubview(typeTitle)
            infoView.addSubview(typeStr)
            infoView.addSubview(accountTitle)
            infoView.addSubview(accountStr)
            typeTitle.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.top.equalToSuperview().offset(10)
                make.height.equalTo(16)
            }
            typeStr.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-16)
                make.centerY.equalTo(typeTitle)
                make.height.equalTo(16)
                make.left.equalTo(typeTitle.snp.right).offset(4)
            }
            accountTitle.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().offset(-10)
                make.height.equalTo(16)
            }
            accountStr.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-16)
                make.centerY.equalTo(accountTitle)
                make.height.equalTo(16)
                make.left.equalTo(accountTitle.snp.right).offset(4)
            }
            
            let backBtn = UIButton.textBtn(title: cancelTxt,titleColor: mainColor38, font: .font_Roboto_M(16), corner: 2,bordW: 1,bordColor: mainColor38)
            backBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
            clickView.addSubview(backBtn)
            let confirmBtn = UIButton.textBtn(title: confirmTxt, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
            confirmBtn.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
            clickView.addSubview(confirmBtn)
            backBtn.snp.makeConstraints { make in
                make.left.bottom.equalToSuperview().inset(16)
                make.right.equalTo(confirmBtn.snp.left).offset(-16)
                make.width.equalTo(confirmBtn.snp.width)
                make.height.equalTo(42)
            }
            confirmBtn.snp.makeConstraints { make in
                make.right.bottom.equalToSuperview().inset(16)
                make.left.equalTo(backBtn.snp.right).offset(16)
                make.width.equalTo(backBtn.snp.width)
                make.height.equalTo(42)
            }
            
        }
        
        bgView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.animate(withDuration: 0.5) {
            self.bgView.transform = .identity
        }
    }
    
    
    //MARK: lazy
    lazy var titleView: UIView = {
        let titleView = UIView.lineView(color: gray249)
        return titleView
    }()

    
    lazy var bgView: UIView = {
        let bgView = UIView.lineView()
        bgView.corners = 2
        return bgView
    }()
    
    
    //MARK: click func
    @objc func closeClick(){
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { isDone in
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                if isDone{
                    self.removeFromSuperview()
                }
            }
            
        }
    }
    
    @objc func cancelClick(){
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { isDone in
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                if isDone{
                    self.cancelBlock()
                    self.removeFromSuperview()
                }
            }
            
        }
    }
    
    @objc func confirmClick(){
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { isDone in
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                if isDone{
                    self.confirmBlock()
                    self.removeFromSuperview()
                }
            }
            
        }
    }
    
    

}
