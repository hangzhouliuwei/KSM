//
//  LPDatePickerView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/11.
//

import UIKit
import SnapKit

class LPDatePickerView: UIView ,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var onDateSelected: ((_ dateString: String) -> Void)?
    
    private var years:[Int] = Array(1960...2040)
    private var months = Array(1...12)
    private var days = Array(1...31)
    
    private var headH: CGFloat = 70
    private var pickerH: CGFloat = 191
    
    private var initialDate: Date?
    private var titleTxt: String?
    
    required init(dateString:String?=nil,titleTxt:String?=nil) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeigth))
        if let dateString = dateString, let date = dateFromString(dateString) {
            initialDate = date
        } else {
            initialDate = Date()
        }
        self.titleTxt = titleTxt
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: dateString)
    }
    
    //MARK: setup View
    func setupView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelClick))
        addGestureRecognizer(tapGesture)
        backgroundColor = transColor
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(headH+pickerH)
            make.height.equalTo(headH+pickerH)
        }
        
        bgView.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(pickerH)
        }
        
        let headView = UIView.lineView(color: gray249)
        headView.partCorners(2, type: .top)
        bgView.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pickerView.snp.top)
            make.height.equalTo(headH)
        }
        
        let cancelBtn = UIButton.textBtn(title: "Cancel",titleColor: .rgba(97, 108, 95, 1),font: .font_PingFangSC_R(15))
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        let confirmBtn = UIButton.textBtn(title: "Confirm",titleColor: mainColor46,font: .font_PingFangSC_R(15))
        confirmBtn.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
        headView.addSubview(cancelBtn)
        headView.addSubview(confirmBtn)
        cancelBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        confirmBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        if let titleTxt = titleTxt{
            let titleLab = UILabel.new(text: titleTxt, textColor: black13, font: .font_Roboto_M(16),alignment: .center,isAjust: true)
            headView.addSubview(titleLab)
            titleLab.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(cancelBtn.snp.right)
                make.right.equalTo(confirmBtn.snp.left)
            }
        }
        
        let lineView = UIView.lineView(color: gray224)
        headView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        selectInitialDate()
        showDateView()
    }
    
    //MARK: lazy
    lazy var bgView:UIView = {
        let bgView = UIView.empty()
        return bgView
    }()
    
    private lazy var pickerView:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    //MARK: Click func
    @objc private func cancelClick() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.transform = .identity
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc private func confirmClick() {
        let day = days[pickerView.selectedRow(inComponent: 0)]
        let month = months[pickerView.selectedRow(inComponent: 1)]
        let year = years[pickerView.selectedRow(inComponent: 2)]
        
        let selectedDateString = String(format: "%02d-%02d-%04d", day, month, year)
        onDateSelected?(selectedDateString)
        
        cancelClick()
    }
    
    private func showDateView(){
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = CGAffineTransformMakeTranslation(0, -(self.headH+self.pickerH))
        }
    }
    
    private func updateDays(for month: Int, year: Int) {
        let daysInMonth = [31, (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        days = Array(1...daysInMonth[month - 1])
        pickerView.reloadComponent(0)
    }
    
    private func selectInitialDate() {
        guard let date = initialDate else { return }
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        if let yearIndex = years.firstIndex(of: year) {
            pickerView.selectRow(day - 1, inComponent: 0, animated: false)
            pickerView.selectRow(month - 1, inComponent: 1, animated: false)
            pickerView.selectRow(yearIndex, inComponent: 2, animated: false)
        }
        
        updateDays(for: month, year: year)
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // Day, Month, Year
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return days.count
        case 1: return months.count
        case 2: return years.count
        default: return 0
        }
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(days[row])Day"
        case 1: return "\(months[row])Month"
        case 2: return "\(years[row])Year"
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 || component == 2 { // Month or Year changed
            let selectedMonth = months[pickerView.selectedRow(inComponent: 1)]
            let selectedYear = years[pickerView.selectedRow(inComponent: 2)]
            updateDays(for: selectedMonth, year: selectedYear)
        }
    }
}
