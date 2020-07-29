//
//  LogoutViewModel.swift
//  AEONVCS
//
//  Created by mac on 3/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class LogoutViewModel{
    
    func logout(customerId:String, logoutTime:String,tokenInfo: TokenData, success: @escaping (LogoutResponse) -> Void,failure: @escaping (String) -> Void){
        LogoutModel.init().makeLogout(customerId: customerId, logoutTime: logoutTime,token: tokenInfo.access_token!, success: { (result) in
            
            success(result)
           
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
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
                        
                        LogoutModel.init().makeLogout(customerId: customerId, logoutTime: logoutTime,token: tokenInfo.access_token!, success: { (result) in
                            
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
    
    func offlineLogout(customerId:String, logoutTime:String,success: @escaping (LogoutResponse) -> Void,failure: @escaping (String) -> Void){
        LogoutModel.init().makeOfflineLogout(customerId: customerId, logoutTime: logoutTime, success: { (result) in
            
            success(result)
            
        }) { (error) in
            failure(error)
        }
    }
}
