//
//  HotlineViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class HotlineViewModel{
    
    func getHotlineData(siteActivationKey:String,success: @escaping (HotlineResponse) -> Void,failure: @escaping (String) -> Void){
        HotlineModel.init().getHotlineNo(siteActivationKey: siteActivationKey, success: { (result) in
            
            if result.status == Constants.STATUS_200 {
                success(result)
            } else {
                failure(Constants.SERVER_INTERNAL_FAILURE)
            }
        }) { (error) in
            failure(error)
        }
    }
}
