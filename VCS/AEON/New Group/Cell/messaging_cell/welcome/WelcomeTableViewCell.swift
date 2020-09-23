//
//  WelcomeTableViewCell.swift
//  AEONVCS
//
//  Created by Ant on 21/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgReceiver: UIImageView!
    @IBOutlet weak var lbMesgText: UITextView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
//         lbMesgText.layer.cornerRadius = lbMesgText.frame.size.width / 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(messageBean: MessageBean){
        self.lbMesgText.text = messageBean.message
        
    }
    
}
