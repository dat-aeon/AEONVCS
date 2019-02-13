//
//  RegisterViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class RegisterViewModel{
    
    func checkMember(registerBean: RegisterRequestBean, success: @escaping (CheckMemberResponse) -> Void, failure: @escaping (String) -> Void){
        
        RegisterModel.init().checkMemberData(registerReqBean: registerBean
            , success: { (result) in
                if result.message.isEmpty {
                    failure(result.message)
                }else{
                    success(result)
                }
        }) { (error) in
            failure(error)
        }
    }
    
    
    func register(username:String,dob:String,nrc:String,phoneno:String,password:String,success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        RegisterModel.init().makeRegister(username: username, dob: dob, nrc: nrc, phoneno: phoneno, password: password, success: { (result) in
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
