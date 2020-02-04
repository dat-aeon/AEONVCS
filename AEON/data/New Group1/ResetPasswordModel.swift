//
//  ResetPasswordModel.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResetPasswordModel: BaseModel {
    
    func makeResetPassword(resetPasswordRequest: ResetPasswordRequest ,success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = [
            "customerId" : "\(resetPasswordRequest.customerId)",
            "userTypeId" : "\(resetPasswordRequest.userTypeId)",
            "password" : resetPasswordRequest.password
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.changePassword, rawData: rawData ) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                if Constants.STATUS_200 == response["status"] as? String {
                    success(response["status"] as! String)
                    
                } else if Constants.STATUS_500 == response["status"] as? String{
                    success(response["messageCode"] as! String)
                    
                } else{
                    failure(Constants.JSON_FAILURE)
                }
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let resetResponse = try? JSONDecoder().decode(ResetPasswordResponse.self, from: responseValue){
//                    success(resetResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
            case .failure(let error):
                print("Reset password error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func makeForceChangePassword(forcePasswordRequest: ForceChangePasswordRequest ,success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = [
            "phoneNo" : forcePasswordRequest.phoneNo,
            "nrcNo" : forcePasswordRequest.nrcNo,
            "password" : forcePasswordRequest.password
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.forceChangePassword, rawData: rawData ) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                if Constants.STATUS_200 == response["status"] as? String {
                    success(response["status"] as! String)
                    
                } else if Constants.STATUS_500 == response["status"] as? String{
                    success(response["messageCode"] as! String)
                    
                } else{
                    failure(Constants.JSON_FAILURE)
                }
                //                let responseJsonData = JSON(result)
                //                let responseValue  = try! responseJsonData.rawData()
                //                if let resetResponse = try? JSONDecoder().decode(ResetPasswordResponse.self, from: responseValue){
                //                    success(resetResponse)
                //                }else{
                //                    failure(Constants.JSON_FAILURE)
            //                }
            case .failure(let error):
                print("Reset password error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
}
