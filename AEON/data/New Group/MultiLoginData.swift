//
//  MultiLogin.swift
//  AEONVCS
//
//  Created by Ant on 07/05/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation

struct MultiLoginResponse: Codable {
   let status: String
    let data : MultiLoginData

}

struct MultiLoginData: Codable {
    let logoutFlag: Bool?

   enum CodingKeys: String, CodingKey {
       case logoutFlag = "logoutFlag"
   }
}
