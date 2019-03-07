//
//  UpdateInfoViewModel.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/16/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class UpdateInfoViewModel{
    
    //LOAD USER QA LIST
    func loadUserQAList(customerId:String,success:@escaping ([UserQAList]) -> Void,failure: @escaping (String) -> Void){
        UpdateInfoModel.init().loadUserQAListRequest(customerId: customerId, success: { (result) in
            if result.statusCode == "200" {
                success(result.secQAUpdateInfoResDtoList)
            } else {
            failure(result.statusMessage)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    
    //UPDATE USER QA LIST
    func updateUserQAList(updateUserQABean : UpdateUserBean ,success:@escaping (UpdateUserQAResponse) -> Void,failure: @escaping (String) -> Void){
        
        var updateUserBeanRequest = UpdateUserQARequest()
        updateUserBeanRequest.customerId = updateUserQABean.customerId
        updateUserBeanRequest.password = updateUserQABean.password
        
        var userQARequestList = [SecurityQAUpdateInfo]()
        for userQABean in updateUserQABean.securityQAUpdateInfo {
            var userQARequest = SecurityQAUpdateInfo()
            userQARequest.secQuesId = userQABean.secQuesId
            userQARequest.custSecQuesId = userQABean.custSecQuesId
            userQARequest.answer = userQABean.answer
            userQARequestList.append(userQARequest)
        }
        updateUserBeanRequest.securityQAUpdateInfo = userQARequestList
        UpdateInfoModel.init().updateUserQAListRequest(updateUserBeanRequest: updateUserBeanRequest, success: { (result) in
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
