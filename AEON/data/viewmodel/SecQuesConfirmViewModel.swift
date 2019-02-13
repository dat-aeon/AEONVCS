//
//  SecQuesConfirmViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/12/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class SecQuesConfirmViewModel{
    
    var secQuesBeanList = [SecQuesListBean]()
    
    var secQuesResult = [[String]]()
    
    func getSelectedQuesList(siteActivationKey: String, success: @escaping (UserSecQuesResponse) -> Void,failure: @escaping (String) -> Void){
        SecQuesConfirmModel.init().getQuestionList(siteActivationKey: siteActivationKey, success: { (result) in
            
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    func makeConfirm(userConfirmBean: UserSecQuesConfirmBean, success: @escaping (UserSecQuesResponse) -> Void,failure: @escaping (String) -> Void){
        var userConfirmRequest = UserSecQuesConfirmRequest()
        userConfirmRequest.nrcData = userConfirmBean.nrcData
        userConfirmRequest.phoneNo = userConfirmBean.phoneNo
        //var userQARequest = UserQABeanRequest()
        var userQARequestList = [UserQABeanRequest]()
        for userQABean in userConfirmBean.quesAnsBean! {
            var userQARequest = UserQABeanRequest()
            userQARequest.secQuesId = userQABean.secQuesId
            userQARequest.question = userQABean.question
            userQARequest.answer = userQABean.answer
            userQARequestList.append(userQARequest)
        
        }
        userConfirmRequest.quesAnsBean = userQARequestList
        
        SecQuesConfirmModel.init().makeConfirm(userConfirmRequest: userConfirmRequest, success: { (result) in
            
            success(result)
        }) { (error) in
            failure(error)
        }
    }
}
