//
//  PromotionData.swift
//  AEONVCS
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct PromotionRequest{
    let customerId: String
    let siteActivationKey: String
}

struct PromotionResponse : Codable{
    let status: String
    let promotionDtoBeanList: [PromotionDtoBean]?
    
    enum CodingKeys: String,CodingKey{
        case status
        case promotionDtoBeanList = "data"
    }
}

struct PromotionDtoBean : Codable{
    let promotionsInfoId: Int?
    let titleEng: String?
    let titleMyn: String?
    let contentEng: String?
    let contentMyn: String?
    let displayDate: String?
    let publishedFromDate: String?
    let publishedToDate: String?
    let imagePath: String?
    let longitude: String?
    let latitude: String?
    let announcementUrl: String?
}


struct PromotionBean{
    var promotionsInfoId: Int = 0
    var titleEng: String? = ""
    var titleMyn: String? = ""
    var contentEng: String? = ""
    var contentMyn: String? = ""
    var displayDate: String?
    var publishedFromDate: String?
    var publishedToDate: String?
    var imagePath: String? = ""
    var longitude: Double? = 0.0
    var latitude: Double? = 0.0
    var isLocationNull: Bool = false
    var announcementUrl: String? = ""
}
