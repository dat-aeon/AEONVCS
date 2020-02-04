//
//  HotlineModel.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HotlineModel:BaseModel {
    
    func getHotlineNo(siteActivationKey:String,success: @escaping (HotlineResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "siteActivationKey": siteActivationKey
        ]
        let _ = super.requestGETWithoutToken(endPoint: ApiServiceEndPoint.hotline, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let hotlineResponse = try? JSONDecoder().decode(HotlineResponse.self, from: responseValue){
                    success(hotlineResponse)
                }else{
                    failure(Constants.JSON_FAILURE)
                }
            case .failure(let error):
                print("hotline error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    
    
    func requestGETWithoutToken(endPoint:String,rawData:[String:String],completion:@escaping (String)->Void) -> String {
        
        //write something
        return endPoint
        
    }
    
    
}
