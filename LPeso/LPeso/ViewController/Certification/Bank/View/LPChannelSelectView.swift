//
//  LPChannelSelectView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/13.
//

import UIKit

class LPChannelSelectView: UIView {
    
    enum SelectType{
        case bank,bill
    }
    
    private var titleList:[String] = []
    private var viewH:CGFloat
    private var selectType:SelectType
    private var currIndex:Int = 0
    
    var channelBlock:(_ index:Int) -> Void = {_  in}

    required init(titleList:[String] = [],currentChannel:Int = 0,selectType:SelectType = .bank,y:CGFloat = 15,viewH:CGFloat = 54) {
        self.titleList = titleList
        self.currIndex = currentChannel
        self.viewH = viewH
        self.selectType = selectType
        super.init(frame: CGRect(x: 0, y: y, width: kWidth, height: viewH))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.backgroundColor = .clear
        self.addShadow()
        
        addSubview(channelColletV)
        channelColletV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var channelColletV:UICollectionView = {
        let collectionLay = UICollectionViewFlowLayout()
        collectionLay.itemSize = CGSize(width: kWidth/CGFloat(titleList.count), height: viewH)
        collectionLay.minimumLineSpacing = 0
        collectionLay.minimumInteritemSpacing = 0
        collectionLay.scrollDirection = .horizontal
        collectionLay.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        var channelColletV = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLay)
        channelColletV.bounces = false
        channelColletV.delegate = self
        channelColletV.dataSource = self
        channelColletV.backgroundColor = .clear
        channelColletV.register(LPChannelCell.self, forCellWithReuseIdentifier: "LPChannelCell")
        channelColletV.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        return channelColletV
    }()
    
    public func setTitleList(titleList:[String]){
        self.titleList = titleList
        channelColletV.reloadData()
    }
    
    public func changeIndex(index:Int){
        if currIndex != index{
            currIndex = index
            channelColletV.reloadData()
        }
        
    }

}

extension LPChannelSelectView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indexNum = indexPath.row
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LPChannelCell", for: indexPath) as? LPChannelCell{
            cell.configure(with: titleList[indexNum])
            switch selectType{
            case .bank:
                cell.setBankState(state: currIndex == indexNum)
            case .bill:
                cell.setBillState(state: currIndex == indexNum)
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currIndex != indexPath.row{
            currIndex = indexPath.row
            channelBlock(currIndex+1)
            collectionView.reloadData()
        }
    }
    
    
}
