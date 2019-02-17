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
            success(result)
            
        }) { (error) in
            failure(error)
        }
    }
}
