//
//  MemberCardInfoTableViewCell.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MemberCardInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var ivBackgroundGif: UIImageView!
    @IBOutlet weak var ivQRCode: UIImageView!
    @IBOutlet weak var lblAgreementNo: UILabel!
    @IBOutlet weak var lblFinancialData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data:CustomerAgreementData){
        self.lblAgreementNo.text = data.agreementNo
        self.ivBackgroundGif.loadGif(asset: "background-gif")
        
        if data.qrShow == "2" {
           
            let qrData =  "www.aeon.com.mm \n \(data.agreementNo)"
            let qrCode = Utils.init().generateQRCode(data:qrData)
            self.ivQRCode.image = qrCode
            
        } else {
            self.ivQRCode.visiblity(gone: true)
        }
        self.lblFinancialData.text = "\(data.financialAmt) Ks \\ \t \(data.financialTerm) months"
        
    }
    
}
