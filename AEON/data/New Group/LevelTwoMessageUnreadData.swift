//
//  LevelTwoMessageUnread.swift
//  AEONVCS
//
//  Created by Ant on 07/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

struct levelTwoMessageUnReadResponse: Codable {
    let status: String
    let data : levelTwoUnReadDatas
}
struct levelTwoUnReadDatas: Codable {
    let level2MessageUnReadCount: Int
    enum CodingKeys: String, CodingKey {
        case level2MessageUnReadCount = "level2MessageUnReadCount"
    }
}


