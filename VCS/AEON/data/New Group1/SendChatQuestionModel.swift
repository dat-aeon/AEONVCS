//
//  SendChatQuestionModel.swift
//  AEONVCS
//
//  Created by Ant on 22/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SendChatQuestionModel:BaseModel {
    func sendChatQuestion(customerId: Int,chatBotQuestionAndAnswerId: Int ,question: String,answer:String,success: @escaping (SendChatQuestionResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId": customerId,
            "chatBotQuestionAndAnswerId": chatBotQuestionAndAnswerId,
            "question": question,
            "answer": answer
            
        ] as [String : Any]
        let _ = super.sendChatPOSTWithoutToken(endPoint: ApiServiceEndPoint.sendchatQuestionAnswer, rawData: rawData) { (result) in
            switch result{
                   case .success(let result):
                       
                       let responseJsonData = JSON(result)
                       let responseValue  = try! responseJsonData.rawData()
                       if let sendChatResponse = try? JSONDecoder().decode(SendChatQuestionResponse.self, from: responseValue){
                           success(sendChatResponse)
                       }else{
                         //  failure(Constants.JSON_FAILURE)
                       }
                  
            case .failure( _):
                       //print("Login error", error.localizedDescription)
                       failure(Constants.SERVER_FAILURE)
                   }
        }
    }
  
}
