//
//  MessageData.swift
//  AEONVCS
//
//  Created by mac on 5/7/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct MessageBean{
    var isButton: Bool = false
    var isPhoto: Bool = false
    var message: String? = ""
    var sender: String? = ""
    var isReceiveMesg: Bool = false
    var sendTime: String? = ""
    var readFlag: String? = ""
    var messageId:Int? = 0
}

struct MessageResBean: Decodable{
    var messageId: String
    var messageContent: String
    var messageType: String
    var sendTime: String
    var sender: String
    var opSendFlag: String
    var readFlag: String
    var readTime: String
}
