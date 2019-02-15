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
    @IBOutlet weak var lblAggrementNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let data =  "www.aeon.com.mm \n \(lblAggrementNo.text ?? "")"
        let qrCode = Utils.init().generateQRCode(data:data)
        ivQRCode.image = qrCode
    }
    
}
