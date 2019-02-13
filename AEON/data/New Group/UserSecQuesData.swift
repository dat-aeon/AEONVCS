//
//  UserSecQuesData.swift
//  AEONVCS
//
//  Created by mac on 2/12/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct UserSecQuesResponse : Codable{
    let numOfQuestion: Int
    let userSecQuesBeanList : UserSecQuesBeanList
}

struct UserSecQuesBeanList : Codable {
    let customerId: Int = 0
    let questionList = [QuestionBean]()
}

struct QuestionBean : Codable {
    let secQuesId: Int
    let questionMM: String
    let questionEN: String
    let answer: String
}

struct UserSecQuesConfirmRequest : Codable{
    var phoneNo: String = ""
    var nrcData: String = ""
    var quesAnsBean = [UserQABeanRequest]()
}

struct UserQABeanRequest : Codable{
    var secQuesId: Int = 0
    var question: String = ""
    var answer: String = ""
}

struct UserSecQuesConfirmBean {
    var phoneNo: String = ""
    var nrcData: String = ""
    var quesAnsBean: [UserQABean]? = nil
}

struct UserQABean{
    var secQuesId: Int = 0
    var question: String = ""
    var answer: String = ""
}
