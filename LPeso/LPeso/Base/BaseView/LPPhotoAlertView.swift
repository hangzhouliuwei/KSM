//
//  LPPhotoAlertView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/12.
//

import UIKit

class LPPhotoAlertView: UIView {
    
    var clickBlock:(_ index:Int) -> Void = {_  in} //0:album 1:camera
 
    private var confirmTxt: String = "Local Album"
    private var cancelTxt: String = "Shoot Now"
    private var imageName: String = "au_identity_photoAlert"
    
    private var contentW: CGFloat = 322
    private var contentH: CGFloat = 490

    required init(cancelTxt:String = "Shoot Now", confirmTxt:String = "Local Album",imageName:String = "au_identity_photoAlert") {
        self.cancelTxt = cancelTxt
        self.confirmTxt = confirmTxt
        self.imageName = imageName
        
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
            make.center.equalToSuperview()
            make.size.equalTo(CGSizeMake(contentW, contentH))
        }
        
        let showView = UIView.lineView()
        showView.corners = 5
        bgView.addSubview(showView)
        let closeBtn = UIButton.imageBtn(imgStr: "au_photo_close")
        closeBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        bgView.addSubview(closeBtn)
        showView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        closeBtn.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 26, height: 26))
        }
        
        let imgV = UIImageView()
        imgV.imgName(imageName)
        imgV.contentMode = .scaleAspectFit
        showView.addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview().offset(2)
            make.size.equalTo(CGSizeMake(290, 290/306*433))
        }
        
        let lineView = UIView.lineView(color: gray224)
        showView.addSubview(lineView)
        
        let leftBtn = UIButton.textBtn(title: confirmTxt,titleColor: mainColor38, font: .font_Roboto_M(16), corner: 2,bordW: 1,bordColor: mainColor38)
        leftBtn.tag = 0
        leftBtn.addTarget(self, action: #selector(btnClick(_ :)), for: .touchUpInside)
        showView.addSubview(leftBtn)
        let rightBtn = UIButton.textBtn(title: cancelTxt, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
        rightBtn.tag = 1
        rightBtn.addTarget(self, action: #selector(btnClick(_ :)), for: .touchUpInside)
        showView.addSubview(rightBtn)
        leftBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(16)
            make.right.equalTo(rightBtn.snp.left).offset(-16)
            make.height.equalTo(48)
            make.width.equalTo(rightBtn.snp.width)
        }
        rightBtn.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(16)
            make.left.equalTo(leftBtn.snp.right).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(leftBtn.snp.width)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(leftBtn.snp.top).offset(-16)
            make.height.equalTo(1)
        }
        
        bgView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.animate(withDuration: 0.5) {
            self.bgView.transform = .identity
        }
    }
    
    lazy var titleView: UIView = {
        let titleView = UIView.lineView(color: gray249)
        return titleView
    }()

    
    lazy var bgView: UIView = {
        let bgView = UIView.empty()
        return bgView
    }()
    
    
    //MARK: click
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
    
    @objc func btnClick(_ sender:UIButton){
        self.clickBlock(sender.tag)
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
    
    

}
