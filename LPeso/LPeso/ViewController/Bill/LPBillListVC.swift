//
//  LPBillListVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/4.
//

import UIKit

class LPBillListVC: LPBaseVC {
    
    var currentChannel:Int = 2
    
    var billList:[LPBillItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lp_title = "My Bill"
        contentV.addSubview(channelView)
        channelView.channelBlock = { tags in
            self.currentChannel = tags
            self.getDataWithType()
        }
        contentV.addSubview(tipsLab)
        tipsLab.snp.makeConstraints { make in
            make.top.equalTo(channelView.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        contentV.addSubview(tableV)
        tableV.snp.makeConstraints { make in
            make.top.equalTo(tipsLab.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        setupSwipeGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataWithType()
    }
    
    //MARK: lazy
    private lazy var tableV: UITableView = {
        let tableV = UITableView(frame: .zero, style: .plain)
        tableV.backgroundColor = .white
        tableV.separatorStyle = .none
        tableV.showsVerticalScrollIndicator = false
        tableV.showsHorizontalScrollIndicator = false
        tableV.delegate = self
        tableV.dataSource = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getDataWithType), for: .valueChanged)
        tableV.refreshControl = refreshControl
        return tableV
    }()
    
    lazy var channelView:LPChannelSelectView = {
        let channelView = LPChannelSelectView(titleList: ["Borrowing","Order","Not fnished","Repaid"],currentChannel: currentChannel-1,selectType: .bill,y: 19,viewH: 34)
        
        return channelView
    }()
    
    lazy var tipsLab:UILabel = {
        let tipsLab = UILabel.new(text: "Please repay on time, the credit limit will be higher.", textColor: .white, font: .font_PingFangSC_M(12),alignment: .center)
        tipsLab.backgroundColor = notiColor
        return tipsLab
    }()
    
    //MARK: - getDataWithType
    @objc func getDataWithType(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.tableV.refreshControl?.endRefreshing()
        }
        
        billList = []
        
        var type = "4"
        if currentChannel == 1{
            type = "7"
        }else if currentChannel == 2{
            type = "4 "
        }else if currentChannel == 3{
            type = "6"
        }else if currentChannel == 4{
            type = "5"
        }
        print("k-- get productList:\(type)")
        Request.send(api: .productList(type: type),showLoading: true) { (result:LPBillModel?) in
            self.tableV.refreshControl?.endRefreshing()
            self.billList = result?.PTUIncipienti ?? []
            self.tableV.reloadData()
        } failure: { error in
            self.tableV.refreshControl?.endRefreshing()
        }
        
    }
    
    //MARK: SwipeGestures
    private func setupSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if currentChannel < 4 {
                currentChannel += 1
                channelView.changeIndex(index: currentChannel-1)
                getDataWithType()
            }
        } else if gesture.direction == .right {
            if currentChannel > 1 {
                currentChannel -= 1
                channelView.changeIndex(index: currentChannel-1)
                getDataWithType()
            }
        }
    }
    
}


extension LPBillListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if billList.count > 0{
            return billList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if billList.count > 0{
            return UITableView.automaticDimension
        }
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if billList.count > 0{
            let cell = LPBillCell(style: .default, reuseIdentifier: "LPBillCell_\(indexPath.section)_\(indexPath.row)")
            cell.configModel(model: billList[indexPath.row])
            return cell
        }else{
            let cell = LPBillEmptyCell(style: .default, reuseIdentifier: "LPBillEmptyCell")
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if billList.count > 0,let url = billList[indexPath.row].PTUPetemani{
            Route.openUrl(urlStr: url)
        }
       
    }
    
}
