//
//  newMemberShipTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 2/7/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class newMemberShipTableViewCell: UITableViewCell {

    @IBOutlet weak var lblQRlabel: UILabel!
    @IBOutlet weak var lblContractId: UILabel!
    @IBOutlet weak var imgQrCode: UIImageView!
    @IBOutlet weak var lblLastReceiveDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setData(data:AgreementInfo){
            
        lblContractId.text = data.agreementNo
        
        if (data.lastPaymentDate != nil) {
            lblLastReceiveDate.text = Utils.newchangeDMYDateformat(date: data.lastPaymentDate)
        }else{
            
            lblLastReceiveDate.text = "-"
            
        }
        
            
            if data.qrShow == 2 {
               
                let qrCode = Utils.init().generateQRCode(data:data.encodeStringForQr!)
                self.imgQrCode.image = qrCode
                
                imgQrCode.isHidden = false
                lblQRlabel.isHidden = false
                
            } else {
               
                 imgQrCode.isHidden = true
                lblQRlabel.isHidden = true
                
            }
    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
