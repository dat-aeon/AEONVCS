//
//  RegisterData.swift
//  AEONVCS
//
//  Created by mac on 2/8/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct RegisterRequestBean {
    var name: String = ""
    var dob: String = ""
    var nrc: String = ""
    var phoneNo: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}

//CHECK MEMBER RESPONSE
struct CheckMemberResponse : Codable {
    var statusCode:String? = ""
    var statusMessage:String? = ""
    var message: String = ""
    var memberDataBean: MemberDataBean? = nil
}

struct MemberDataBean : Codable {
    var importCustomerInfoId: Int = 0
    var customerNo: String = ""
    var name: String = ""
    var gender: Int = 0
    var phoneNo: String = ""
    var nrcNo: String = ""
    var dateOfBirth: String = ""
    var salary: String = ""
    var age: Int = 0
    var companyName: String = ""
    var townshipAddress: String = ""
    var status: String = ""
    var custAgreementListResDaoList :[CustAgreementListResDao]? = nil
    
    enum CodingKeys: String, CodingKey {
        case importCustomerInfoId = "importCustomerInfoId"
        case customerNo = "customerNo"
        case name = "name"
        case gender = "gender"
        case phoneNo = "phoneNo"
        case nrcNo = "nrcNo"
        case dateOfBirth = "dateOfBirth"
        case salary = "salary"
        case age = "age"
        case companyName = "companyName"
        case townshipAddress = "townshipAddress"
        case status = "status"
        case custAgreementListResDaoList = "custAgreementListResDaoList"
    }
}

struct CustAgreementListResDao : Codable {
    var custAgreementId:Int = 0
    var importCustomerId = 0
    var agreementNo:String = ""
    var agreementStatus:String = ""
    
    enum CodingKeys: String, CodingKey {
        case custAgreementId = "custAgreementId"
        case importCustomerId = "importCustomerId"
        case agreementNo = "agreementNo"
        case agreementStatus = "agreementStatus"
    }
}

//REGISTER RESPONSE
struct NewRegisterResponse: Codable {
    var statusCode:String? = ""
    var statusMessage:String? = ""
    var customerId:Int? = 0
    var customerNo:String? = ""
    var phoneNo:String? = ""
    var customerTypeId:Int? = 0
    var userTypeId:Int? = 0
    var name:String? = ""
    var dateOfBirth:String? = ""
    var nrcNo:String? = ""
    var status:String? = ""
    var photoPath:String? = ""
    var delFlag:Int? = 0
    var password:String? = ""
//    var custAgreementListDtoList:[CustomerAgreementData]?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case statusMessage
        case customerId
        case customerNo
        case phoneNo
        case customerTypeId
        case userTypeId
        case name
        case dateOfBirth
        case nrcNo
        case status
        case photoPath
        case delFlag
        case password
//        case custAgreementListDtoList
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        statusCode = try? values.decode(String.self, forKey: .statusCode)
//        statusMessage = try values.decode(String.self, forKey: .statusMessage)
//        customerId = try values.decode(String.self, forKey: .customerId)
//        customerNo = try values.decode(String.self, forKey: .customerNo)
//        phoneNo = try values.decode(String.self, forKey: .phoneNo)
//        customerTypeId = try values.decode(String.self, forKey: .customerTypeId)
//        userTypeId = try values.decode(String.self, forKey: .userTypeId)
//        name = try values.decode(String.self, forKey: .name)
//        dateOfBirth = try values.decode(String.self, forKey: .dateOfBirth)
//        nrcNo = try values.decode(String.self, forKey: .nrcNo)
//        status = try values.decode(String.self, forKey: .status)
//        photoPath = try values.decode(String.self, forKey: .photoPath)
//        delFlag = try values.decode(String.self, forKey: .delFlag)
//        password = try values.decode(String.self, forKey: .password)
////        if let _custAgreementListDtoList = try? values.decode([CustomerAgreementData].self, forKey: .custAgreementListDtoList) {
////            custAgreementListDtoList = _custAgreementListDtoList
////        } else {
////            custAgreementListDtoList = []
////        }
//    }
    
//    mutating func setAgreementNoList(list:[CustomerAgreementData]){
////        self.custAgreementListDtoList = list
//    }
}
struct RegisterResponse: Codable {
    var statusCode:String? = ""
    var statusMessage:String? = ""
    var customerId:String? = ""
    var customerNo:String? = ""
    var phoneNo:String? = ""
    var customerTypeId:String? = ""
    var userTypeId:String? = ""
    var name:String? = ""
    var dateOfBirth:String? = ""
    var nrcNo:String? = ""
    var status:String? = ""
    var photoPath:String? = ""
    var delFlag:String? = ""
    var password:String? = ""
    var custAgreementListDtoList:[CustomerAgreementData]? = [CustomerAgreementData]()
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case statusMessage
        case customerId
        case customerNo
        case phoneNo
        case customerTypeId
        case userTypeId
        case name
        case dateOfBirth
        case nrcNo
        case status
        case photoPath
        case delFlag
        case password
        case custAgreementListDtoList
    }
    init(customerId:String,customerNo:String,phoneNo:String,customerTypeId:String,userTypeId:String,name:String,dateOfBirth:String,nrcNo:String,status:String,photoPath:String) {
        self.customerId = customerId
        self.customerNo = customerNo
        self.phoneNo = phoneNo
        self.customerTypeId = customerTypeId
        self.userTypeId = userTypeId
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.nrcNo = nrcNo
        self.status = status
        self.photoPath = photoPath
    }
    
    mutating func mapFrom(customerId:String,customerNo:String,phoneNo:String,customerTypeId:String,userTypeId:String,name:String,dateOfBirth:String,nrcNo:String,status:String,photoPath:String)->RegisterResponse{
        self.customerId = customerId
        self.customerNo = customerNo
        self.phoneNo = phoneNo
        self.customerTypeId = customerTypeId
        self.userTypeId = userTypeId
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.nrcNo = nrcNo
        self.status = status
        self.photoPath = photoPath
        return self
    }
}

