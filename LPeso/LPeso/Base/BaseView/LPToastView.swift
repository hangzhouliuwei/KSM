//
//  LPToastView.swift
//  LPeso
//
//  Created by Kiven on 2024/10/30.
//

import UIKit

class LPToastView: UIView {

    required init(title: String, delay:CGFloat = 1.5) {
        let maxSize = CGSize(width: kWidth*0.8-20, height: kHeigth*0.8-20)
        let textRect = (title as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)], context: nil)
        let hei = textRect.height + 20
        let wid = (textRect.width + 20) > 72 ? (textRect.width + 20) : 72
        let positionY:CGFloat = (kHeigth-hei)/2
        super.init(frame: CGRectMake((kWidth-wid)/2, positionY, wid, hei))
        showView(str:title,deadLine: delay)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showView(str: "",deadLine: 1.5)
    }
    
    func showView(str:String,deadLine:CGFloat){
        self.backgroundColor = .black.withAlphaComponent(0.8)
        self.corners = 14
        
        let titleLab = UILabel.new(text: str, textColor: .white, font: UIFont.boldSystemFont(ofSize: 14),alignment: .center,lines: 0)
        titleLab.frame = CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)
        self.addSubview(titleLab)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.removeFromSuperview()
        }
        
    }

}
