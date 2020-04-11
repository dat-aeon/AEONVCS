//
//  LevelTwoMessageUnreadViewModel.swift
//  AEONVCS
//
//  Created by Ant on 07/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
class LevelTwoMessageUnreadViewModel {
    func levelTwoUnreadMessageSync(customerId:Int, success: @escaping (levelTwoMessageUnReadResponse) -> Void,failure: @escaping (String) -> Void){
        
        LevelTwoMessageUnreadModel.init().levelTwoMessageUnreadSync(customerId: customerId, success: { (result) in
            if result.status == Constants.STATUS_200 {
                success(result)
            }else{
                failure(result.status)
            }
        }) { (error) in
            LevelTwoMessageUnreadModel.init().levelTwoMessageUnreadSync(customerId: customerId, success: { (result) in
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
 
