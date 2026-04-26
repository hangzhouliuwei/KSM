//
//  UIView+XTCategory.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

private func xtCategoryColor(_ rgbValue: Int, alpha: CGFloat = 1.0) -> UIColor {
    UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

@objc
extension UIView {
    @objc(xt_frame:color:)
    class func xt_frame(_ frame: CGRect, color: UIColor?) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = color
        return view
    }

    @objc(xt_layer:locations:startPoint:endPoint:size:)
    class func xt_layer(_ colors: [Any], locations: [Any], startPoint: CGPoint, endPoint: CGPoint, size: CGSize) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.locations = locations as? [NSNumber]
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return layer
    }

    @objc(xt_rect:corners:size:)
    func xt_rect(_ rect: CGRect, corners: UIRectCorner, size: CGSize) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }

    @objc(xt_img:tag:)
    class func xt_img(_ name: String?, tag: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.tag = tag
        if let name, !name.isEmpty {
            imageView.image = UIImage(named: name)
        }
        return imageView
    }

    @objc(xt_btn:font:textColor:cornerRadius:borderColor:borderWidth:backgroundColor:tag:)
    class func xt_btn(
        _ title: String?,
        font: UIFont?,
        textColor: UIColor?,
        cornerRadius: Float,
        borderColor: UIColor?,
        borderWidth: Float,
        backgroundColor: UIColor?,
        tag: Int
    ) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        if let title {
            button.setTitle(title, for: .normal)
        }
        if let font {
            button.titleLabel?.font = font
        }
        if let textColor {
            button.setTitleColor(textColor, for: .normal)
        }
        if cornerRadius > 0 {
            button.layer.cornerRadius = CGFloat(cornerRadius)
        }
        if let borderColor {
            button.layer.borderColor = borderColor.cgColor
        }
        if borderWidth > 0 {
            button.layer.borderWidth = CGFloat(borderWidth)
        }
        if let backgroundColor {
            button.backgroundColor = backgroundColor
        }
        button.tag = tag
        return button
    }

    @objc(xt_btn:font:textColor:cornerRadius:tag:)
    class func xt_btn(
        _ title: String?,
        font: UIFont?,
        textColor: UIColor?,
        cornerRadius: Float,
        tag: Int
    ) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        if let title {
            button.setTitle(title, for: .normal)
        }
        if let font {
            button.titleLabel?.font = font
        }
        if let textColor {
            button.setTitleColor(textColor, for: .normal)
        }
        if cornerRadius > 0 {
            button.layer.cornerRadius = CGFloat(cornerRadius)
            button.clipsToBounds = true
        }
        button.tag = tag
        return button
    }

    @objc(xt_textField:placeholder:font:textColor:withdelegate:)
    class func xt_textField(
        _ secureText: Bool,
        placeholder: String?,
        font: UIFont?,
        textColor: UIColor?,
        withdelegate delegate: Any?
    ) -> UITextField {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        if secureText {
            textField.isSecureTextEntry = true
        }
        if let placeholder {
            textField.xt_placeholder(placeholder, placeholderColor: xtCategoryColor(0xB0B0B0))
        }
        if let textColor {
            textField.textColor = textColor
        }
        textField.font = font
        if let delegate = delegate as? UITextFieldDelegate {
            textField.delegate = delegate
        }
        return textField
    }

    @objc(xt_lab:text:font:textColor:alignment:tag:)
    class func xt_lab(_ frame: CGRect, text: String?, font: UIFont?, textColor: UIColor?, alignment: NSTextAlignment, tag: Int) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment
        label.backgroundColor = .clear
        label.tag = tag
        return label
    }

    @objc(xt_lab:font:textColor:alignment:isPriority:tag:)
    class func xt_lab(_ text: String?, font: UIFont?, textColor: UIColor?, alignment: NSTextAlignment, isPriority: Bool, tag: Int) -> UILabel {
        let label = xt_lab(.zero, text: text, font: font, textColor: textColor, alignment: alignment, tag: tag)
        if isPriority {
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.setContentCompressionResistancePriority(.required, for: .vertical)
            label.setContentHuggingPriority(.required, for: .vertical)
        }
        return label
    }

    @objc(xt_drawLineFromPoint:toPoint:lineColor:lineWidth:lineHeight:lineSpace:lineType:)
    func xt_drawLine(from fPoint: CGPoint, to tPoint: CGPoint, lineColor color: UIColor?, lineWidth width: CGFloat, lineHeight height: CGFloat, lineSpace space: CGFloat, lineType type: Int) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = (color ?? .lightGray).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        let path = UIBezierPath()
        path.move(to: fPoint)
        path.addLine(to: tPoint)
        shapeLayer.path = path.cgPath
        let lineWidth = width < 0 ? 1 : width
        shapeLayer.lineWidth = height < 0 ? 1 : height
        shapeLayer.lineCap = .butt
        shapeLayer.lineDashPattern = [NSNumber(value: Double(lineWidth)), NSNumber(value: Double(space))]
        if type == 1 {
            shapeLayer.lineCap = .round
            shapeLayer.lineDashPattern = [NSNumber(value: Double(lineWidth)), NSNumber(value: Double(space + lineWidth))]
        }
        layer.addSublayer(shapeLayer)
    }
}

@objc
extension UITextField {
    @objc(xt_placeholder:placeholderColor:)
    func xt_placeholder(_ placeholder: String, placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: placeholderColor]
        )
    }
}

@objc
extension UIViewController {
    @objc(xt_presentViewController:animated:completion:modalPresentationStyle:)
    func xt_presentViewController(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)?,
        modalPresentationStyle: UIModalPresentationStyle
    ) {
        viewControllerToPresent.modalPresentationStyle = modalPresentationStyle
        present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
