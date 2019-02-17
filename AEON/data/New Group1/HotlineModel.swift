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
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.hotline, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let loginResponse = try? JSONDecoder().decode(HotlineResponse.self, from: responseValue){
                    success(loginResponse)
                }else{
                    failure("JSON parse error")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
}
