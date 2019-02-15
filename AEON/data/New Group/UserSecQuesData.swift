//
//  UserSecQuesData.swift
//  AEONVCS
//
//  Created by mac on 2/12/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct UserSecQuesResponse : Codable{
    let numOfSecQues: Int
    let numOfAnsChar: Int
    let userSecQuesBeanList : [QuestionBean]
}

struct QuestionBean : Codable {
    let secQuesId: Int
    let questionMM: String
    let questionEN: String
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
