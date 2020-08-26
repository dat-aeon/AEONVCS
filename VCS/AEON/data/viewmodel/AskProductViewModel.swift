//
//  askProductModel.swift
//  AEONVCS
//
//  Created by Ant on 06/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation

class AskProductViewModel {
    func askProductSync(customerId:Int, success: @escaping (contactUsResponse) -> Void,failure: @escaping (String) -> Void){
        
        contactUsModel.init().contactUsMessage(customerId: customerId, success: { (result) in
            if result.status == Constants.STATUS_200 {
                success(result)
            }else{
                failure(result.status)
            }
        }) { (error) in
            contactUsModel.init().contactUsMessage(customerId: customerId, success: { (result) in
                if result.status == Constants.STATUS_200 {
                    success(result)
                }else{
                    failure(result.status)
                }
            }) { (error) in
                failure(error)
                
            }
            
        }
   
        }

}
 
