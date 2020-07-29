//
//  AutoReplyMessageViewModel.swift
//  AEONVCS
//
//  Created by Ant on 27/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation

class AutoReplyMessageViewModel {
    
    func AutoReplyMessageSync( success: @escaping (AutoReplyMessageResponse) -> Void,failure: @escaping (String) -> Void){
        AutoReplyMessageModel.init().AutoReplyMessageSync( success: { (result) in
            if result.status == Constants.STATUS_200 {
                            success(result)
            
                        } else {
                            failure(result.status)
                        }
        }) { (error) in
            failure(error)
        }

    }
    
    
}
