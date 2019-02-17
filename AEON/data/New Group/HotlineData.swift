//
//  HotlineData.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct HotlineResponse : Codable{
    let statusCode: String
    let statusMessage: String
    let hotLinePhone: String
}
