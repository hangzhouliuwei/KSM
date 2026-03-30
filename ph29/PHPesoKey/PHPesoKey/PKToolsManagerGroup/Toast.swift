//
//  Toast.swift
//  Toast-Swift
//
//  Copyright (c) 2015-2019 Charles Scalesse.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be included
//  in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit
import ObjectiveC
import SnapKit

/**
 Toast is a Swift extension that adds toast notifications to the `UIView` object class.
 It is intended to be simple, lightweight, and easy to use. Most toast notifications
 can be triggered with a single line of code.

 The `makeToast` methods create a new view and then display it as toast.

 The `showToast` methods display any view as toast.

 */
extension UIView {

    /**
     Keys used for associated objects.
     */
    private struct ToastKeys {
        static var timer        = "com.toast-swift.timer"
        static var duration     = "com.toast-swift.duration"
        static var point        = "com.toast-swift.point"
        static var completion   = "com.toast-swift.completion"
        static var activeToasts = "com.toast-swift.activeToasts"
        static var activityView = "com.toast-swift.activityView"
        static var queue        = "com.toast-swift.queue"
    }

    /**
     Swift closures can't be directly associated with objects via the
     Objective-C runtime, so the (ugly) solution is to wrap them in a
     class that can be used with associated objects.
     */
    private class ToastCompletionWrapper {
        let completion: ((Bool) -> Void)?

        init(_ completion: ((Bool) -> Void)?) {
            self.completion = completion
        }
    }

    private enum ToastError: Error {
        case missingParameters
    }

