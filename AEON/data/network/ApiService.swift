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
    
    //Information
    static var secQuesList = "registration/get_security_questions"
    static var faqList = "information/faq_info"
    static var nrcList = "information/nrc_info"
    static var aboutUs = "information/about_us"
    
    //Register
    static var checkMember = "registration/check_member"
    static var registerNew = "registration/register_new"
    static var registerExisted = "registration/register_existed"
    
    static var checkRegisterVerifyNewMember = "registration/check_verify_new_member"
    static var registerVerifyNewMember = "registration/verify_new_member"
    
    
    static var selectedQuesList = "security_questions"
    static var confirmUser = "confirm_info"
    static var resetSecQuesList = "registration/get_security_questions"
    
    //Update Information
    static var userQAList = "updateuserinfo/get_security_questions"
    static var updateUserQAList = "updateuserinfo/update_security_qas"
    
    
}
