//
//  LoginAuthViewModel.swift
//  AEONVCS
//
//  Created by mac on 5/13/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class LoginAuthViewModel {
    
    func accessLoginToken(phoneNo:String,loginDeviceId:String,password:String,success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        LoginAuthModel.init().getAccessToken(phoneNo: phoneNo, loginDeviceId: loginDeviceId, password: password, success: { (result) in
            
            success(result)
            
        }) { (error) in
            failure(error)
        }
    }
}
