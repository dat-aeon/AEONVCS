//
//  LoginModel.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginModel:BaseModel {
    
    func makeLogin(phoneNo:String,password:String,success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "phoneNo": phoneNo,
            "password": password
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.login, rawData: rawData) { (result) in
            
            print("Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: responseValue){
                    success(loginResponse)
                }else{
                    failure("JSON can't decode")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
}
