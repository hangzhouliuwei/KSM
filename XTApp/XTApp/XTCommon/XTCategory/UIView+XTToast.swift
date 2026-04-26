//
//  UIView+XTToast.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import ObjectiveC
import UIKit

private let xtToastMaxWidth: CGFloat = 0.8
private let xtToastMaxHeight: CGFloat = 0.8
private let xtToastHorizontalPadding: CGFloat = 10
private let xtToastVerticalPadding: CGFloat = 10
private let xtToastCornerRadius: CGFloat = 10
private let xtToastOpacity: CGFloat = 0.8
private let xtToastFontSize: CGFloat = 16
private let xtToastFadeDuration: TimeInterval = 0.2
private let xtToastDefaultDuration: TimeInterval = 3
private let xtToastDefaultPosition = "bottom"
private let xtToastActivitySize = CGSize(width: 100, height: 100)
private var xtToastTimerKey: UInt8 = 0
private var xtToastActivityViewKey: UInt8 = 0

@objc
extension UIView {
    @objc func makeToast(_ message: String) {
        makeToast(message, duration: xtToastDefaultDuration, position: xtToastDefaultPosition)
    }

    @objc(makeToast:duration:position:)
    func makeToast(_ message: String, duration: TimeInterval, position: Any) {
        guard let toast = viewForToast(message: message, title: nil, image: nil) else { return }
        showToast(toast, duration: duration, position: position)
    }

    @objc(makeToast:duration:position:title:)
    func makeToast(_ message: String, duration: TimeInterval, position: Any, title: String?) {
        guard let toast = viewForToast(message: message, title: title, image: nil) else { return }
        showToast(toast, duration: duration, position: position)
    }

    @objc(makeToast:duration:position:image:)
    func makeToast(_ message: String, duration: TimeInterval, position: Any, image: UIImage?) {
        guard let toast = viewForToast(message: message, title: nil, image: image) else { return }
        showToast(toast, duration: duration, position: position)
    }

    @objc(makeToast:duration:position:title:image:)
    func makeToast(_ message: String, duration: TimeInterval, position: Any, title: String?, image: UIImage?) {
        guard let toast = viewForToast(message: message, title: title, image: image) else { return }
        showToast(toast, duration: duration, position: position)
    }

    @objc(showToast:)
    func showToast(_ toast: UIView) {
        showToast(toast, duration: xtToastDefaultDuration, position: xtToastDefaultPosition)
    }

