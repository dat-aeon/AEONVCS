//
//  NewsData.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 4/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct NewsRequest{
    let customerId: String
    let siteActivationKey: String
}

struct NewsResponse : Codable{
    let status: String
    let newsInfoDtoList: [NewsDtoBean]?
    
    enum CodingKeys: String,CodingKey{
        case status
        case newsInfoDtoList = "data"
    }
}

struct NewsDtoBean : Codable{
    let newsInfoId: Int?
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
    let newsUrl: String?
}


struct NewsInfoBean{
    var newsInfoId: Int = 0
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
    var newsUrl: String? = ""
}


