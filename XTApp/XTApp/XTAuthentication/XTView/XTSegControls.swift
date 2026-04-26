//
//  XTSegControls.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import UIKit

@objcMembers
@objc(XTSegBtn)
class XTSegBtn: UIButton {
    dynamic var index = 0

    private var normalFont: UIFont?
    private var selectedFont: UIFont?
    private var normalColor: UIColor?
    private var selectedColor: UIColor?
    private var normalBgColor: UIColor?
    private var selectedBgColor: UIColor?

    override var isEnabled: Bool {
        didSet {
            applyStateStyle()
        }
    }

    @objc(initTit:font:selectFont:color:selectColor:bgColor:selectBgColor:)
    init(tit: String, font: UIFont, selectFont: UIFont, color: UIColor, selectColor: UIColor, bgColor: UIColor, selectBgColor: UIColor) {
        normalFont = font
        selectedFont = selectFont
        normalColor = color
        selectedColor = selectColor
        normalBgColor = bgColor
        selectedBgColor = selectBgColor
        super.init(frame: .zero)
        setTitle(tit, for: .normal)
        applyStateStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func applyStateStyle() {
        if isEnabled {
            titleLabel?.font = normalFont
            setTitleColor(normalColor, for: .normal)
            backgroundColor = normalBgColor
        } else {
            titleLabel?.font = selectedFont
            setTitleColor(selectedColor, for: .normal)
            backgroundColor = selectedBgColor
        }
    }
}

@objcMembers
@objc(XTSegView)
class XTSegView: UIView {
    weak dynamic var indexBtn: XTSegBtn?
    dynamic var block: XTIntBlock?

    private var btnList: [XTSegBtn] = []

    @objc(initArr:font:selectFont:color:selectColor:bgColor:selectBgColor:select:)
    convenience init(
        arr: [NSDictionary],
        font: UIFont,
        selectFont: UIFont,
        color: UIColor,
        selectColor: UIColor,
        bgColor: UIColor,
        selectBgColor: UIColor,
        select: Int
    ) {
        self.init(
            arr: arr,
            font: font,
            selectFont: selectFont,
            color: color,
            selectColor: selectColor,
            bgColor: bgColor,
            selectBgColor: selectBgColor,
            cornerRadius: 0,
            select: select
        )
    }

    @objc(initArr:font:selectFont:color:selectColor:bgColor:selectBgColor:cornerRadius:select:)
    init(
        arr: [NSDictionary],
        font: UIFont,
        selectFont: UIFont,
        color: UIColor,
        selectColor: UIColor,
        bgColor: UIColor,
        selectBgColor: UIColor,
        cornerRadius: Int,
        select: Int
    ) {
        super.init(frame: .zero)
        setup(
            arr: arr,
            font: font,
            selectFont: selectFont,
            color: color,
            selectColor: selectColor,
            bgColor: bgColor,
            selectBgColor: selectBgColor,
            cornerRadius: cornerRadius,
            select: select
        )
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup(
        arr: [NSDictionary],
        font: UIFont,
        selectFont: UIFont,
        color: UIColor,
        selectColor: UIColor,
        bgColor: UIColor,
        selectBgColor: UIColor,
        cornerRadius: Int,
        select: Int
    ) {
        guard !arr.isEmpty else { return }
        var lastBtn: XTSegBtn?
        for index in arr.indices {
            let dic = arr[index]
            let name = dic["name"] as? String ?? ""
            let btn = XTSegBtn(tit: name, font: font, selectFont: selectFont, color: color, selectColor: selectColor, bgColor: bgColor, selectBgColor: selectBgColor)
            if cornerRadius > 0 {
                btn.layer.cornerRadius = CGFloat(cornerRadius)
                btn.clipsToBounds = true
            }
            btn.index = index
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(xt_select(_:)), for: .touchUpInside)
            addSubview(btn)
            btnList.append(btn)

            NSLayoutConstraint.activate([
                btn.topAnchor.constraint(equalTo: topAnchor),
                btn.bottomAnchor.constraint(equalTo: bottomAnchor),
                btn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0 / CGFloat(arr.count))
            ])
            if let lastBtn {
                btn.leftAnchor.constraint(equalTo: lastBtn.rightAnchor).isActive = true
            } else {
                btn.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            }
            if select == index {
                btn.isEnabled = false
                indexBtn = btn
            }
            lastBtn = btn
        }
    }

    @objc(xt_select:)
    func xt_select(_ btn: XTSegBtn) {
        indexBtn?.isEnabled = true
        indexBtn = btn
        indexBtn?.isEnabled = false
        block?(btn.index)
    }

    @objc(reloadSeg:)
    func reloadSeg(_ index: Int) {
        guard btnList.indices.contains(index) else { return }
        indexBtn?.isEnabled = true
        let btn = btnList[index]
        indexBtn = btn
        indexBtn?.isEnabled = false
    }
}
