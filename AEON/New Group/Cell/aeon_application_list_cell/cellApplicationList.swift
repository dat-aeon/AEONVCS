//
//  cellApplicationList.swift
//  AEONVCS
//
//  Created by mac on 11/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

protocol cellApplicationListDelegate {
    func showPurchaseDetail(index: Int)
    func showAttachmentDetail(index: Int)
    func showCancelDialog(index: Int)
    func showApplicationDetail(index: Int)
}

class cellApplicationList: UITableViewCell {
    
    @IBOutlet weak var cellLblStatus: UILabel! {
        didSet {
            self.cellLblStatus.layer.cornerRadius = 5
            self.cellLblStatus.clipsToBounds = true
        }
    }
    @IBOutlet weak var cellAppNo: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var cellLblTitleDate: UILabel!
    @IBOutlet weak var cellLblTitleFinanceAmt: UILabel!
    @IBOutlet weak var cellLblFinanceTerms: UILabel!
    
    @IBOutlet weak var cellLblDate: UILabel!
    @IBOutlet weak var cellLblAmt: UILabel!
    @IBOutlet weak var cellLblTerms: UILabel!
    
    @IBOutlet weak var cellLblPurchaseDetail: UILabel!
    @IBOutlet weak var cellLblAttachmentEdit: UILabel!
    @IBOutlet weak var cellLblCancel: UILabel!
    
    
    @IBOutlet weak var viewCancel: UIView! {
        didSet {
            self.viewCancel.layer.cornerRadius = 5
            self.viewCancel.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var viewAttachmentEdit: UIView! {
        didSet {
            self.viewAttachmentEdit.layer.cornerRadius = 5
            self.viewAttachmentEdit.clipsToBounds = true
        }
    }
    @IBOutlet weak var viewPurchaseDetail: UIView! {
        didSet {
            self.viewPurchaseDetail.layer.cornerRadius = 5
            self.viewPurchaseDetail.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnPurchaseDetail: UIButton!
    @IBOutlet weak var btnAttachmentEdit: UIButton!
    
    var delegate: cellApplicationListDelegate?
    
    var formActualStatus = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(appForm: DAInquiryResponse) {
        
        self.cellLblTitleDate.text = "APPLICATIONLIST.APPLIED_DATE".localized
        self.cellLblTitleFinanceAmt.text = "APPLICATIONLIST.FINANCE_AMT".localized
        self.cellLblFinanceTerms.text = "APPLICATIONLIST.FINANCE_TERMS".localized
        
        self.cellAppNo.text = "\(appForm.applicationNo ?? "")"
         
        //self.cellLblDate.text = appForm.appliedDate?.strstr(needle: "T", beforeNeedle: true)
        self.cellLblDate.text = Utils.changeYMDDateformat(date: appForm.appliedDate!)
        self.cellLblAmt.text = "\(Int(Double(appForm.financeAmount ?? 0.0)).thousandsFormat) MMK"
        self.cellLblTerms.text = "\(appForm.financeTerm ?? 0) Months"
        let formStatus = appForm.status ?? 0
        
        var statusString = ""
        switch formStatus {
        case 1:
            statusString = "On Process"//"Draft"
            
        case 2:
            statusString = "On Process"//"Applied"
            
        case 3:
            statusString = "On Process"//"Index"
            
        case 4:
            statusString = "On Process"//"Upload Finish"
            
        case 5:
            statusString = "On Process"//"Attachment Edit Requested"
            
        case 6:
            statusString = "On Process"//"Attachment Edit Updated"
            
        case 7:
            statusString = "On Process"//"Attachment Edit Checked"
            
        case 8:
            statusString = "Canceled"
            
        case 9:
            statusString = "Unsuccessful"
            
        case 10:
            statusString = "Approve"
            
        case 11:
            statusString = "Approve"//"Purchase Canceled"
            
        case 12:
            statusString = "Approve"//"Purchase initial"
            
        case 13:
            statusString = "Approve"//"Purchase confirm waiting"
            
        case 14:
            statusString = "Purchase Confirmed"
            
        case 15:
            statusString = "Purchase completed"
            
        case 16:
            statusString = "Purchase completed"//"Settlement upload finish"
            
        case 17:
            statusString = "Purchase completed"//"Setttlement pending"
            
        default:
            statusString = ""
        }
        
        if formStatus == 5 {
//            self.btnAttachmentEdit.isUserInteractionEnabled = true
            self.viewAttachmentEdit.backgroundColor = UIColor(red: 183.0/255.0, green: 0/255.0, blue: 129.0/255.0, alpha: 1.0)
        } else {
//            self.btnAttachmentEdit.isUserInteractionEnabled = false
            self.viewAttachmentEdit.backgroundColor = .gray
        }
        
        if formStatus >= 14 {
//            self.btnPurchaseDetail.isUserInteractionEnabled = true
            self.viewPurchaseDetail.backgroundColor = UIColor(red: 183.0/255.0, green: 0/255.0, blue: 129.0/255.0, alpha: 1.0)
        } else {
//            self.btnPurchaseDetail.isUserInteractionEnabled = false
            self.viewPurchaseDetail.backgroundColor = .gray
        }
        
        if formStatus != 8 && formStatus < 15 {
            self.viewCancel.backgroundColor = UIColor(red: 183.0/255.0, green: 0/255.0, blue: 129.0/255.0, alpha: 1.0)
        } else {
            self.viewCancel.backgroundColor = .gray
        }
        
        self.cellLblStatus.text = statusString
        
    }
    
    
    @IBAction func tappedPurchasedetail(_ sender: Any) {
        if self.formActualStatus >= 14 {
            if let btn = sender as? UIButton {
                self.delegate?.showPurchaseDetail(index: btn.tag)
            }
        }
    }
    
    
    @IBAction func tappedAttachmentEdit(_ sender: Any) {
        
        if self.formActualStatus == 5 {
            if let btn = sender as? UIButton {
                self.delegate?.showAttachmentDetail(index: btn.tag)
            }
        }
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        if self.formActualStatus != 8 && self.formActualStatus < 15{
            if let btn = sender as? UIButton {
                self.delegate?.showCancelDialog(index: btn.tag)
            }
        }
    }
    
    @IBAction func onClickDetailBtn(_ sender: UIButton) {
        self.delegate?.showApplicationDetail(index: sender.tag)
    }
    
}
