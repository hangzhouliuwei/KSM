//
//  XTUtility.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import AVFoundation
import MBProgressHUD
import Photos
import UIKit
import YYModel

private let xtAlertDuration: TimeInterval = 2
private let xtAlertCenter = "center"

@objcMembers
@objc(XTUtility)
class XTUtility: NSObject {
    private static let shared = XTUtility()

    @objc class func xt_share() -> XTUtility {
        shared
    }

    @objc(xt_showProgress:message:)
    class func xt_showProgress(_ view: UIView?, message msg: String?) {
        guard let targetView = view ?? XT_AppDelegate?.window else { return }
        let hud = MBProgressHUD.showAdded(to: targetView, animated: true)
        hud.mode = .indeterminate
        hud.label.text = msg
    }

    @objc(xt_hideProgress:)
    class func xt_hideProgress(_ view: UIView?) {
        DispatchQueue.main.async {
            guard let targetView = view ?? XT_AppDelegate?.window else { return }
            MBProgressHUD.hide(for: targetView, animated: false)
        }
    }

    @objc(xt_atHideProgress:)
    class func xt_atHideProgress(_ view: UIView?) {
        guard let targetView = view ?? XT_AppDelegate?.window else { return }
        MBProgressHUD.hide(for: targetView, animated: false)
    }

    @objc(xt_objectToJSONString:)
    class func xt_objectToJSONString(_ obj: Any?) -> String? {
        guard let obj else { return nil }
        if let string = obj as? String {
            return string
        }
        if let model = obj as? NSObject,
           (obj is NSDictionary || obj is NSArray || obj is [Any] || obj is [AnyHashable: Any]) {
            return model.yy_modelToJSONString()
        }
        if JSONSerialization.isValidJSONObject(obj),
           let data = try? JSONSerialization.data(withJSONObject: obj, options: []),
           let string = String(data: data, encoding: .utf8) {
            return string
        }
        return nil
    }

    @objc(xt_showTips:view:)
    class func xt_showTips(_ str: String?, view: UIView?) {
        guard let str, !str.isEmpty else { return }
        DispatchQueue.main.async {
            if let view {
                view.makeToast(str, duration: xtAlertDuration, position: xtAlertCenter, title: nil)
            } else {
                XT_AppDelegate?.window?.makeToast(str, duration: xtAlertDuration, position: xtAlertCenter, title: nil)
            }
        }
    }

    @objc(xt_removeFileWithPath:)
    func xt_removeFile(withPath path: String?) {
        guard let path, FileManager.default.fileExists(atPath: path) else { return }
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            XTLog("删除文件失败:", error)
        }
    }

    @objc(xt_urlEncode:)
    class func xt_urlEncode(_ urlStr: String?) -> String {
        urlStr?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }

    @objc func xt_nowTimeStamp() -> String {
        "\(UInt64(Date().timeIntervalSince1970))000"
    }

    @objc(xt_saveImg:path:)
    func xt_saveImg(_ imgData: Data?, path: String?) -> String {
        let fillPath: String
        if NSString.xt_isEmpty(path) {
            fillPath = "\(XT_DocumentPath)/\(xt_nowTimeStamp()).jpg"
        } else {
            fillPath = path ?? ""
        }
        try? imgData?.write(to: URL(fileURLWithPath: fillPath))
        return fillPath
    }

    @objc class func xt_getCurrentVC() -> UIViewController? {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != .normal {
            window = UIApplication.shared.windows.first { $0.windowLevel == .normal }
        }
        guard let window else { return nil }
        if let frontView = window.subviews.first,
           let nextResponder = frontView.next {
            return nextResponder as? UIViewController ?? window.rootViewController
        }
        return window.rootViewController
    }

    @objc class func xt_getCurrentVCInNav() -> UIViewController? {
        let current = xt_getCurrentVC()
        if let nav = current as? UINavigationController {
            return nav.visibleViewController
        }
        return current
    }

    @objc(xt_checkPhotoAuthorization:)
    class func xt_checkPhotoAuthorization(_ successBlock: XTBoolBlock?) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    successBlock?(true)
                } else {
                    presentSettingsAlert(
                        message: "Please allow access to your phone's albums in the Settings - Privacy - Albums option on your iPhone"
                    )
                    successBlock?(false)
                }
            }
        }
    }

    @objc(xt_checkAVCaptureAuthorization:)
    class func xt_checkAVCaptureAuthorization(_ successBlock: XTBoolBlock?) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    successBlock?(true)
                } else {
                    presentSettingsAlert(
                        message: "Please allow access to your phone's camera in the Settings - Privacy - Camera option on your iPhone"
                    )
                    successBlock?(false)
                }
            }
        }
    }

    private class func presentSettingsAlert(message: String) {
        let alert = UIAlertController(title: "Tips", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        xt_getCurrentVCInNav()?.xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }

    @objc(xt_objectFromJSON:)
    class func xt_objectFromJSON(_ json: Any?) -> Any? {
        guard let json else { return nil }
        if json is NSDictionary || json is NSArray {
            return json
        }
        let data: Data?
        if let json = json as? Data {
            data = json
        } else if let json = json as? String {
            data = json.data(using: .utf8)
        } else {
            data = nil
        }
        guard let data else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch {
            XTLog("json解析失败:", error)
            return nil
        }
    }

    @objc(xt_login:)
    class func xt_login(_ block: XTBlock?) {
        guard let currentVC = xt_getCurrentVCInNav() else { return }
        let className = NSStringFromClass(type(of: currentVC))
        if className.contains("XTLoginCodeVC") || className.contains("XTLoginVC") {
            return
        }
        let loginVC = XTLoginCodeVC()
        let nav = XTNavigationController(rootViewController: loginVC)
        currentVC.xt_presentViewController(nav, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
        loginVC.loginBlock = block
    }
}
