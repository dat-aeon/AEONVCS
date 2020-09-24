//
//  CalculatorMessageModel.swift
//  AEONVCS
//
//  Created by Ant on 24/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CalculatorMessageModel:BaseModel {
    
    func CalculatorMessageSync(success: @escaping (CalculatorMessageResponse) -> Void,failure: @escaping (String) -> Void){
        
        let _ = super.AutoReplyMessagePOSTWithoutToken(endPoint: ApiServiceEndPoint.CALCULATOR_MESSAGE) { (result) in
            
            //print("Login Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let calculatorMessageResponse = try? JSONDecoder().decode(CalculatorMessageResponse.self, from: responseValue){
                  
                    success(calculatorMessageResponse)
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
