//
//  AboutUsData.swift
//  AEONVCS
//
//  Created by mac on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct AboutUsResponse1 : Codable{
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

struct AboutUsResponse: Codable {
    let status: String
    let data: CompanyInfo
}

struct CompanyInfo: Codable {
    let companyInfoId: Int?
    let addressEn, addressMm, hotlinePhone: String
    let webAddress, socialMediaAddress: String
    let aboutCompanyEn, aboutCompanyMm: String
    
    enum CodingKeys: String, CodingKey {
        case companyInfoId = "companyInfoId"
        case addressEn, addressMm, hotlinePhone, webAddress, socialMediaAddress, aboutCompanyEn, aboutCompanyMm
    }
}
