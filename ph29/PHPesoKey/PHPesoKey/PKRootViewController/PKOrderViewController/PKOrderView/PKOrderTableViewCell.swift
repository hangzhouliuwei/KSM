//
//  PKOrderTableViewCell.swift
//  PHPesoKey
//
//  Created by Kiven on 2025/2/13.
//

import UIKit

class PKOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var pk_order_state: UILabel!
    @IBOutlet weak var pk_order_amountTitle: UILabel!
    @IBOutlet weak var pk_order_amount: UILabel!
    @IBOutlet weak var pk_order_name: UILabel!
    @IBOutlet weak var pk_order_Head: UIImageView!
    @IBOutlet weak var pk_order_refund: UIButton!
    var itmeModel = JSON()
    var orderTableViewCellClickBlock: PKStingBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pk_order_Head.layer.cornerRadius = 2
        self.pk_order_Head.clipsToBounds = true
        pk_order_state.layer.cornerRadius = 11
        pk_order_state.clipsToBounds = true
        pk_order_state.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configPKOrderTableViewCellModel(itmeModel:JSON){
        self.itmeModel = itmeModel
        self.pk_order_Head.kf.setImage(with: URL(string: itmeModel["BftJJVvRiotouslyYnnJhcv"].stringValue))
        self.pk_order_name.text = itmeModel["mycOUpLNitrobenzolXoIeLbP"].stringValue
        self.pk_order_amount.text = itmeModel["ghwDBdNBivouackedScFmaEN"].stringValue
        self.pk_order_amountTitle.text = pKCheckString(with: itmeModel["JQQsvzeScholziteBpuRMAx"].stringValue) ?  itmeModel["JQQsvzeScholziteBpuRMAx"].stringValue : "Loan amount"
        if pKCheckString(with: itmeModel["UXCceOrUltracytochemistryHszTZVa"].stringValue){
            self.pk_order_refund.setTitle(itmeModel["UXCceOrUltracytochemistryHszTZVa"].stringValue, for: .normal)
            self.pk_order_refund.backgroundColor = UIColor.init(hex:itmeModel["KRNSycGDiphenylGgHkZMP"].stringValue)
            self.pk_order_state.text = itmeModel["CEahhgfBituminiseABMmEIj"].stringValue
            self.pk_order_state.isHidden = false
            
        }else{
            self.pk_order_refund.setTitle(itmeModel["CEahhgfBituminiseABMmEIj"].stringValue, for: .normal)
            self.pk_order_refund.backgroundColor = .white
            //self.pk_order_state.text = itmeModel["CEahhgfBituminiseABMmEIj"].stringValue
            self.pk_order_state.isHidden = true
        }
    }
    
    
    @IBAction func pkOrderClick(_ sender: Any) {
        self.orderTableViewCellClickBlock?(self.itmeModel["rFIKgstDisreputeWLzkEKt"].stringValue)
        
    }
    
}

