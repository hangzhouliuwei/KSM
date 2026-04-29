//
//  XTBannerCell.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import TYCyclePagerView
import UIKit

@objcMembers
@objc(XTBannerCell)
class XTBannerCell: XTCell, TYCyclePagerViewDataSource, TYCyclePagerViewDelegate {
    private var bannerList: [BannerModel] = []

    private lazy var banner: TYCyclePagerView = {
        let view = TYCyclePagerView(frame: CGRect(x: 15, y: 0, width: UIScreen.main.bounds.width - 30, height: 115))
        view.isInfiniteLoop = false
        view.dataSource = self
        view.delegate = self
        view.register(XTBannerChildCell.self, forCellWithReuseIdentifier: "XTBannerChildCell")
        return view
    }()

    override var xt_data: Any? {
        didSet {
            guard let array = xt_data as? [BannerModel] else { return }
            bannerList = array
            banner.autoScrollInterval = array.count > 1 ? 3 : 0
            banner.reloadData()
        }
    }

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(banner)
    }

    @objc(layoutForPagerView:)
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: banner.frame.width, height: banner.frame.height)
        layout.itemSpacing = 10
        layout.itemHorizontalCenter = true
        return layout
    }

    @objc(numberOfItemsInPagerView:)
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        bannerList.count
    }

    @objc(pagerView:cellForItemAtIndex:)
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "XTBannerChildCell", for: index)
        if let bannerCell = cell as? XTBannerChildCell, bannerList.indices.contains(index) {
            bannerCell.model = bannerList[index]
        }
        return cell
    }

    @objc(pagerView:didSelectedItemCell:atIndex:)
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        guard bannerList.indices.contains(index) else { return }
        XTRoute.xt_share().goHtml(bannerList[index].routeURL ?? "", success: nil)
    }
}
