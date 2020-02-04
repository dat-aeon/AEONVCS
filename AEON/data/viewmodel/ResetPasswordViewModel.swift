//
//  ResetPasswordViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class ResetPasswordViewModel{
    
    func changePassword(resetRequest:ResetPasswordRequest,success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        ResetPasswordModel.init().makeResetPassword(resetPasswordRequest: resetRequest, success: { (result) in
            
            success(result)
                
        }) { (error) in
            failure(error)
        }
    }
    
    func forceChangePassword(forceRequest:ForceChangePasswordRequest,success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        ResetPasswordModel.init().makeForceChangePassword(forcePasswordRequest: forceRequest, success: { (result) in
            
            success(result)
            
        }) { (error) in
            failure(error)
        }
    }
}
