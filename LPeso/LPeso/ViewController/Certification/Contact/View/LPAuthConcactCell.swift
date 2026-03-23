//
//  LPAuthConcactCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/11.
//

import UIKit

class LPAuthConcactCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var txt2: UITextField!
    
    @IBOutlet weak var txt3: UITextField!
    
    @IBOutlet var cellViews: [UIView]!
    
    var itemModel:LPAuthConcactItemModel?
    
    var clickBlock:(_ index:Int) -> Void = {_  in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for cellView in cellViews{
            cellView.borderColor = gray224
            let tpas = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
            cellView.isUserInteractionEnabled = true
            cellView.addGestureRecognizer(tpas)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let viewTag = gesture.view?.tag ?? 0
        clickBlock(viewTag)
    }
    
    func configModel(itemModel:LPAuthConcactItemModel){
        self.itemModel = itemModel
        self.titleLab.text = itemModel.PTUTilefishi ?? ""
        if let filled = itemModel.PTUMechanotheropyi{
            self.txt2.text =  filled.PTUCarmarthenshirei
            self.txt3.text =  filled.PTUCarritchi
            
            guard let filledType = itemModel.PTUMechanotheropyi?.PTUDentistryi?.string,
                  let relationList = itemModel.PTUDentistryi else { return }
            self.txt1.text =  relationList.first(where: { $0.type?.string == filledType })?.name ?? ""
        }
        
    }
    
}


