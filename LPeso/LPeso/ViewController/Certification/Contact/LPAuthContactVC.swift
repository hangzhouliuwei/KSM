//
//  LPAuthContactVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit

class LPAuthContactVC: LPAuthBaseVC {

    var dataModel:LPAuthConcactModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentV.addSubview(tableV)
        tableV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        getData()
    }
    
    func getData(){
        Request.send(api: .contactGet(proID: self.proID),showLoading: true) { (result:LPAuthConcactModel?) in
            if let result = result{
                self.dataModel = result
                self.refreshUI()
            }
            
        } failure: { error in
            
        }
        
    }
    
    func refreshUI(){
        if let countdown = self.dataModel?.PTUKickouti?.string{
            setCountDown(lastTime: countdown)
        }
        tableV.reloadData()
    }
    
    //MARK: lazy
    private lazy var tableV: UITableView = {
        let tableV = UITableView(frame: .zero, style: .plain)
        tableV.backgroundColor = tabBgColor
        tableV.separatorStyle = .none
        tableV.showsVerticalScrollIndicator = false
        tableV.showsHorizontalScrollIndicator = false
        tableV.delegate = self
        tableV.dataSource = self
        return tableV
    }()
    
    override func nextClick() {
        saveData()
    }
    
    func saveData(){
        guard let modelList = self.dataModel?.PTUCyprinidi else { return }
        
        var dic:[String:Any] = [:]
        for itemModel in modelList{
            guard let name = itemModel.PTUMechanotheropyi?.PTUCarmarthenshirei,
               let mobile = itemModel.PTUMechanotheropyi?.PTUCarritchi,
                  let relation = itemModel.PTUMechanotheropyi?.PTUDentistryi?.string,!isBlank(name),!isBlank(mobile),!isBlank(relation) else{
                Route.toast("Please enter the information")
                return
            }
            guard let list = itemModel.PTUHeuristici else { return }
            
            for (index,items) in list.enumerated() {
                if index == 0,let key = items.name,!isBlank(key){//name
                    dic[key] = name
                }else if index == 1,let key = items.name,!isBlank(key){//mobile
                    dic[key] = mobile
                }else if index == 2,let key = items.name,!isBlank(key){//relation
                    dic[key] = relation
                }
                
            }
            
        }
        LPApplyManager.shared.saveParams(vc: self, params: dic)
        
    }

}

extension LPAuthContactVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel?.PTUCyprinidi?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemModel = self.dataModel?.PTUCyprinidi?[indexPath.row] else {
            return UITableViewCell()
        }
        
        if let cell = Bundle.main.loadNibNamed("LPAuthConcactCell", owner: self, options: nil)?.first as? LPAuthConcactCell {
            cell.configModel(itemModel: itemModel)
            cell.clickBlock = { tags in
                DispatchQueue.main.async {
                    self.cellClick(index: indexPath.row, tags: tags)
                }
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func cellClick(index:Int,tags:Int){
        guard let itemModel = self.dataModel?.PTUCyprinidi?[index],let itemList = itemModel.PTUDentistryi else { return }
        if tags == 0{
            Route.showAuthAlert(titleTxt: "Relationship", itemList: itemList , valueType: itemModel.PTUMechanotheropyi?.PTUDentistryi?.string) { tpyes in
                if tpyes != itemModel.PTUMechanotheropyi?.PTUDentistryi?.string{
                    var model = itemModel
                    model.PTUMechanotheropyi?.PTUDentistryi?.string = tpyes
                    self.dataModel?.PTUCyprinidi?[index] = model
                    self.tableV.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            }
        }else{
            LPContactManager.shared.showContactPicker(from: self) { fullName, phoneNumber in
                if let fullName = fullName, let phoneNumber = phoneNumber{
                    var model = itemModel
                    model.PTUMechanotheropyi?.PTUCarritchi = phoneNumber
                    model.PTUMechanotheropyi?.PTUCarmarthenshirei = fullName
                    self.dataModel?.PTUCyprinidi?[index] = model
                    self.tableV.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
            
            
        }
        
        
        
    }

}

