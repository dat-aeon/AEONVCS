//
//  CheckPasswordViewModel.swift
//  AEONVCS
//
//  Created by mac on 9/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

class CheckPasswordViewModel {
    //CHECK VERIFY USER INFO
    func checkPasswordvm(verifyUserRequest: CheckPasswordRequest,token: String,refreshToken: String, success: @escaping (CheckPasswordResponse) -> Void, failure: @escaping (String) -> Void){
        
        CheckPasswordModel.init().checkPassword(userIdInfo: verifyUserRequest, token: token
            , success: { (result) in
                
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
                        
                        CheckPasswordModel.init().checkPassword(userIdInfo: verifyUserRequest, token: token.accessToken!
                            , success: { (result) in
                                
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
