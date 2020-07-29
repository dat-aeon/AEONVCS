//
//  NewVersionViewModel.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 4/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class NewVersionViewModel{
    
    func getVersionData(newVersion:String,success: @escaping (NewVersionResponse) -> Void,failure: @escaping (String) -> Void){
        NewVersionModel.init().getVersionInfo(newVersion: newVersion, success: { (result) in
            
            if result.status == Constants.STATUS_500 {
                failure(result.messageCode ?? Constants.STATUS_500)
            }
            success(result)
            
        }) { (error) in
            failure(error)
        }
    }
}
