//
//  XTDefinitions.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

// MARK: - App Constants

enum AppConstants {
    static let apiDomain = "https://api-16i.ph.dev.ksmdev.top"
    static let apiBase = apiDomain + "/api"
    static let privacyURL = apiDomain + "/#/privacyAgreement"
    static let bundleId: String = Bundle.main.bundleIdentifier ?? ""
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let appName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    static let documentPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
    static let localURLFilePath: String = documentPath + "/Locality_Url.txt"
}

// MARK: - Enums (replacing ObjC-defined XT_BackType and XT_VerifyType)

enum NavBackType {
    case white
    case black
}

enum VerifyType {
    case base
    case contact
    case identification
}

// MARK: - Screen / Layout Helpers

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

// MARK: - App Helpers

var XT_AppDelegate: AppDelegate? { UIApplication.shared.delegate as? AppDelegate }

// MARK: - String Helper

func XT_Object_To_Stirng(_ object: Any?) -> String {
    guard let object, !(object is NSNull) else { return "" }
    if let string = object as? String { return string }
    return "\(object)"
}

// MARK: - Font Helpers

func XT_Font(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size) }
func XT_Font_B(_ size: CGFloat) -> UIFont { .boldSystemFont(ofSize: size) }
func XT_Font_W(_ size: CGFloat, _ weight: UIFont.Weight) -> UIFont { .systemFont(ofSize: size, weight: weight) }
func XT_Font_M(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .medium) }
func XT_Font_SD(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .semibold) }
func XT_Font_H(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .heavy) }

// MARK: - Image Helper

func XT_Img(_ name: String) -> UIImage? { UIImage(named: name) }

// MARK: - Color Helpers

func XT_RGBA(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}

func XT_RGB(_ rgbValue: Int, _ alpha: CGFloat = 1.0) -> UIColor {
    UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

// MARK: - Debug Logging

func XTLog(_ items: Any...) {
    #if DEBUG
    print(items.map { "\($0)" }.joined(separator: " "))
    #endif
}
