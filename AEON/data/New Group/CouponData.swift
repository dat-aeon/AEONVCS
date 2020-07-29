//
//  CouponData.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct CouponRequest{
    let customerId: String
    let siteActivationKey: String
}

struct CouponResponse : Codable{
    let status: String
    let data: [CouponResBean]?
    
}

struct CouponResBean : Codable{
    let couponId: Int
    let couponCode: String
    let couponNameMM: String
    let couponNameEN: String
    let descriptionMM: String
    let descriptionEN: String
    let specialEventMM: String?
    let specialEventEN: String?
    let couponAmount: Int
    let goodsPrice: Int
    let startTime: String
    let expiredTime: String
    let discountUnit: String
    let unuseImagePath: String
    let useImagePath: String
    let totalNo: Int
    let customerId: Int
    let status: String
}

struct CouponBean : Codable {
    var couponId: String = ""
    var couponCode: String = ""
    var couponNameMM: String = ""
    var couponNameEN: String = ""
    var descriptionMM: String = ""
    var descriptionEN: String = ""
    var specialEventMM: String = ""
    var specialEventEN: String = ""
    var couponAmount: String = ""
    var goodsPrice: String = ""
    var startTime: String = ""
    var expiredTime: String = ""
    var discountUnit: String = ""
    var unuseImagePath: String = ""
    var useImagePath: String = ""
    var totalNum: String = ""
    var customerId: String = ""
    var status: String = ""
    var isUsed:Bool = false
}


struct CouponUpdateRequest{
    let customerId: String
    let couponId: String
    let shopId: String
}

struct CouponUpdateResponse : Codable{
    let statusCode: String
    let statusMessage: String
    let couponId: String
    
    enum CodingKeys: String,CodingKey{
        case statusCode
        case statusMessage
        case couponId
    }
}
