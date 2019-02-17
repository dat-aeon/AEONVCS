 //
//  LoginData.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
 
 struct LoginResponse: Codable {
    var statusCode:Int = 0
    var statusMessage:String = ""
    var customerId:Int = 0
    var customerNo: String? = ""
    var phoneNo: String = ""
    var customerTypeId: Int = 0
    var userTypeId: Int = 0
    var name: String = ""
    var dateOfBirth: String = ""
    var nrcNo: String = ""
    var status: String = ""
    var photoPath: String? = ""
    var delFlag: Int = 0
    var password: String = ""
    var custAgreementListDtoList = [CustAgreementListDto?]()
    
 }

 struct CustAgreementListDto : Codable{
    var custAgreementId: Int = 0
    var importCustomerId: Int = 0
    var agreementNo: String = ""
    var agreementStatus: String = ""
 }

