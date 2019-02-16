//
//  UpdateInfoViewModel.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/16/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class UpdateInfoViewModel{
    
    //LOAD USER QA LIST
    func loadUserQAList(success:@escaping ([UserQAResponse]) -> Void,failure: @escaping (String) -> Void){
        let customerId = ""
        UpdateInfoModel.init().loadUserQAList(customerId: customerId, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    
    //UPDATE USER QA LIST
    func updateUserQAList(success:@escaping (UpdateUserQAResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = Data()
        UpdateInfoModel.init().updateUserQAList(rawData: rawData, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
}
