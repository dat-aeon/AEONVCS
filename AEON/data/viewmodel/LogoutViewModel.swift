//
//  LogoutViewModel.swift
//  AEONVCS
//
//  Created by mac on 3/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class LogoutViewModel{
    
    func logout(customerId:String, loginTime:String, logoutTime:String,success: @escaping (LogoutResponse) -> Void,failure: @escaping (String) -> Void){
        LogoutModel.init().makeLogout(customerId: customerId,loginTime: logoutTime,logoutTime: logoutTime, success: { (result) in
            
            if result.statusCode == "200" {
                success(result)
            } else {
                failure(result.statusMessage ?? "Cannot Logout")
            }
            
        }) { (error) in
            failure(error)
        }
    }
}
