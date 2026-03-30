//
//  PKCertificationViewController.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/10.
//

import UIKit

class PKCertificationViewController: UIViewController, UIGestureRecognizerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var pkCertificationTitleLab: UILabel!
    
    @IBOutlet weak var pkCertificationStepImg: UIImageView!
    @IBOutlet weak var stepimgH: NSLayoutConstraint!
    
    @IBOutlet weak var pkCertificationTimeView: UIView!
    @IBOutlet weak var timeViewH: NSLayoutConstraint!
    
    @IBOutlet weak var pkCertificationNextBut: UIButton!
    
    @IBOutlet weak var pkCertificationContentView: UIView! //ContentView
    
    @IBOutlet weak var pkTimeLabel: UILabel! // 01 : 00 : 00
    
    var cerIdForLending = ""
    var timeIntValue = 0
    var countTimer: Timer?
    var sortIndex = 0
    var timeViewDidLoad = ""
    var timeWillUpload = ""
    var toDeletePkPageWhenDismiss = false
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PKCertificationViewController", bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        fatalError("nib init error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeViewDidLoad = PKUserManager.pkGetNowTime()
        pkCertificationNextBut.cornerRadius = pkCertificationNextBut.height/2
        pkCertificationTitleLab.text = ["Basic", "Contact", "Identification", "Facial " + "Recognition", "Withdrawal" + " account"][sortIndex]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.isNavigationBarHidden = true
        navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.delegate = nil
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        pkCertificationBackClick(UIButton())
        return false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if toDeletePkPageWhenDismiss {
            if let navigationController = self.navigationController,
               !navigationController.viewControllers.contains(self) {
                return
            }
            if let navigationController = self.navigationController {
                navigationController.viewControllers.removeAll { $0 === self }
            }
        }
    }
    
    func showStepImage(){
        stepimgH.constant = width_PK_bounds/371*108
        pkCertificationStepImg.isHidden = false
    }

    func hideStepImage(){
        stepimgH.constant = 0
        pkCertificationStepImg.isHidden = true
    }
    
    func showCountTimeView(){
        timeViewH.constant = 80
        pkCertificationTimeView.isHidden = false
        countTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        RunLoop.current.add(countTimer!, forMode: .common)
    }
    
    @objc private func timerUpdate() {

        pkTimeLabel.text = String(format: "%02d", timeIntValue / 3600) + " : " + String(format: "%02d", (timeIntValue / 60) % 60) + " : " + String(format: "%02d", timeIntValue % 60)
        pkTimeLabel.sizeToFit()
        if timeIntValue <= 0 {
            cancelTimer()
            hideCountTimeView()
        }
        timeIntValue -= 1
    }
    
    private func cancelTimer() {
        countTimer?.invalidate()
        countTimer = nil
    }
    
    func hideCountTimeView(){
        timeViewH.constant = 0
        pkCertificationTimeView.isHidden = true
    }

    @IBAction func pkCertificationBackClick(_ sender: Any) {
        view.endEditing(true)
        let iconArr = ["pk_auth_leave1", "pk_auth_leave2", "pk_auth_leave3", "pk_auth_leave4", "pk_auth_leave5"]
            
        let contentArr = ["Complete the " + "form to apply for a" + " loan, and we'll " + "tailor a loan amount" + " just for you.", "Enhance " + "your loan approval chances " + "by providing your " + "emergency contact information " + "now.", "Complete your identification" + " now for a chance to increase" + " your loan limit.", "Boost" + " your credit score by " + "completing facial recognition now.", "Take" + " the final step to apply for your " + "loan—submitting now will enhance" + " your approval rate."]
        
        let centerImage = UIImageView(frame: CGRect(x:35.w, y: 0, width: 305.w, height: 320.w))
        centerImage.image = UIImage(named: iconArr[sortIndex])
        centerImage.isUserInteractionEnabled = true
        centerImage.centerY = height_PK_bounds/2
        
        let title = UILabel(frame: CGRect(x: 0, y: 135.w, width: centerImage.width, height: 20))
        title.textColor = vrgba(40, 40, 40, 1)
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textAlignment = .center
        title.text = "Are " + "you sure you " + "want to " + "leave?"
        centerImage.addSubview(title)
        
        let middleText = UILabel(frame: CGRect(x: 35, y: 172.w, width: centerImage.width - 70, height: 20))
        middleText.textColor = vrgba(40, 40, 40, 1)
        middleText.font = UIFont.systemFont(ofSize: 12)
        middleText.textAlignment = .center
        middleText.text = contentArr[sortIndex]
        middleText.numberOfLines = 0
        middleText.sizeToFit()
        centerImage.addSubview(middleText)
        
        let leftBorderLabel = UILabel()
        leftBorderLabel.font = .systemFont(ofSize: 14)
        leftBorderLabel.textAlignment = .center
        leftBorderLabel.backgroundColor = .white
        leftBorderLabel.frame = CGRect(x: 35.w, y: 320.w - 62.w, width: 112.w, height: 40)
        leftBorderLabel.text = "Cancel"
        leftBorderLabel.cornerRadius = 20
        leftBorderLabel.layer.borderColor = vrgba(222, 222, 222, 1).cgColor
        leftBorderLabel.layer.borderWidth = 1
        leftBorderLabel.touch {
            PKBottomFlatView.dismissed()
        }
        centerImage.addSubview(leftBorderLabel)
        
        let rightNormalLabel = UILabel()
        rightNormalLabel.font = .systemFont(ofSize: 14)
        rightNormalLabel.textAlignment = .center
        rightNormalLabel.backgroundColor = vrgba(191, 253, 64, 1)
        rightNormalLabel.frame = CGRect(x: 158.w, y: 320.w - 62.w, width: 112.w, height: 40)
        rightNormalLabel.text = "Confirm"
        rightNormalLabel.cornerRadius = 20
        rightNormalLabel.touch {
            PKBottomFlatView.dismissed()
            self.navigationController?.popViewController(animated: true)
        }
        centerImage.addSubview(rightNormalLabel)
        
        PKBottomFlatView.addToFlat(infoVie: centerImage)
    }
    
    @IBAction func pkCertificationNextClick(_ sender: Any) {
        
    }
    
    static func judgeCerPageStepWithInfo(cerId:String, cerType:String) {
        let navigationController = UIApplication.shared.windows.first?.rootViewController as! UINavigationController
        if cerType.contains("http") {
            if pKCheckString(with: cerType){
                let webVC = PKWebkitViewController()
                webVC.pkWebUrlStr = cerType
                navigationController.pushViewController(webVC, animated: true)
            }
        }else if cerType == "QFZAGXBCOKVXTOL" {
            let sortPage = PKCertificationBasicItemViewController()
            sortPage.sortIndex = 0
            sortPage.cerIdForLending = cerId
            navigationController.pushViewController(sortPage, animated: true)
        }else if cerType == "LXIGZQVVXYSBKHF"{
            let sortPage = PKCertificationContactItemViewController()
            sortPage.sortIndex = 1
            sortPage.cerIdForLending = cerId
            navigationController.pushViewController(sortPage, animated: true)
        }else if cerType == "WGVGQLMTLXHDNEE"{
            let sortPage = PKCertificationPhotoItemViewController()
            sortPage.sortIndex = 2
            sortPage.cerIdForLending = cerId
            navigationController.pushViewController(sortPage, animated: true)
        }else if cerType == "UUCTWKMMYKRSAKU"{
            let sortPage = PKCertificationRecognitionFile()
            sortPage.sortIndex = 3
            sortPage.cerIdForLending = cerId
            navigationController.pushViewController(sortPage, animated: true)
        }else if cerType == "HYASNKBRLBMSLEW"{
            let sortPage = PKCertificationBankItemViewController()
            sortPage.sortIndex = 4
            sortPage.cerIdForLending = cerId
            navigationController.pushViewController(sortPage, animated: true)
        }
    }
    
    
}

func vrgba(_ red:Double, _ green:Double, _ blue:Double, _ alpha:Double) -> UIColor {
    let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    return color
}


extension Int {
    var w:Double {
        return Double(self)*(width_PK_bounds/375.0)
    }
}

extension Double {
    var w:Double {
        return Double(self)*(width_PK_bounds/375.0)
    }
}

let pkeum = "ZABWGXVBIKHCDFK"
let pkopt = "EASQEMHJURNYACT"
let pktx = "GWOVTQQLXTHIANW"
let pkdy = "CKWIDYKPBHWNEPH"

extension UIView {
    func touch(method: @escaping () -> Void) {
        self.addGestureRecognizer(ToClick(action: method))
        self.isUserInteractionEnabled = true
    }
}
class ToClick: UITapGestureRecognizer {
    private var action: (() -> Void)?

    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(handleTap))
    }

    @objc private func handleTap() {
        action?()
    }
}
