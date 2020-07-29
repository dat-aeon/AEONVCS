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
    
    func makeLogout(customerId:String, logoutTime:String, token:String, success: @escaping (LogoutResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId": customerId
        ]
        let token = [
            "access_token": token
        ]
        let _ = super.requestDataWithToken(endPoint: ApiServiceEndPoint.logout, rawData: rawData, token: token) { (result) in
            
           // print("Logout result :::::::::::\(result)")
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                var logoutResponse = LogoutResponse()
                if Constants.STATUS_200 == response["status"] as? String {
                    logoutResponse.statusCode = Constants.STATUS_200
                    success(logoutResponse)

                } else if Constants.EXPIRE_TOKEN == response["error"] as? String {
                    failure(Constants.EXPIRE_TOKEN)
                    
                } else{
                    failure(Constants.JSON_FAILURE)
                }
            case .failure(let error):
                print("Logout error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func makeOfflineLogout(customerId:String, logoutTime:String,success: @escaping (LogoutResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId": customerId,
            "logoutTime": logoutTime
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.offline_logout, rawData: rawData) { (result) in
            
            //print("Offline Logout result :::::::::::\(result)")
            switch result{
            case .success(let result):
                let response = result as AnyObject
                //print("login response : ", response)
                
                var logoutResponse = LogoutResponse()
                if Constants.STATUS_200 == response["status"] as? String {
                    logoutResponse.statusCode = Constants.STATUS_200
                    success(logoutResponse)
                    
                }else{
                    failure(Constants.JSON_FAILURE)
                }
            case .failure(let error):
                print("Logout error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
}
