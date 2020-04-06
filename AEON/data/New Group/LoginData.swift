 //
//  LoginData.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON
 
 struct LoginResponse: Codable {
    var status: String = ""
    var data = LoginDataBean()
 }
 
 struct LoginDataBean: Codable {
    var customerId: Int?
    var customerNo: String?
    var phoneNo: String?
    var customerTypeId : Int?
    var userTypeId: Int?
    var name, dateOfBirth, nrcNo, photoPath: String?
    var memberNo: String?
    var memberNoValid: Bool?
    var hotlinePhone: String?
    var customerAgreementDtoList: [CustomerAgreementDtoList]?
    
    enum CodingKeys: String, CodingKey {
        case customerId = "customerId"
        case customerNo, phoneNo
        case customerTypeId = "customerTypeId"
        case userTypeId = "userTypeId"
        case memberNo, hotlinePhone
        case name, dateOfBirth, nrcNo, photoPath, customerAgreementDtoList
        case memberNoValid
    }
 }
 
 struct CustomerAgreementDtoList: Codable {
    var custAgreementId, importCustomerId: Int?
    var agreementNo: String?
    var qrShow, financialStatus, financialAmt, financialTerm: Int?
    
    enum CodingKeys: String, CodingKey {
        case custAgreementId = "custAgreementId"
        case importCustomerId = "importCustomerId"
        case agreementNo, qrShow, financialStatus, financialAmt, financialTerm
    }
 }
 
 struct LogoutResponse: Codable {
    var statusCode:String? = ""
    var statusMessage:String? = ""
 }

 struct LogoutRequest: Codable {
    var customerId:String?
    var logoutTime:String?
 }

 struct BadCredentialResponse: Codable {
    var status:String? = ""
    var messageCode:String? = ""
    var message:String? = ""
    var timestamp:String? = ""
    var payLoad:String? = ""
 }
 
 struct SessionDataBean : Codable {
    var customerId: Int?
    var customerNo: String?
    var phoneNo: String?
    var customerTypeId : Int?
    var userTypeId: Int?
    var name, dateOfBirth, nrcNo, photoPath: String?
    var memberNo: String?
    var memberNoValid: Bool?
    var hotlineNo: String?
    var customerAgreementDtoList: [CustomerAgreementDtoList]?
 }
 
 //CHECK MEMBER PASSWORD
 struct CheckPasswordRequest: Codable{
    var customerId:Int
    var password:String
 }
 
 struct CheckPasswordResponse: Codable{
    var status:String?
 }
 
 
 struct AgreementInfo: Codable {
    var custAgreementId, importCustomerId, daApplicationInfoId: Int?
    var agreementNo, applicationNo,lastPaymentDate,encodeStringForQr: String?
    var qrShow, financialStatus, financialAmt, financialTerm: Int?
//    var lastPaymentDate : Date?
    
    enum CodingKeys: String, CodingKey {
        case custAgreementId = "custAgreementId"
        case importCustomerId = "importCustomerId"
        case daApplicationInfoId = "daApplicationInfoId"
        case agreementNo, qrShow, financialStatus, financialAmt, financialTerm, applicationNo,encodeStringForQr,lastPaymentDate
    }
 }
