//
//  GetChatBotViewModel.swift
//  AEONVCS
//
//  Created by Ant on 17/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation

class GetChatBotViewModel {
    
    func getChatBotSync(type:Int, success: @escaping ([ChatBotInfo]) -> Void,failure: @escaping (String) -> Void){
        
        
        GetChatBotModel.init().getchatBotSync(type: type, success: { (result) in
           
          
            
            if result.status == Constants.STATUS_200 {
                let chatQuestion = self.getChatBotList(chatBotResponse: result)
              
                
                success(chatQuestion)
                
            } else {
                failure(result.status)
            }
            
        }) { (error) in

        }
    }
    func getChatBotList (chatBotResponse: GetChatBotSyncResponse) -> [ChatBotInfo] {
        var chatList = [ChatBotInfo]()
        for chatbot in chatBotResponse.data ?? [] {
            var chatbotInfo = ChatBotInfo()
            chatbotInfo.answer = chatbot.answer ?? ""
            chatbotInfo.question = chatbot.question ?? ""
            chatbotInfo.chatBotQuestionAndAnswerId = chatbot.chatBotQuestionAndAnswerId ?? 0
            chatList.append(chatbotInfo)
        }
        return chatList
    }
    
    
}
