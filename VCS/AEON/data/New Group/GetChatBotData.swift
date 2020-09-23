
//  GetChatBotData.swift
//  AEONVCS
//  Created by Ant on 17/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.//

//
//import Foundation
//struct GetChatBotSyncResponse: Codable {
//    let status: String
//    let data : [ChatBotData]
//}
//
//struct ChatBotData: Codable {
//    let question: String
//    let chatBotQuestionAndAnswerId: Int
//    let answer: String
//    enum CodingKeys: String, CodingKey {
//        case question = "question"
//        case chatBotQuestionAndAnswerId = "chatBotQuestionAndAnswerId"
//        case answer = "answer"
//    }
//}
//

struct GetChatBotSyncResponse : Codable{
    let status: String
    let data : [ChatBotData]?
    
   
}

struct ChatBotData : Codable{
   
    let question: String?
    let answer: String?
    let chatBotQuestionAndAnswerId: Int?
    enum CodingKeys: String,CodingKey{
        case question
        case answer
        case chatBotQuestionAndAnswerId
    }
}
struct ChatBotInfo {
    var question: String = ""
    var answer: String = ""
    var chatBotQuestionAndAnswerId: Int = 0
}

