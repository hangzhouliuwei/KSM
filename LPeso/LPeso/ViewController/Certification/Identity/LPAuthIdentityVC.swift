//
//  LPAuthIdentityVC.swift
//  LPeso
//
//  Created by Kiven on 2024/11/7.
//

import UIKit
import Photos
import AVFoundation

class LPAuthIdentityVC: LPAuthBaseVC{
    
    var dataModel:LPIdentityPhotoModel?
    
    var headView = LPAuthIdentityHeadView()
    
    var uploadImg:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextView.isHidden = true
        headView.photoBlock = {
            Route.showPhotoAlertView { tags in
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    getPhoto(WithType: tags)
                }
            }
        }
        headView.typeBlock = { types in
            self.dataModel?.PTUTickiei?.string = types
        }
        tableV.tableHeaderView = headView
        contentV.addSubview(tableV)
        tableV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        getData()
    }
    
    func getData(){
        Request.send(api: .photoGet(proID: self.proID)) { (result:LPAuthIdentityModel?) in
            if let result = result{
                self.refreshUI(model: result)
            }
        } failure: { error in
            
        }
        
    }
    
    func refreshUI(model:LPAuthIdentityModel){
        self.dataModel = model.PTUShifti
        if let countdown = model.PTUKickouti?.string{
            setCountDown(lastTime: countdown)
        }
        if let list = self.dataModel?.PTUIncipienti,list.count>0{
            self.nextView.isHidden = false
        }
        headView.configModel(model: self.dataModel)
        tableV.reloadData()
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
        return tableV
    }()
    
    lazy var camearPicker:UIImagePickerController = {
        let camearPicker = UIImagePickerController.init()
        camearPicker.delegate = self
        camearPicker.sourceType = .camera
        return camearPicker
    }()
    
    func getPhoto(WithType type:Int){
        if type == 0 {
            openAlbum()
        }else if type == 1 {
            openCamera()
        }
    }

    lazy var picker:UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()

    func openCamera(){
        picker.sourceType = .camera
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    self.openCamera()
                }
            })
        case .authorized:
            DispatchQueue.main.async {
                self.navigationController?.present(self.picker, animated: true)
            }
        default:
            Route.toast("No permission to open the camera, please open it in the settings")
        }
    }

    func openAlbum(){
        picker.sourceType = .photoLibrary
        Route.preVC(vc: picker)
    }
    
    
    //MARK: nextClick
    override func nextClick() {
        guard  let id = self.dataModel?.PTUMesenchymatousi else { return }
        if isBlank(id){
            Route.toast("Please select")
            return
        }
        guard let modelList = self.dataModel?.PTUIncipienti else { return }
        
        var dic: [String: Any] = ["PTUDerangementi":id]
        for itemModel in modelList{
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
        
        LPApplyManager.shared.saveParams(vc: self, params: dic)
    }

}

extension LPAuthIdentityVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel?.PTUIncipienti?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35+48
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let modelList = self.dataModel?.PTUIncipienti,modelList.count > indexPath.row  else {
            return UITableViewCell()
        }
        let itemModel = modelList[indexPath.row]
        
        let cell = LPAuthGroupCell(style: .default, reuseIdentifier: "LPAuthGroupCell\(indexPath.section)_\(indexPath.row)")
        cell.configModel(itemModel: itemModel)
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
        cell.optionBlock = { tags in
            if let types = itemModel.PTUPosi?[tags].type?.string{
                var model = itemModel
                model.PTUMesenchymatousi?.string = types
                self.resetModel(model: model, indexPath: indexPath)
            }
            
        }
        return cell
    }
    
    func showSelectAlert(itemModel:LPAuthItemModel,indexPath:IndexPath){
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
        self.dataModel?.PTUIncipienti?[indexPath.row] = model
        self.tableV.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

extension LPAuthIdentityVC:UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage,let imageData = LPTools.compressImage(orangeImg: image) {
            self.updatePhoto(img: UIImage(data: imageData)!)
            return
        }
        
        guard let phAsset = info[.phAsset] as? PHAsset else {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,let imageData = LPTools.compressImage(orangeImg: image) {
                DispatchQueue.main.async {
                    self.updatePhoto(img: UIImage(data: imageData)!)
                }
                
            }
            return
        }
        
        Route.loading()
        let options = PHImageRequestOptions()
        options.version = .original
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .none
        options.isNetworkAccessAllowed = true
        options.isSynchronous = true
        PHImageManager.default().requestImage(for: phAsset, targetSize: CGSize(width: phAsset.pixelWidth, height: phAsset.pixelHeight), contentMode: .aspectFit, options: options) { (image, info) in
            Route.hideLoading()
            if let image = image,let imageData = LPTools.compressImage(orangeImg: image) {
                self.updatePhoto(img: UIImage(data: imageData)!)
            }
        }
        
    }
    
    func updatePhoto(img:UIImage) {
        guard let id_type = self.dataModel?.PTUTickiei?.string else { return }
        if let _ = self.uploadImg { return }
        self.uploadImg = img
        Request.send(api: .photoUpdate(img: img, type: id_type),showLoading: true,showResult: true) { (result:LPIdentityUploadModel?) in
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.uploadImg = nil
                self.dataModel?.PTUMesenchymatousi = result?.PTUStaggeryi
                self.dataModel?.PTUIncipienti = result?.PTUIncipienti
                self.headView.setPhotos(img: img)
                self.nextView.isHidden = false
                self.tableV.reloadData()
            }
            
        } failure: { error in
            self.uploadImg = nil
        }

        
    }
    
}
