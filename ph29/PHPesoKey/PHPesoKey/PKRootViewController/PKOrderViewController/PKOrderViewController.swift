//
//  PKOrderViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit

class PKOrderViewController: UIViewController {

    @IBOutlet weak var orderBut1: UIButton!
    @IBOutlet weak var butLine1: UIView!
    
    @IBOutlet weak var orderBut2: UIButton!
    @IBOutlet weak var butLine2: UIView!
    
    @IBOutlet weak var orderTabView: UITableView!
    
    @IBOutlet weak var orderNullView: UIView!
    @IBOutlet weak var bgV: UIView!
    
    var currentType:Int = 0
    let orderRefresh = UIRefreshControl()
    var OrderDataArr:[JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTabView.delegate = self
        orderTabView.dataSource = self
        orderRefresh.addTarget(self, action: #selector(loadOrderViewControllerData), for: .valueChanged)
        orderTabView.refreshControl = orderRefresh
        addPKOrderViewControllerSwipeGestures()
        bgV.layer.masksToBounds = true
        bgV.layer.cornerRadius = 20
        bgV.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgV.snp.remakeConstraints { make in
//            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(-(safe_PK_bottom + 60 * PK_Scale))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadOrderViewControllerData()
    }
    
    @objc func loadOrderViewControllerData(){
        let dic = ["maembYIFacilitateJMnEZhr":currentType == 0 ? "6" : "8","jXctLWcBorborygmusJwNJFIO":"1","QxGpJPMRendezvousGPuhkzD":"20"]
        PKupLoadingManager.upload.loadPost(place: "/BcheNSkillfullyTDaGb",dict: dic,upping: true) { [weak self] data in
            guard let self = self else { return }
            self.OrderDataArr = data.runData["wxEXRPPPrudenceAHcCpFJ"].arrayValue
            self.updataPKOrderViewControllerUI()
            self.orderRefresh.endRefreshing()
        } failed: { [weak self] errorMsg in
            guard let self = self else { return }
            self.orderRefresh.endRefreshing()
        }
        
    }
    
    func updataPKOrderViewControllerUI(){
        orderTabView.isHidden = OrderDataArr.count == 0
        orderNullView.isHidden = OrderDataArr.count > 0
        orderTabView.reloadData()
    }
    

    @IBAction func selectClcik(_ sender: UIButton) {
        if currentType != sender.tag{
            currentType = sender.tag
            butLine1.isHidden = currentType == 1
            butLine2.isHidden = currentType == 0
            orderBut1.titleLabel?.font =  currentType == 0 ? UIFont(name: "PingFangSC-Semibold", size: 14) : UIFont(name: "PingFangSC-Regular", size: 14)
            orderBut2.titleLabel?.font =  currentType == 1 ? UIFont(name: "PingFangSC-Semibold", size: 14) : UIFont(name: "PingFangSC-Regular", size: 14)
            loadOrderViewControllerData()
        }
        
    }
    
    func addPKOrderViewControllerSwipeGestures() {
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)
        

        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        rightSwipeGesture.direction = .right
        self.view.addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            pkOrderViewControllerSlidemonitoring(type: 1)
        } else if gesture.direction == .right {
            pkOrderViewControllerSlidemonitoring(type: 0)
        }
    }
    
    func pkOrderViewControllerSlidemonitoring(type: Int){
        if type == currentType{
            return
        }
        
        currentType = type
        butLine1.isHidden = currentType == 1
        butLine2.isHidden = currentType == 0
        orderBut1.titleLabel?.font =  currentType == 0 ? UIFont(name: "PingFangSC-Semibold", size: 14) : UIFont(name: "PingFangSC-Regular", size: 14)
        orderBut2.titleLabel?.font =  currentType == 1 ? UIFont(name: "PingFangSC-Semibold", size: 14) : UIFont(name: "PingFangSC-Regular", size: 14)
        loadOrderViewControllerData()
    }
    
    
    @IBAction func applyMow(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    func pkOrdergotoWebVC(webUrl:String){
        if pKCheckString(with: webUrl){
            let webVC = PKWebkitViewController()
            webVC.pkWebUrlStr = webUrl
            navigationController?.pushViewController(webVC, animated: true)
        }
        
    }
    
}

extension PKOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          OrderDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let orderItem = Bundle.main.loadNibNamed("PKOrderTableViewCell", owner: self, options: nil)?.first as? PKOrderTableViewCell {
            orderItem.configPKOrderTableViewCellModel(itmeModel: OrderDataArr[indexPath.row])
            orderItem.orderTableViewCellClickBlock = { [weak self] webUrl in
                guard let self = self else { return }
                self.pkOrdergotoWebVC(webUrl: webUrl)
            }
            return orderItem
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
           165
    }
    
    
    
}

