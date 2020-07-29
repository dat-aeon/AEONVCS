//
//  SecQuesVerifyModel.swift
//  AEONVCS
//
//  Created by mac on 2/19/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON
class SecQuesVerifyModel:BaseModel {
    
    func verifyUserQAList(userVerifyBeanRequest:UserSecQuesVerifyRequest,token: String, success: @escaping (UserQAVerifyResponse) -> Void,failure: @escaping (String) -> Void){

        let rawData = getVerifyUserRequestData(userVerifyBeanRequest: userVerifyBeanRequest)
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataObjWithToken(endPoint: ApiServiceEndPoint.verifyQAList, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                var verifyResponse = UserQAVerifyResponse()
                
                if Constants.STATUS_200 == response["status"] as? String {
                    verifyResponse.status = response["status"] as? String
                    
                } else {
                    verifyResponse.status = response["status"] as? String
                    verifyResponse.messageCode = response["messageCode"] as? String
                }
                success(verifyResponse)
                
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let userQuesResponse = try? JSONDecoder().decode(UserQAVerifyResponse.self, from: responseValue){
//                    success(userQuesResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
            case .failure(let error):
                print("verify user QA error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    //GET REQUEST DATA FOR VERIFY MEMBER
    func getVerifyUserRequestData(userVerifyBeanRequest:UserSecQuesVerifyRequest)-> Data{
        
        do {
            let jsonData = try JSONEncoder().encode(userVerifyBeanRequest)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            //print("Encode \(jsonString)")
            
            return jsonData
        } catch { print("Error \(error)") }
        
        return Data()
    }
    
}
