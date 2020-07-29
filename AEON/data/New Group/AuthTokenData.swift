//
//  AuthTokenData.swift
//  AEONVCS
//
//  Created by mac on 5/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct InvalidTokenResponse: Codable {
    let error, errorDescription: String
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
    }
}

struct TokenResponse: Codable {
    var status:String? = ""
    var data: TokenData
}
struct TokenData: Codable {
    var access_token:String? = ""
    var refresh_token:String? = ""
    var scope:String? = ""
    var token_type:String? = ""
    var expire_in:String? = ""
}

struct TokenBean {
    var accessToken:String? = ""
    var refreshToken:String? = ""
    var scope:String? = ""
    var tokenType:String? = ""
    var expireIn:String? = ""
}

struct RequestFailedResponse: Codable {
    let status, messageCode, message, timestamp: String
    let payLoad: String?
}

