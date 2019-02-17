//
//  ResetPasswordViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class ResetPasswordViewModel{
    
    func changePassword(resetRequest:ResetPasswordRequest,success: @escaping (ResetPasswordResponse) -> Void,failure: @escaping (String) -> Void){
        ResetPasswordModel.init().makeResetPassword(resetPasswordRequest: resetRequest, success: { (result) in
            if result.statusCode == "200" {
                success(result)
            } else {
                failure(result.statusMessage!)
            }
            success(result)
            
        }) { (error) in
            failure(error)
        }
    }
}
