//
//  XTDefinitions.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

let XT_Api_domain = "https://api-16i.ph.dev.ksmdev.top"
let XT_Api_api = "/api"
let XT_Api = XT_Api_domain + XT_Api_api
let XT_Privacy_Url = XT_Api_domain + "/#/privacyAgreement"

var XT_Screen_Width: CGFloat { UIScreen.main.bounds.width }
var XT_Screen_Height: CGFloat { UIScreen.main.bounds.height }
var XT_StatusBar_Height: CGFloat { UIApplication.shared.statusBarFrame.size.height }
var XT_Is_iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
var XT_NavBar_Height: CGFloat { XT_Is_iPhone ? 44.0 : 50.0 }
var XT_Nav_Height: CGFloat { XT_StatusBar_Height + XT_NavBar_Height }
var XT_Bottom_Height: CGFloat {
    UIApplication.shared.windows.first { $0.isKeyWindow }?.safeAreaInsets.bottom ?? 0
}
var XT_Tabbar_Height: CGFloat {
    XT_Is_iPhone ? XT_Bottom_Height + 49.0 : (XT_Bottom_Height == 20.0 ? 65.0 : 50.0)
}

var XT_DocumentPath: String {
    NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
}

var XT_Locality_Url_Path: String { XT_DocumentPath + "/Locality_Url.txt" }
var XT_AppDelegate: AppDelegate? { UIApplication.shared.delegate as? AppDelegate }
var XT_App_BundleId: String { Bundle.main.bundleIdentifier ?? "" }
var XT_App_Version: String { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }
var XT_App_Name: String { Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "" }

func XT_Object_To_Stirng(_ object: Any?) -> String {
    guard let object, !(object is NSNull) else { return "" }
    if let string = object as? String {
        return string
    }
    return "\(object)"
}

func XT_Font(_ size: CGFloat) -> UIFont {
    .systemFont(ofSize: size)
}

func XT_Font_B(_ size: CGFloat) -> UIFont {
    .boldSystemFont(ofSize: size)
}

func XT_Font_W(_ size: CGFloat, _ weight: UIFont.Weight) -> UIFont {
    .systemFont(ofSize: size, weight: weight)
}

func XT_Font_M(_ size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .medium)
}

func XT_Font_SD(_ size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .semibold)
}

func XT_Font_H(_ size: CGFloat) -> UIFont {
    .systemFont(ofSize: size, weight: .heavy)
}

func XT_Img(_ name: String) -> UIImage? {
    UIImage(named: name)
}

func XT_RGBA(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}

func XT_RGB(_ rgbValue: Int, _ alpha: CGFloat) -> UIColor {
    UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

func XT_Controller_Init(_ controllerName: String) -> UIViewController {
    (NSClassFromString(controllerName) as? NSObject.Type)?.init() as? UIViewController ?? UIViewController()
}

func XTLog(_ items: Any...) {
#if DEBUG
    print(items.map { "\($0)" }.joined(separator: " "))
#endif
}
