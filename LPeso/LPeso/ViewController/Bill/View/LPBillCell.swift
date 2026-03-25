//
//  LPBillCell.swift
//  LPeso
//
//  Created by Kiven on 2024/11/14.
//

import UIKit
import SnapKit

class LPBillCell: UITableViewCell {
    
    var billModel:LPBillItemModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        bgView.addSubview(iconImg)
        bgView.addSubview(titleLab)
        bgView.addSubview(stateLab)
        bgView.addSubview(arrowImg)
        bgView.addSubview(lineView)
        bgView.addSubview(amountLab)
        bgView.addSubview(repayTimeLab)
        bgView.addSubview(repayBtnLab)
        bgView.addSubview(planTabV)
        
        iconImg.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(iconImg.snp.right).offset(12)
            make.right.equalTo(stateLab.snp.left).offset(-2)
            make.centerY.equalTo(iconImg)
            make.height.equalTo(20)
            make.width.equalTo(stateLab.snp.width)
        }
        arrowImg.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(iconImg)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        stateLab.snp.makeConstraints { make in
            make.right.equalTo(arrowImg.snp.left).offset(-4)
            make.left.equalTo(titleLab.snp.right).offset(2)
            make.centerY.equalTo(iconImg)
            make.height.equalTo(20)
            make.width.equalTo(titleLab.snp.width)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(iconImg.snp.bottom).offset(12)
            make.height.equalTo(1)
        }
        
        amountLab.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.left.equalTo(iconImg)
            make.height.equalTo(44)
        }
        repayTimeLab.snp.makeConstraints { make in
            make.top.equalTo(amountLab.snp.bottom).offset(2)
            make.left.equalTo(amountLab)
            make.right.equalTo(repayBtnLab.snp.left).offset(-4)
            make.height.equalTo(14)
        }
        
        repayBtnLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(amountLab).offset(4)
            make.size.equalTo(CGSize(width: 120, height: 40))
        }
        
        planTabV.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(16)
            make.top.equalTo(repayBtnLab.snp.bottom).offset(23)
        }
        
    }
    
    //MARK: lazy
    private lazy var bgView:UIView = {
        let bgView = UIView.empty()
        bgView.corners = 2
        bgView.borderColor = gray224
        bgView.borderWidth = 1
        return bgView
    }()
    
    private lazy var iconImg:UIImageView = {
        let iconImg = UIImageView()
        iconImg.corners = 16
        return iconImg
    }()
    
    private lazy var titleLab:UILabel = {
        let titleLab = UILabel.new(text: "", textColor: mainColor46, font: .font_Roboto_M(16))
        
        return titleLab
    }()
    
    private lazy var arrowImg:UIImageView = {
        let arrowImg = UIImageView.nameWith("bill_right_arrow")
        return arrowImg
    }()
    
    private lazy var stateLab:UILabel = {
        let stateLab = UILabel.new(text: "", textColor: mainColor46, font: .font_Roboto_M(16),alignment: .right)
        
        return stateLab
    }()
    
    private lazy var lineView:UIView = {
        let lineView = UIView.lineView(color: gray224)
        return lineView
    }()
    
    private lazy var amountLab:UILabel = {
        let amountLab = UILabel.new(text: "", textColor: black51, font: .systemFont(ofSize: 32))
        
        return amountLab
    }()
    
    private lazy var repayTimeLab:UILabel = {
        let repayTimeLab = UILabel.new(text: "", textColor: black51, font: .systemFont(ofSize: 12))
        
        return repayTimeLab
    }()
    
    private lazy var repayBtnLab:UILabel = {
        let repayBtnLab = UILabel.new(text: "", textColor: .white, font: .systemFont(ofSize: 12),alignment: .center)
        repayBtnLab.backgroundColor = mainColor38
        repayBtnLab.corners = 3
        return repayBtnLab
    }()
    
    
    private lazy var planTabV: UITableView = {
        let planTabV = UITableView(frame: .zero, style: .plain)
        planTabV.separatorStyle = .none
        planTabV.showsVerticalScrollIndicator = false
        planTabV.showsHorizontalScrollIndicator = false
        planTabV.delegate = self
        planTabV.dataSource = self
        planTabV.isUserInteractionEnabled = false
        planTabV.backgroundColor = mainColor241
        planTabV.corners = 2
        planTabV.isHidden = true
        return planTabV
    }()
    
    
    //MARK: configModel
    public func configModel(model:LPBillItemModel){
        billModel = model
        
        titleLab.text = model.PTUTrimonthlyi ?? ""
        iconImg.setImage(urlString: model.PTUTalofibulari)
        
        if let stateStr = model.PTUAmortisationi,!isBlank(stateStr){
            stateLab.isHidden = false
            stateLab.text = stateStr
            stateLab.textColor = UIColor.init(hex: model.PTUHolmiumi ?? "") ?? mainColor46
        }else{
            stateLab.isHidden = true
        }
        
        amountLab.text = model.PTUNandini?.string ?? ""
        
        if let timeStr = model.PTUoihjivgc,!isBlank(timeStr){
            repayTimeLab.isHidden = false
            repayTimeLab.text = timeStr
        }else{
            repayTimeLab.isHidden = true
        }
        
        if let repayStr = model.PTUTirosi,!isBlank(repayStr){
            repayBtnLab.isHidden = false
            repayBtnLab.text = repayStr
            repayBtnLab.backgroundColor = UIColor.init(hex: model.PTUAeropoliticsi ?? "") ?? mainColor46
        }else{
            repayBtnLab.isHidden = true
        }
        
        //repayView
        if let planList = model.PTUuqwsdgytc,planList.count > 0{
            planTabV.snp.remakeConstraints { make in
                make.left.right.bottom.equalToSuperview().inset(16)
                make.top.equalTo(repayBtnLab.snp.bottom).offset(23)
                make.height.equalTo(planList.count*28)
            }
            planTabV.isHidden = false
            planTabV.reloadData()
            
        }
        
    }

}


extension LPBillCell:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billModel?.PTUuqwsdgytc?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let planModel = billModel?.PTUuqwsdgytc?[indexPath.row]{
            if let cell = Bundle.main.loadNibNamed("LPBillPlanCell", owner: self, options: nil)?.first as? LPBillPlanCell {
                cell.configModel(model: planModel)
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
}
