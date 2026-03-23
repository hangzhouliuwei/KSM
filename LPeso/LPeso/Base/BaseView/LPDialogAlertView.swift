//
//  LPDialogAlertView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit
import SnapKit

enum DialogType{
    case sigleClick,confirmSelect,remind
}

class LPDialogAlertView: UIView {
    
    var submitBlock:(_ valueType:String) -> Void = {_  in}
    var confirmBlock:() -> Void = {}
    
    var dialogType:DialogType = .sigleClick
    
    var titleTxt:String = ""
    var remindTxt:String = ""
    var remindImg:String = ""
    var itemList:[LPAuthSelectModel] = []
    var valueType:String?
    var selectIndex:Int?
    
    let headH1:CGFloat = 70 //sigleClick,confirmSelect
    let headH2:CGFloat = 41 //remind
    
    let cellH:CGFloat = 56
    let cellMar:CGFloat = 16
    
    let remindH:CGFloat = 110
    
    let footH:CGFloat = 80 + Device.bottomSafe
    
    var totalH:CGFloat = 374
    
    required init(dialogType: DialogType, titleTxt:String, remindTxt:String="", remindImg:String="", itemList: [LPAuthSelectModel], selectIndex:Int? = nil, valueType:String? = nil) {
        self.dialogType = dialogType
        self.titleTxt = titleTxt
        self.remindTxt = remindTxt
        self.remindImg = remindImg
        self.itemList = itemList
        self.selectIndex = selectIndex
        self.valueType = valueType
        
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeigth))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = transColor
        
        let collectH = cellMar+CGFloat(itemList.count>3 ? 3 : itemList.count)*(cellH+cellMar)
        switch dialogType {
        case .sigleClick:
            totalH = headH1+collectH + Device.bottomSafe
        case .confirmSelect:
            totalH = headH1 + collectH + footH
        case .remind:
            totalH = headH2 + remindH + footH
        }
        
        let closeBtn = UIButton.emptyBtn()
        closeBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        self.addSubview(closeBtn)
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(totalH)
            make.bottom.equalToSuperview().offset(totalH)
        }
        closeBtn.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(kHeigth-totalH)
        }
        
        bgView.addSubview(headView)
        
        switch dialogType {
        case .sigleClick:
            //MARK: sigleClick
            let titleLab = UILabel.new(text: titleTxt, textColor: black13, font: .font_Roboto_M(16),lines: 2,isAjust: true)
            headView.addSubview(titleLab)
            headView.snp.makeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(headH1)
            }
            
            //headCloseBtn
            let headCloseBtn = UIButton.imageBtn(imgStr: "base_close_btn")
            headCloseBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
            headView.addSubview(headCloseBtn)
            titleLab.snp.makeConstraints { make in
                make.left.top.bottom.equalToSuperview().inset(16)
                make.right.equalTo(headCloseBtn.snp.left).offset(-16)
            }
            headCloseBtn.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-16)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSizeMake(24, 24))
            }
            
            bgView.addSubview(selectCollectV)
            selectCollectV.snp.makeConstraints { make in
                make.top.equalTo(headView.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
            
            
        case .confirmSelect:
            //MARK: confirmSelect
            let titleLab = UILabel.new(text: titleTxt, textColor: black13, font: .font_Roboto_M(16),lines: 2,isAjust: true)
            headView.addSubview(titleLab)
            headView.snp.makeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(headH1)
            }
            titleLab.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(16)
            }
            
            //footView
            let footView = UIView.lineView()
            footView.addShadow()
            bgView.addSubview(footView)
            footView.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(footH)
            }
            
            let backBtn = UIButton.textBtn(title: "Back", titleColor: mainColor38, font: .font_Roboto_M(16), bgColor: .clear, corner: 2, bordW: 1, bordColor: mainColor38)
            backBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
            let submitBtn = UIButton.textBtn(title: "Submit", titleColor: .white, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
            submitBtn.addTarget(self, action: #selector(submitClick), for: .touchUpInside)
            footView.addSubview(backBtn)
            footView.addSubview(submitBtn)
            backBtn.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(16)
                make.right.equalTo(submitBtn.snp.left).offset(-15)
                make.height.equalTo(48)
                make.width.equalTo(submitBtn.snp.width)
            }
            submitBtn.snp.makeConstraints { make in
                make.right.top.equalToSuperview().inset(16)
                make.left.equalTo(backBtn.snp.right).offset(15)
                make.height.equalTo(48)
                make.width.equalTo(backBtn.snp.width)
            }
            
            bgView.addSubview(selectCollectV)
            selectCollectV.snp.makeConstraints { make in
                make.top.equalTo(headView.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(footView.snp.top)
            }
            
        case .remind:
            //MARK: remind
            let titleLab = UILabel.new(text: titleTxt, textColor: black33, font: .font_Roboto_M(15),lines: 2,isAjust: true)
            headView.addSubview(titleLab)
            headView.snp.makeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(headH2)
            }
            titleLab.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.top.bottom.equalToSuperview().inset(10)
            }
            
            //contentView
            let contentView = UIView.lineView()
            bgView.addSubview(contentView)
            
            let remindLab = UILabel.new(text: remindTxt, textColor: gray102, font: .font_PingFangSC_R(15),lines: 0,isAjust: true)
            contentView.addSubview(remindLab)
            
            let remindImgV = UIImageView()
            remindImgV.imgName(remindImg)
            contentView.addSubview(remindImgV)
            
            remindLab.snp.makeConstraints { make in
                make.left.top.bottom.equalToSuperview().inset(16)
                make.right.equalTo(remindImgV.snp.left).offset(-14)
            }
            remindImgV.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-10)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSizeMake(111, 81))
            }
            
            //footView
            let footView = UIView.lineView(masks: false)
            footView.addShadow()
            bgView.addSubview(footView)
            footView.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(footH)
            }
            contentView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(headView.snp.bottom)
                make.bottom.equalTo(footView.snp.top)
            }
            
            let confirmBtn = UIButton.textBtn(title: "Confirm", titleColor: mainColor38, font: .font_Roboto_M(16), bgColor: .clear, corner: 2, bordW: 1, bordColor: mainColor38)
            confirmBtn.addTarget(self, action: #selector(confrimClick), for: .touchUpInside)
            let cancelBtn = UIButton.textBtn(title: "Cancel", titleColor: .white, font: .font_Roboto_M(16), bgColor: mainColor38, corner: 2)
            cancelBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
            footView.addSubview(confirmBtn)
            footView.addSubview(cancelBtn)
            confirmBtn.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(16)
                make.right.equalTo(cancelBtn.snp.left).offset(-15)
                make.height.equalTo(48)
                make.width.equalTo(cancelBtn.snp.width)
            }
            cancelBtn.snp.makeConstraints { make in
                make.right.top.equalToSuperview().inset(16)
                make.left.equalTo(confirmBtn.snp.right).offset(15)
                make.height.equalTo(48)
                make.width.equalTo(confirmBtn.snp.width)
            }
            
        }
        
        
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = CGAffineTransformMakeTranslation(0, -self.totalH)
        }
        
    }
    
    
    //MARK: lazy
    lazy var bgView:UIView = {
        let bgView = UIView.empty()
        return bgView
    }()
    
    lazy var headView:UIView = {
        let headView = UIView.lineView(color: gray249)
        headView.partCorners(2, type: .top)
        headView.borderColor = gray224
        headView.borderWidth = 1
        return headView
    }()
    
    lazy var selectCollectV:UICollectionView = {
        let colLay = UICollectionViewFlowLayout()
        colLay.itemSize = CGSize(width: kWidth-cellMar*2, height: cellH)
        colLay.minimumLineSpacing = cellMar
        colLay.minimumInteritemSpacing = cellMar
        colLay.scrollDirection = .vertical
        colLay.sectionInset = UIEdgeInsets(top: cellMar, left: cellMar, bottom: cellMar, right: cellMar)
        
        var selectCollectV = UICollectionView(frame: CGRectZero, collectionViewLayout: colLay)
        selectCollectV.delegate = self
        selectCollectV.dataSource = self
        selectCollectV.bounces = false
        selectCollectV.backgroundColor = .white
        selectCollectV.showsVerticalScrollIndicator = false
        selectCollectV.register(UINib.init(nibName: "LPSelectCell", bundle: nil), forCellWithReuseIdentifier: "LPSelectCell")
        return selectCollectV
    }()
  
    
    //MARK: click func
    @objc func closeClick(){
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = .identity
        }completion: { isDone in
            if isDone{
                self.removeFromSuperview()
            }
        }
        
    }
    
    @objc func submitClick(){
        guard let valueType = self.valueType else {
            Route.toast("Please select one first")
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = .identity
        }completion: { isDone in
            if isDone{
                self.removeFromSuperview()
                self.submitBlock(valueType)
            }
        }
        
    }
    
    @objc func confrimClick(){
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = .identity
        }completion: { isDone in
            if isDone{
                self.removeFromSuperview()
                self.confirmBlock()
            }
        }
        
    }

}


//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension LPDialogAlertView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indexNum = indexPath.row
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LPSelectCell", for: indexPath) as? LPSelectCell{
            cell.titleLab.text = itemList[indexNum].name ?? ""
            var hasValue = false
            if let selectIndex = selectIndex{
                hasValue = selectIndex == indexNum
            }else if let valueType = valueType{
                hasValue = valueType == itemList[indexNum].type?.string
            }
            cell.selectBtn.isSelected = hasValue
            if hasValue,collectionView.contentOffset.y == 0{
                collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
            }
            cell.clickBlock = {
                self.clickAt(index: indexPath.row)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickAt(index: indexPath.row)
    }
    
    func clickAt(index:Int){
        guard let clickType = itemList[index].type?.string else { return }
        self.valueType = clickType
        if self.dialogType == .sigleClick{
            self.submitBlock(clickType)
            self.closeClick()
        }
        selectCollectV.reloadData()
    }
    
}
