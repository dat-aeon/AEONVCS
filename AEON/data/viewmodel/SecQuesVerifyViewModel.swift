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
    
    func makeVerify(userConfirmBean: UserSecQuesVerifyBean, success: @escaping (UserQAVerifyResponse) -> Void,failure: @escaping (String) -> Void){
        
        var userConfirmRequest = UserSecQuesVerifyRequest()
        userConfirmRequest.customerId = userConfirmBean.customerId
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
        
        SecQuesVerifyModel.init().verifyUserQAList(userVerifyBeanRequest: userConfirmRequest, success: { (result) in
            
            if result.statusCode == "200" {
                success(result)
            } else {
                failure(result.statusMessage)
            }
        }) { (error) in
            failure(error)
        }
    }
}
