//
//  AppLockData.swift
//  AEONVCS
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct AppLockResponse : Codable{
    var status: String?
    var messageCode: String?
    var phoneNo: String?
    var lockStatus: Int?
    var hotlinePhone: String?
    var custQuesCount: Int?
}
