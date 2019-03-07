 //
//  LoginData.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
 
 struct LoginResponse: Codable {
    var statusCode:String? = ""
    var statusMessage:String? = ""
    var customerId:Int! = 0
    var customerNo: String? = ""
    var phoneNo: String? = ""
    var customerTypeId: Int? = 0
    var userTypeId: Int? = 0
    var name: String? = ""
    var dateOfBirth: String? = ""
    var nrcNo: String? = ""
    var status: String? = ""
    var photoPath: String? = ""
    var delFlag: Int? = 0
    var password: String? = ""
    var custAgreementListDtoList:[CustomerAgreementData]? = []
 }

 struct LogoutResponse: Codable {
    var statusCode:String? = ""
    var statusMessage:String? = ""
 }

 struct LogoutRequest: Codable {
    var customerId:String? = ""
    var statusMessage:String? = ""
 }

