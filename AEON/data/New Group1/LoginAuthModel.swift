//
//  LoginAuthModel.swift
//  AEONVCS
//
//  Created by mac on 5/13/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginAuthModel:BaseModel {
    
    func getAccessToken(phoneNo:String,loginDeviceId:String,password:String,success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "username": phoneNo,
            "password": password,
            "grant_type": "password",
            "login_device_id": loginDeviceId
        ]
        let _ = super.requestToken(endPoint: ApiServiceEndPoint.authenticate, rawData: rawData) { (result) in
            
            //print("Login Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                let response = result as AnyObject
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                //print("Login Response JSON :::::::::::\(responseJsonData)")
                
                if let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: responseValue){
                    
                    let jsonData = try? JSONEncoder().encode(tokenResponse.data)
                    let jsonString = String(data: jsonData!, encoding: .utf8)!
                    UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                    
                    let data = response["data"] as AnyObject
                    let userInfo = data["userInformationResDto"] as AnyObject
                    
                    var loginResponse = LoginResponse()
                    if (data["customerNo"]) != nil {
                        loginResponse.data.customerNo = userInfo["customerNo"] as? String
                        loginResponse.data.photoPath = userInfo["photoPath"] as? String
                        loginResponse.data.customerAgreementDtoList = [CustomerAgreementDtoList]()
                        if let agreeList = userInfo["customerAgreementDtoList"] as? [AnyObject] {
                            for agree in agreeList {
                                var cust = CustomerAgreementDtoList()
                                //let agree:NSObject = agreeList as! NSObject
                                cust.agreementNo = agree.value(forKey: "agreementNo") as? String
                                cust.custAgreementId = agree.value(forKey: "custAgreementId") as? Int
                                cust.financialAmt = agree.value(forKey: "financialAmt") as? Int
                                cust.financialStatus = agree.value(forKey: "financialStatus") as? Int
                                cust.financialTerm = agree.value(forKey: "financialTerm") as? Int
                                cust.importCustomerId = agree.value(forKey: "importCustomerId") as? Int
                                cust.qrShow = agree.value(forKey: "qrShow") as? Int
                                loginResponse.data.customerAgreementDtoList?.append(cust)
                            }
                        }
                    } else {
                        loginResponse.data.customerNo = Constants.BLANK
                        loginResponse.data.photoPath = Constants.BLANK
                        loginResponse.data.customerAgreementDtoList = [CustomerAgreementDtoList]()
                    }
                    loginResponse.data.customerId = userInfo["customerId"] as? Int
                    loginResponse.data.customerTypeId = userInfo["customerTypeId"] as? Int
                    loginResponse.data.dateOfBirth = userInfo["dateOfBirth"] as? String
                    loginResponse.data.name = userInfo["name"] as? String
                    loginResponse.data.nrcNo = userInfo["nrcNo"] as? String
                    loginResponse.data.phoneNo = userInfo["phoneNo"] as? String
                    loginResponse.data.userTypeId = userInfo["userTypeId"] as? Int
                    loginResponse.data.memberNo = userInfo["memberNo"] as? String
                    loginResponse.data.memberNoValid = userInfo["memberNoValid"] as? Bool
                    if loginResponse.data.memberNo != nil && loginResponse.data.memberNo != Constants.BLANK {
                        loginResponse.data.memberNo?.insert(separator: "-", every: 4)
                    }
                    loginResponse.data.hotlinePhone = userInfo["hotlinePhone"] as? String
                    loginResponse.status = response["status"] as! String
                    
                    success(loginResponse)
                    
                }else if let badCredential = try? JSONDecoder().decode(BadCredentialResponse.self, from: responseValue){
                    

                    if "\(badCredential.messageCode ?? "")" == Constants.ACCOUNT_LOCK {
                        failure(Constants.ACCOUNT_LOCK)
                    } else {
                        failure(Messages.BAD_CREDENTIAL_ERROR.localized)
                    }
                }else {
                    failure(Constants.JSON_FAILURE)
                }

            case .failure(let error):
                print("Login error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func refereshToken(refreshToken:String,success: @escaping (TokenResponse) -> Void,failure: @escaping (String) -> Void){
        
        
        let rawData = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        let _ = super.requestToken(endPoint: ApiServiceEndPoint.authenticate, rawData: rawData) { (result) in
            
            //print("Login Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                print("Refresh Token :::::::::::\(responseJsonData)")
                
                if let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: responseValue){
                    success(tokenResponse)
                    
                }else if let _ = try? JSONDecoder().decode(BadCredentialResponse.self, from: responseValue){
                    failure(Messages.BAD_CREDENTIAL_ERROR.localized)
                }else {
                    failure(Constants.JSON_FAILURE)
                }
                
            case .failure(let error):
                print("Refresh error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
}
