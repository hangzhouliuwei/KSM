//
//  LPChannelCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/13.
//

import UIKit
import SnapKit

class LPChannelCell: UICollectionViewCell {
    
    private let bgView: UIView = {
        let bgView = UIView.lineView()
        return bgView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel.new(text: "", textColor: gray102, font: .font_Roboto_R(14),alignment: .center,isAjust: true)
        return label
    }()
    
    private let lineView: UIView = {
        let lineView = UIView.lineView(color: mainColor38)
        lineView.isHidden = true
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(titleLabel)
        bgView.addSubview(lineView)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
        
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    func setBankState(state:Bool){
        bgView.backgroundColor = state ? gray249 : .white
        titleLabel.textColor = state ? mainColor38 : gray102
        titleLabel.font = state ? .font_Roboto_M(14) : .font_Roboto_R(14)
        lineView.isHidden = !state
    }
    
    func setBillState(state:Bool){
        bgView.corners = 2
        bgView.backgroundColor = state ? mainColor38 : .clear
        titleLabel.textColor = state ? .white : .black
        titleLabel.font = state ? .font_PingFangSC_M(15) : .font_PingFangSC_R(14)
    }
    
}


