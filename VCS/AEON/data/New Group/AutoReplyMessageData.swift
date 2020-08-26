//
//  AutoReplyMessage.swift
//  AEONVCS
//
//  Created by Ant on 27/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON


struct AutoReplyMessageResponse: Codable {
    let status: String
    let data : ReplyMessageData
}

struct ReplyMessageData: Codable {
    var messageEng: String
    var messageMya: String

    enum CodingKeys: String, CodingKey {
        case messageEng = "messageEng"
        case messageMya = "messageMya"
    }
}
