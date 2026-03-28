//
//  LPAuthBasicVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit

class LPAuthBasicVC: LPAuthBaseVC {
    
    var dataModel:LPAuthBasicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentV.addSubview(tableV)
        tableV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        getData()

    }

    func getData(){
        Request.send(api: .basicGet(proID: self.proID),showLoading: true) { (result:LPAuthBasicModel?) in
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
        let tableV = UITableView(frame: .zero, style: .grouped)
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
        guard let groupList = self.dataModel?.PTUCyprinidi else { return }
        var dic: [String: Any] = [:]
        for groupModel in groupList{
            for itemModel in groupModel.PTUIncipienti ?? []{
                if itemModel.PTUIndividualityi?.int == 0{
                    if isBlank(itemModel.PTUMesenchymatousi?.string){
                        Route.toast(itemModel.PTUAntehalli ?? "Please select")
                        return
                    }
                    if let key = itemModel.PTUGoatpoxi{
                        dic[key] = itemModel.PTUMesenchymatousi?.string
                    }
                    
                }else{
                    if let key = itemModel.PTUGoatpoxi{
                        dic[key] = itemModel.PTUMesenchymatousi?.string
                    }
                    
                }
                
            }
            
        }
        
        LPApplyManager.shared.saveParams(vc: self, params: dic)
        
    }
    
}

extension LPAuthBasicVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataModel?.PTUCyprinidi?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let groupModel = self.dataModel?.PTUCyprinidi?[section] else {
            return 0
        }
        return groupModel.more?.bool == true && !(groupModel.isFold ?? false) ? 0 : groupModel.PTUIncipienti?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        guard let groupModel = self.dataModel?.PTUCyprinidi?[section],let _ = groupModel.PTUTilefishi else {
            return 0.01
        }
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let groupModel = self.dataModel?.PTUCyprinidi?[section],let _ = groupModel.PTUTilefishi else {
            return UIView.empty()
        }
        let headView = LPAuthGroupHeadView(headModel: groupModel)
        headView.moreBlock = { [weak self] isFold in
            guard let self = self else { return }
            self.dataModel?.PTUCyprinidi?[section].isFold = !isFold
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
        return headView
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.empty()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupModel = self.dataModel?.PTUCyprinidi?[indexPath.section],let modelList = groupModel.PTUIncipienti,modelList.count > indexPath.row  else {
            return UITableViewCell()
        }
        let itemModel = modelList[indexPath.row]
        
        let cell = LPAuthItemCell(style: .default, reuseIdentifier: "LPAuthCell_\(indexPath.section)_\(indexPath.row)")
        cell.configModel(itemModel: itemModel, tabview: tableView)
        cell.clickBlock = {
            DispatchQueue.main.async {
                self.showSelectAlert(itemModel: itemModel, indexPath: indexPath)
            }
            
        }
        cell.endEditBlcok = { txt in
            var model = itemModel
            model.PTUMesenchymatousi?.string = txt
            self.resetModel(model: model, indexPath: indexPath)
        }
        return cell
    }
    
    func showSelectAlert(itemModel:LPAuthItemModel,indexPath:IndexPath){
        view.endEditing(true)
        if itemModel.PTUCockadei == .enums{
            Route.showBasicAuthAlert(itemModel: itemModel) { selectType in
                var model = itemModel
                model.PTUMesenchymatousi?.string = selectType
                self.resetModel(model: model, indexPath: indexPath)
            }
        }else if itemModel.PTUCockadei == .day{
            Route.showDatePicker(dateString: itemModel.PTUMesenchymatousi?.string, titleTxt: itemModel.PTUTilefishi) { dateStr in
                var model = itemModel
                model.PTUMesenchymatousi?.string = dateStr
                self.resetModel(model: model, indexPath: indexPath)
            }
            
        }
        
    }
    
    func resetModel(model:LPAuthItemModel,indexPath:IndexPath){
        self.dataModel?.PTUCyprinidi?[indexPath.section].PTUIncipienti?[indexPath.row] = model
        self.tableV.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        
        if model.PTUCockadei == .txt{
            return
        }
        if let nextPath = getNextIndex(indexPath: indexPath){
            if let itemModel = self.dataModel?.PTUCyprinidi?[nextPath.section].PTUIncipienti?[nextPath.row],isBlank(itemModel.PTUMesenchymatousi?.string){
                if itemModel.PTUCockadei == .enums || itemModel.PTUCockadei == .day{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {[weak self] in
                        guard let self = self else { return }
                        tableV.scrollToRow(at: nextPath, at: .top, animated: true)
                        showSelectAlert(itemModel: itemModel, indexPath: nextPath)
                    }
                }else if itemModel.PTUCockadei == .txt{
                    return
                }
//                else if itemModel.PTUCockadei == .txt,isBlank(itemModel.PTUMesenchymatousi?.string){
//                    if let cell = self.tableV.cellForRow(at: nextPath) as? LPAuthItemCell{
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {[weak self] in
//                            guard let self = self else { return }
//                            tableV.scrollToRow(at: nextPath, at: .middle, animated: true)
//                            cell.inputfiled.becomeFirstResponder()
//                        }
//                        
//                    }
//                }
                
            }
            
            
        }
    }
    
    func getNextIndex(indexPath:IndexPath) ->IndexPath?{
        if let groupModel = self.dataModel?.PTUCyprinidi?[indexPath.section],let rowNum = groupModel.PTUIncipienti?.count{
            if indexPath.row < rowNum-1{
                let nextPath = IndexPath(row: indexPath.row+1, section: indexPath.section)
                
                if let groupModel = self.dataModel?.PTUCyprinidi?[nextPath.section],let modelList = groupModel.PTUIncipienti,modelList.count > nextPath.row{
                    let itemModel = modelList[nextPath.row]
                    if isBlank(itemModel.PTUMesenchymatousi?.string){
                        return nextPath
                    }else{
                        return getNextIndex(indexPath: nextPath)
                    }
                    
                }
                
                
            }else{
                if let secitonNum = self.dataModel?.PTUCyprinidi?.count, indexPath.section < secitonNum-1{
                    return IndexPath(row: 0, section: indexPath.section+1)
                }
                
            }
            
        }
        
        return nil
    }
    
}
