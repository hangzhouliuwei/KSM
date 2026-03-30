//
//  PKMainExtensions.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit

extension URLEncoding {
    
    func runCoding(_ defaultDict: [String: Any]) -> String {
        var runWei: [(String, String)] = []

        for key in defaultDict.keys.sorted(by: <) {
            let value = defaultDict[key]!
            runWei += queryComponents(fromKey: key, value: value)
        }
        return runWei.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}


extension UIColor {

    convenience init?(hex: String, alpha: CGFloat = 1) {

        var hex = hex

        if hex.hasPrefix("#") {

            let index = hex.index(after: hex.startIndex)
            hex = String(hex[index...])
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0

        if scanner.scanHexInt64(&hexValue) {

            switch hex.count {
            case 3:
                red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
                blue = CGFloat(hexValue & 0x00F) / 15.0
            case 6:
                red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexValue & 0x0000FF) / 255.0
            default:
                return nil
            }
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

  
    convenience init?(rgba: String) {

        var rgba = rgba

        if rgba.hasPrefix("#") {

            let index = rgba.index(after: rgba.startIndex)
            rgba = String(rgba[index...])
        }

        let scanner = Scanner(string: rgba)
        var rgbaValue: CUnsignedLongLong = 0

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1

        if scanner.scanHexInt64(&rgbaValue) {

            switch rgba.count {
            case 3:
                red = CGFloat((rgbaValue & 0xF00) >> 8) / 15.0
                green = CGFloat((rgbaValue & 0x0F0) >> 4) / 15.0
                blue = CGFloat(rgbaValue & 0x00F) / 15.0
            case 4:
                red = CGFloat((rgbaValue & 0xF000) >> 12) / 15.0
                green = CGFloat((rgbaValue & 0x0F00) >> 8) / 15.0
                blue = CGFloat((rgbaValue & 0x00F0) >> 4) / 15.0
                alpha = CGFloat(rgbaValue & 0x000F) / 15.0
            case 6:
                red = CGFloat((rgbaValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((rgbaValue & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(rgbaValue & 0x0000FF) / 255.0
            case 8:
                red = CGFloat((rgbaValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((rgbaValue & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((rgbaValue & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(rgbaValue & 0x000000FF) / 255.0
            default:
                return nil
            }
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}

extension UIView {
    
    var x: CGFloat {
        get { frame.origin.x }
        set { frame.origin.x = newValue }
    }
    
    var y: CGFloat {
        get { frame.origin.y }
        set { frame.origin.y = newValue }
    }
    
    var width: CGFloat {
        get { frame.size.width }
        set { frame.size.width = newValue }
    }
    
    var height: CGFloat {
        get { frame.size.height }
        set { frame.size.height = newValue }
    }
    
    var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    var origin: CGPoint {
        get { frame.origin }
        set { frame.origin = newValue }
    }
    
    var size: CGSize {
        get { frame.size }
        set { frame.size = newValue }
    }
    
    var centerX: CGFloat {
        get { center.x }
        set { center.x = newValue }
    }
    
    var centerY: CGFloat {
        get { center.y }
        set { center.y = newValue }
    }
    
    public var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue != 0
        }
    }
}


