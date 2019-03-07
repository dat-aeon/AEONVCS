//
//  RegisterData.swift
//  AEONVCS
//
//  Created by mac on 2/8/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

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
    var message: String? = ""
    var memberDataBean: MemberDataBean?
    enum CodingKeys:String,CodingKey{
        case statusCode
        case statusMessage
        case message
        case memberDataBean = "checkMemInfoResBean"
    }
    
    static func parseToCheckMemberResponse(_ data : JSON) -> CheckMemberResponse {
        let dictData = data.dictionary
        var checkMemberResponse = CheckMemberResponse()
        checkMemberResponse.statusCode = dictData!["statusCode"]?.string
        checkMemberResponse.statusMessage = dictData!["statusMessage"]?.string
        checkMemberResponse.message = dictData!["message"]?.string
        if let memberData = dictData!["checkMemInfoResBean"]?.string{
            checkMemberResponse.memberDataBean = MemberDataBean.parseToMemberDataBean(JSON(parseJSON: memberData))
        }
        return checkMemberResponse
        
    }
}

struct MemberDataBean : Codable {
    var importCustomerInfoId: Int? = 0
    var customerNo: String? = ""
    var name: String? = ""
    var gender: Int? = 0
    var phoneNo: String? = ""
    var nrcNo: String? = ""
    var dateOfBirth: String? = ""
    var salary: String? = ""
    var age: Int? = 0
    var companyName: String? = ""
    var townshipAddress: String? = ""
    var status: String? = ""
    var custAgreementListResDaoList :[CustAgreementListResDao]? = []
    
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
    
    static func parseToMemberDataBean(_ data : JSON) -> MemberDataBean {
        
        var memberDataBean = MemberDataBean()
        memberDataBean.importCustomerInfoId = data["importCustomerInfoId"].int
        memberDataBean.customerNo = data["customerNo"].string
        memberDataBean.name = data["name"].string
        memberDataBean.gender = data["gender"].int
        memberDataBean.phoneNo = data["phoneNo"].string
        memberDataBean.nrcNo = data["nrcNo"].string
        memberDataBean.dateOfBirth = data["dateOfBirth"].string
        memberDataBean.salary = data["salary"].string
        memberDataBean.age = data["age"].int
        memberDataBean.companyName = data["companyName"].string
        memberDataBean.townshipAddress = data["townshipAddress"].string
        memberDataBean.status = data["status"].string
        if let agreementDatas = data["custAgreementListResDaoList"].array{
            var agreementList : [CustAgreementListResDao] = []
            agreementDatas.forEach({ (agreementData) in
                agreementList.append(CustAgreementListResDao.parseToCustAgreementListResDao(agreementData))
            })
            memberDataBean.custAgreementListResDaoList = agreementList
        }
        
        return memberDataBean
        
    }
}

struct CustAgreementListResDao : Codable {
    var custAgreementId:String? = ""
    var importCustomerId:String? = ""
    var agreementNo:String? = ""
    var qrShow:String? = ""
    var financialAmt:String? = ""
    var financialTerm:String? = ""
    
    enum CodingKeys: String, CodingKey {
        case custAgreementId = "custAgreementId"
        case importCustomerId = "importCustomerId"
        case agreementNo = "agreementNo"
        case qrShow = "qrShow"
        case financialAmt = "financialAmt"
        case financialTerm = "financialTerm"
    }
    
    static func parseToCustAgreementListResDao(_ data : JSON) -> CustAgreementListResDao {
        var custAgreementListResDao = CustAgreementListResDao()
        custAgreementListResDao.custAgreementId = data["custAgreementId"].string
        custAgreementListResDao.importCustomerId = data["importCustomerId"].string
        custAgreementListResDao.agreementNo = data["agreementNo"].string
        custAgreementListResDao.qrShow = data["qrShow"].string
        custAgreementListResDao.financialAmt = data["financialAmt"].string
        custAgreementListResDao.financialTerm = data["financialTerm"].string
        return custAgreementListResDao
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
    var custAgreementListDtoList:[CustomerAgreementData]?
    
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
        self.customerId = Int(customerId) ?? 0
        self.customerNo = customerNo
        self.phoneNo = phoneNo
        self.customerTypeId = Int(customerTypeId) ?? 0
        self.userTypeId = Int(userTypeId) ?? 0
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.nrcNo = nrcNo
        self.status = status
        self.photoPath = photoPath
    }
//
//    mutating func mapFrom(customerId:String,customerNo:String,phoneNo:String,customerTypeId:String,userTypeId:String,name:String,dateOfBirth:String,nrcNo:String,status:String,photoPath:String)->RegisterResponse{
//        self.customerId = customerId
//        self.customerNo = customerNo
//        self.phoneNo = phoneNo
//        self.customerTypeId = customerTypeId
//        self.userTypeId = userTypeId
//        self.name = name
//        self.dateOfBirth = dateOfBirth
//        self.nrcNo = nrcNo
//        self.status = status
//        self.photoPath = photoPath
//        return self
//    }
}

struct CustomerAgreementData:Codable{
//    var custAgreementId:String? = ""
//    var importCustomerId:String? = ""
//    var agreementNo:String? = ""
//    var qrShow:String? = ""
//    var financialAmt:String? = ""
//    var financialTerm:String? = ""
//
    var custAgreementId, importCustomerId, agreementNo, qrShow: String
    var financialAmt, financialTerm: String
    
    enum CodingKeys: String, CodingKey{
        case custAgreementId
        case importCustomerId
        case agreementNo
        case qrShow
        case financialAmt
        case financialTerm
    }
}

//Member Register Request Param Data
struct RegisterExistedRequestData : Codable {
    var name:String? = ""
    var dateOfBirth:String? = ""
    var nrcNo:String? = ""
    var phoneNo:String? = ""
    var password:String? = ""
    var importCustomerId:Int? = 0
    var customerNo:String? = ""
    var photoPath:String? = ""
    var securityAnsweredInfoList:[SecQABean]?
    var appUsageInfo:AppUsageInfoReqBean?
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
    enum CodingKeys: String, CodingKey {
        case agreementNo
        case dateOfBirth
        case nrcNo
    }
    init(agreementNo:String,dob:String,nrcNo:String) {
        self.agreementNo = agreementNo
        self.dateOfBirth = dob
        self.nrcNo = nrcNo
    }
}
struct CheckVerifyUserInfoResponse: Codable{
    var statusCode:String
    var statusMessage: String
    var customerNo:String
    var verifyStatus:String
    enum CodingKeys: String, CodingKey{
        case statusCode
        case statusMessage
        case customerNo
        case verifyStatus
    }

}

struct VerifyUserInfoBean {
    var agreementNo:String = ""
    var dateOfBirth:String = ""
    var nrcNo:String = ""
    var customerNo: String = ""
}
