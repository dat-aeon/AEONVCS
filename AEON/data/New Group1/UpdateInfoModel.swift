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
    
    func loadUserQAListRequest(customerId:String,success: @escaping (UserQAResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = ["customerId":customerId]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.userQAList, rawData: rawData) { (result) in
            print("Update Info Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let checkMemberResponse = try? JSONDecoder().decode(UserQAResponse.self, from: responseValue){
                    success(checkMemberResponse)
                }else{
                    failure("JSON can't decode")
                }
                break
            case .failure(let error):
                failure(error.localizedDescription)
                break
            }
        }
    }
    
    
    func updateUserQAListRequest(updateUserBeanRequest : UpdateUserQARequest,success: @escaping (UpdateUserQAResponse) -> Void,failure: @escaping (String) -> Void){
        
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try! jsonEncoder.encode(updateUserBeanRequest.securityQAUpdateInfo)
//        let qaString = String(data: jsonData, encoding: String.Encoding.utf8)
        
//        let rawData = [
//            "customerId": updateUserBeanRequest.customerId,
//            "password": updateUserBeanRequest.password,
//            "securityQAUpdateInfo": qaString
//        ]
        let rawData = getUpdateUserRequestData(updateUserBeanRequest: updateUserBeanRequest)
        
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.updateUserQAList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let updateResponse = try? JSONDecoder().decode(UpdateUserQAResponse.self, from: responseValue){
                    success(updateResponse)
                }else{
                    failure("JSON parse Update User Error")
                }
                break
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
