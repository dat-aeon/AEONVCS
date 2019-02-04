 //
//  LoginData.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
 struct LoginResponse: Codable {
    let message: String
    let dataBean: DataBean
 }
 
 struct DataBean: Codable {
    let id: Int = 0
    let loginID: String? = "", name: String? = ""
    let agencyID: Int?=0
    let agencyName: String? = "", location: String?=""
    let outletID: Int?=0
    let outletName: String? = "", agencyOutletID: String? = "", mobileTeam: String? = "", nonMobileTeam: String? = ""
    let roleIDList:String? = ""
    let groupID: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case loginID = "loginId"
        case name
        case agencyID = "agencyId"
        case agencyName, location
        case outletID = "outletId"
        case outletName
        case agencyOutletID = "agencyOutletId"
        case mobileTeam, nonMobileTeam
        case roleIDList = "roleIdList"
        case groupID = "groupId"
    }
 }

