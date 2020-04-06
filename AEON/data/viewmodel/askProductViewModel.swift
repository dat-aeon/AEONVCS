//
//  askProductModel.swift
//  AEONVCS
//
//  Created by Ant on 06/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation


 func askProductSync(customerId:Int, success: @escaping (askProductResponse) -> Void,failure: @escaping (String) -> Void){
    
    askProductModel.init().askProductSync(customerId: customerId, success: { (result) in
        if result.status == Constants.STATUS_200 {
            success(result)
        }else{
            failure(result.status)
        }
        
    })
//    askProductModel.init().askProductSync(phoneNo: phoneNo, success: { (result) in
//
//            if result.status == Constants.STATUS_200 {
//                success(result)
//
//            } else {
//                failure(result.status)
//            }
//
//        }) { (error) in
//
//
//
//                        RoomSyncModel.init().makeroomSync(phoneNo: phoneNo,success: { (result) in
//
//                            if result.status == Constants.STATUS_200 {
//                                success(result)
//
//                            } else {
//                                failure(result.status)
//                            }
//
//                        }) { (error) in
//                            failure(error)
//                        }
//
//        }
    }
