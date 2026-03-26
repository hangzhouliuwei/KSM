//
//  LPHomeSmallCardView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/4.
//

import UIKit
import FSPagerView

class LPHomeSmallCardView: UIView{
    
    var cardClick:() -> Void = {}
    
    var cardModel:LPHomeItemModel?
    var bannerList:[LPHomeItemModel] = []
    var repayModel:LPHomeItemModel?
    
    required init(cardModel:LPHomeItemModel?=nil, bannerList:[LPHomeItemModel]?=nil, repayModel:LPHomeItemModel?=nil) {
        self.cardModel = cardModel
        var cardH:CGFloat = 200
        if let bannerList = bannerList,bannerList.count>0{
            self.bannerList = bannerList
            cardH += 128
        }
        if let repayModel = repayModel{
            self.repayModel = repayModel
            cardH += 52
        }
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: cardH))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(177)
        }
        
        //MARK: cardView
        cardView.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(29)
        }
        let imgV = UIImageView()
        imgV.imgName("my_account_deletion")
        headView.addSubview(imgV)
        let labs = UILabel.new(text: "The more the amount used / The higher the interest rate", textColor: mainColor38, font: .font_PingFangSC_R(10),isAjust: true)
        headView.addSubview(labs)
        imgV.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        labs.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imgV.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
        let lineView = UIView.lineView(color: gray224)
        
        cardView.addSubview(lineView)
        cardView.addSubview(iconImg)
        cardView.addSubview(titleLab)
        cardView.addSubview(amountTitle)
        cardView.addSubview(amountLab)
        cardView.addSubview(repayBtn)
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(26)
            make.size.equalTo(CGSize(width: 1, height: 32))
            make.centerX.equalToSuperview()
        }
        iconImg.snp.makeConstraints { make in
            make.centerY.equalTo(lineView)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 38, height: 38))
        }
        titleLab.snp.makeConstraints { make in
            make.centerY.equalTo(iconImg)
            make.left.equalTo(iconImg.snp.right).offset(4)
            make.right.equalTo(lineView.snp.left).offset(-4)
        }
        amountTitle.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.equalTo(lineView.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        amountLab.snp.makeConstraints { make in
            make.top.equalTo(amountTitle.snp.bottom).offset(1)
            make.left.equalTo(lineView.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(38)
        }
        
        repayBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-13)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        
        if let cardModel = cardModel{
            self.setCardWithModel(model: cardModel)
        }
        
        //MARK: Banner
        if bannerList.count>0{
            self.addSubview(bannerView)
            bannerView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.top.equalTo(cardView.snp.bottom).offset(16)
                make.height.equalTo(112)
            }
            bannerView.reloadData()
        }
        
        //MARK: repay
        if let repayModel = repayModel{
            repayImgV.setImage(urlString: repayModel.PTUCircumorali)
            self.addSubview(repayImgV)
            repayImgV.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-8)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(36)
            }
            
        }
    }
    
    lazy var cardView:UIView = {
        let cardView = UIView.lineView()
        cardView.corners = 2
        cardView.borderColor = mainColor195
        cardView.borderWidth = 1
        cardView.isUserInteractionEnabled = true
        let tpas = UITapGestureRecognizer(target: self, action: #selector(repayClick))
        cardView.addGestureRecognizer(tpas)
        return cardView
    }()
    
    lazy var headView:UIView = {
        let headView = UIView.lineView()
        headView.corners = 2
        headView.addShadow()
        return headView
    }()
    
    lazy var iconImg:UIImageView = {
        let iconImg = UIImageView()
        iconImg.imgName("LPeso_logo")
        iconImg.corners = 19
        iconImg.addShadow()
        return iconImg
    }()
    
    lazy var titleLab:UILabel = {
        let titleLab = UILabel.new(text: "LPeso", textColor: black51, font: .boldSystemFont(ofSize: 26),isAjust: true)
        
        return titleLab
    }()
    
    lazy var amountTitle:UILabel = {
        let amountTitle = UILabel.new(text: "", textColor: gray102, font: .systemFont(ofSize: 14),alignment: .center)
        
        return amountTitle
    }()
    
    lazy var amountLab:UILabel = {
        let amountLab = UILabel.new(text: "", textColor: black51, font: .boldSystemFont(ofSize: 32),alignment: .center,isAjust: true)
        
        return amountLab
    }()
    
    lazy var repayBtn:UIButton = {
        let repayBtn = UIButton.textBtn(title: "", titleColor: .white, font: .font_Roboto_M(16), bgColor: notiColor, corner: 2)
        repayBtn.addTarget(self, action: #selector(repayClick), for: .touchUpInside)
        return repayBtn
    }()

    @objc func repayClick(){
        repayBtn.isUserInteractionEnabled = false
        cardClick()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            guard let self = self else { return }
            self.repayBtn.isUserInteractionEnabled = true
        }
    }
    
    lazy var repayImgV:UIImageView = {
        let repayImgV = UIImageView()
        let tpas = UITapGestureRecognizer(target: self, action: #selector(repayImgClick))
        repayImgV.addGestureRecognizer(tpas)
        return repayImgV
    }()
    
    @objc func repayImgClick(){
        guard let urlStr = self.repayModel?.PTUThenarditei else { return }
        print("k-- repayImgClick:\(urlStr)")
        Route.openUrl(urlStr: urlStr)
    }
    
    
    //MARK: bannerView
    private lazy var bannerView: FSPagerView = {
        let bannerView = FSPagerView()
        bannerView.backgroundColor = .clear
        bannerView.delegate = self
        bannerView.dataSource = self
        bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        bannerView.isInfinite = true
        bannerView.automaticSlidingInterval = 3
        return bannerView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.addGradient(colors: [mainColor241.cgColor,UIColor.white.cgColor])
    }
    
    public func setCardWithModel(model:LPHomeItemModel){
        iconImg.setImage(urlString: model.PTUTalofibulari)
        titleLab.text = model.PTUTrimonthlyi ?? ""
        
        amountTitle.text = model.PTUMeconici ?? ""
        amountLab.text = model.PTUTaeniai?.string

        repayBtn.setTitle(model.PTUTirosi ?? "", for: .normal)
        if let color = model.PTUJuglandaceousi{
            repayBtn.backgroundColor = UIColor(hex: color)
        }
        
    }
    
}

extension LPHomeSmallCardView:FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        self.bannerList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 2
        cell.layer.masksToBounds = true
        cell.imageView?.contentMode = .scaleAspectFit
        if self.bannerList.count > index{
            cell.imageView?.setImage(urlString:self.bannerList[index].PTUNaturopathici)
        }
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        if self.bannerList.count > index, let urlStr = self.bannerList[index].PTUThenarditei{
            Route.openUrl(urlStr: urlStr)
        }
        return false
    }

}
