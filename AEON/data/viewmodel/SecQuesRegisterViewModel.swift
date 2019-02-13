//
//  SecQuesRegisterViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class SecQuesRegisterViewModel{
    
    var secQuesBeanList = [SecQuesListBean]()
    
    var secQuesResult = [[String]]()
    
    func getSecQuesList(siteActivationKey: String, success: @escaping (SecQuesRegisterBean) -> Void,failure: @escaping (String) -> Void){
        SecQuesRegisterModel.init().getSecQuestionList(siteActivationKey: siteActivationKey, success: { (result) in
           
            var secQuesListMM = [String]()
            var secQuesListEN = [String]()
            self.secQuesBeanList = result.dataBean
            
            for dataBean in self.secQuesBeanList {
                secQuesListMM.append(dataBean.questionMM)
                secQuesListEN.append(dataBean.questionEN)
            }
            
            self.secQuesResult.append(secQuesListMM)
            self.secQuesResult.append(secQuesListEN)
            
            let secQuesRegisterBean = SecQuesRegisterBean(numOfQuestion: result.numOfQuestion, numOfAnsCount: result.numOfAnsCount, questionList: self.secQuesResult)
            success(secQuesRegisterBean)
        }) { (error) in
            failure(error)
        }
    }
    
    func register(username:String,dob:String,nrc:String,phoneno:String,password:String,success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        RegisterModel.init().makeRegister(username: username, dob: dob, nrc: nrc, phoneno: phoneno, password: password, success: { (result) in
            if result.dataBean.id != 0{
                success(result)
            }else{
                failure(result.message)
            }
        }) { (error) in
            failure(error)
        }
    }
}
