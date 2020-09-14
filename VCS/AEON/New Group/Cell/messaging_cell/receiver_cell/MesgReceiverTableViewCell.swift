//
//  MesgReceiverTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 4/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MesgReceiverTableViewCell: UITableViewCell {

    @IBOutlet weak var imgReceiver: UIImageView!
    @IBOutlet weak var lbMesgText: UITextView!
    @IBOutlet weak var lbSendDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//         lbMesgText.layer.cornerRadius = lbMesgText.frame.size.width / 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(messageBean: MessageBean){
        self.lbMesgText.text = messageBean.message
        self.lbSendDate.text = messageBean.sendTime
    }
}
