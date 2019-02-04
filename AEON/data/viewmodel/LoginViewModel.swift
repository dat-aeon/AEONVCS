//
//  LoginViewModel.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class LoginViewModel{
    
    func login(username:String,password:String,success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        LoginModel.init().makeLogin(username: username, password: password, success: { (result) in
            if result.dataBean.id != 0{
                success(result)
            }else{
                failure(result.message)
            }
        }) { (error) in
            failure(error)
        }
    }
}
