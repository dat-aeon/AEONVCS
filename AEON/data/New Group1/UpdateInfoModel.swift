//
//  UpdateInfoModel.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/16/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON
class UpdateInfoModel:BaseModel {
    
    func loadUserQAListRequest(customerId:String, token: String, success: @escaping (UserQAResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId":customerId
        ]
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataWithToken(endPoint: ApiServiceEndPoint.userQAList, rawData: rawData, token: token) { (result) in
            
            switch result{
            case .success(let result):
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let userQAResponse = try? JSONDecoder().decode(UserQAResponse.self, from: responseValue){
                    success(userQAResponse)
                    
                } else if let expireTokenResponse = try? JSONDecoder().decode(InvalidTokenResponse.self, from: responseValue){
                    failure(expireTokenResponse.error)
                    
                }else  {
                    failure(Constants.JSON_FAILURE)
                }
                break
            case .failure(let error):
                print("User QA list loading error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                break
            }
        }
    }
    
    
    func updateUserQAListRequest(updateUserBeanRequest : UpdateUserQARequest, token: String,success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try! jsonEncoder.encode(updateUserBeanRequest.securityQAUpdateInfo)
//        let qaString = String(data: jsonData, encoding: String.Encoding.utf8)
        
//        let rawData = [
//            "customerId": updateUserBeanRequest.customerId,
//            "password": updateUserBeanRequest.password,
//            "securityQAUpdateInfo": qaString
//        ]
        let rawData = getUpdateUserRequestData(updateUserBeanRequest: updateUserBeanRequest)
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataObjWithToken(endPoint: ApiServiceEndPoint.updateUserQAList, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                if response["status"] as! String == Constants.STATUS_200 {
                    success(response["status"] as! String)
                    
                } else if response["status"] as! String == Constants.STATUS_500 {
                    success(response["messageCode"] as! String)
                } else {
                    failure(Constants.EXPIRE_TOKEN)
                }
            
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let updateResponse = try? JSONDecoder().decode(UpdateUserQAResponse.self, from: responseValue){
//                    success(updateResponse)
//                }else{
//                    failure("JSON parse Update User Error")
//                }
//                break
            case .failure(let error):
                failure(error.localizedDescription)
                break
            }
        }
    }

    //GET REQUEST DATA FOR NEW MEMBER
    func getUpdateUserRequestData(updateUserBeanRequest : UpdateUserQARequest)->Data{
        
        do {
            let jsonData = try JSONEncoder().encode(updateUserBeanRequest)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print("Encode \(jsonString)")
            
            return jsonData
        } catch { print("Error \(error)") }
        
        return Data()
    }
    
}
