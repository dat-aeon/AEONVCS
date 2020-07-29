//
//  AppLockCheckModel.swift
//  AEONVCS
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class AppLockCheckModel: BaseModel {
    
    func getAppLockStatus(phoneNo:String, nrcNo:String, success: @escaping (AppLockResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "phoneNo" : phoneNo,
            "nrcNo" : nrcNo
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.checkAccountLock, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                var appLockResponse = AppLockResponse()
                
                if Constants.STATUS_200 == response["status"] as? String {
                    let data = response["data"] as AnyObject
                    appLockResponse.status = Constants.STATUS_200
                    appLockResponse.lockStatus = data["lockStatus"] as? Int
                    appLockResponse.phoneNo = data["phoneNo"] as? String
                    appLockResponse.hotlinePhone = data["hotlinePhone"] as? String
                    appLockResponse.custQuesCount = data["customerSecurityQuestionCount"] as? Int
                    success(appLockResponse)
                    
                } else if Constants.STATUS_500 == response["status"] as? String {
                    appLockResponse.status = Constants.STATUS_500
                    appLockResponse.messageCode = response["messageCode"] as? String
                    success(appLockResponse)
                    
                } else {
                    failure(Constants.SERVER_FAILURE)
                }
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let userQuesResponse = try? JSONDecoder().decode(UserSecQuesResponse.self, from: responseValue){
//                    success(userQuesResponse)
//                }else{
//                    failure("Cannot load any data")
//                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
