//
//  XTOCRVC.swift
//  XTApp
//

import UIKit

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