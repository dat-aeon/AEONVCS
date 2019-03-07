//
//  LogoutModel.swift
//  AEONVCS
//
//  Created by mac on 3/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LogoutModel:BaseModel {
    
    func makeLogout(customerId:String, loginTime:String, logoutTime:String,success: @escaping (LogoutResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId": customerId,
            "loginTime": loginTime,
            "logoutTime": logoutTime
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.logout, rawData: rawData) { (result) in
            
            print("Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let loginResponse = try? JSONDecoder().decode(LogoutResponse.self, from: responseValue){
                    success(loginResponse)
                }else{
                    failure("Logout:JSON can't decode")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
}
