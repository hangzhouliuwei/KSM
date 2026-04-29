//
//  XTVerifyControllers.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import AAILiveness
import AAILivenessSDK
import ContactsUI
import UIKit

func xtVerifyActivate(_ constraints: [NSLayoutConstraint]) {
    NSLayoutConstraint.activate(constraints)
}

func xtVerifyPoint(productId: String, startTime: String, type: String) -> [String: Any] {
    [
        "deamsixatoryNc": XT_Object_To_Stirng(startTime),
        "munisixumNc": XT_Object_To_Stirng(productId),
        "hyrasixrthrosisNc": type,
        "boomsixofoNc": XT_Object_To_Stirng(XTLocationManger.xt_share().xt_latitude),
        "unulsixyNc": XT_Object_To_Stirng(XTUtility.xt_share().xt_nowTimeStamp()),
        "cacosixtomyNc": XT_Object_To_Stirng(XTDevice.xt_share().xt_idfv),
        "unevsixoutNc": XT_Object_To_Stirng(XTLocationManger.xt_share().xt_longitude)
    ]
}

func xtVerifyEnsureLocation() {
    if NSString.xt_isEmpty(XTLocationManger.xt_share().xt_longitude) || NSString.xt_isEmpty(XTLocationManger.xt_share().xt_latitude) {
        XTLocationManger.xt_share().xt_startLocation()
    }
}

func xtVerifyShowOverlay(_ overlay: UIView, from view: UIView) {
    let host = XT_AppDelegate?.window ?? view
    overlay.frame = host.bounds
    host.addSubview(overlay)
}

