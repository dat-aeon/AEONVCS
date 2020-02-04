//
//  MesgSenderTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 4/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MesgSenderTableViewCell: UITableViewCell {

    @IBOutlet weak var vMainView: UIView!
    @IBOutlet weak var lbSendDate: UILabel!
    @IBOutlet weak var lbMesgText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(messageBean: MessageBean){
        self.lbSendDate.text = messageBean.sendTime
        self.lbMesgText.text = messageBean.message
        
    }
    
}
