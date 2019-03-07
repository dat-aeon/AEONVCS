//
//  SecQuesVerifyBtnTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 2/18/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesVerifyBtnTableViewCell: UITableViewCell {

    @IBOutlet weak var btnVerifyConfirm: UIButton!
    var delegate:SecurityQuestionVerifyDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickVerifyConfirmBtn(_ sender: UIButton) {
        delegate?.onClickVerifyConfirmBtn(cell: self)
    }
}

protocol SecurityQuestionVerifyDelegate {
    func onClickVerifyConfirmBtn(cell:SecQuesVerifyBtnTableViewCell)
}
