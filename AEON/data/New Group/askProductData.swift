//
//  askProductData.swift
//  AEONVCS
//
//  Created by Ant on 06/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

struct askProductResponse: Codable {
    let status: String
    let data : askProductDatas
}

struct askProductDatas: Codable {
    let freeCustomerInfoID: Int

    enum CodingKeys: String, CodingKey {
        case askProductUnReadID = "askProductUnReadCount"
    }
}
