//
//  RoomSyncViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/11/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation

class RoomSyncViewModel {
    
    func roomSync(phoneNo:String, success: @escaping (RoomSyncResponse) -> Void,failure: @escaping (String) -> Void){
        RoomSyncModel.init().makeroomSync(phoneNo: phoneNo, success: { (result) in
           
            if result.status == Constants.STATUS_200 {
                success(result)
                
            } else {
                failure(result.status)
            }
            
        }) { (error) in
            
//            if error == Constants.EXPIRE_TOKEN {
//                LoginAuthModel.init().refereshToken(refreshToken: refreshToken, success: { (result) in
//
//                    if result.status == Constants.STATUS_200 {
//                        var token = TokenBean()
//                        token.accessToken = result.data.access_token
//                        token.refreshToken = result.data.refresh_token
//                        token.tokenType = result.data.token_type
//                        token.scope = result.data.scope
//                        token.expireIn = result.data.expire_in
//
//                        let jsonData = try? JSONEncoder().encode(result)
//                        let jsonString = String(data: jsonData!, encoding: .utf8)!
//                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        RoomSyncModel.init().makeroomSync(phoneNo: phoneNo,success: { (result) in
                            
                            if result.status == Constants.STATUS_200 {
                                success(result)
                                
                            } else {
                                failure(result.status)
                            }
                            
                        }) { (error) in
                            failure(error)
                        }
                        
//                    } else {
//                        failure(result.status ?? "FAILED")
//                    }
                    
//                }) { (error) in
//                    failure(error)
//                }
//            }
//            failure(error)
        }
    }
    
    
}
