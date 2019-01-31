//
//  SecQuesConfirmTableViewCell.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesConfirmTableViewCell: UITableViewCell {

    @IBOutlet weak var tfPhoneNo: UITextField!
    @IBOutlet weak var tfNrcDiv: UITextField!
    @IBOutlet weak var tfNrcTownship: UITextField!
    @IBOutlet weak var tfNrcType: UITextField!
    @IBOutlet weak var tfNrcNo: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var delegate :SecQuesConfirmDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:SecurityQuestionConfirm) {
        self.tfPhoneNo.text = data.phoneNo
        self.tfNrcNo.text = data.nrcNumber
        self.tfNrcDiv.text = data.nrcDivision
        self.tfNrcType.text = data.nrcType
        
    }
    @IBAction func onClickConfirmBtn(_ sender: Any) {
        delegate?.onClickConfirm(phoneNo: self.tfPhoneNo.text ?? "09", nrcDiv: self.tfNrcDiv.text ?? "09", nrcTownship: self.tfNrcTownship.text ?? "09", nrcType: self.tfNrcType.text ?? "09", nrcNo: self.tfNrcNo.text ?? "09")
    }
}

protocol SecQuesConfirmDelegate {
    func onClickConfirm(phoneNo :String, nrcDiv :String, nrcTownship :String, nrcType :String, nrcNo :String)
}
