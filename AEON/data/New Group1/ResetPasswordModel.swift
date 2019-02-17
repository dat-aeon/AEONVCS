//
//  ResetPasswordModel.swift
//  AEONVCS
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResetPasswordModel: BaseModel {
    
    func makeResetPassword(resetPasswordRequest: ResetPasswordRequest ,success: @escaping (ResetPasswordResponse) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = [
            "customerId" : "\(resetPasswordRequest.customerId)",
            "userTypeId" : "\(resetPasswordRequest.userTypeId)",
            "password" : resetPasswordRequest.password
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.changePassword, rawData: rawData ) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let resetResponse = try? JSONDecoder().decode(ResetPasswordResponse.self, from: responseValue){
                    success(resetResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
