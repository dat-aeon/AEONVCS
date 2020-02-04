//
//  ATsendMessageTableViewCell.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 11/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ATsendMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var txMessageContent: UITextView!
    @IBOutlet weak var lbDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(messageBean: ATmessageBean){
        var content = "Hello! I want to buy " + messageBean.brandName + " " + messageBean.categoryName + ".\n"
        content = content + "My Location is " + messageBean.location + ".\n"
        content = content + messageBean.contentMessage
        self.txMessageContent.text = content
        self.lbDate.text = messageBean.sendTime
    }
}
