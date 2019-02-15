//
//  RegisterData.swift
//  AEONVCS
//
//  Created by mac on 2/8/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct CheckMemberResponse : Codable {
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

struct RegisterResponse: Codable {
    var message: String
    var dataBean: RegisterDataBean
}

struct RegisterDataBean: Codable {
    var customerId:String = ""
    var customerNo:String = ""
    var phoneNo:String = ""
    var customerTypeId:String = ""
    var userTypeId:String = ""
    var name:String = ""
    var dateOfBirth:String = ""
    var nrcNo:String = ""
    var status:String = ""
    var photoPath:String = ""
    var delFlag:String = ""
    var password:String = ""
    var custAgreementListDtoList:String = ""
    
    enum CodingKeys: String, CodingKey {
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
}

struct RegisterRequestBean {
    var name: String = ""
    var dob: String = ""
    var nrc: String = ""
    var phoneNo: String = ""
    var password: String = ""
    var confirmPassword: String = ""
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