struct CustomerAgreementData:Codable{
    var custAgreementId:String
    var importCustomerId:String
    var agreementNo:String
    var agreementStatus:String
    enum CodingKeys: String, CodingKey{
        case custAgreementId
        case importCustomerId
        case agreementNo
        case agreementStatus
    }
}

//Member Register Request Param Data
struct RegisterExistedRequestData : Codable {
    var name:String
    var dateOfBirth:String
    var nrcNo:String
    var phoneNo:String
    var password:String
    var importCustomerId:Int
    var customerNo:String
    var photoPath:String
    var securityAnsweredInfoList:[SecQABean]
    var appUsageInfo:AppUsageInfoReqBean
     enum CodingKeys: String, CodingKey {
        case name
        case dateOfBirth
        case nrcNo
        case phoneNo
        case password
        case importCustomerId
        case customerNo
        case photoPath
        case securityAnsweredInfoList
        case appUsageInfo
        }
//    init(name:String,dateOfBirth:String,nrcNo:String,phoneNo:String,password:String,importCustomerId:Int,customerNo:String,photoPath:String,secQAList:[SecQABean],appUsageInfo:AppUsageInfoReqBean) {
//        self.name = name
//        self.dateOfBirth = dateOfBirth
//        self.nrcNo = nrcNo
//        self.phoneNo = phoneNo
//        self.password = password
//        self.importCustomerId = importCustomerId
//        self.customerNo = customerNo
//        self.photoPath = photoPath
//        self.securityAnsweredInfoList = secQAList
//        self.appUsageInfo = appUsageInfo
//    }
}
struct RegisterNewRequestData:Codable {
    var name:String
    var dateOfBirth:String
    var nrcNo:String
    var phoneNo:String
    var password:String
    var securityAnsweredInfoList:[SecQABean]
    var appUsageInfo:AppUsageInfoReqBean
    enum CodingKeys: String, CodingKey {
        case name
        case dateOfBirth
        case nrcNo
        case phoneNo
        case password
        case securityAnsweredInfoList
        case appUsageInfo
    }
}

struct AppUsageInfoReqBean:Codable{
    var phoneModel:String
    var manufacture:String
    var sdk:String
    var osType:String
    var osVersion:String
    var resolution:String
    var instructionSet:String
    var cpuArchitecture:String
    var registrationTime:String
    enum CodingKeys: String, CodingKey {
        case phoneModel
        case manufacture
        case sdk
        case osType
        case osVersion
        case resolution
        case instructionSet
        case cpuArchitecture
        case registrationTime
    }
}

//CHECK VERIFY NEW MEMBER
struct CheckVerifyUserInfoRequest: Codable{
    var agreementNo:String
    var dateOfBirth:String
    var nrcNo:String
    var customerId:String
    enum CodingKeys: String, CodingKey {
        case agreementNo
        case dateOfBirth
        case nrcNo
        case customerId
    }
    init(agreementNo:String,dob:String,nrcNo:String,customerId:String) {
        self.agreementNo = agreementNo
        self.dateOfBirth = dob
        self.nrcNo = nrcNo
        self.customerId = customerId
    }
}
struct CheckVerifyUserInfoResponse: Codable{
    var responseStatus:String
    var customerNo:String
    enum CodingKeys: String, CodingKey{
        case responseStatus
        case customerNo
    }

}
