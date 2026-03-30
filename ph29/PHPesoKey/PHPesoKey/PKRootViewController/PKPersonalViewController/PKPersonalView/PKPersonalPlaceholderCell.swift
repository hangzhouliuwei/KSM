//
//  PKPersonalPlaceholderCell.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/18.
//

import UIKit

class PKPersonalPlaceholderCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor =  UIColor.init(hex: "#F6F8FA")
        self.contentView.backgroundColor = UIColor.init(hex: "#F6F8FA")
        certPKPersonalPlaceholderCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func certPKPersonalPlaceholderCellUI(){
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: width_PK_bounds - 24, height: 12))
        topView.backgroundColor = .white
        topView.layer.cornerRadius = 8
        topView.clipsToBounds = true
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        contentView.addSubview(topView)
        
        
        let btommeView = UIView(frame: CGRect(x: 0, y: 26, width: width_PK_bounds - 24, height: 12))
        btommeView.backgroundColor = .white
        btommeView.layer.cornerRadius = 8
        btommeView.clipsToBounds = true
        btommeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(btommeView)
        
    }
}
