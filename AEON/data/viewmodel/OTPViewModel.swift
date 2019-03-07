//
//  OTPViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class OTPViewModel{
    
    func sendOTPRequest(siteActivationKey:String,phoneNo:String,success: @escaping (OTPResponse) -> Void,failure: @escaping (String) -> Void){
        OTPModel.init().sendOTP(siteActivationKey: siteActivationKey, phoneNo: phoneNo, success: { (result) in
            if result.statusCode == "200" {
                success(result)
            } else {
                failure(result.statusMessage)
            }
            
        }) { (error) in
            failure(error)
        }
    }
}
