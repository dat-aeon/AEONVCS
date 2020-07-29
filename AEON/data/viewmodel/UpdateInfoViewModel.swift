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
    func loadUserQAList(customerId:String, token: String, refreshToken: String,success:@escaping (UserQAResponse) -> Void,failure: @escaping (String) -> Void){
        UpdateInfoModel.init().loadUserQAListRequest(customerId: customerId, token: token, success: { (result) in
            
            if result.status == Constants.STATUS_200 {
                success(result)
                
            } else {
            failure(Constants.SERVER_INTERNAL_FAILURE)
            }
            
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
                        
                        UpdateInfoModel.init().loadUserQAListRequest(customerId: customerId, token: result.data.access_token!, success: { (result) in
                            
                            if result.status == Constants.STATUS_200 {
                                success(result)
                            } else {
                                failure(Constants.SERVER_INTERNAL_FAILURE)
                            }
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
    
    //UPDATE USER QA LIST
    func updateUserQAList(updateUserQABean : UpdateUserBean, token:String, refreshToken:String, success:@escaping (String) -> Void,failure: @escaping (String) -> Void){
        
        var updateUserBeanRequest = UpdateUserQARequest()
        updateUserBeanRequest.customerId = updateUserQABean.customerId
        updateUserBeanRequest.password = updateUserQABean.password
        
        var userQARequestList = [SecurityQAUpdateInfo]()
        for userQABean in updateUserQABean.securityQAUpdateInfo {
            var userQARequest = SecurityQAUpdateInfo()
            userQARequest.secQuesId = userQABean.secQuesId
            //userQARequest.custSecQuesId = userQABean.custSecQuesId
            userQARequest.answer = userQABean.answer
            userQARequestList.append(userQARequest)
        }
        updateUserBeanRequest.securityQAUpdateInfo = userQARequestList
        UpdateInfoModel.init().updateUserQAListRequest(updateUserBeanRequest: updateUserBeanRequest, token: token, success: { (result) in
            
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
                        
                        UpdateInfoModel.init().updateUserQAListRequest(updateUserBeanRequest: updateUserBeanRequest, token: token.accessToken!, success: { (result) in
                            
                            success(result)
                            
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
}
