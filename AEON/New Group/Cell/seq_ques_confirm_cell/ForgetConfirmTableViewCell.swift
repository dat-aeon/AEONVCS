//
//  ForgetConfirmTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 5/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ForgetConfirmTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCallNow: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var delegate :ForgetConfirmDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickCallNow(_ sender: UIButton) {
        delegate?.onClickCallNow()
    }
    @IBAction func onClickConfirm(_ sender: UIButton) {
        delegate?.onClickConfirm(cell: self)
    }
}

protocol ForgetConfirmDelegate {
    func onClickConfirm(cell: ForgetConfirmTableViewCell)
    func onClickCallNow()
}
