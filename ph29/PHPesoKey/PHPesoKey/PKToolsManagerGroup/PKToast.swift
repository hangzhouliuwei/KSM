//
//  PKToast.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/13.
//

import UIKit

public struct PKToast{
    
    public static func show(_ message: String, in view: UIView? = nil, completion:((_ didTap: Bool) -> Void)? = nil) {

        guard !message.isEmpty else { return }
        guard let toast = try? toast(message: message, image: nil) else { return }

        let target = targetView(view)
        target?.showToast(toast, completion: completion)
    }
    
    
    private static func targetView(_ view: UIView?) -> UIView? {

        if let view = view {
            return view
        }
        else {
            guard let delegate = UIApplication.shared.delegate else { return nil }
            guard let window = delegate.window else { return nil }

            return window
        }
    }
    
}

extension PKToast {
    
    private static func toast(message: String? = nil, image: UIImage? = nil) throws -> UIView {


        let style = ToastManager.shared.style
        let wrapperView = UIView()
        wrapperView.backgroundColor = style.backgroundColor
        wrapperView.layer.cornerRadius = style.cornerRadius

        if style.displayShadow {
            wrapperView.layer.shadowColor = UIColor.black.cgColor
            wrapperView.layer.shadowOpacity = style.shadowOpacity
            wrapperView.layer.shadowRadius = style.shadowRadius
            wrapperView.layer.shadowOffset = style.shadowOffset
        }

        let label = UILabel()
        label.text = message
        label.numberOfLines = style.messageNumberOfLines
        label.font = style.messageFont
        label.textAlignment = style.messageAlignment
        label.lineBreakMode = .byTruncatingTail;
        label.textColor = style.messageColor
        label.backgroundColor = UIColor.clear


        if let image = image {

            let stackView = UIStackView()
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 4
            wrapperView.addSubview(stackView)

            let imageView = UIImageView(image: image)
            imageView.contentMode = .center
            stackView.addArrangedSubview(imageView)

            stackView.addArrangedSubview(label)

            imageView.snp.makeConstraints { make in
                make.width.equalTo(32)
            }

            if message?.count ?? 0  > 4 {

                stackView.axis = .horizontal

                stackView.snp.makeConstraints { make in

                    make.left.equalTo(8)
                    make.top.equalTo(7)
                    make.bottom.equalTo(-7)
                    make.right.equalTo(-12)
                    make.width.lessThanOrEqualTo(168)
                }

            } else {

                stackView.axis = .vertical

                stackView.snp.makeConstraints { make in

                    make.left.top.equalTo(16)
                    make.right.bottom.equalTo(-16)
                }
            }

        } else {

            wrapperView.addSubview(label)
            label.snp.makeConstraints { make in
                make.left.top.equalTo(12)
                make.right.bottom.equalTo(-12)
                make.width.lessThanOrEqualTo(168)
            }
        }

        return wrapperView
    }
}
