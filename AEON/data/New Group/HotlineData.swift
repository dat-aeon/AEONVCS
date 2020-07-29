//
//  HotlineData.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct HotlineResponse: Codable {
    let status: String
    let data: HotlineData
}

struct HotlineData: Codable {
    let hotlinePhone: String
}
