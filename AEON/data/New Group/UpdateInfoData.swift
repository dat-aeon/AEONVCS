//
//  UpdateInfoData.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/16/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct UserQAResponse: Codable {
    var status: String?
    var data: UserSECResponse?
}

struct UserSECResponse:Codable {
    var numOfSECQues, numOfAnsChar: Int?
    var secQAUpdateInfoResDtoList:[UserQAList]
    
    enum CodingKeys:String,CodingKey {
        case numOfSECQues = "numOfSecQues"
        case numOfAnsChar = "numOfAnsChar"
        case secQAUpdateInfoResDtoList = "customerSecurityQuestionDtoList"
    }
}

struct UserQAList:Codable{
    var custSecQuesId:Int?
    var secQuesId:Int?
    var customerId:Int?
    var answer:String?
    var questionMM:String?
    var questionEN:String?

    enum CodingKeys:String,CodingKey {
        case custSecQuesId
        case secQuesId
        case answer
        case customerId
        case questionMM = "questionMyan"
        case questionEN = "questionEng"
    }
}

struct UpdateUserQARequest:Codable{
    var customerId:String = ""
    var password:String = ""
    var securityQAUpdateInfo = [SecurityQAUpdateInfo]()
    enum CodingKeys: String,CodingKey {
        case customerId;
        case password;
        case securityQAUpdateInfo = "securityQuestionAnswerReqDtoList"
    }
}

struct SecurityQAUpdateInfo:Codable {
    var answer:String = ""
    var secQuesId:String = ""
    enum CodingKeys: String,CodingKey{
        case answer
        case secQuesId = "secQuesId"
    }
}

struct UpdateUserQAResponse:Codable{
    var statusCode: String
    var statusMessage: String
    var updateStatus:String
    enum CodingKeys: String,CodingKey {
        case statusCode
        case statusMessage
        case updateStatus
    }
    
}

struct UpdateUserBean{
    var customerId:String
    var password:String
    var securityQAUpdateInfo:[UpdateUserQABean]
}

struct UpdateUserQABean {
    var custSecQuesId:String = ""
    var answer:String = ""
    var secQuesId:String = ""
}
