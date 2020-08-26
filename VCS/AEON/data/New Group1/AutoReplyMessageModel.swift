//
//  AutoReplyMessageModel.swift
//  AEONVCS
//
//  Created by Ant on 27/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AutoReplyMessageModel:BaseModel {
    
    func AutoReplyMessageSync(success: @escaping (AutoReplyMessageResponse) -> Void,failure: @escaping (String) -> Void){
        
        let _ = super.AutoReplyMessagePOSTWithoutToken(endPoint: ApiServiceEndPoint.AUTO_REPLY_MESSAGE) { (result) in
            
            //print("Login Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let autoReplyMessageResponse = try? JSONDecoder().decode(AutoReplyMessageResponse.self, from: responseValue){
                    success(autoReplyMessageResponse)
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