extension XTBaseVC {
    func xtVerifySetupTable(_ tableView: UITableView, submitButton: UIButton, headerType: XT_VerifyType) {
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        xtVerifyActivate([
            submitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -XT_Bottom_Height - 20),
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: xt_navView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20)
        ])
        tableView.tableHeaderView = XTVerifyHeadView(frame: CGRect(x: 0, y: 0, width: view.width, height: 94), type: headerType)
    }

    func xtVerifyConfirmLeave() {
        view.endEditing(true)
        let alert = UIAlertController(title: nil, message: "Are you sure you want to\n leave?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }

    func xtVerifyRemoveSelf() {
        guard var controllers = navigationController?.viewControllers else { return }
        controllers.removeAll { $0 === self }
        navigationController?.viewControllers = controllers
    }
}

@objcMembers
@objc(XTVerifyContactVC)
class XTVerifyContactVC: XTBaseVC, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate {
    private let viewModel = XTVerifyViewModel()
    private var productId = ""
    private var orderId = ""
    private var startTime = ""
    private var indexBlock: XTDicBlock?
    private lazy var tableView = xtVerifyTable(style: .grouped)
    private lazy var submitBtn: UIButton = xtVerifySubmitButton(title: "Next", target: self, action: #selector(goSubmit))

    @objc(initWithProductId:orderId:)
    init(productId: String, orderId: String) {
        self.productId = productId
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xtVerifyEnsureLocation()
        startTime = XTUtility.xt_share().xt_nowTimeStamp()
        xt_title = "Contact"
        xt_title_color = .white
        view.backgroundColor = XT_RGB(0xF7F7F7, 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        xtVerifySetupTable(tableView, submitButton: submitBtn, headerType: XT_Verify_Contact)
        viewModel.xt_contact(productId, success: { [weak self] in
            self?.tableView.reloadData()
        }, failure: {
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.contactModel?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "XTVerifyContactCell") as? XTVerifyContactCell)
            ?? XTVerifyContactCell(style: .default, reuseIdentifier: "XTVerifyContactCell")
        guard let model = viewModel.contactModel?.items?[indexPath.row] else { return cell }
        cell.model = model
        cell.block = { [weak self, weak model] block in
            guard let self, let model else { return }
            self.selectRelation(model, block: block)
        }
        cell.contactBlock = { [weak self] block in
            self?.indexBlock = block
            self?.goContactVC()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        196
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView.xt_frame(CGRect(x: 0, y: 0, width: view.width, height: 20), color: view.backgroundColor)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.01
    }

    @objc(selectRelation:block:)
    func selectRelation(_ model: XTContactItemModel, block: XTDicBlock?) {
        let select = XTSelectView(tit: "Please Select", arr: model.relation ?? [])
        select.xt_value(model.threeValue)
        select.closeBlock = { [weak select] in select?.removeFromSuperview() }
        select.sureBlock = block
        xtVerifyShowOverlay(select, from: view)
    }

    @objc func goContactVC() {
        let vc = CNContactPickerViewController()
        vc.delegate = self
        xt_presentViewController(vc, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        var name = ""
        if !contact.familyName.isEmpty { name += contact.familyName }
        if !contact.givenName.isEmpty { name += contact.givenName }
        let phone = contact.phoneNumbers.first?.value.stringValue ?? ""
        let trimmed = (phone as NSString).xt_trimPhoneNumber()
        indexBlock?(["name": XT_Object_To_Stirng(name), "value": XT_Object_To_Stirng(trimmed), "mobile": XT_Object_To_Stirng(trimmed)])
    }

    override func xt_back() {
        xtVerifyConfirmLeave()
    }

    @objc func goSubmit() {
        var dic: [String: Any] = [:]
        for model in viewModel.contactModel?.items ?? [] {
            if (model.xt_field?.count ?? 0) == 3 {
                if NSString.xt_isEmpty(model.firstValue) || NSString.xt_isEmpty(model.secondValue) || NSString.xt_isEmpty(model.threeValue) {
                    XTUtility.xt_showTips("Please complete \(model.xt_title ?? "")", view: view)
                    return
                }
                let fields = model.xt_field as? [[AnyHashable: Any]] ?? []
                if fields.count >= 3 {
                    dic[XT_Object_To_Stirng(fields[0]["uporsixnNc"])] = XT_Object_To_Stirng(model.firstValue)
                    dic[XT_Object_To_Stirng(fields[1]["uporsixnNc"])] = XT_Object_To_Stirng(model.secondValue)
                    dic[XT_Object_To_Stirng(fields[2]["uporsixnNc"])] = XT_Object_To_Stirng(model.threeValue)
                }
            }
        }
        dic["lietsixusNc"] = XT_Object_To_Stirng(productId)
        dic["point"] = xtVerifyPoint(productId: productId, startTime: startTime, type: "23")
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_contact_next(NSDictionary(dictionary: dic), success: { [weak self] str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.goNext(str)
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    @objc(goNext:)
    func goNext(_ str: String?) {
        LoanFlowCoordinator.shared.routeNext(code: str, productId: productId, orderId: orderId, loadingView: view, removeCurrentController: self)
    }
}

@objcMembers
@objc(XTOCRVC)
class XTOCRVC: XTBaseVC, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let viewModel = XTVerifyViewModel()
    private var productId = ""
    private var orderId = ""
    private var startTime = ""
    private lazy var tableView = xtVerifyTable(style: .grouped)
    private lazy var submitBtn: UIButton = xtVerifySubmitButton(title: "Next", target: self, action: #selector(goSubmit))

    @objc(initWithProductId:orderId:)
    init(productId: String, orderId: String) {
        self.productId = productId
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xtVerifyEnsureLocation()
        startTime = XTUtility.xt_share().xt_nowTimeStamp()
        xt_title = "Identifcation"
        xt_title_color = .white
        view.backgroundColor = XT_RGB(0xF7F7F7, 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        xtVerifySetupTable(tableView, submitButton: submitBtn, headerType: XT_Verify_Identifcation)
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_photo(productId, success: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.tableView.reloadData()
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel.ocrModel?.model else { return 0 }
        if section == 0 { return 1 }
        if NSString.xt_isEmpty(model.xt_relation_id) { return 0 }
        return model.list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "XTPhotoCell") as? XTPhotoCell)
                ?? XTPhotoCell(style: .default, reuseIdentifier: "XTPhotoCell")
            cell.model = viewModel.ocrModel?.model
            cell.block = { [weak self] block in
                guard let self, let model = self.viewModel.ocrModel?.model else { return }
                self.selectRelation(model.note ?? [], tit: "Please Select", value: model.value, block: block)
            }
            cell.photoBlock = { [weak self] in self?.goPhoto() }
            return cell
        }
        guard let model = viewModel.ocrModel?.model?.list?[indexPath.row] else { return XTCell(style: .default, reuseIdentifier: nil) }
        if model.xt_cate == "AASIXTENBG" || model.xt_cate == "AASIXTENBL" {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "XTTextCell") as? XTTextCell)
                ?? XTTextCell(style: .default, reuseIdentifier: "XTTextCell")
            cell.model = model
            model.cell = cell
            return cell
        }
        let cell = (tableView.dequeueReusableCell(withIdentifier: "XTSelectCell") as? XTSelectCell)
            ?? XTSelectCell(style: .default, reuseIdentifier: "XTSelectCell")
        cell.model = model
        model.cell = cell
        cell.selectBlock = { [weak self, weak model] block in
            guard let self, let model else { return }
            if model.xt_code == "birthday" {
                self.xt_selectDay(model) { [weak self] dic in
                    block?(dic)
                    self?.xt_nextCell(model)
                }
            } else {
                self.selectRelation(model.noteList ?? [], tit: model.xt_title, value: model.value) { [weak self] dic in
                    block?(dic)
                    self?.xt_nextCell(model)
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 325 : 70
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView.xt_frame(CGRect(x: 0, y: 0, width: view.width, height: 20), color: view.backgroundColor)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.01
    }

    @objc(xt_nextCell:)
    func xt_nextCell(_ model: XTListModel) {
        guard let list = viewModel.ocrModel?.model?.list,
              let index = list.firstIndex(of: model),
              index + 1 < list.count,
              let nextCell = list[index + 1].cell else { return }
        if let select = nextCell as? XTSelectCell, select.model?.isHiddenCell == false, NSString.xt_isEmpty(select.model?.value) {
            select.becomeFirst()
        } else if let text = nextCell as? XTTextCell, text.model?.isHiddenCell == false, NSString.xt_isEmpty(text.model?.value) {
            text.becomeFirst()
        }
    }

    @objc(xt_selectDay:block:)
    func xt_selectDay(_ model: XTListModel, block: XTDicBlock?) {
        let select = XTSelectDayView(tit: model.xt_title ?? "")
        select.xt_value(model.value)
        select.closeBlock = { [weak select] in select?.removeFromSuperview() }
        select.sureBlock = block
        xtVerifyShowOverlay(select, from: view)
    }

    @objc(selectRelation:tit:value:block:)
    func selectRelation(_ arr: [XTNoteModel], tit: String?, value: String?, block: XTDicBlock?) {
        let select = XTSelectView(tit: tit ?? "", arr: arr)
        select.xt_value(value)
        select.closeBlock = { [weak select] in select?.removeFromSuperview() }
        select.sureBlock = block
        xtVerifyShowOverlay(select, from: view)
    }

    @objc func goPhoto() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.xt_checkAuthorization(.camera) { [weak self] in self?.goImagePickerVC(.camera) }
        })
        alert.addAction(UIAlertAction(title: "Photo album", style: .default) { [weak self] _ in
            self?.xt_checkAuthorization(.photoLibrary) { [weak self] in self?.goImagePickerVC(.photoLibrary) }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        xt_presentViewController(alert, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }

    @objc(xt_checkAuthorization:block:)
    func xt_checkAuthorization(_ sourceType: UIImagePickerController.SourceType, block: XTBlock?) {
        if sourceType == .camera {
            XTUtility.xt_checkAVCaptureAuthorization { granted in if granted { block?() } }
        } else {
            XTUtility.xt_checkPhotoAuthorization { granted in if granted { block?() } }
        }
    }

    @objc(goImagePickerVC:)
    func goImagePickerVC(_ type: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.delegate = self
        xt_presentViewController(picker, animated: true, completion: nil, modalPresentationStyle: .fullScreen)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        let data = image?.xt_compress(withLengthLimit: UInt(1.5 * 1024 * 1024))
        let path = XTUtility.xt_share().xt_saveImg(data, path: "")
        goUPLoad(path)
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    @objc(goUPLoad:)
    func goUPLoad(_ path: String) {
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_upload_ocr_image(path, typeId: viewModel.ocrModel?.model?.value ?? "", success: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.tableView.reloadData()
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    override func xt_back() {
        xtVerifyConfirmLeave()
    }

    @objc func goSubmit() {
        guard let photo = viewModel.ocrModel?.model else { return }
        var dic: [String: Any] = [:]
        for model in photo.list ?? [] {
            if !model.xt_optional && NSString.xt_isEmpty(model.value) {
                XTUtility.xt_showTips(model.xt_subtitle, view: view)
                return
            }
            if !NSString.xt_isEmpty(model.value) {
                dic[XT_Object_To_Stirng(model.xt_code)] = XT_Object_To_Stirng(model.value)
            }
        }
        XTRequestCenter.xt_share().xt_device()
        dic["lietsixusNc"] = XT_Object_To_Stirng(productId)
        dic["seiasixbstractNc"] = XT_Object_To_Stirng(photo.xt_relation_id)
        dic["point"] = xtVerifyPoint(productId: productId, startTime: startTime, type: "24")
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_photo_next(NSDictionary(dictionary: dic), success: { [weak self] str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.goNext(str)
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    @objc(goNext:)
    func goNext(_ str: String?) {
        LoanFlowCoordinator.shared.routeNext(code: str, productId: productId, orderId: orderId, loadingView: view, removeCurrentController: self)
    }
}

@objcMembers
@objc(XTVerifyFaceVC)
class XTVerifyFaceVC: XTBaseVC {
    private let viewModel = XTVerifyViewModel()
    private var productId = ""
    private var orderId = ""
    private var startTime = ""
    private let alertLab = UILabel()
    private lazy var submitBtn: UIButton = xtVerifySubmitButton(title: "Start", target: self, action: #selector(startTap))
    private lazy var againBtn: UIButton = {
        let button = UIButton.xt_btn("Try Again", font: XT_Font_B(20), textColor: XT_RGB(0x02CC56, 1.0), cornerRadius: 24, borderColor: XT_RGB(0x02CC56, 1.0), borderWidth: 1, backgroundColor: .clear, tag: 0)
        button.isHidden = true
        button.addTarget(self, action: #selector(againTap), for: .touchUpInside)
        return button
    }()

    @objc(initWithProductId:orderId:)
    init(productId: String, orderId: String) {
        self.productId = productId
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xtVerifyEnsureLocation()
        startTime = XTUtility.xt_share().xt_nowTimeStamp()
        xt_title = "Facial Recognition"
        xt_title_color = .white
        view.backgroundColor = XT_RGB(0xF2F5FA, 1.0)
        AAILivenessSDK.initWith(.philippines)
        viewModel.xt_auth(productId, success: { [weak self] in
            self?.xt_UI()
        }, failure: {
        })
    }

    @objc func xt_UI() {
        let top = UIView(frame: CGRect(x: 0, y: xt_navView.frame.maxY, width: view.width, height: 17))
        top.backgroundColor = XT_RGB(0x0BB559, 1.0)
        view.addSubview(top)
        let topBg = UIImageView(image: XT_Img("xt_verify_face_top_bg"))
        topBg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBg)
        alertLab.text = "To ensure it is operated by yourself, we\nneeds to verify your identity."
        alertLab.font = XT_Font_M(15)
        alertLab.textColor = XT_RGB(0x02CC56, 1.0)
        alertLab.textAlignment = .center
        alertLab.numberOfLines = 2
        alertLab.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertLab)
        let icon = UIImageView(image: XT_Img("xt_verify_face_icon"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(icon)
        [submitBtn, againBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        let error0 = UIImageView(image: XT_Img("xt_verify_face_error_0"))
        let error1 = UIImageView(image: XT_Img("xt_verify_face_error_1"))
        let error2 = UIImageView(image: XT_Img("xt_verify_face_error_2"))
        [error0, error1, error2].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        xtVerifyActivate([
            topBg.leftAnchor.constraint(equalTo: view.leftAnchor),
            topBg.rightAnchor.constraint(equalTo: view.rightAnchor),
            topBg.topAnchor.constraint(equalTo: top.bottomAnchor),
            alertLab.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            alertLab.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            alertLab.topAnchor.constraint(equalTo: topBg.bottomAnchor, constant: 9),
            alertLab.heightAnchor.constraint(equalToConstant: 42),
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.topAnchor.constraint(equalTo: alertLab.bottomAnchor, constant: 16),
            submitBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            submitBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            submitBtn.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 28),
            submitBtn.heightAnchor.constraint(equalToConstant: 48),
            againBtn.leftAnchor.constraint(equalTo: submitBtn.leftAnchor),
            againBtn.rightAnchor.constraint(equalTo: submitBtn.rightAnchor),
            againBtn.topAnchor.constraint(equalTo: submitBtn.topAnchor),
            againBtn.heightAnchor.constraint(equalTo: submitBtn.heightAnchor),
            error0.leftAnchor.constraint(equalTo: submitBtn.leftAnchor, constant: 11),
            error0.topAnchor.constraint(equalTo: submitBtn.bottomAnchor, constant: 47),
            error1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            error1.topAnchor.constraint(equalTo: submitBtn.bottomAnchor, constant: 47),
            error2.rightAnchor.constraint(equalTo: submitBtn.rightAnchor, constant: -11),
            error2.topAnchor.constraint(equalTo: submitBtn.bottomAnchor, constant: 47)
        ])
    }

    @objc private func startTap() { goCheck(false) }
    @objc private func againTap() { goCheck(true) }

    @objc(goCheck:)
    func goCheck(_ isAgain: Bool) {
        if !NSString.xt_isEmpty(viewModel.faceModel?.xt_relation_id) {
            goSubmit(viewModel.faceModel?.xt_relation_id)
            return
        }
        AAILivenessSDK.initWith(.philippines)
        AAILivenessSDK.configResultPictureSize(800)
        AAILivenessSDK.additionalConfig().detectionLevel = .easy
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_limit(productId, success: { [weak self] in
            guard let self else { return }
            self.viewModel.xt_licenseSuccess({ [weak self] license in
                guard let self else { return }
                XTUtility.xt_atHideProgress(self.view)
                self.goFaceUI(license ?? "", again: isAgain)
            }, failure: { [weak self] in
                guard let self else { return }
                XTUtility.xt_atHideProgress(self.view)
            })
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    @objc(goFaceUI:again:)
    func goFaceUI(_ license: String, again: Bool) {
        AAILivenessSDK.additionalConfig().detectionLevel = .easy
        let status = AAILivenessSDK.configLicenseAndCheck(license)
        if status == "SUCCESS" {
            let vc = AAILivenessViewController()
            vc.prepareTimeoutInterval = 100
            navigationController?.pushViewController(vc, animated: true)
            vc.detectionSuccessBlk = { [weak self] _, result in
                guard let self else { return }
                let livenessId = result.livenessId
                if !NSString.xt_isEmpty(livenessId) {
                    self.xt_detection(livenessId ?? "")
                } else {
                    self.errorBtn()
                }
                self.navigationController?.popViewController(animated: true)
            }
            vc.detectionFailedBlk = { [weak self] _, _ in
                self?.errorBtn()
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            errorBtn()
            viewModel.xt_auth_err(status ?? "")
        }
    }

    @objc func errorBtn() {
        submitBtn.isHidden = true
        againBtn.isHidden = false
        alertLab.text = "Authentication failed, please try again!"
        alertLab.textColor = XT_RGB(0xCC0202, 1.0)
    }

    @objc(xt_detection:)
    func xt_detection(_ livenessId: String) {
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_detectionProductId(productId, livenessId: livenessId, success: { [weak self] str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.goSubmit(str)
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    @objc(goSubmit:)
    func goSubmit(_ relationId: String?) {
        var dic: [String: Any] = [:]
        dic["lietsixusNc"] = XT_Object_To_Stirng(productId)
        dic["alumsixinNc"] = XT_Object_To_Stirng(relationId)
        dic["point"] = xtVerifyPoint(productId: productId, startTime: startTime, type: "25")
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_save_auth(NSDictionary(dictionary: dic), success: { [weak self] str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.goNext(str)
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    @objc(goNext:)
    func goNext(_ str: String?) {
        LoanFlowCoordinator.shared.routeNext(code: str, productId: productId, orderId: orderId, loadingView: view, removeCurrentController: self)
    }
}

@objcMembers
@objc(XTVerifyBankVC)
class XTVerifyBankVC: XTBaseVC {
    private let viewModel = XTVerifyViewModel()
    private var productId = ""
    private var orderId = ""
    private var startTime = ""
    private lazy var submitBtn: UIButton = xtVerifySubmitButton(title: "Next", target: self, action: #selector(goCheck))
    private let segList: [NSDictionary] = [
        ["value": "2", "name": "E-Wallet"] as NSDictionary,
        ["value": "1", "name": "Bank"] as NSDictionary
    ]
    private var walletView = XTWalletView()
    private var bankView = XTBankView()

    @objc(initWithProductId:orderId:)
    init(productId: String, orderId: String) {
        self.productId = productId
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xtVerifyEnsureLocation()
        startTime = XTUtility.xt_share().xt_nowTimeStamp()
        xt_title = "Withdrawal account"
        xt_title_color = .white
        view.backgroundColor = XT_RGB(0xF2F5FA, 1.0)
        viewModel.xt_card(productId, success: { [weak self] in
            self?.xt_UI()
        }, failure: {
        })
    }

    @objc func xt_UI() {
        let topView = UIView(frame: CGRect(x: 0, y: xt_navView.frame.maxY, width: view.width, height: 2))
        topView.backgroundColor = XT_RGB(0x0BB559, 1.0)
        view.addSubview(topView)
        let topBG = UIImageView(image: XT_Img("xt_verify_bank_top_bg"))
        topBG.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBG)
        let title = UILabel()
        title.text = "You can use E-wallet / bank account / over the counter to repay the bills."
        title.font = XT_Font(14)
        title.textColor = XT_RGB(0x333333, 1.0)
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)

        var index = 0
        if !NSString.xt_isEmpty(viewModel.bankModel?.bankModel?.xt_channel) {
            index = 1
        }
        let seg = XTSegView(arr: segList, font: XT_Font_SD(15), selectFont: XT_Font_SD(15), color: XT_RGB(0x01A652, 1.0), selectColor: .white, bgColor: .white, selectBgColor: XT_RGB(0x0BB559, 1.0), select: index)
        seg.layer.borderColor = XT_RGB(0x0BB559, 1.0).cgColor
        seg.layer.borderWidth = 1
        seg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seg)
        walletView = XTWalletView()
        walletView.model = viewModel.bankModel?.walletModel
        bankView = XTBankView()
        bankView.model = viewModel.bankModel?.bankModel
        walletView.isHidden = index == 1
        bankView.isHidden = index == 0
        bankView.block = { [weak self] block in
            guard let self else { return }
            self.select(self.viewModel.bankModel?.bankModel?.note ?? [], tit: "Select Bank", value: self.bankView.value, block: block)
        }
        [submitBtn, walletView, bankView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        seg.block = { [weak self] (_: Int) in
            guard let self else { return }
            self.walletView.isHidden.toggle()
            self.bankView.isHidden.toggle()
        }
        xtVerifyActivate([
            topBG.leftAnchor.constraint(equalTo: view.leftAnchor),
            topBG.rightAnchor.constraint(equalTo: view.rightAnchor),
            topBG.topAnchor.constraint(equalTo: topView.bottomAnchor),
            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            title.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14),
            title.topAnchor.constraint(equalTo: topBG.bottomAnchor, constant: 20),
            seg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            seg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14),
            seg.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            seg.heightAnchor.constraint(equalToConstant: 42),
            submitBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            submitBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            submitBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -XT_Bottom_Height - 20),
            submitBtn.heightAnchor.constraint(equalToConstant: 48),
            walletView.leftAnchor.constraint(equalTo: view.leftAnchor),
            walletView.rightAnchor.constraint(equalTo: view.rightAnchor),
            walletView.topAnchor.constraint(equalTo: seg.bottomAnchor, constant: 20),
            walletView.bottomAnchor.constraint(equalTo: submitBtn.topAnchor, constant: -20),
            bankView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bankView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bankView.topAnchor.constraint(equalTo: seg.bottomAnchor, constant: 20),
            bankView.bottomAnchor.constraint(equalTo: submitBtn.topAnchor, constant: -20)
        ])
    }

    override func xt_back() {
        xtVerifyConfirmLeave()
    }

    @objc(select:tit:value:block:)
    func select(_ arr: [XTNoteModel], tit: String?, value: String?, block: XTDicBlock?) {
        let select = XTSelectView(tit: tit ?? "", arr: arr)
        select.xt_value(value)
        select.closeBlock = { [weak select] in select?.removeFromSuperview() }
        select.sureBlock = block
        xtVerifyShowOverlay(select, from: view)
    }

    @objc func goCheck() {
        let type: Int
        let title: String
        let name: String?
        let value: String?
        let account: String?
        if !walletView.isHidden {
            guard let indexModel = walletView.indexModel else {
                XTUtility.xt_showTips("Please Select E-Wallet", view: view)
                return
            }
            guard !NSString.xt_isEmpty(walletView.textField?.text) else {
                XTUtility.xt_showTips("Please Enter E-wallet Account", view: view)
                return
            }
            type = 2
            title = "Channel"
            name = indexModel.xt_name
            value = indexModel.xt_type
            account = walletView.textField?.text
        } else {
            guard !NSString.xt_isEmpty(bankView.value) else {
                XTUtility.xt_showTips("Please Select Bank", view: view)
                return
            }
            guard !NSString.xt_isEmpty(bankView.accountTextField.text) else {
                XTUtility.xt_showTips("Please Enter Bank Account", view: view)
                return
            }
            type = 1
            title = "Bank"
            name = bankView.name
            value = bankView.value
            account = bankView.accountTextField.text
        }

        let alert = XTBankAltView(tit: title, name: name ?? "", account: account ?? "")
        alert.center = view.center
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        overlay.addSubview(alert)
        view.addSubview(overlay)
        alert.cancelBlock = { [weak overlay] in overlay?.removeFromSuperview() }
        alert.submitBlock = { [weak self] in
            self?.goSubmit([
                "ceNcsix": "\(type)",
                "blthsixelyNc": XT_Object_To_Stirng(value),
                "ovrcsixutNc": XT_Object_To_Stirng(account)
            ])
        }
    }

    @objc(goSubmit:)
    func goSubmit(_ parameter: [AnyHashable: Any]) {
        var dic = parameter
        dic["lietsixusNc"] = XT_Object_To_Stirng(productId)
        dic["point"] = xtVerifyPoint(productId: productId, startTime: startTime, type: "26")
        XTUtility.xt_showProgress(view, message: "loading...")
        viewModel.xt_card_next(NSDictionary(dictionary: dic), success: { [weak self] str in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
            self.goNext(str)
        }, failure: { [weak self] in
            guard let self else { return }
            XTUtility.xt_atHideProgress(self.view)
        })
    }

    @objc(goNext:)
    func goNext(_ str: String?) {
        LoanFlowCoordinator.shared.routeNext(code: str, productId: productId, orderId: orderId, loadingView: view, removeCurrentController: self)
    }
}

func xtVerifyTable(style: UITableView.Style) -> UITableView {
    let tableView = UITableView(frame: .zero, style: style)
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.estimatedRowHeight = 50
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.tableFooterView = UIView(frame: .zero)
    tableView.showsHorizontalScrollIndicator = false
    tableView.showsVerticalScrollIndicator = false
    return tableView
}

func xtVerifySubmitButton(title: String, target: Any, action: Selector) -> UIButton {
    let button = UIButton.xt_btn(title, font: XT_Font_B(title == "Start" ? 20 : 24), textColor: .white, cornerRadius: 24, tag: 0)
    button.backgroundColor = XT_RGB(0x02CC56, 1.0)
    button.addTarget(target, action: action, for: .touchUpInside)
    return button
}
