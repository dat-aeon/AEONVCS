//
//  ApiService.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct ApiServiceEndPoint {
    //Login API end Point
    static var login = "appLogin"
    
    //Register
    static var checkMember = "registration/check_member"
    static var registerNew = "registration/register_new"
    static var registerExisted = "registration/register_existed"
    static var secQuesList = "registration/get_security_questions"
    static var registerVerifyNewMember = "registration/verify_new_member"
    
    
    static var selectedQuesList = "security_questions"
    static var confirmUser = "confirm_info"
    
    //Information
    static var faqList = "information/faq_info"
    static var nrcList = "information/nrc_info"
    
}
