//
//  AboutUsData.swift
//  AEONVCS
//
//  Created by mac on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct AboutUsResponse : Codable{
    let statusCode: String
    let statusMessage: String
    let companyInfoId: Int
    let addressEn: String
    let addressMm: String
    let hotLinePhone: String
    let webAddress: String
    let socialMediaAddress: String
    let aboutCompanyEn: String
    let aboutCompanyMm: String
}
