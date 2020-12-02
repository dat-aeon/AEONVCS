//
//  newMemberShipTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 2/7/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

//protocol newMemberCardInfoCellDelegate {
//    func tappedOnAgreementNumber(currentIndex: Int)
//    func tappedOnQRcode(currentIndex: Int)
//}

class newMemberShipTableViewCell: UITableViewCell {

      var delegate : MemberCardInfoCellDelegate?
    
    @IBOutlet weak var qrCodeHeight: NSLayoutConstraint!
    @IBOutlet weak var labelQRTopConstraint: NSLayoutConstraint!
    var index : Int = 0
    
    @IBOutlet weak var qrViewAction: UIView!
    @IBOutlet weak var lblQRlabel: UILabel!
    @IBOutlet weak var lblContractId: UILabel!
    @IBOutlet weak var imgQrCode: UIImageView!
    @IBOutlet weak var lblLastReceiveDate: UILabel!
    @IBOutlet weak var imgCalender: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.qrViewAction.isUserInteractionEnabled = true
        self.lblContractId.isUserInteractionEnabled = true
        self.imgCalender.isUserInteractionEnabled = true
        self.imgQrCode.isUserInteractionEnabled = true
         self.lblContractId.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapContractId)))
        self.imgQrCode.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapQrCode)))
        
   self.imgCalender.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapContractId)))
         self.qrViewAction.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapContractId)))
    }
    @IBOutlet weak var lblLastReceiveDateLabel: UILabel!
    
    @objc func onTapQrCode() {
        print("Clicked")
        self.delegate?.alertQR()
    }
   @objc func onTapContractId() {
        print("Clicked")
    self.delegate?.tappedOnAgreementNumber(currentIndex: index)
    }
    
    
    func setData(data:AgreementInfo,index : Int){
        
        self.index = index
        
        let text = "\(data.agreementNo ?? "")"
        let textRange = NSRange(location: 0, length: (text.count))
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        self.lblContractId.attributedText = attributedText
            
        lblContractId.text = data.agreementNo
         self.lblLastReceiveDateLabel.text = "membership.lastReceiveday".localized
        
        if (data.lastPaymentDate != "") {
            lblLastReceiveDate.text = Utils.newchangeDMYDateformat(date: data.lastPaymentDate)
        }else{
            
            lblLastReceiveDate.text = "-"
            
        }
        
            
            if data.qrShow == 2 {
               
                let qrCode = Utils.init().generateQRCode(data:data.encodeStringForQr!)
                self.imgQrCode.image = qrCode
                qrCodeHeight.constant = 100
                imgQrCode.isHidden = false
                lblQRlabel.isHidden = false
                lblQRlabel.text = "QR Code :"
                
            } else {
               
                 imgQrCode.isHidden = true
                lblQRlabel.isHidden = true
                lblQRlabel.text = ""
                labelQRTopConstraint.constant = 0
                self.qrCodeHeight.constant = 0
                self.layoutIfNeeded()
            }
    
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
