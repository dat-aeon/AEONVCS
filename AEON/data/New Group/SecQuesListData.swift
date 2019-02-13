//
//  SecQuesListData.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct SecQuesListResponse: Codable {
    let numOfQuestion: Int
    let numOfAnsCount: Int
    let dataBean: [SecQuesListBean]
}

struct SecQuesListBean: Codable {
    let secQuestionId: Int = 0
    let questionMM: String = ""
    let questionEN: String = ""
    let delFlag: Int = 0
}

struct SecQuesRegisterBean {
    let numOfQuestion: Int
    let numOfAnsCount: Int
    let questionList: [[String]]
}
