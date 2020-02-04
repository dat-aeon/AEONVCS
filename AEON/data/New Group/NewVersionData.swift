//
//  NewVersionData.swift
//  AEONVCS
//
//  Created by mac on 4/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct NewVersionResponse : Codable{
    var forceUpdFlag: String?
    var status: String?
    var appStoreUrl: String?
    var messageCode: String?
    var versionUpdateInfo: String?
}
