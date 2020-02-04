//
//  RegisterModel.swift
//  AEONVCS
//
//  Created by mac on 2/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class RegisterModel:BaseModel {
    
    func loadNRCData(siteActivationKey: String,success: @escaping ([[String]]) -> Void,failure: @escaping (String) -> Void) {
        let rawData = ["siteActivationKey":siteActivationKey]
        
        let _ = super.requestGETWithoutToken(endPoint: ApiServiceEndPoint.nrcList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):

                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let nrcResponse = try? JSONDecoder().decode(NRCResponse.self, from: responseValue){
                    //success(checkMemberResponse)
                    var townshipList = [[String]]()
                    for data in nrcResponse.data {
                        townshipList.append(data.townshipCodeList)
                        print("\(townshipList.count)", data.townshipCodeList)
                    }
                    success(townshipList)
                }else{
                    failure(Constants.JSON_FAILURE)
                }

            case .failure( _):
                //print("NRC error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
    func checkMemberData(registerReqBean: RegisterRequestBean,success: @escaping (CheckMemberResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "name": registerReqBean.name,
            "dateOfBirth": registerReqBean.dob,
            "nrcNo": registerReqBean.nrc,
            "phoneNo": registerReqBean.phoneNo,
            "password": registerReqBean.password
        ]
        
        let _ = super.requestPOSTWithoutToken(endPoint: ApiServiceEndPoint.checkMember, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("check member response : ", response)
                
                var checkResponse = CheckMemberResponse()
                checkResponse.data = MemberData()
                if response["status"] as! String == Constants.STATUS_200 {
                    checkResponse.status = response["status"] as? String
                    let data = response["data"] as AnyObject
                    if (data["memberStatus"] as? String == Constants.MEMBER) {
                        checkResponse.data?.memberStatus = data["memberStatus"] as? String
                        checkResponse.data?.memberPhoneNo = data["memberPhoneNo"] as? String
                        checkResponse.data?.hotlinePhone = data["hotlinePhone"] as? String
                        
                    } else {
                        checkResponse.data?.memberStatus = data["memberStatus"] as? String
                        checkResponse.data?.memberPhoneNo = Constants.BLANK
                        checkResponse.data?.hotlinePhone = Constants.BLANK
                    }
                    
                } else {
                    checkResponse.data?.messageCode = response["messageCode"] as? String
                    checkResponse.data?.message = response["message"] as? String
                }
                success(checkResponse)
                
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let checkMemberResponse = try? JSONDecoder().decode(CheckMemberResponse.self, from: responseValue){
//                    success(checkMemberResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
                
            case .failure(let error):
                print("Check Member error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
    
    func checkVerifiedUserInfo(verifyUserInfo: CheckVerifyUserInfoRequest, token: String,success: @escaping (CheckVerifyUserInfoResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "agreementNo": verifyUserInfo.agreementNo,
            "dateOfBirth": verifyUserInfo.dateOfBirth,
            "nrcNo": verifyUserInfo.nrcNo,
            "customerId" : verifyUserInfo.customerId
        ]
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataWithToken(endPoint: ApiServiceEndPoint.checkRegisterVerifyNewMember, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("register response : ", response)
                
                var verifyInfo = CheckVerifyUserInfoResponse()
                verifyInfo.data = VerifyData()
                let data = response["data"] as AnyObject
                
                if Constants.STATUS_200 == response["status"] as? String {
                    verifyInfo.status = response["status"] as? String
                    verifyInfo.data?.verifyStatus = data["verifyStatus"] as? String
                    verifyInfo.data?.customerNo = data["customerNo"] as? String
                    success (verifyInfo)
                    
                } else if Constants.STATUS_500 == response["status"] as? String {
                    verifyInfo.data?.verifyStatus = data["messageCode"] as? String
                    success (verifyInfo)
                    
                } else if Constants.STATUS_500 == response["error"] as? String {
                    failure(response["error"] as! String)
                    
                }else {
                    failure(Constants.JSON_FAILURE)
                }
                
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let checkMemberResponse = try? JSONDecoder().decode(CheckVerifyUserInfoResponse.self, from: responseValue){
//                    success(checkMemberResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
            case .failure(let error):
                //print("Verify User error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
    
    func registerNew(rawData:Data,success: @escaping (NewRegisterResponse) -> Void,failure: @escaping (String) -> Void){
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.registerNew, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("register response : ", response)
                
                if response["status"] as! String == Constants.STATUS_200 {
                    let data = response["data"] as AnyObject
                    var newRegister = NewRegisterResponse()
                    newRegister.data = NewRegisterData()
                    newRegister.status = response["status"] as? String
                    newRegister.data?.customerId = data["customerId"] as? Int
                    success (newRegister)
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
                
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let registerResponse = try? JSONDecoder().decode(NewRegisterResponse.self, from: responseValue){
//
//                    success(registerResponse)
//                    print("model", registerResponse )
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
            case .failure(let error):
                //print("Register New error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func registerExisted(rawData: Data,success: @escaping (NewRegisterResponse) -> Void,failure: @escaping (String) -> Void){
        
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.registerExisted, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("register response : ", response)
                
                if response["status"] as! String == Constants.STATUS_200 {
                    let data = response["data"] as AnyObject
                    var newRegister = NewRegisterResponse()
                    newRegister.data = NewRegisterData()
                    newRegister.status = response["status"] as? String
                    newRegister.data?.customerId = data["customerId"] as? Int
                    success (newRegister)
                    
                } else {
                    failure(Constants.SERVER_INTERNAL_FAILURE)
                }
            case .failure(let error):
                //print("Register New error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
//        let _ = super.performRequestWithImage(endPoint: ApiServiceEndPoint.registerExisted, imageData:imageData , rawData: rawData) { (response) in
//            switch response {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (progress) in
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            
//            upload.responseJSON { response in
//                let api = response.result.value
//                if let result = api {
//
//                    let responseJsonData = JSON(result)
//                    let responseValue  = try! responseJsonData.rawData()
//                    if let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: responseValue){
//                        print("success", registerResponse)
//                        success(registerResponse)
//                    }else{
//                        failure(Constants.JSON_FAILURE)
//                    }
//                } else {
//                    
//                    failure(Constants.SERVER_FAILURE)
//                }
//            }
//            break
//                
//            case .failure(let error):
//                print("Register Existed error",error)
//                failure(Constants.SERVER_FAILURE)
//                break
//                
//            }
//        }
    }
    
    //Verify Member Register
    func registerVerifyMember(rawData:Data,token:String, success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataObjWithToken(endPoint: ApiServiceEndPoint.registVerifyMember, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("verify register response : ", response)
                
                if Constants.STATUS_200 == response["status"] as? String {
                    let data = response["data"] as AnyObject
                    var loginResponse = LoginResponse()
                    if (data["customerNo"]) != nil {
                        loginResponse.data.customerNo = data["customerNo"] as? String
                        loginResponse.data.photoPath = data["photoPath"] as? String
                        loginResponse.data.memberNo = data["memberNo"] as? String
                        if loginResponse.data.memberNo != nil && loginResponse.data.memberNo != Constants.BLANK {
                            loginResponse.data.memberNo?.insert(separator: "-", every: 4)
                        }
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
                    loginResponse.data.hotlinePhone = data["hotlinePhone"] as? String
                    loginResponse.status = response["status"] as! String
                    loginResponse.data.memberNoValid = data["memberNoValid"] as? Bool
                    
                    success(loginResponse)
                    
                } else if Constants.STATUS_500 == response["status"] as? String {
                    failure(response["message"] as! String)
                    
                } else if Constants.EXPIRE_TOKEN == response["error"] as? String {
                    failure(response["error"] as! String)
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
            case .failure(let error):
                //print("Register New error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
//        let _ = super.performRequestWithImage(endPoint: ApiServiceEndPoint.registVerifyMember, imageData:imageData , rawData: rawData) { (response) in
//
//            print("Verify Member result::::: \(response)")
//            switch response {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (progress) in
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//
//            upload.responseJSON { response in
//                let api = response.result.value
//                if let result = api {
//
//                    let responseJsonData = JSON(result)
//                    let responseValue  = try! responseJsonData.rawData()
//                    if let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: responseValue){
//                        success(registerResponse)
//                    }else{
//                        failure(Constants.JSON_FAILURE)
//                    }
//                } else {
//                    print(api!)
//                    failure(Constants.SERVER_FAILURE)
//                }
//
//            }
//            break
//
//            case .failure(let error):
//                print("Register Verify Member error",error.localizedDescription)
//                failure(Constants.SERVER_FAILURE)
//                break
//
//            }
//        }
    }
}
