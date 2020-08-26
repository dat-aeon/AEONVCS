//
//  NRCData.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct NRCResponse: Codable {
    let status: String
    let data: [NRCData]
}

struct NRCData: Codable {
    let stateId: Int
    let townshipCodeList: [String]
    
    enum CodingKeys: String, CodingKey {
        case stateId = "stateId"
        case townshipCodeList
    }
}
