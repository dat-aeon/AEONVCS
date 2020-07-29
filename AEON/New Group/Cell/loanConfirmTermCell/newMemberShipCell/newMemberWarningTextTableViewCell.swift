//
//  newMemberWarningTextTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 2/17/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class newMemberWarningTextTableViewCell: UITableViewCell {
    @IBOutlet weak var lblWarningText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData() {
        self.lblWarningText.text = "membership.warningtext".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
