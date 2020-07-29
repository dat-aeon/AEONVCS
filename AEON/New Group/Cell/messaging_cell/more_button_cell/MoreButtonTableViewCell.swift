//
//  MoreButtonTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 6/13/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MoreButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var vMainView: UIView!
    @IBOutlet weak var btnMoreButton: UIButton!
    
    var delegate :MoreMessageDelegate?
    var messageBean : MessageBean?
    var messageId : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(messageId: Int){
        self.messageId = messageId
    }
    
    @IBAction func onClickMoreMesg(_ sender: UIButton) {
     delegate?.onClickMoreMesg(messageId: self.messageId!)
    }
}

protocol MoreMessageDelegate {
    func onClickMoreMesg(messageId:Int)
}
