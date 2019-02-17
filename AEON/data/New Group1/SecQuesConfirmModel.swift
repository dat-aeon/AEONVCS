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
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(userConfirmRequest.resetPwdAnsweredSecQuesList)
        let qaString = String(data: jsonData, encoding: String.Encoding.utf8)

        let rawData = [
            "phoneNo" : userConfirmRequest.phoneNo,
            "nrcNo" : userConfirmRequest.nrcData,
            "resetPwdAnsweredSecQuesList" : qaString
        ]
        print("RAW data::::::::::\(rawData)")
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.confirmUser, rawData: rawData as! [String : String]) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let userQuesResponse = try? JSONDecoder().decode(ConfirmResponse.self, from: responseValue){
                    success(userQuesResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
struct SecurityQuestionConfirm {
    var phoneNo: String!
    var nrcDivision: String!
    var nrcTownship: String!
    var nrcType: String!
    var nrcNumber: String!
}

