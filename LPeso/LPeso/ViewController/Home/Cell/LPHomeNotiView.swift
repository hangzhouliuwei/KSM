//
//  LPHomeNotiView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/5.
//

import UIKit

class LPHomeNotiView: UIScrollView ,UIScrollViewDelegate {
    
    var timer:Timer?
    var notiArr:[LPHomeItemModel] = []

    required init(arr:[LPHomeItemModel]?=nil) {
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: 32))
        self.backgroundColor = notiColor
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.isUserInteractionEnabled = false
        self.delegate = self
        if let arr = arr{
            setScrollWithArr(arr: arr)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScrollWithArr(arr:[LPHomeItemModel]){
        notiArr = arr
        endTimer()
        removeAllSubviews()
        if self.notiArr.count > 0{
            
            let arr = notiArr+notiArr+notiArr
            let labWid: CGFloat = self.bounds.width
            let labHei: CGFloat = self.bounds.height
            
            for i in 0..<arr.count {
                let item = arr[i]
                
                let iconImg = UIImageView(frame: CGRect(x: 18, y: CGFloat(i)*labHei+8, width: 16, height: 16))
                iconImg.imgName("home_notice")
                self.addSubview(iconImg)
                
                let lab = UILabel()
                lab.frame = CGRect(x: 45, y: CGFloat(i)*labHei, width: labWid-60, height: labHei)
                lab.text = item.PTUZedoaryi
                lab.font = .font_PingFangSC_R(13)
                lab.textColor = UIColor.init(hex: item.PTUPolysemyi ?? "#FFFFFF") ?? .white
                self.addSubview(lab)
            }
            let contentHei = CGFloat(arr.count) * labHei
            self.contentSize = CGSizeMake(0, contentHei)
            self.contentOffset = CGPoint(x: 0, y: 0)
            startTimer()
        }
        
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(turnPages), userInfo: nil, repeats: false)
    }
    
    func endTimer(){
        timer?.invalidate()
        timer = nil
    }

    @objc func turnPages() {
        let offsetY = self.contentOffset.y
        if offsetY == CGFloat(3 * self.notiArr.count - 1) * self.bounds.height {
            self.contentOffset.y = CGFloat(self.notiArr.count - 1) * self.bounds.height
        }else {
            self.setContentOffset(CGPoint(x: 0, y: offsetY+self.bounds.size.height), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.contentOffset.y == 0 {
            self.contentOffset.y = CGFloat(self.notiArr.count*2 - 1) * self.bounds.height
        }else if self.contentOffset.y == CGFloat(self.notiArr.count*3 - 1) * self.bounds.height {
            self.contentOffset.y = CGFloat(self.notiArr.count - 1) * self.bounds.height
        }
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        endTimer()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        startTimer()
    }
    
}
