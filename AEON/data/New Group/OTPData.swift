//
//  OTPData.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct OTPRequest{
    let phoneNo: String
    let siteActivationKey: String
}

struct OTPResponse : Codable{
    let statusCode: String
    let statusMessage: String
    let otpCode: String
}
