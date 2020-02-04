//
//  ATreceiveMessageTableViewCell.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 11/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ATreceiveMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var senderView: UIView!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var txMesgContent: UITextView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var vPhoneCall: UIView!
    
    
    var callDelegate : CallAgentDelegate?
    var messageBean : ATmessageBean?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vPhoneCall.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickCallAgent(tapGestureRecognizer:))))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(messageBean: ATmessageBean){
        self.messageBean = messageBean
        var content = "Dear Customer, \n We are " + messageBean.agentName
        content = content + ". We have " + messageBean.brandName + " " + messageBean.categoryName + " as your wish.\n"
        content = content + "Price is " + messageBean.price + " MMK.\n"
        content = content + messageBean.contentMessage
        content = content + "\n If you interest our information, please contact us " + messageBean.phoneNo
        content = content + "\n Link : " + messageBean.urlLink
        self.txMesgContent.text = content
        self.lbDate.text = messageBean.sendTime
        //print("Send Time : \(messageBean.sendTime)")
    }
    
    @objc func onClickCallAgent(tapGestureRecognizer: UITapGestureRecognizer){
        //self.messageBean!.phoneNo.makeCall()
        callDelegate?.onClickCallAgent(phoneNo: self.messageBean!.phoneNo, agentId: self.messageBean!.agentId)
    }
}


    protocol CallAgentDelegate {
        func onClickCallAgent(phoneNo:String , agentId:Int)
    }
