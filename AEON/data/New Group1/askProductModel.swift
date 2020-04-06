//
//  askProductModel.swift
//  AEONVCS
//
//  Created by Ant on 06/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class askProductModel:BaseModel {
    
    func askProductSync(customerId:Int, success: @escaping (askProductResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId": customerId
        ]
        
        let _ = super.getAskProductUnread(endPoint: ApiServiceEndPoint.askproductunread, rawData: rawData) { (result) in
            switch result{
                       case .success(let result):
                           
                           let responseJsonData = JSON(result)
                           let responseValue  = try! responseJsonData.rawData()
                           if let askProductsResponse = try? JSONDecoder().decode(askProductResponse.self, from: responseValue){
                               success(askProductsResponse)
                           }else{
                               failure(Constants.JSON_FAILURE)
                           }
                       case .failure(let error):
                           //print("Login error", error.localizedDescription)
                           failure(Constants.SERVER_FAILURE)
                       }
        }

//        let _ = super.requestPOSTWithoutToken(endPoint: ApiServiceEndPoint.askproductunread, rawData: rawData) { (result) in
//
//            //print("Login Response result :::::::::::\(result)")
//            switch result{
//            case .success(let result):
//
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let askProductsResponse = try? JSONDecoder().decode(askProductResponse.self, from: responseValue){
//                    success(askProductsResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
//
//            case .failure(let error):
//                //print("Login error", error.localizedDescription)
//                failure(Constants.SERVER_FAILURE)
//            }
//
//        }
        
    }
    
    
}
