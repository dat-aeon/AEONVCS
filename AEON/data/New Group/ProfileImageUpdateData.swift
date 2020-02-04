//
//  ProfileImageUpdateData.swift
//  AEONVCS
//
//  Created by mac on 7/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct ProfileUpdateResponse : Codable {
    var status: String = ""
    var data = ProfileUpdateBean()
}

struct ProfileUpdateBean : Codable{
    var photoPath : String = ""
}
