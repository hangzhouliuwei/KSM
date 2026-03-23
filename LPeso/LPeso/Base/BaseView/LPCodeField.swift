//
//  LPCodeField.swift
//  LPeso
//
//  Created by Kiven on 2024/11/1.
//

import UIKit

class LPCodeField: UITextField {
    
    var backwardBlock: (() -> Void)?
    
    override func deleteBackward() {
        super.deleteBackward()
        backwardBlock?()
    }
    
}


class LPTxtField: UITextField{
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            
            if let pasteboardString = UIPasteboard.general.string {
                
                let isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: pasteboardString))
                
                if self.keyboardType == .numberPad {
                    
                    return isNumeric
                }
            }
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}
