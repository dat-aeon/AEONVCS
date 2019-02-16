//
//  AboutUsData.swift
//  AEONVCS
//
//  Created by mac on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct AboutUsResponse : Codable{
    let companyInfoId: Int
    let address: String
    let hotLinePhone: String
    let webAddress: String
    let socialMediaAddress: String
    let aboutCompany: String
}
