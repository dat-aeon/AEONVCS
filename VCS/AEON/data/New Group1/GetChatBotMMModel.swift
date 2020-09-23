//
//  GetChatBotModel.swift
//  AEONVCS
//
//  Created by Ant on 17/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetChatBotMMModel:BaseModel {
    
    func getchatBotSync(type: Int, success: @escaping (GetChatBotSyncResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "type": type
        ]

        let _ = super.getChatBotPostWithoutToken(endPoint: ApiServiceEndPoint.getchatbotmm, rawData: rawData) { (result) in
            
            print("chatbot Response result :::::::::::\(result)")
           
            switch result{
            case .success(let result):
                 
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let GetChatBotResponse = try? JSONDecoder().decode(GetChatBotSyncResponse.self, from: responseValue){
                    success(GetChatBotResponse)
                }else{
                    failure(Constants.JSON_FAILURE)
                }
            case .failure(let error):
                //print("Login error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
            
        }
        
    }
    
}
