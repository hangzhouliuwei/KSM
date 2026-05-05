//
//  XTVerifyContactVC.swift
//  XTApp
//

import ContactsUI
import UIKit

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
        XTLoanFlowCoordinator.shared.routeNext(code: str, productId: productId, orderId: orderId, loadingView: view, removeCurrentController: self)
    }
}