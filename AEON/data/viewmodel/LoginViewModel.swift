//
//  LoginViewModel.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class LoginViewModel{
    
    func login(phoneNo:String,password:String,success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        LoginModel.init().makeLogin(phoneNo: phoneNo, password: password, success: { (result) in
           
            if result.statusCode == 200 {
                success(result)
            } else {
                failure(result.statusMessage)
            }
            
        }) { (error) in
            failure(error)
        }
    }
}
