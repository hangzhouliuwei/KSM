//
//  PKHomePopUPView.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/17.
//

import UIKit

class PKHomePopUPView: UIView {

    private var model: JSON
            var confirmBlock: PKStingBlock?
    init(jsonModel:JSON){
        self.model = jsonModel
        super.init(frame: .zero)
        certPKHomePopUPViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
           self.alpha = 1
           UIApplication.shared.windows.first?.addSubview(self)

           let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
           scaleAnimation.values = [0.1, 1.1, 0.9, 1.0]
           scaleAnimation.calculationMode = .linear

           let animationGroup = CAAnimationGroup()
           animationGroup.animations = [scaleAnimation]
           animationGroup.duration = 0.5
           self.alertView.layer.add(animationGroup, forKey: nil)
       }
    
    private func certPKHomePopUPViewUI() {
           self.frame = CGRect(x: 0, y: 0, width: width_PK_bounds, height: height_PK_bounds)
           let backButton = UIButton(type: .custom)
           backButton.frame = self.frame
           backButton.backgroundColor = UIColor.black.withAlphaComponent(0.7)
           backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
           self.addSubview(backButton)

          
           let alertWidth: CGFloat = 320
           let alertHeight: CGFloat = 306
           alertView.frame = CGRect(x: 0, y: 0, width: alertWidth, height: alertHeight)
           alertView.backgroundColor = .clear
           alertView.center = self.center
           alertView.layer.cornerRadius = 16
           alertView.clipsToBounds = true
           self.addSubview(alertView)

          
           let logoImageView = UIImageView()
           logoImageView.isUserInteractionEnabled = true
           logoImageView.frame = CGRect(x: 0, y: 0, width: alertWidth, height: alertHeight)
           alertView.addSubview(logoImageView)
           logoImageView.kf.setImage(with: URL(string: self.model["TNyxqSeThermonukePsrZfLM"].stringValue))

           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           logoImageView.addGestureRecognizer(tapGesture)

         
           let closeButton = UIButton(type: .custom)
           closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
           closeButton.setImage(UIImage(named: "pk_home_popClose"), for: .normal)
           closeButton.backgroundColor = .clear
           closeButton.frame.size = CGSize(width: 60, height: 40)
           closeButton.center = CGPoint(x: alertView.center.x, y: alertView.frame.maxY + 30)
           self.addSubview(closeButton)
       }

       @objc private func handleTap() {
           hide()
           confirmBlock?(model["frPFiGQHarkFDGovYI"].stringValue)
       }

       private func hide() {
           UIView.animate(withDuration: 0.3, animations: {
               self.alpha = 0
           }) { _ in
               self.removeFromSuperview()
           }
       }

       @objc private func closeButtonTapped() {
           hide()
       }

       @objc private func backButtonTapped() {
           hide()
       }
    
    lazy var alertView: UIView = {
        let alertView = UIView()
        return alertView
    }()
}
