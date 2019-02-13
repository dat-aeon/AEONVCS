//
//  SecQuesDataModel.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

class SecQuesRegisterModel: BaseModel {
    
    func makeRegister(username:String,dob:String,nrc:String,phoneno:String,password:String,success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "userName": username,
            "dob": dob,
            "nrc": nrc,
            "phoneNo": phoneno,
            "password": password
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.register, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: responseValue){
                    success(registerResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
    
    func getSecQuestionList(siteActivationKey: String, success: @escaping (SecQuesListResponse) -> Void, failure: @escaping (String) ->Void){
        
        let rawData = [Constants.SITE_ACTIVATION_KEY: siteActivationKey]
        
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.secQuesList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let secQuesListResponse = try? JSONDecoder().decode(SecQuesListResponse.self, from: responseValue){
                    success(secQuesListResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
        
    }
    
    func getSecQuesList() -> [SecurityQuestion] {
        var secQuesList = [SecurityQuestion]()
        let secQues1 = SecurityQuestion(index: "1",questionMyan: "What is your fav food? [Myan]", questionEng: "What is your fav food? [Eng]", answerEng: "Sandwich")
        let secQues2 = SecurityQuestion(index: "2",questionMyan: "What is your fav color? [Myan]", questionEng: "What is your fav color? [Eng]", answerEng: "red")
        
        secQuesList.append(secQues1)
        secQuesList.append(secQues2)
        return secQuesList
    }
}
    
struct SecurityQuestion {
    var index: String!
    var questionMyan: String!
    var questionEng: String!
    var answerEng: String?
}


