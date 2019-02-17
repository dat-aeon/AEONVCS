//
//  MemberCardInfoTableViewCell.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MemberCardInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var ivQRCode: UIImageView!
    @IBOutlet weak var lblAgreementNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data:CustomerAgreementData){
        let qrData =  "www.aeon.com.mm \n \(data.agreementNo ?? "")"
        let qrCode = Utils.init().generateQRCode(data:qrData)
        self.ivQRCode.image = qrCode
        self.lblAgreementNo.text = data.agreementNo
    }
    
}
