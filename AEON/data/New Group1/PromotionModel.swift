//
//  PromotionModel.swift
//  AEONVCS
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PromotionModel:BaseModel {
    
    func getPromoList(token:String, success: @escaping (PromotionResponse) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        let rawData = [
            "access_token" : ""
        ]
        let _ = super.requestDataWithGETToken(endPoint: ApiServiceEndPoint.promoInfo, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                //print("Promo Response result :::::::::::\(result)")
                
                if let promoResponse = try? JSONDecoder().decode(PromotionResponse.self, from: responseValue){
                    success(promoResponse)
                }else{
                    failure(Constants.EXPIRE_TOKEN)
                }
            case .failure(let error):
                print("Failure on Promo List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                
            }
        }
    }
}
