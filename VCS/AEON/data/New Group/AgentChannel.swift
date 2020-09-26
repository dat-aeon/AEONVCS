//
//  AgentChannel.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 11/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct CategoryResponse: Codable {
    let status: String
    let data: [CategoryData]
}

struct CategoryData: Codable {
    var productTypeID: Int = 0
    var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case productTypeID = "productTypeId"
        case name
    }
}

struct BrandData: Codable {
    var brandId: Int = 0
    var brandName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case brandId = "brandId"
        case brandName
    }
}

struct ATmessageBean: Codable{
    var isButton : Bool = false
    var isReceiveMesg: Bool = false
    var agentId : Int = 0
    var messageId: Int = 0
    var senderId: Int = 0
    var agentName : String = ""
    var brandId : Int = 0
    var brandName : String = ""
    var price : String = ""
    var contentMessage: String = ""
    var location: String = ""
    var categoryId : Int = 0
    var categoryName : String = ""
    var phoneNo : String = ""
    var urlLink: String = ""
    var sendTime: String = ""
    var levelType : Int = 1
}

struct SocketReqBean: Codable {
    var api : String = ""
    var param = SocketParam()
    
    enum CodingKeys: String, CodingKey {
        case api = "api"
        case param
    }
}

struct SocketParam : Codable {
    var phoneNo : String = ""
    var customerId : Int = 0
    var roomName : String = ""
    var oldRoom : String = ""
    var userWithAgency : String = ""
    var messageId : Int = 0
    var agentId : Int = 0
    var categoryId : Int = 0
    var categoryName : String = ""
    var brandId : Int = 0
    var brandName : String = ""
    var location : String = ""
    var additionalText : String = ""
    var userId : Int = 0
    var sendFlag : Int = 0
    var sendTime : String = ""
    var readFlag : Int = 0
    var levelType : Int = 1
}
