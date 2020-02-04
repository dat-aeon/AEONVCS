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
    
    func makeLogin(phoneNo:String,token:String, success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "phoneNo": phoneNo
        ]
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataWithToken(endPoint: ApiServiceEndPoint.login, rawData: rawData, token: token) { (result) in
            
            //print("Login Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                if Constants.STATUS_200 == response["status"] as? String {
                    let data = response["data"] as AnyObject
                    var loginResponse = LoginResponse()
                    if (data["customerNo"]) != nil {
                        loginResponse.data.customerNo = data["customerNo"] as? String
                        loginResponse.data.photoPath = data["photoPath"] as? String
                        loginResponse.data.customerAgreementDtoList = [CustomerAgreementDtoList]()
                        if let agreeList = data["customerAgreementDtoList"] as? [AnyObject] {
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
                    loginResponse.data.customerId = data["customerId"] as? Int
                    loginResponse.data.customerTypeId = data["customerTypeId"] as? Int
                    loginResponse.data.dateOfBirth = data["dateOfBirth"] as? String
                    loginResponse.data.name = data["name"] as? String
                    loginResponse.data.nrcNo = data["nrcNo"] as? String
                    loginResponse.data.phoneNo = data["phoneNo"] as? String
                    loginResponse.data.userTypeId = data["userTypeId"] as? Int
                    loginResponse.data.memberNo = data["memberNo"] as? String
                    loginResponse.status = response["status"] as! String
                    
                    success(loginResponse)
                    
                } else if Constants.STATUS_500 == response["status"] as? String {
                    failure(response["message"] as! String)
                    
                } else if Constants.EXPIRE_TOKEN == response["error"] as? String {
                    failure(response["error"] as! String)
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
           
            case .failure(let error):
                //print("Login error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
            
        }
        
    }
    
    
}
