//
//  OutletInfoViewModel.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 7/31/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class OutletInfoViewModel{
    
    func getOutletData(success: @escaping (OutletInfoResponse) -> Void,failure: @escaping (String) -> Void){
        OutletModel.init().getOutletList( success: { (result) in
            
            if result.status == Constants.STATUS_200 {
                success(result)
                
            }
            
        }) { (error) in
            failure(error)
        }
    }
}
