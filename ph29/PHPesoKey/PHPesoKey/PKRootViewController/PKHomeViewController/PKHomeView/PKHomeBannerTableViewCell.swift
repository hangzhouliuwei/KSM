//
//  PKHomeBannerTableViewCell.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/14.
//

import UIKit
import FSPagerView

class PKHomeBannerTableViewCell: UITableViewCell {

    var homeBannerItemModel:JSON = JSON()
    var homebannerClickBlock: PKStingBlock?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        certPKHomeBannerTableViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    func certPKHomeBannerTableViewCellUI(){
        homeBannerTableViewCellbannerView.frame = CGRect(x: 0, y: safe_PK_top, width: width_PK_bounds, height: 139)
        contentView.addSubview(homeBannerTableViewCellbannerView)
    }
    
    func configPKHomeBannerTableViewCellModel(itemModel:JSON){
        self.homeBannerItemModel = itemModel
        if ( self.homeBannerItemModel["unoBYBSShoppyMwSzwtV"].arrayValue.count == 1) {
            homeBannerTableViewCellbannerView.isScrollEnabled = false
            homeBannerTableViewCellbannerView.automaticSlidingInterval = 0
        }else {
            homeBannerTableViewCellbannerView.isScrollEnabled = true
            homeBannerTableViewCellbannerView.automaticSlidingInterval = 3
        }
        self.homeBannerTableViewCellbannerView.reloadData()
    }
    
    
    //MARK: - lazy

    private lazy var homeBannerTableViewCellbannerView : FSPagerView = {
        let homeBannerTableViewCellbannerView = FSPagerView()
        homeBannerTableViewCellbannerView.backgroundColor = .clear
        homeBannerTableViewCellbannerView.delegate = self
        homeBannerTableViewCellbannerView.dataSource = self
        homeBannerTableViewCellbannerView.automaticSlidingInterval =  3
        homeBannerTableViewCellbannerView.isInfinite = !homeBannerTableViewCellbannerView.isInfinite
        homeBannerTableViewCellbannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PERABEEMianBannerCellID")
        return homeBannerTableViewCellbannerView
    }()
}

extension PKHomeBannerTableViewCell: FSPagerViewDelegate, FSPagerViewDataSource{
    
    //MARK: - FSPagerView
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        self.homeBannerItemModel["unoBYBSShoppyMwSzwtV"].arrayValue.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PERABEEMianBannerCellID", at: index)
        let model = self.homeBannerItemModel["unoBYBSShoppyMwSzwtV"].arrayValue[index]
        let imageUrl = model["nYuEdAKDelicatelyRayWHmw"].stringValue
        cell.imageView?.kf.setImage(with: URL(string:(imageUrl)), placeholder:(UIImage(named: "pk_home_bannerPlaceholder")))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if self.homeBannerItemModel["rxpCowbaneJqj"].arrayValue.count > index{
            let model = self.homeBannerItemModel["rxpCowbaneJqj"].arrayValue[index]
            homebannerClickBlock?(model["frPFiGQHarkFDGovYI"].stringValue)
        }
    }
    
}
