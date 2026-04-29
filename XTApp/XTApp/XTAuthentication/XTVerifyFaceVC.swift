//
//  XTVerifyFaceVC.swift
//  XTApp
//

import AAILiveness
import AAILivenessSDK
import UIKit

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