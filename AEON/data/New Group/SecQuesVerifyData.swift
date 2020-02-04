//
//  SecQuesVerifyModel.swift
//  AEONVCS
//
//  Created by mac on 2/19/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct VerifyUserQARequest:Codable{
    var customerId:String
    var securityQAUpdateInfo:VerifySecQAUpdateInfo
    enum CodingKeys: String,CodingKey {
        case customerId
        case securityQAUpdateInfo
    }
}

struct VerifySecQAUpdateInfo:Codable {
    var custSecQuesId:String
    var answer:String
    var secQuesId:String
    enum CodingKeys: String,CodingKey{
        case custSecQuesId
        case answer
        case secQuesId
    }
}

struct UserSecQuesVerifyRequest : Codable{
    var customerId: Int = 0
    var secQuesList = [UserQAVerifyList]()
    
    enum CodingKeys: String,CodingKey {
        case customerId
        case secQuesList = "securityQuestionAnswerReqDtoList"
    }
}

struct UserQAVerifyList : Codable{
    var secQuesId: Int = 0
    var question: String = ""
    var answer: String = ""
}

struct UserSecQuesVerifyBean {
    var customerId: String = ""
    var quesAnsBean = [UserQABean]()
}

struct UserQAVerifyBean{
    var secQuesId: Int = 0
    var question: String = ""
    var answer: String = ""
}

struct UserQAVerifyResponse:Codable {
    var status: String?
    var messageCode: String?
}
