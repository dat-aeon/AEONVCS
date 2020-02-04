//
//  SecQuesConfirmModel.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

class SecQuesConfirmModel: BaseModel {
    
    func getSecQuestConfirmation() -> [SecurityQuestionConfirm]{
        var confirmList = [SecurityQuestionConfirm]()
        let confirmData = SecurityQuestionConfirm(phoneNo: "091234567", nrcDivision: "12", nrcTownship: "LALANA", nrcType: "(N)", nrcNumber: "123456")
        confirmList.append(confirmData)
        return confirmList
    }
    
    func getQuestionList(siteActivationKey:String,success: @escaping (UserSecQuesResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "siteActivationKey" : siteActivationKey
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.resetSecQuesList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let userQuesResponse = try? JSONDecoder().decode(UserSecQuesResponse.self, from: responseValue){
                    success(userQuesResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }

    func makeConfirm(userConfirmRequest: UserSecQuesConfirmRequest,success: @escaping (ConfirmResponse) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = getResetConfrimRequestData(resetConfirmRequest: userConfirmRequest)
        //print("RAW data::::::::::\(rawData)")
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.confirmUser, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                var confirmResponse = ConfirmResponse()
                
                if Constants.STATUS_200 == response["status"] as? String  {
                    let data = response["data"] as AnyObject
                    confirmResponse.statusCode = response["status"] as? String
                    confirmResponse.customerId = data["customerId"] as? Int
                    confirmResponse.userTypeId = data["userTypeId"] as? Int
                    
                } else {
                    confirmResponse.statusCode = response["messageCode"] as? String
                    
                }
                success(confirmResponse)
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let userQuesResponse = try? JSONDecoder().decode(ConfirmResponse.self, from: responseValue){
//                    success(userQuesResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
            case .failure(let error):
                print("Sec Confirm error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
}

//GET REQUEST DATA FOR NEW MEMBER
func getResetConfrimRequestData(resetConfirmRequest: UserSecQuesConfirmRequest)->Data{
    
    do {
        let jsonData = try JSONEncoder().encode(resetConfirmRequest)
        let jsonString = String(data: jsonData, encoding: .utf8)!
       // print("Encode \(jsonString)")
        
        return jsonData
    } catch { print("Error \(error)") }
    
    return Data()
}

struct SecurityQuestionConfirm {
    var phoneNo: String!
    var nrcDivision: String!
    var nrcTownship: String!
    var nrcType: String!
    var nrcNumber: String!
}

