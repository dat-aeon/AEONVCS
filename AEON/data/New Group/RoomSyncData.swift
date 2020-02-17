//
//  RoomSyncData.swift
//  AEONVCS
//
//  Created by mac on 2/11/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

struct RoomSyncResponse: Codable {
    let status: String = ""
    let data = RoomSynceDatum()
}

struct RoomSynceDatum: Codable {
    let freeCustomerInfoID: Int = 0

    enum CodingKeys: String, CodingKey {
        case freeCustomerInfoID = "freeCustomerInfoId"
    }
}
