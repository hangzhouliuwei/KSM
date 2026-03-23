//
//  LPHomeAlertView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/18.
//

import UIKit
import SnapKit

class LPHomeAlertView: UIView {
    
    var imgUrl:String
    var clickUrl:String?

    required init(imgUrl: String,clickUrl:String? = nil) {
        self.imgUrl = imgUrl
        self.clickUrl = clickUrl
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeigth))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = transColor
        isUserInteractionEnabled = true
        
        loadImage()
        addSubview(pictureImg)
        pictureImg.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(pictureImg.snp.top).offset(20)
            make.right.equalTo(pictureImg.snp.right).offset(-20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
    }
    
    private lazy var pictureImg:UIImageView = {
        let pictureImg = UIImageView()
        pictureImg.contentMode = .scaleAspectFit
        pictureImg.isUserInteractionEnabled = true
        let tpas = UITapGestureRecognizer(target: self, action: #selector(pictureClick))
        pictureImg.addGestureRecognizer(tpas)
        return pictureImg
    }()
    
    @objc private func pictureClick() {
        if let clickUrl = clickUrl{
            self.removeFromSuperview()
            Route.openUrl(urlStr: clickUrl)
        }
    }
    
    private lazy var closeBtn:UIButton = {
        let closeBtn = UIButton()
        closeBtn.imgName(imageName: "home_close")
        closeBtn.addTarget(self, action: #selector(closeImg), for: .touchUpInside)
        return closeBtn
    }()
    
    @objc func closeImg(){
        UIView.animate(withDuration: 0.2) {
            self.pictureImg.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { isDone in
            if isDone{
                self.removeFromSuperview()
            }
        }
    }
    
    
    private func loadImage() {
        let imageUrl = URL(string: self.imgUrl)!
        pictureImg.kf.setImage(with: imageUrl) { [weak self] result in
            switch result {
            case .success(let value):
                self?.adjustImageViewSize(for: value.image)
            case .failure(let error):
                print("k--- loadImage failure: \(error)")
                self?.removeFromSuperview()
            }
        }
    }
        
    private func adjustImageViewSize(for image: UIImage) {
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let targetWidth = kWidth - 40
        let targetHeight = targetWidth * (imageHeight / imageWidth)
        
        if targetHeight > kHeigth - 80 {
            let adjustedHeight = kHeigth - 80
            let adjustedWidth = adjustedHeight * (imageWidth / imageHeight)
            pictureImg.frame = CGRect(x: (kWidth - adjustedWidth) / 2, y: 20, width: adjustedWidth, height: adjustedHeight)
        } else {
            pictureImg.frame = CGRect(x: 20, y: (kHeigth - targetHeight) / 2, width: targetWidth, height: targetHeight)
        }
    }

}
