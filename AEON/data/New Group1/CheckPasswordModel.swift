//
//  CheckPasswordModel.swift
//  AEONVCS
//
//  Created by mac on 9/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

class CheckPasswordModel: BaseModel {
    
    func checkPassword(userIdInfo: CheckPasswordRequest, token: String,success: @escaping (CheckPasswordResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId": "\(userIdInfo.customerId)",
            "password": userIdInfo.password
        ]
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataWithToken(endPoint: ApiServiceEndPoint.checkPasswordToVerifyUser, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("register response : ", response)
                
                var verifyInfo = CheckPasswordResponse()
//                verifyInfo.data = VerifyData()
//                let data = response["data"] as AnyObject
                
                if Constants.STATUS_200 == response["status"] as? String {
                    verifyInfo.status = response["status"] as? String
//                    verifyInfo.data?.verifyStatus = data["verifyStatus"] as? String
//                    verifyInfo.data?.customerNo = data["customerNo"] as? String
                    success (verifyInfo)
                    
                } else if Constants.STATUS_500 == response["status"] as? String {
                    verifyInfo.status = response["status"] as? String
                    success (verifyInfo)
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
                
            case .failure(let error):
                //print("Verify User error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
}
