//
//  Extensions.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import Foundation
import UIKit
import Kingfisher

//MARK: UIView
extension UIView{
    
    public class func empty() ->UIView{
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        emptyView.layer.masksToBounds = true
        return emptyView
    }
    
    public class func lineView(color:UIColor = .white,masks:Bool=true) ->UIView{
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.layer.masksToBounds = masks
        return lineView
    }
    
    public var corners: CGFloat{
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    public var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    public func removeAllSubviews() {
        self.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    enum CornerType{
        case top,bottom,left,right
    }
    
    func partCorners(_ corner:CGFloat,type:CornerType){
        layer.masksToBounds = true
        layer.cornerRadius = corner
        switch type {
        case .top:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .left:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .right:
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
        
    }
    
    public func addGradient(colors: [CGColor], start:CGPoint = CGPoint(x: 0.5, y: 0), end:CGPoint = CGPoint(x: 0.5, y: 1)) {
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func addShadow(){
        self.layer.shadowColor = gray224.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4
    }
 
}


//MARK: UIFont
extension UIFont{
    
    public class func font_Roboto_R(_ a:CGFloat) ->UIFont{
        return UIFont(name: "Roboto-Regular", size: a) ?? UIFont.systemFont(ofSize: a)
    }
    public class func font_Roboto_M(_ a:CGFloat) ->UIFont{
        return UIFont(name: "Roboto-Medium", size: a) ?? UIFont.systemFont(ofSize: a)
    }
    
    public class func font_PingFangSC_R(_ a:CGFloat) ->UIFont{
        return UIFont(name: "PingFangSC-Regular", size: a) ?? UIFont.systemFont(ofSize: a)
    }
    public class func font_PingFangSC_M(_ a:CGFloat) ->UIFont{
        return UIFont(name: "PingFangSC-Medium", size: a) ?? UIFont.systemFont(ofSize: a)
    }
    
    public class func font_Helvetica_B(_ a:CGFloat) ->UIFont{
        return UIFont(name: "Helvetica-Bold", size: a) ?? UIFont.systemFont(ofSize: a)
    }
    public class func font_HelveticaNeue_BI(_ a:CGFloat) ->UIFont{
        return UIFont(name: "HelveticaNeue-BoldItalic", size: a) ?? UIFont.systemFont(ofSize: a)
    }
    
}


//MARK: UIImage
extension UIImage {
    public func compressImage(toLength length: Int = 1) -> Data? {
        let maxL = length * 1024 * 1024
        var compress:CGFloat = 0.9
        let maxCompress:CGFloat = 0.1
        var imageData = self.jpegData(compressionQuality: compress)
        while (imageData?.count)! > maxL && compress > maxCompress {
            compress -= 0.1
            imageData = self.jpegData(compressionQuality: compress)
        }
        return imageData
    }
  
    
}

//MARK: UIImageView
extension UIImageView{

    func setImage(urlString: String?, placeholder: String? = nil, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        guard let urlString = urlString else { return }
        if let url = URL(string: urlString) {
            if let placeholder = placeholder {
                self.kf.setImage(with: url, placeholder: UIImage(named: placeholder), completionHandler: completionHandler)
            } else {
                self.kf.setImage(with: url, completionHandler: completionHandler)
            }
        } else if let placeholder = placeholder {
            self.image = UIImage(named: placeholder)
        }
    }
    
    static func nameWith(_ imgName:String) ->UIImageView{
        let imgV = UIImageView()
        imgV.image = UIImage(named: imgName)
        imgV.contentMode = .scaleAspectFit
        return imgV
    }
    
    func imgName(_ imgName:String){
        self.image = UIImage(named: imgName)
    }
    
}

//MARK: UIColor
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }

        return nil
    }
    
    public class func rgba(_ red:CGFloat,_ green:CGFloat,_ blue:CGFloat,_ alpha:CGFloat=1.0) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
}

//MARK: UIButton
extension UIButton {
    
    static func emptyBtn() ->UIButton{
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }
    
    static func textBtn(title: String? = nil, titleColor: UIColor = .white, font: UIFont = UIFont.systemFont(ofSize: 15),bgColor:UIColor = .clear, corner:CGFloat?=nil, bordW: CGFloat? = nil, bordColor:UIColor?=nil) -> UIButton{
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = bgColor
        if let corner = corner{
            button.layer.cornerRadius = corner
            button.layer.masksToBounds = true
        }
        if let bordW = bordW{
            button.borderWidth = bordW
        }
        if let bordColor = bordColor{
            button.borderColor = bordColor
        }
        return button
    }
    
    static func imageBtn(imgStr:String) -> UIButton{
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imgStr), for: .normal)
        return button
    }
    
    public var title:String {
        get {
            return self.title(for: .normal) ?? ""
        }
        set(value) {
            self.setTitle(value, for: .normal)
        }
    }
    
    public func setImg(imgUrl:String?,placeholder:String?=nil) {
        guard let imgUrl = imgUrl,let url = URL(string: imgUrl) else { return }
        
        if let placeholder = placeholder {
            self.kf.setImage(with: url, for: .normal, placeholder: UIImage(named: placeholder))
        }else{
            self.kf.setImage(with: url, for: .normal)
        }
    }
    
    public func imgName(imageName:String,state:UIControl.State = .normal) {
        self.setImage(UIImage(named: imageName), for: state)
    }
    
}


//MARK: UILabel
extension UILabel {
    
    static func new(text: String?, textColor: UIColor?, font: UIFont?, alignment: NSTextAlignment = .left, lines:Int = 1, isAjust:Bool = false) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = textColor ?? black51
        label.font = font ?? UIFont.systemFont(ofSize: 15)
        label.textAlignment = alignment
        label.numberOfLines = lines
        if isAjust{
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
        }
        return label
    }
}


//MARK: String
extension String {
    func modify() -> String {
        let length = self.count
        if length <= 6 {
            return self
        } else {
            let start = self.prefix(3)
            let end = self.suffix(3)
            return String(start) + "***" + String(end)
        }
    }
    
    func equalsIgnoreCase(_ other: String) -> Bool {
        return self.lowercased() == other.lowercased()
    }
    
}


extension URL{
    
    func parameters() -> [String: String] {
        var params = [String: String]()
        if let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false),
           let queryItems = urlComponents.queryItems {
            for queryItem in queryItems {
                params[queryItem.name] = queryItem.value
            }
        }
        return params
    }
    
}




