//
//  YYTextAsyncLayer+XTCategory.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import ObjectiveC
import YYText

@objc
extension YYTextAsyncLayer {
    @objc class func xt_installCategoryPatch() {
        struct Once {
            static let run: Void = {
                guard
                    let original = class_getInstanceMethod(YYTextAsyncLayer.self, NSSelectorFromString("_displayAsync:")),
                    let swizzled = class_getInstanceMethod(YYTextAsyncLayer.self, #selector(YYTextAsyncLayer.xt_displayAsync(_:)))
                else { return }
                if !class_addMethod(
                    YYTextAsyncLayer.self,
                    #selector(YYTextAsyncLayer.xt_displayAsync(_:)),
                    method_getImplementation(original),
                    method_getTypeEncoding(original)
                ) {
                    method_exchangeImplementations(original, swizzled)
                }
            }()
        }
        _ = Once.run
    }

    @objc func xt_displayAsync(_ async: Bool) {
        if bounds.size.width <= 0 || bounds.size.height <= 0 {
            contents = nil
            XTLog("来了")
            return
        }
        xt_displayAsync(async)
    }
}

