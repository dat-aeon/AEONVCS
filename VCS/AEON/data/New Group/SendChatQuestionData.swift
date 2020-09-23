//
//  SendChatQuestionData.swift
//  AEONVCS
//
//  Created by Ant on 22/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//


import Foundation

struct SendChatQuestionResponse: Codable {
   let status: String
    let data : SendChatQuestionData

}

struct SendChatQuestionData: Codable {
    let data: String?

   enum CodingKeys: String, CodingKey {
       case data = "data"
   }
}
