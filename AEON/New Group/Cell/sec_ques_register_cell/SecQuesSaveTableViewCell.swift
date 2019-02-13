//
//  SecQuesSaveTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 2/11/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesSaveTableViewCell: UITableViewCell {

    @IBOutlet weak var ivSaveBtn: UIButton!
    var delegate:SecurityQuestionSaveDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickSaveBtn(_ sender: UIButton) {
        delegate?.onClickSaveButton()
    }
}

protocol SecurityQuestionSaveDelegate {
    func onClickSaveButton()
}


