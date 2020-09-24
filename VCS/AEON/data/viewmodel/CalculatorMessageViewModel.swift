//
//  CalculatorMessageViewModel.swift
//  AEONVCS
//
//  Created by Ant on 24/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation

class CalculatorMessageViewModel {
    
    func CalculatorMessageSync( success: @escaping (CalculatorMessageResponse) -> Void,failure: @escaping (String) -> Void){
        CalculatorMessageModel.init().CalculatorMessageSync( success: { (result) in
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
