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
    
    func checkMemberData(registerReqBean: RegisterRequestBean,success: @escaping (CheckMemberResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "userName": registerReqBean.name,
            "dob": registerReqBean.dob,
            "nrc": registerReqBean.nrc,
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
    
    func makeRegister(username:String,dob:String,nrc:String,phoneno:String,password:String,success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "userName": username,
            "dob": dob,
            "nrc": nrc,
            "phoneNo": phoneno,
            "password": password
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.register, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: responseValue){
                    success(registerResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
}