    @objc(showToast:duration:position:)
    func showToast(_ toast: UIView, duration: TimeInterval, position: Any) {
        toast.center = centerPointForToast(position: position, toast: toast)
        toast.alpha = 0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleToastTapped(_:)))
        toast.addGestureRecognizer(recognizer)
        toast.isUserInteractionEnabled = true
        toast.isExclusiveTouch = true
        addSubview(toast)

        UIView.animate(withDuration: xtToastFadeDuration, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) {
            toast.alpha = xtToastOpacity
        } completion: { _ in
            let timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.toastTimerDidFinish(_:)), userInfo: toast, repeats: false)
            objc_setAssociatedObject(toast, &xtToastTimerKey, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc func makeToastActivity() {
        makeToastActivity("center")
    }

    @objc(makeToastActivity:)
    func makeToastActivity(_ position: Any) {
        if objc_getAssociatedObject(self, &xtToastActivityViewKey) as? UIView != nil { return }
        let activityView = UIView(frame: CGRect(origin: .zero, size: xtToastActivitySize))
        activityView.center = centerPointForToast(position: position, toast: activityView)
        activityView.backgroundColor = UIColor.black.withAlphaComponent(xtToastOpacity)
        activityView.alpha = 0
        activityView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        activityView.layer.cornerRadius = xtToastCornerRadius

        let indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        indicator.center = CGPoint(x: activityView.bounds.midX, y: activityView.bounds.midY)
        activityView.addSubview(indicator)
        indicator.startAnimating()

        objc_setAssociatedObject(self, &xtToastActivityViewKey, activityView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addSubview(activityView)
        UIView.animate(withDuration: xtToastFadeDuration) {
            activityView.alpha = 1
        }
    }

    @objc func hideToastActivity() {
        guard let activityView = objc_getAssociatedObject(self, &xtToastActivityViewKey) as? UIView else { return }
        UIView.animate(withDuration: xtToastFadeDuration, delay: 0, options: [.curveEaseIn, .beginFromCurrentState]) {
            activityView.alpha = 0
        } completion: { _ in
            activityView.removeFromSuperview()
            objc_setAssociatedObject(self, &xtToastActivityViewKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc private func toastTimerDidFinish(_ timer: Timer) {
        if let toast = timer.userInfo as? UIView {
            hideToast(toast)
        }
    }

    @objc private func handleToastTapped(_ recognizer: UITapGestureRecognizer) {
        if let toast = recognizer.view {
            (objc_getAssociatedObject(toast, &xtToastTimerKey) as? Timer)?.invalidate()
            hideToast(toast)
        }
    }

    private func hideToast(_ toast: UIView) {
        UIView.animate(withDuration: xtToastFadeDuration, delay: 0, options: [.curveEaseIn, .beginFromCurrentState]) {
            toast.alpha = 0
        } completion: { _ in
            toast.removeFromSuperview()
        }
    }

    private func centerPointForToast(position: Any, toast: UIView) -> CGPoint {
        if let string = position as? String {
            if string.caseInsensitiveCompare("top") == .orderedSame {
                return CGPoint(x: bounds.midX, y: toast.frame.height / 2 + xtToastVerticalPadding)
            }
            if string.caseInsensitiveCompare("bottom") == .orderedSame {
                return CGPoint(x: bounds.midX, y: bounds.height - toast.frame.height / 2 - xtToastVerticalPadding)
            }
            if string.caseInsensitiveCompare("center") == .orderedSame {
                return CGPoint(x: bounds.midX, y: bounds.midY)
            }
        } else if let value = position as? NSValue {
            return value.cgPointValue
        }
        return centerPointForToast(position: xtToastDefaultPosition, toast: toast)
    }

    private func viewForToast(message: String?, title: String?, image: UIImage?) -> UIView? {
        guard message != nil || title != nil || image != nil else { return nil }
        let wrapperView = UIView()
        wrapperView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        wrapperView.layer.cornerRadius = xtToastCornerRadius
        wrapperView.backgroundColor = UIColor.black.withAlphaComponent(xtToastOpacity)

        var imageView: UIImageView?
        if let image {
            let view = UIImageView(image: image)
            view.contentMode = .scaleAspectFit
            view.frame = CGRect(x: xtToastHorizontalPadding, y: xtToastVerticalPadding, width: 80, height: 80)
            imageView = view
        }

        let imageWidth = imageView?.bounds.width ?? 0
        let imageHeight = imageView?.bounds.height ?? 0
        let imageLeft = imageView == nil ? 0 : xtToastHorizontalPadding
        let maxTextSize = CGSize(width: bounds.width * xtToastMaxWidth - imageWidth, height: bounds.height * xtToastMaxHeight)

        let titleLabel = labelForToast(text: title, font: .boldSystemFont(ofSize: xtToastFontSize), maxSize: maxTextSize)
        let messageLabel = labelForToast(text: message, font: .systemFont(ofSize: xtToastFontSize), maxSize: maxTextSize)

        let titleTop = titleLabel == nil ? 0 : xtToastVerticalPadding
        let titleLeft = titleLabel == nil ? 0 : imageLeft + imageWidth + xtToastHorizontalPadding
        let titleSize = titleLabel?.bounds.size ?? .zero

        let messageTop = messageLabel == nil ? 0 : titleTop + titleSize.height + xtToastVerticalPadding
        let messageLeft = messageLabel == nil ? 0 : imageLeft + imageWidth + xtToastHorizontalPadding
        let messageSize = messageLabel?.bounds.size ?? .zero

        let longerWidth = max(titleSize.width, messageSize.width)
        let longerLeft = max(titleLeft, messageLeft)
        let wrapperWidth = max(imageWidth + xtToastHorizontalPadding * 2, longerLeft + longerWidth + xtToastHorizontalPadding)
        let wrapperHeight = max(messageTop + messageSize.height + xtToastVerticalPadding, imageHeight + xtToastVerticalPadding * 2)
        wrapperView.frame = CGRect(x: 0, y: 0, width: wrapperWidth, height: wrapperHeight)

        if let titleLabel {
            titleLabel.frame.origin = CGPoint(x: titleLeft, y: titleTop)
            wrapperView.addSubview(titleLabel)
        }
        if let messageLabel {
            messageLabel.frame.origin = CGPoint(x: messageLeft, y: messageTop)
            wrapperView.addSubview(messageLabel)
        }
        if let imageView {
            wrapperView.addSubview(imageView)
        }
        return wrapperView
    }

    private func labelForToast(text: String?, font: UIFont, maxSize: CGSize) -> UILabel? {
        guard let text else { return nil }
        let label = UILabel()
        label.numberOfLines = 0
        label.font = font
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.backgroundColor = .clear
        label.alpha = 1
        label.text = text
        let size = (text as NSString).boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        ).integral.size
        label.frame = CGRect(origin: .zero, size: size)
        return label
    }
}

