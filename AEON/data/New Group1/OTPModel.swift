//
//  OTPViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OTPModel:BaseModel {
    
    func sendOTP(siteActivationKey:String, phoneNo:String,success: @escaping (OTPResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            //"siteActivationKey": siteActivationKey,
            "phoneNo" : phoneNo
        ]
        let _ = super.requestPOSTWithoutToken(endPoint: ApiServiceEndPoint.otpRequest, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let otpResponse = try? JSONDecoder().decode(OTPResponse.self, from: responseValue){
                    success(otpResponse)
                }else{
                    failure(Constants.JSON_FAILURE)
                }
            case .failure(let error):
                print("OTP send error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
}
