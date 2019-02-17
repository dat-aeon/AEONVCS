//
//  ResetPasswordData.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct ResetPasswordRequest : Codable {
    var customerId:Int
    var userTypeId:Int
    var password:String
    
}
struct ResetPasswordResponse : Codable{
    var statusCode: String?
    var statusMessage: String?
    var customerId:Int
    var userTypeId:Int
}
