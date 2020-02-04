//
//  SecQuesListData.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

//load Security Question & upload
struct SECQuesListResponse: Codable {
    var status: String?
    var data: SecQuesListData?
}

struct SecQuesListData: Codable {
    var numOfQuestion: Int?
    var numOfAnsCount: Int?
    var secQuesList: [SecQuesListBean]?
    
    enum CodingKeys: String, CodingKey {
        case numOfQuestion = "numOfSecQues"
        case numOfAnsCount = "numOfAnsChar"
        case secQuesList = "securityQuestionResDtoList"
    }
}

struct SecQuesListBean: Codable {
    var secQuestionId: Int?
    var questionMM: String?
    var questionEN: String?
}

struct SecQuesRegisterBean {
    let numOfQuestion: Int
    let numOfAnsCount: Int
    let questionList: [[String]]
    let secQuesList:[SecQuesListBean]
}

struct SecQABean:Codable {
    let questionId:Int
    let answer:String
    enum CodingKeys: String, CodingKey {
    case questionId = "secQuesId"
    case answer = "answer"
    }
}

