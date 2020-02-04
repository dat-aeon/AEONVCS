//
//  SecQuesVerifyBtnTableViewCell.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 2/18/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesVerifyBtnTableViewCell: UITableViewCell {

    @IBOutlet weak var btnVerifyConfirm: UIButton!
    var delegate:SecurityQuestionVerifyDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onClickVerifyConfirmBtn(_ sender: UIButton) {
        delegate?.onClickVerifyConfirmBtn(cell: self)
    }
}

protocol SecurityQuestionVerifyDelegate {
    func onClickVerifyConfirmBtn(cell:SecQuesVerifyBtnTableViewCell)
}
