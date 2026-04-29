//
//  XTMyShared.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import UIKit

func xtMyActivate(_ constraints: [NSLayoutConstraint]) {
    NSLayoutConstraint.activate(constraints)
}

func xtMyHexColor(_ text: String?, fallback: UIColor = XT_RGB(0x02CC56, 1.0)) -> UIColor {
    guard let text, let color = (text as NSString).xt_hexColor() else { return fallback }
    return color
}