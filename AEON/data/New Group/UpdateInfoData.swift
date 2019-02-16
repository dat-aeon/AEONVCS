//
//  UpdateInfoData.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/16/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct UserQAResponse:Codable{
    var custSecQuesId:String
    var answer:String
    var secQuestionId:String
    var questionMM:String
    var questionEN:String

    enum CodingKeys:String,CodingKey {
        case custSecQuesId
        case answer
        case secQuestionId
        case questionMM
        case questionEN
    }
}

struct UpdateUserQARequest:Codable{
    var customerId:String
    var userTypeId:String
    var password:String
    var securityQAUpdateInfo:SecurityQAUpdateInfo
    enum CodingKeys: String,CodingKey {
        case customerId;
        case userTypeId;
        case password;
        case securityQAUpdateInfo
    }
}

struct SecurityQAUpdateInfo:Codable {
    var custSecQuesId:String
    var answer:String
    var secQuesId:String
    enum CodingKeys: String,CodingKey{
        case custSecQuesId
        case answer
        case secQuesId
    }
}

struct UpdateUserQAResponse:Codable{
    var updateStatus:String
    enum CodingKeys: String,CodingKey {
        case updateStatus
    }
    
}
