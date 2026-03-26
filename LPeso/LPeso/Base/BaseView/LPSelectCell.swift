//
//  LPSelectCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit

class LPSelectCell: UICollectionViewCell {
    
    var clickBlock:() -> Void = {}

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.borderColor = gray224
    }
    
    @IBAction func btnClick(_ sender: Any) {
        clickBlock()
    }
    

}
