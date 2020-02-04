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
    
    func getSecQuestionList(siteActivationKey: String, success: @escaping (SECQuesListResponse) -> Void, failure: @escaping (String) ->Void){
        
        let rawData = [Constants.SITE_ACTIVATION_KEY: siteActivationKey]
        
        let _ = super.requestGETWithoutToken(endPoint: ApiServiceEndPoint.secQuesList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let response = result as AnyObject
                //print("seq ques list response : ", response)
                
                if response["status"] as! String == Constants.STATUS_200 {
                    let data = response["data"] as AnyObject
                    var secQuesListResponse = SECQuesListResponse()
                    secQuesListResponse.data = SecQuesListData()
                    secQuesListResponse.status = response["status"] as? String
                    secQuesListResponse.data?.numOfQuestion = data["numOfSecQues"] as? Int
                    secQuesListResponse.data?.numOfAnsCount = data["numOfAnsChar"] as? Int
                    
                    secQuesListResponse.data?.secQuesList = [SecQuesListBean]()
                    let secList = data["securityQuestionDtoList"] as! [AnyObject]
                    for sec in secList {
                        var secBean = SecQuesListBean()
                        //let agree:NSObject = agreeList as! NSObject
                        secBean.secQuestionId = sec.value(forKey: "secQuestionId") as? Int
                        secBean.questionEN = sec.value(forKey: "questionEN") as? String
                        secBean.questionMM = sec.value(forKey: "questionMM") as? String
                        
                        secQuesListResponse.data?.secQuesList?.append(secBean)
                    }
                    success(secQuesListResponse)
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
                
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let secQuesListResponse = try? JSONDecoder().decode(SecQuesListResponse.self, from: responseValue){
//                    success(secQuesListResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
            case .failure(let error):
                //print("SecQues Register error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
        
    }
//
//    func getSecQuesList() -> [SecurityQuestion] {
//        var secQuesList = [SecurityQuestion]()
//        let secQues1 = SecurityQuestion(index: "1",questionMyan: "What is your fav food? [Myan]", questionEng: "What is your fav food? [Eng]", answerEng: "Sandwich")
//        let secQues2 = SecurityQuestion(index: "2",questionMyan: "What is your fav color? [Myan]", questionEng: "What is your fav color? [Eng]", answerEng: "red")
//
//        secQuesList.append(secQues1)
//        secQuesList.append(secQues2)
//        return secQuesList
//    }
}
    
struct SecurityQuestion {
    var index: String!
    var questionMyan: String!
    var questionEng: String!
    var answerEng: String?
}


