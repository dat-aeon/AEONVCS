//
//  SecQuesRegisterViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class SecQuesRegisterViewModel{
    var questionList = [[String]]()
    
    func getSecQuesList(siteActivationKey: String, success: @escaping (SecQuesRegisterBean) -> Void,failure: @escaping (String) -> Void){
        SecQuesRegisterModel.init().getSecQuestionList(siteActivationKey: siteActivationKey, success: { (result) in
           
            if result.status == Constants.STATUS_200 {
                var secQuesListMM = [String]()
                var secQuesListEN = [String]()
                
                for dataBean in (result.data?.secQuesList)! {
                    secQuesListMM.append(dataBean.questionMM!)
                    secQuesListEN.append(dataBean.questionEN!)
                }
                
                self.questionList.append(secQuesListMM)
                self.questionList.append(secQuesListEN)
                
                let secQuesRegisterBean = SecQuesRegisterBean(numOfQuestion: (result.data?.numOfQuestion)!, numOfAnsCount: (result.data?.numOfAnsCount)!, questionList: self.questionList,secQuesList: (result.data?.secQuesList)!)
                success(secQuesRegisterBean)
            
            } else {
                failure(Constants.SERVER_INTERNAL_FAILURE)
            }
        }) { (error) in
            failure(error)
        }
    }
    
//    func register(username:String,dob:String,nrc:String,phoneno:String,password:String,success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
//        RegisterModel.init().makeRegister(username: username, dob: dob, nrc: nrc, phoneno: phoneno, password: password, success: { (result) in
//            if result.dataBean.id != 0{
//                success(result)
//            }else{
//                failure(result.message)
//            }
//        }) { (error) in
//            failure(error)
//        }
//    }
}
