//
//  SecQuesDataModel.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class SecQuesDataModel {
    
    func getSecQuesList() -> [SecurityQuestion] {
        var secQuesList = [SecurityQuestion]()
        let secQues1 = SecurityQuestion(index: "1",questionMyan: "What is your fav food? [Myan]", questionEng: "What is your fav food? [Eng]", answerMyan: "sandwich", answerEng: "Sandwich")
        let secQues2 = SecurityQuestion(index: "2",questionMyan: "What is your fav color? [Myan]", questionEng: "What is your fav color? [Eng]", answerMyan: "blue", answerEng: "red")
        
        secQuesList.append(secQues1)
        secQuesList.append(secQues2)
        return secQuesList
    }
    
    func getSecQuestConfirmation() -> [SecurityQuestionConfirm]{
        var confirmList = [SecurityQuestionConfirm]()
        let confirmData = SecurityQuestionConfirm(phoneNo: "091234567", nrcDivision: "12", nrcTownship: "LALANA", nrcType: "(N)", nrcNumber: "123456")
        confirmList.append(confirmData)
        return confirmList
    }
}
    
struct SecurityQuestion {
    var index: String!
    var questionMyan: String!
    var questionEng: String!
    var answerMyan: String?
    var answerEng: String?
}


struct SecurityQuestionConfirm {
    var phoneNo: String!
    var nrcDivision: String!
    var nrcTownship: String!
    var nrcType: String!
    var nrcNumber: String!
}

