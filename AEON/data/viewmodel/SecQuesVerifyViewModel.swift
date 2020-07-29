//
//  SecQuesVerifyViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/19/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class SecQuesVerifyViewModel{
    
    var secQuesBeanList = [SecQuesListBean]()
    
    var secQuesResult = [[String]]()
    
    func makeVerify(userConfirmBean: UserSecQuesVerifyBean,phoneNo:String, token:String, refreshToken:String, success: @escaping (UserQAVerifyResponse) -> Void,failure: @escaping (String) -> Void){
        
        var userConfirmRequest = UserSecQuesVerifyRequest()
        userConfirmRequest.customerId = Int(userConfirmBean.customerId)!
        //var userQARequest = UserQABeanRequest()
        var userQARequestList = [UserQAVerifyList]()
        for userQABean in userConfirmBean.quesAnsBean {
            var userQARequest = UserQAVerifyList()
            userQARequest.secQuesId = userQABean.secQuesId
            userQARequest.question = userQABean.question
            userQARequest.answer = userQABean.answer
            userQARequestList.append(userQARequest)

        }
        userConfirmRequest.secQuesList  = userQARequestList
        
        SecQuesVerifyModel.init().verifyUserQAList(userVerifyBeanRequest: userConfirmRequest, token: token, success: { (result) in
            
            success(result)
            
        }) { (error) in
            
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: refreshToken, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        SecQuesVerifyModel.init().verifyUserQAList(userVerifyBeanRequest: userConfirmRequest, token: token.accessToken!, success: { (result) in
                            
                            success(result)
                            
                        }) { (error) in
                            failure(error)
                        }
                        
                    } else {
                        failure(result.status ?? "FAILED")
                    }
                    
                }) { (error) in
                    failure(error)
                }
            }
            failure(error)
        }
    }
}
