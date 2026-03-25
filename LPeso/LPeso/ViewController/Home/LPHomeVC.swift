//
//  LPHomeVC.swift
//  LPeso
//
//  Created by Kiven on 2024/10/25.
//

import UIKit

enum HomeItemType: String, Codable{
    case BANNER = "HYNMKS"
    case RIDING_LANTERN = "HYNIUDS"
    case LARGE_CARD = "HYNMKKA"
    case SMALL_CARD = "HYNQQQA"
    case PRODUCT_LIST = "HYNQQQB"
    case REPAY_NOTICE = "HYNQQQC"
}

class LPHomeVC: LPBaseVC {
    
    var homeModel:LPHomeDataModel?
    
    var cardModel:LPHomeItemModel?
    
    var bannerArr:[LPHomeItemModel]?
    
    var repayModel:LPHomeItemModel?
    
    var productList:[LPHomeItemModel]?
    
    var isLarge:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        hasBackButton = false
        
        self.contentV.addSubview(notiScrollView)
        self.contentV.addSubview(homeTableV)
        homeTableV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserSession.isLogin(){
            reloadDataSource()
            LPDataManager.shared.checkDomains()
        }
    }
    
    @objc func reloadDataSource(){
        Route.showHomeAlertView()

        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.homeTableV.refreshControl?.endRefreshing()
        }
        Request.send(api: .home,showLoading: true) { (result:LPHomeDataModel?) in
            self.homeTableV.refreshControl?.endRefreshing()
            if let result = result{
                self.dealWithHomeData(model: result)
            }
        } failure: { error in
            self.homeTableV.refreshControl?.endRefreshing()
        }
        LPDataManager.shared.reloadMineData()
    }
    
    //MARK:  deal Data
    func dealWithHomeData(model:LPHomeDataModel){
        self.homeModel = model
        
        LPDataManager.shared.customModel = model.custom
        self.setCustomModel(model: model.custom)
        
        guard let itemList = model.itemList else { return }
        for homeItem in itemList{
            guard let homeType = homeItem.type, let items = homeItem.items,items.count>0 else{ return }
            switch homeType {
            case .BANNER:
                self.bannerArr = items
                
            case .RIDING_LANTERN:
                self.notiScrollView.isHidden = false
                self.notiScrollView.setScrollWithArr(arr: items)
                homeTableV.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(32)
                    make.left.right.bottom.equalToSuperview()
                }
                
            case .LARGE_CARD:
                isLarge = true
                self.cardModel = items.first
                
            case .SMALL_CARD:
                isLarge = false
                self.cardModel = items.first
                
            case .PRODUCT_LIST:
                self.productList = items
                
            case .REPAY_NOTICE:
                self.repayModel = items.first
                
            }
        }
        
        if isLarge{
            let headView = LPHomeLargeCardView(cardModel: self.cardModel)
            self.homeTableV.tableHeaderView = headView
            headView.cardClick = {[weak self] in
                guard let self = self,let proID = self.cardModel?.PTUProfanei?.string else { return }
                LPApplyManager.shared.applyNow(proID: proID)
            }
        }else{
            let headView = LPHomeSmallCardView(cardModel: self.cardModel, bannerList: self.bannerArr, repayModel: self.repayModel)
            headView.cardClick = {[weak self] in
                guard let self = self,let proID = self.cardModel?.PTUProfanei?.string else { return }
                LPApplyManager.shared.applyNow(proID: proID)
            }
            self.homeTableV.tableHeaderView = headView
        }
        
        homeTableV.reloadData()
        
    }

    //MARK: lazy
    private lazy var homeTableV: UITableView = {
        let homeTableV = UITableView(frame: .zero, style: .plain)
        homeTableV.backgroundColor = .white
        homeTableV.separatorStyle = .none
        homeTableV.showsVerticalScrollIndicator = false
        homeTableV.showsHorizontalScrollIndicator = false
        homeTableV.register(UINib.init(nibName: "LPHomeProductCell", bundle: nil), forCellReuseIdentifier: "LPHomeProductCell")
        homeTableV.register(UINib.init(nibName: "LPHomeLargeCardCell", bundle: nil), forCellReuseIdentifier: "LPHomeLargeCardCell")
        homeTableV.delegate = self
        homeTableV.dataSource = self
        homeTableV.tableFooterView = LPHomeFootView()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadDataSource), for: .valueChanged)
        homeTableV.refreshControl = refreshControl
        return homeTableV
    }()
    
    lazy var notiScrollView:LPHomeNotiView = {
        let notiScrollView = LPHomeNotiView()
        notiScrollView.isHidden = true
        return notiScrollView
    }()
    
}


//MARK: UITableViewDelegate
extension LPHomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        if isLarge{
            num = 1
        }else{
            num = productList?.count ?? 0
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLarge{
            return 164
        }else{
            return 152
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLarge{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LPHomeLargeCardCell", for: indexPath) as? LPHomeLargeCardCell{
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LPHomeProductCell", for: indexPath) as? LPHomeProductCell{
                if (productList?.count ?? 0)>indexPath.row,let item = productList?[indexPath.row]{
                    cell.updateWithModel(model: item)
                }
                cell.clickBlock = {
                    self.productClick(index: indexPath.row)
                }
                return cell
            }
        }
        
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productClick(index: indexPath.row)
    }
    
    func productClick(index:Int){
        guard let listNum = productList?.count,listNum > index,let proID = productList?[index].PTUProfanei?.string else { return }
        LPApplyManager.shared.applyNow(proID: proID)
    }
    
}

