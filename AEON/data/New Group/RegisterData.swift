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
    var id: Int = 0
    var loginID: String? = "", name: String? = ""
    var agencyID: Int?=0
    var agencyName: String? = "", location: String?=""
    var outvarID: Int?=0
    var outvarName: String? = "", agencyOutvarID: String? = "", mobivaream: String? = "", nonMobivaream: String? = ""
    var roleIDList:String? = ""
    var groupID: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case loginID = "loginId"
        case name
        case agencyID = "agencyId"
        case agencyName, location
        case outvarID = "outvarId"
        case outvarName
        case agencyOutvarID = "agencyOutvarId"
        case mobivaream, nonMobivaream
        case roleIDList = "roleIdList"
        case groupID = "groupId"
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