    private var activeToasts: NSMutableArray {
        get {
            if let activeToasts = objc_getAssociatedObject(self, &ToastKeys.activeToasts) as? NSMutableArray {
                return activeToasts
            } else {
                let activeToasts = NSMutableArray()
                objc_setAssociatedObject(self, &ToastKeys.activeToasts, activeToasts, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activeToasts
            }
        }
    }

    private var queue: NSMutableArray {
        get {
            if let queue = objc_getAssociatedObject(self, &ToastKeys.queue) as? NSMutableArray {
                return queue
            } else {
                let queue = NSMutableArray()
                objc_setAssociatedObject(self, &ToastKeys.queue, queue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return queue
            }
        }
    }

    // MARK: - Show Toast Methods

    /**
     Displays any view as toast at a provided position and duration. The completion closure
     executes when the toast view completes. `didTap` will be `true` if the toast view was
     dismissed from a tap.

     @param toast The view to be displayed as toast
     @param duration The notification duration
     @param position The toast's position
     @param completion The completion block, executed after the toast view disappears.
     didTap will be `true` if the toast view was dismissed from a tap.
     */
    func showToast(_ toast: UIView, duration: TimeInterval = ToastManager.shared.duration, completion: ((_ didTap: Bool) -> Void)? = nil) {
        let point = centerPoint(forToast: toast, inSuperview: self)
        showToast(toast, duration: duration, point: point, completion: completion)
    }

    /**
     Displays any view as toast at a provided center point and duration. The completion closure
     executes when the toast view completes. `didTap` will be `true` if the toast view was
     dismissed from a tap.

     @param toast The view to be displayed as toast
     @param duration The notification duration
     @param point The toast's center point
     @param completion The completion block, executed after the toast view disappears.
     didTap will be `true` if the toast view was dismissed from a tap.
     */
    func showToast(_ toast: UIView, duration: TimeInterval = ToastManager.shared.duration, point: CGPoint, completion: ((_ didTap: Bool) -> Void)? = nil) {

        /// toast添加蒙层
        let toastContainerView = UIView()
        toastContainerView.backgroundColor = .clear
        toastContainerView.alpha = 0.0

        if ToastManager.shared.isTapToDismissEnabled {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleToastTapped(_:)))
            toastContainerView.addGestureRecognizer(recognizer)
            toastContainerView.isUserInteractionEnabled = true
            toastContainerView.isExclusiveTouch = true
        }

        activeToasts.add(toastContainerView)

        toastContainerView.addSubview(toast)
        toast.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        self.addSubview(toastContainerView)
        toastContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        if let completion = completion {
            objc_setAssociatedObject(toastContainerView, &ToastKeys.completion, ToastCompletionWrapper(completion), .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }

        if ToastManager.shared.isQueueEnabled, activeToasts.count > 1 {
            objc_setAssociatedObject(toastContainerView, &ToastKeys.duration, NSNumber(value: duration), .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            objc_setAssociatedObject(toastContainerView, &ToastKeys.point, NSValue(cgPoint: point), .OBJC_ASSOCIATION_RETAIN_NONATOMIC);

            queue.add(toastContainerView)
        } else {
            showToast(toastContainerView, duration: duration, point: point)
        }
    }

    // MARK: - Hide Toast Methods

    /**
     Hides the active toast. If there are multiple toasts active in a view, this method
     hides the oldest toast (the first of the toasts to have been presented).

     @see `hideAllToasts()` to remove all active toasts from a view.

     @warning This method has no effect on activity toasts. Use `hideToastActivity` to
     hide activity toasts.

    */
    func hideToast() {
        guard let activeToast = activeToasts.firstObject as? UIView else { return }
        hideToast(activeToast)
    }

    /**
     Hides an active toast.

     @param toast The active toast view to dismiss. Any toast that is currently being displayed
     on the screen is considered active.

     @warning this does not clear a toast view that is currently waiting in the queue.
     */
    func hideToast(_ toast: UIView) {
        guard activeToasts.contains(toast) else { return }
        hideToast(toast, fromTap: false)
    }

    /**
     Hides all toast views.

     @param includeActivity If `true`, toast activity will also be hidden. Default is `false`.
     @param clearQueue If `true`, removes all toast views from the queue. Default is `true`.
    */
    func hideAllToasts(includeActivity: Bool = false, clearQueue: Bool = true) {
        if clearQueue {
            clearToastQueue()
        }

        activeToasts.compactMap { $0 as? UIView }
                    .forEach { hideToast($0) }

        if includeActivity {
            hideToastActivity()
        }
    }

    /**
     Removes all toast views from the queue. This has no effect on toast views that are
     active. Use `hideAllToasts(clearQueue:)` to hide the active toasts views and clear
     the queue.
     */
    func clearToastQueue() {
        queue.removeAllObjects()
    }

    // MARK: - Activity Methods

    /**
     Creates and displays a new toast activity indicator view at a specified position.

     @warning Only one toast activity indicator view can be presented per superview. Subsequent
     calls to `makeToastActivity()` will be ignored until `hideToastActivity()` is called.

     @warning `makeToastActivity(position:)` works independently of the `showToast` methods. Toast
     activity views can be presented and dismissed while toast views are being displayed.
     `makeToastActivity()` has no effect on the queueing behavior of the `showToast` methods.

     @param position The toast's position
     */
    func makeToastActivity() {
        // sanity
        guard objc_getAssociatedObject(self, &ToastKeys.activityView) as? UIView == nil else { return }

        let toast = createToastActivityView()
        let point = centerPoint(forToast: toast, inSuperview: self)
        makeToastActivity(toast, point: point)
    }

    /**
     Dismisses the active toast activity indicator view.
     */
    func hideToastActivity() {
        if let toast = objc_getAssociatedObject(self, &ToastKeys.activityView) as? UIView {
            UIView.animate(withDuration: ToastManager.shared.style.fadeDuration, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState], animations: {
                toast.alpha = 0.0
            }) { _ in
                toast.removeFromSuperview()
                objc_setAssociatedObject(self, &ToastKeys.activityView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    // MARK: - Private Activity Methods

    private func makeToastActivity(_ toast: UIView, point: CGPoint) {

        /// 增加定制逻辑
        let toastContainerView = UIView()
        toastContainerView.backgroundColor = .clear
        toastContainerView.alpha = 0.0

        objc_setAssociatedObject(self, &ToastKeys.activityView, toastContainerView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        toastContainerView.addSubview(toast)
        toast.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        self.addSubview(toastContainerView)
        toastContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        UIView.animate(withDuration: ToastManager.shared.style.fadeDuration, delay: 0.0, options: .curveEaseOut, animations: {
            toastContainerView.alpha = 1.0
        })
    }

    private func createToastActivityView() -> UIView {
        let style = ToastManager.shared.style

        let activityView = UIView()
        activityView.backgroundColor = style.activityBackgroundColor
        activityView.layer.cornerRadius = style.cornerRadius

        if style.displayShadow {
            activityView.layer.shadowColor = style.shadowColor.cgColor
            activityView.layer.shadowOpacity = style.shadowOpacity
            activityView.layer.shadowRadius = style.shadowRadius
            activityView.layer.shadowOffset = style.shadowOffset
        }

        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicatorView.color = style.activityIndicatorColor
        activityIndicatorView.startAnimating()
        activityView.snp.makeConstraints { make in
            make.width.equalTo(style.activitySize.width)
            make.height.equalTo(style.activitySize.height)
        }

        return activityView
    }

    // MARK: - Private Show/Hide Methods
    private func showToast(_ toast: UIView, duration: TimeInterval, point: CGPoint) {
        UIView.animate(withDuration: ToastManager.shared.style.fadeDuration, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            toast.alpha = 1.0
        }) { _ in
            let timer = Timer(timeInterval: duration, target: self, selector: #selector(UIView.toastTimerDidFinish(_:)), userInfo: toast, repeats: false)
            RunLoop.main.add(timer, forMode: .common)
            objc_setAssociatedObject(toast, &ToastKeys.timer, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private func hideToast(_ toast: UIView, fromTap: Bool) {
        if let timer = objc_getAssociatedObject(toast, &ToastKeys.timer) as? Timer {
            timer.invalidate()
        }

        UIView.animate(withDuration: ToastManager.shared.style.fadeDuration, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState], animations: {
            toast.alpha = 0.0
        }) { _ in
            // 执行完成回调
            if let wrapper = objc_getAssociatedObject(toast, &ToastKeys.completion) as? ToastCompletionWrapper, let completion = wrapper.completion {
                completion(fromTap)
            }
            // 移除当前toast
            toast.removeFromSuperview()
            self.activeToasts.remove(toast)

            // 显示队列中第一个toast
            if let nextToast = self.queue.firstObject as? UIView,
               let duration = objc_getAssociatedObject(nextToast, &ToastKeys.duration) as? NSNumber,
               let point = objc_getAssociatedObject(nextToast, &ToastKeys.point) as? NSValue {
                self.queue.removeObject(at: 0)
                self.showToast(nextToast, duration: duration.doubleValue, point: point.cgPointValue)
            }
        }
    }

    // MARK: - Events

    @objc
    private func handleToastTapped(_ recognizer: UITapGestureRecognizer) {
        guard let toast = recognizer.view else { return }
        hideToast(toast, fromTap: true)
    }

    @objc
    private func toastTimerDidFinish(_ timer: Timer) {
        guard let toast = timer.userInfo as? UIView else { return }
        hideToast(toast)
    }
}

extension UIView {

    fileprivate func centerPoint(forToast toast: UIView, inSuperview superview: UIView) -> CGPoint {
        return CGPoint(x: superview.bounds.size.width / 2.0, y: superview.bounds.size.height / 2.0)
    }
}

// MARK: - Toast Style

/**
 `ToastStyle` instances define the look and feel for toast views created via the
 `makeToast` methods as well for toast views created directly with
 `toastViewForMessage(message:title:image:style:)`.

 @warning `ToastStyle` offers relatively simple styling options for the default
 toast view. If you require a toast view with more complex UI, it probably makes more
 sense to create your own custom UIView subclass and present it with the `showToast`
 methods.
*/
struct ToastStyle {

    init() {}

    /**
     The background color. Default is `.black` at 80% opacity.
    */
    var backgroundColor: UIColor = UIColor.init(hex: "#000000",alpha: 0.8) ?? .black
    /**
     The title color. Default is `UIColor.whiteColor()`.
    */
    var titleColor: UIColor = .white

    /**
     The message color. Default is `.white`.
    */
    var messageColor: UIColor = .white

    /**
     A percentage value from 0.0 to 1.0, representing the maximum width of the toast
     view relative to it's superview. Default is 0.8 (80% of the superview's width).
    */
    var maxWidthPercentage: CGFloat = 0.8 {
        didSet {
            maxWidthPercentage = max(min(maxWidthPercentage, 1.0), 0.0)
        }
    }

    /**
     A percentage value from 0.0 to 1.0, representing the maximum height of the toast
     view relative to it's superview. Default is 0.8 (80% of the superview's height).
    */
    var maxHeightPercentage: CGFloat = 0.8 {
        didSet {
            maxHeightPercentage = max(min(maxHeightPercentage, 1.0), 0.0)
        }
    }

    /**
     The corner radius. Default is 10.0.
    */
    var cornerRadius: CGFloat = 12;

    /**
     The message font. Default is `.systemFont(ofSize: 16.0)`.
    */
    var messageFont: UIFont = .systemFont(ofSize: 14)

    /**
     The message text alignment. Default is `NSTextAlignment.Left`.
    */
    var messageAlignment: NSTextAlignment = .left

    /**
     The maximum number of lines for the title. The default is 0 (no limit).
    */
    var titleNumberOfLines = 0

    /**
     The maximum number of lines for the message. The default is 0 (no limit).
    */
    var messageNumberOfLines = 0

    /**
     Enable or disable a shadow on the toast view. Default is `false`.
    */
    var displayShadow = false

    /**
     The shadow color. Default is `.black`.
     */
    var shadowColor: UIColor = .black

    /**
     A value from 0.0 to 1.0, representing the opacity of the shadow.
     Default is 0.8 (80% opacity).
    */
    var shadowOpacity: Float = 0.8 {
        didSet {
            shadowOpacity = max(min(shadowOpacity, 1.0), 0.0)
        }
    }

    /**
     The shadow radius. Default is 6.0.
    */
    var shadowRadius: CGFloat = 6.0

    /**
     The shadow offset. The default is 4 x 4.
    */
    var shadowOffset = CGSize(width: 4.0, height: 4.0)

    /**
     The image size. The default is 80 x 80.
    */
    var imageSize = CGSize(width: 80.0, height: 80.0)

    /**
     The size of the toast activity view when `makeToastActivity(position:)` is called.
     Default is 100 x 100.
    */
    var activitySize = CGSize(width: 100.0, height: 100.0)

    /**
     The fade in/out animation duration. Default is 0.2.
     */
    var fadeDuration: TimeInterval = 0.2

    /**
     Activity indicator color. Default is `.white`.
     */
    var activityIndicatorColor: UIColor = .white

    /**
     Activity background color. Default is `.black` at 80% opacity.
     */
    var activityBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.8)

}

// MARK: - Toast Manager

/**
 `ToastManager` provides general configuration options for all toast
 notifications. Backed by a singleton instance.
*/
class ToastManager {

    /**
     The `ToastManager` singleton instance.

     */
    static let shared = ToastManager()

    /**
     The shared style. Used whenever toastViewForMessage(message:title:image:style:) is called
     with with a nil style.

     */
    var style = ToastStyle()

    /**
     Enables or disables tap to dismiss on toast views. Default is `true`.

     */
    var isTapToDismissEnabled = true

    /**
     Enables or disables queueing behavior for toast views. When `true`,
     toast views will appear one after the other. When `false`, multiple toast
     views will appear at the same time (potentially overlapping depending
     on their positions). This has no effect on the toast activity view,
     which operates independently of normal toast views. Default is `false`.

     */
    var isQueueEnabled = true

    /**
     The default duration. Used for the `makeToast` and
     `showToast` methods that don't require an explicit duration.
     Default is 3.0.

     */
    var duration: TimeInterval = 3.0
}
