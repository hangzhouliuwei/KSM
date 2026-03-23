//
//  LPAuthIdentityHeadView.swift
//  LPeso
//
//  Created by Kiven on 2024/11/12.
//

import UIKit
import Kingfisher

class LPAuthIdentityHeadView: UIView {
    
    var identityModel:LPIdentityPhotoModel?

    var photoImg:UIImage?
    var idType:String?
    var cardList:[LPIdentityCardModel]?
    var selectList:[LPAuthSelectModel]?
    
    var typeBlock:(_ types:String) -> Void = {_  in}
    var photoBlock:() -> Void = {}

    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: 300))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .clear
        
        addSubview(titleLab)
        addSubview(selectView)
        titleLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        selectView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(titleLab.snp.bottom).offset(2)
            make.height.equalTo(29)
        }
        
        //selectView
        let lineView = UIView.lineView(color: gray224)
        let imgArrow = UIImageView()
        imgArrow.imgName("au_cell_click")
        selectView.addSubview(lineView)
        selectView.addSubview(imgArrow)
        selectView.addSubview(idTxtFiled)
        idTxtFiled.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.right.equalTo(imgArrow.snp.left).offset(-16)
            make.bottom.equalTo(lineView.snp.top).offset(-4)
        }
        imgArrow.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(idTxtFiled)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        lineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(photoImgV)
        photoImgV.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(lineView.snp.bottom).offset(10)
            make.bottom.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 347, height: 196))
        }
    }
    
    lazy var titleLab:UILabel = {
        let titleLab = UILabel.new(text: "", textColor: black51, font: .font_PingFangSC_M(12))
        titleLab.setContentHuggingPriority(.required, for: .horizontal)
        titleLab.setContentCompressionResistancePriority(.required, for: .horizontal)
        let txt = "Select ID Type *"
        let attrStr = NSMutableAttributedString(string:txt, attributes:nil)
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.red, range:NSRange(location:txt.count-1, length:1))
        titleLab.attributedText = attrStr
        return titleLab
    }()
    
    lazy var selectView:UIView = {
        let selectView = UIView.empty()
        let tpas = UITapGestureRecognizer(target: self, action: #selector(selectClick))
        selectView.isUserInteractionEnabled = true
        selectView.addGestureRecognizer(tpas)
        return selectView
    }()
    
    lazy var idTxtFiled:UITextField = {
        let idTxtFiled = UITextField()
        idTxtFiled.placeholder = "Please Select"
        idTxtFiled.textColor = black51
        idTxtFiled.backgroundColor = .clear
        idTxtFiled.font = .font_PingFangSC_M(14)
        idTxtFiled.isEnabled = false
        return idTxtFiled
    }()
    
    lazy var photoImgV:UIImageView = {
        let photoImgV = UIImageView()
        photoImgV.imgName("au_takePhoto")
        let tpas = UITapGestureRecognizer(target: self, action: #selector(photoClick))
        photoImgV.isUserInteractionEnabled = true
        photoImgV.addGestureRecognizer(tpas)
        return photoImgV
    }()
    
    //MARK: reloadData
    @objc private func reloadDataWith(types:String){
        self.idType = types
        self.typeBlock(types)
        
        let titleStr = self.cardList?
            .first(where: { $0.PTUEroductioni?.string == types })?
            .PTUParajournalismi?.string
        self.idTxtFiled.text = titleStr
        
        let imgStr = self.cardList?
            .first(where: { $0.PTUEroductioni?.string == types })?
            .PTUMiloni
        self.photoImgV.setImage(urlString: imgStr,placeholder: "au_takePhoto")
        
    }
    
    //MARK: select Click
    @objc private func selectClick() {
        if self.photoImg == nil && isBlank(identityModel?.PTUThenarditei){
            guard let selectList = self.selectList else { return }
            Route.showAuthAlert(titleTxt: "Select ID Type", itemList: selectList , valueType: idType) { types in
                self.reloadDataWith(types: types)
            }
        }
        
    }
    
    //MARK: photo Click
    @objc private func photoClick(){
        if isBlank(self.idType){
            Route.toast("Please Select")
        }else{
            if self.photoImg == nil && isBlank(identityModel?.PTUThenarditei){
                photoBlock()
            }
        }
        
    }
    
    
    //MARK: configModel
    public func configModel(model:LPIdentityPhotoModel?){
        guard let model = model else { return }
        self.identityModel = model
        self.idType = model.PTUTickiei?.string
        if let list = model.PTUPosi{
            self.cardList = list
            var selects:[LPAuthSelectModel] = []
            for cardModel in list{
                if let names = cardModel.PTUParajournalismi?.string,let types = cardModel.PTUEroductioni{
                    selects.append(LPAuthSelectModel(name: names, type: types))
                    if let currentType = model.PTUTickiei?.string,currentType == types.string{
                        self.idTxtFiled.text = names
                    }
                }
            }
            self.selectList = selects
        }
        
        if let imgUrlString = model.PTUThenarditei,!isBlank(imgUrlString){
            photoImgV.setImage(urlString: imgUrlString)
        }else{
            selectClick()
        }
        
    }
    
    public func setPhotos(img:UIImage){
        self.photoImg = img
        photoImgV.image = img
    }
    
    
}
