//
//  GetChatBotMMData.swift
//  AEONVCS
//
//  Created by Ant on 22/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//


struct GetChatBotMMSyncResponse : Codable{
    let status: String
    let data : [ChatBotDatas]?
    
   
}

struct ChatBotDatas : Codable{
   
    let question: String?
    let answer: String?
    let chatBotQuestionAndAnswerId: Int?
    enum CodingKeys: String,CodingKey{
        case question
        case answer
        case chatBotQuestionAndAnswerId
    }
}
struct ChatBotMMInfo {
    var question: String = ""
    var answer: String = ""
    var chatBotQuestionAndAnswerId: Int = 0
}
