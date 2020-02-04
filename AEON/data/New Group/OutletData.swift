//
//  OutletData.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 7/28/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct OutletInfoResponse : Codable {
    var status: String = ""
    var data = OutletData()
}

struct OutletData : Codable {
    var outletLimitMetre : Int?
    var outletInfoList = [OutletInfoBean]()
    
}

struct OutletInfoBean : Codable{
    var outletId : Int?
    var outletName : String?
    var address :String?
    var phoneNo : String?
    var longitude : Double?
    var latitude : Double?
    var isAeonOutlet : Bool?
    var roleType : Int?
    var imagePath : String?
    var distance : Double?
    
    enum CodingKeys: String,CodingKey{
        case outletId
        case outletName
        case address = "outletAddress"
        case phoneNo
        case longitude
        case latitude
        case isAeonOutlet = "isAeon"
        case roleType = "roleId"
        case imagePath = "imagePath"
        case distance
    }
}
