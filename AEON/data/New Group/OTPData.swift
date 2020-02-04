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
    let status: String
    let data: OTPData
    
}
struct OTPData : Codable {
    let otpCode: String
}
