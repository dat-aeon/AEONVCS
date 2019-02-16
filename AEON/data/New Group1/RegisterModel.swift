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
    
    func loadNRCData(success: @escaping ([String]) -> Void,failure: @escaping (String) -> Void) {
        let rawData = ["siteActivationKey":"12345678"]
        
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.nrcList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                if let resultDictionary = result as? Dictionary<String,String>{
                    let townships = Array(resultDictionary.values.map{ $0 })
                    success(townships)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
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
        
//        var memberData = CheckMemberResponse()
//        let message = "MEMBER"
//        var dataBean = MemberDataBean()
//        dataBean.age = 16
//        dataBean.companyName = "DAT"
//        dataBean.customerNo = "12334-123456-09"
//        dataBean.dateOfBirth = "6-1-1993"
//        dataBean.gender = 0
//        dataBean.name = "Jue"
//        dataBean.nrcNo = "12/LALALA(N)123456"
//        dataBean.phoneNo = "0912345678"
//        dataBean.salary = "100000"
//        dataBean.status = "1"
//        dataBean.townshipAddress = "Yangon"
//
//        var agreementList: CustAgreementListResDao? = nil
//        agreementList?.agreementNo = "1234-123456-00"
//        agreementList?.agreementStatus = "1"
//        agreementList?.custAgreementId = 1
//        agreementList?.importCustomerId = 1
//        dataBean.custAgreementListResDaoList = [agreementList] as? [CustAgreementListResDao]
//
//        memberData?.message = message
//        memberData?.memberDataBean = dataBean
//        print("\(memberData)")
//        success(memberData)
//
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.checkMember, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let checkMemberResponse = try? JSONDecoder().decode(CheckMemberResponse.self, from: responseValue){
                    success(checkMemberResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
    
    func checkVerifiedUserInfo(verifyUserInfo: CheckVerifyUserInfoRequest,success: @escaping (CheckVerifyUserInfoResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "agreementNo": verifyUserInfo.agreementNo,
            "dateOfBirth": verifyUserInfo.dateOfBirth,
            "nrcNo": verifyUserInfo.nrcNo,
            "customerId":verifyUserInfo.customerId
        ]
        
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.checkRegisterVerifyNewMember, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let checkMemberResponse = try? JSONDecoder().decode(CheckVerifyUserInfoResponse.self, from: responseValue){
                    success(checkMemberResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
    func registerNew(rawData:Data,success: @escaping (NewRegisterResponse) -> Void,failure: @escaping (String) -> Void){
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.registerNew, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let registerResponse = try? JSONDecoder().decode(NewRegisterResponse.self, from: responseValue){
//                    if let agreementNoValue = try? responseJsonData["custAgreementListDtoList"] {
//                        if let noList = try? agreementNoValue.encode(to: [CustomerAgreementData] as! Encoder.self) {
//                            registerResponse.setAgreementNoList(list: noList)
//                        } else {
//                            registerResponse.setAgreementNoList(list: [])
//                        }
//
//                    } else {
//                        registerResponse.setAgreementNoList(list: [])
//                    }
                    success(registerResponse)
                }else{
                    failure("Json Serialization Error")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func registerExisted(rawData:String, imageData: Data,success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        let _ = super.performRequestWithImage(endPoint: ApiServiceEndPoint.registerExisted, imageData:imageData , rawData: rawData) { (response) in
            switch response {
            case .success(let upload, _, _):                                    upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            
            upload.responseJSON { response in
                let api = response.result.value
                if let result = api {
//                    let json = JSON(result)
//                    if json["code"].int ?? 0 == 200 {
//                        self.ivProfile.sd_setImage(with: URL(string: json["data"].string!), placeholderImage: UIImage(named: "profile-placeholder"))
//                        print(json["data"].string!)
//
//                    } else {
//
//                    }
                    let responseJsonData = JSON(result)
                    let responseValue  = try! responseJsonData.rawData()
                    if let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: responseValue){
                        success(registerResponse)
                    }else{
                        failure("Cannot serialize data")
                    }
                } else {
                    print(api)
                    failure("Cannot Register")
                }
                
            }
            
                break
                
            case .failure(let error):
                print(error)
                failure(error.localizedDescription)
                break
                
            }
        }
    }
}
