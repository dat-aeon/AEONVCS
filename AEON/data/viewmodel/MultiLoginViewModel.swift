//
//  MultiLoginViewModel.swift
//  AEONVCS
//
//  Created by Ant on 07/05/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation

class MultiLoginViewModel {
    
    func multiLogin(customerId: String, loginDeviceId:String,success: @escaping (MultiLoginResponse) -> Void,failure: @escaping (String) -> Void){
        MultiLoginModel.init().makeMultiLogin(customerId: customerId, loginDeviceId: loginDeviceId, success: { (result) in
             if result.status == Constants.STATUS_200 {
                           success(result)
                           
                       } else {
                           failure(result.status)
                       }
            MultiLoginModel.init().makeMultiLogin(customerId: customerId, loginDeviceId: loginDeviceId, success: { (result) in
                        if result.status == Constants.STATUS_200 {
                                                      success(result)
                                                      
                                                  } else {
                                                      failure(result.status)
                                                  }
                    }) { (error) in
                        failure(error)
                    }
            
        }) { (error) in
            failure(error)
        }
    }
    
   

}
