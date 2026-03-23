//
//  LPAuthStepView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit

class LPAuthStepView: UIView {
    
    private var step:AuthStepType = .basic
    private var startTime:Int = 0//3600
    private var timer: Timer!
    
    var timeOutBlcok:() -> Void = {}
    
    required init(step:AuthStepType) {
        self.step = step
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        self.backgroundColor = .clear
        
        addSubview(timeView)
        switch step {
        case .basic,.ext,.photos:
            let imgName = step == .photos ? "au_step_identication" : step == .ext ? "au_step_contact" : "au_step_basic"
            stepImgV.imgName(imgName)
            self.addSubview(stepImgV)
            stepImgV.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.size.equalTo(CGSizeMake(352, 55))
                make.centerX.equalToSuperview().offset(7)
            }
            timeView.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(stepImgV.snp.bottom)
            }
        default:
            timeView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        let tipsLab = UILabel.new(text: "Increase pass rate by 20% for a limited time!", textColor: .white, font: .font_Roboto_M(14),alignment: .center)
        timeView.addSubview(tipsLab)
        
        let colonLab1 = setColonLab()
        let colonLab2 = setColonLab()
        timeView.addSubview(colonLab1)
        timeView.addSubview(colonLab2)
        timeView.addSubview(hoursLab)
        timeView.addSubview(minutesLab)
        timeView.addSubview(secondsLab)
        minutesLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.size.equalTo(CGSizeMake(35, 18))
        }
        hoursLab.snp.makeConstraints { make in
            make.centerY.equalTo(minutesLab)
            make.right.equalTo(minutesLab.snp.left).offset(-20)
            make.size.equalTo(CGSizeMake(35, 18))
        }
        secondsLab.snp.makeConstraints { make in
            make.centerY.equalTo(minutesLab)
            make.left.equalTo(minutesLab.snp.right).offset(20)
            make.size.equalTo(CGSizeMake(35, 18))
        }
        colonLab1.snp.makeConstraints { make in
            make.centerY.equalTo(minutesLab)
            make.left.equalTo(hoursLab.snp.right)
            make.right.equalTo(minutesLab.snp.left)
        }
        colonLab2.snp.makeConstraints { make in
            make.centerY.equalTo(minutesLab)
            make.left.equalTo(minutesLab.snp.right)
            make.right.equalTo(secondsLab.snp.left)
        }
        
        tipsLab.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(minutesLab.snp.top)
        }
        
    }
    
    private lazy var hoursLab:UILabel = {
        return setTimesLab()
    }()
    private lazy var minutesLab:UILabel = {
        return setTimesLab()
    }()
    private lazy var secondsLab:UILabel = {
        return setTimesLab()
    }()
    
    private func setTimesLab() -> UILabel{
        let timesLab = UILabel.new(text: "00", textColor: black2, font: .font_Roboto_M(12),alignment: .center)
        timesLab.corners = 2
        timesLab.backgroundColor = .white
        return timesLab
    }
    
    private func setColonLab() -> UILabel{
        let colonLab = UILabel.new(text: ":", textColor: .white, font: .font_Roboto_M(12),alignment: .center)
        return colonLab
    }
    
    private lazy var stepImgV:UIImageView = {
        let stepImgV = UIImageView()
        return stepImgV
    }()
    
    private lazy var timeView:UIView = {
        let timeView = UIView.lineView(color: mainColor38)
        timeView.isHidden = true
        return timeView
    }()
    
    @objc private func onCountDown() {
        if self.startTime > 0{
            self.startTime -= 1
            setCurrentTimeLab()
        }else{
            stopCountDown()
        }
        
    }
    
    private func stopCountDown() {
        guard timer != nil else { return }
        timer.invalidate()
        timer = nil
        timeView.isHidden = true
        timeOutBlcok()
    }
    
    private func setCurrentTimeLab(){
        timeView.isHidden = false
        
        let timeInSeconds = Double(startTime)
        
        let hours = Int(timeInSeconds / 3600)
        self.hoursLab.text = String(format: "%02d", hours)
        
        let remainingSecondsAfterHours = timeInSeconds.truncatingRemainder(dividingBy: 3600)
        let minutes = Int(remainingSecondsAfterHours / 60)
        self.minutesLab.text = String(format: "%02d", minutes)
        
        let remainingSecondsAfterMinutes = remainingSecondsAfterHours.truncatingRemainder(dividingBy: 60)
        let seconds = Int(remainingSecondsAfterMinutes)
        self.secondsLab.text = String(format: "%02d", seconds)
    }
    
    @objc func startCountDownWith(times:Int) {
        self.startTime = times
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onCountDown), userInfo: nil, repeats: true)
        
    }
    
}
