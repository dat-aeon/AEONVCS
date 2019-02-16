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
    static var login = "login/do_login"
    static var faqList = "information/faq_info"
    static var nrcList = "information/nrc_info"
    static var aboutUs = "information/about_us"
    static var checkMember = "check_member"
    static var register = "registration"
    static var secQuesList = "get_security_questions"
    static var selectedQuesList = "security_questions"
    static var confirmUser = "confirm_info"
    static var resetSecQuesList = "registration/get_security_questions"
    
}
