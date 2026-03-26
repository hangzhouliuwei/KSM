//
//  LPDefine.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit


#if DEBUG
let LPBase_api = "http://api-100i.ph.dev.ksmdev.top"
#else
let LPBase_api = "http://api-100i.ph.dev.ksmdev.top"
#endif
let LP_Privacy = LPBase_api + "/#/privacyAgreement"

let kWidth = UIScreen.main.bounds.size.width
let kHeigth = UIScreen.main.bounds.size.height

func kScaleX(_ float: CGFloat) -> CGFloat {
    return float * (kWidth / 375.0)
}
func kScaleY(_ float: CGFloat) -> CGFloat {
    return float * (kHeigth / 667.0)
}

func isBlank(_ string: String?) -> Bool {
    if string == nil {
        return true
    }
    if string!.isEmpty {
        return true
    }
    return false
}


let Mine_noti = NSNotification.Name("Mine_noti")


//MARK: UIColor
let mainColor38:UIColor = .rgba(38, 66, 251)
let mainColor46:UIColor = .rgba(46, 14, 223)
let mainColor195:UIColor = .rgba(195, 219, 255)
let mainColor241:UIColor = .rgba(241, 247, 254)

let transColor:UIColor = .rgba(0, 0, 0, 0.40)

let black2:UIColor = .rgba(2, 9, 38)
let black13:UIColor = .rgba(13, 14, 14)
let black33:UIColor = .rgba(33, 33, 33)
let black51:UIColor = .rgba(51, 51, 51)

let gray102:UIColor = .rgba(102, 102, 102)
let gray128:UIColor = .rgba(128, 128, 128)
let gray153:UIColor = .rgba(153, 153, 153)
let gray195:UIColor = .rgba(195, 195, 195)
let gray204:UIColor = .rgba(204, 204, 204)
let gray224:UIColor = .rgba(224, 224, 224)
let gray249:UIColor = .rgba(249, 249, 249)

let tabBgColor:UIColor = .rgba(237, 239, 243)
let reSendColor:UIColor = .rgba(118, 149, 255)
let notiColor:UIColor = .rgba(245, 150, 38, 1)
let alertBgColor:UIColor = .rgba(127, 126, 129)



