//
//  AppLockViewModel.swift
//  AEONVCS
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class AppLockCheckViewModel {
    func checkAppLock(phoneNo:String, nrcNo:String, success: @escaping (AppLockResponse) -> Void,failure: @escaping (String) -> Void){
        AppLockCheckModel.init().getAppLockStatus(phoneNo: phoneNo, nrcNo: nrcNo, success: { (result) in
            
            success(result)
            
        }) { (error) in
            failure(error)
        }
    }
}
