//
//  AboutUsModel.swift
//  AEONVCS
//
//  Created by mac on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AboutUsModel:BaseModel {
    
    func getAboutUs(siteActivationKey:String,success: @escaping (AboutUsResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "siteActivationKey": siteActivationKey
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.aboutUs, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let loginResponse = try? JSONDecoder().decode(AboutUsResponse.self, from: responseValue){
                    success(loginResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
}
