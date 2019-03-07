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
    static var logout = "login/do_logout"
    
    //Information
    static var secQuesList = "registration/get_security_questions"
    static var faqList = "information/faq_info"
    static var nrcList = "information/nrc_info"
    static var aboutUs = "information/about_us"
    static var hotline = "information/hotline"
    
    //Register
    static var checkMember = "registration/check_member"
    static var registerNew = "registration/register_new"
    static var registerExisted = "registration/register_existed"
    static var otpRequest = "registration/otp_request"
    
    //Verify
    static var checkRegisterVerifyNewMember = "registration/check_verify_new_member"
    static var registerVerifyNewMember = "registration/verify_new_member"
    static var verifyQAList = "registration/verify_answer"
    static var registVerifyMember = "registration/verify_new_member"
    
    //Reset Password
    static var selectedQuesList = "security_questions"
    static var confirmUser = "resetpassword/confirm_info"
    static var changePassword = "resetpassword/password_change"
    static var resetSecQuesList = "registration/get_security_questions"
    
    //Update Information
    static var userQAList = "updateuserinfo/get_security_questions"
    static var updateUserQAList = "updateuserinfo/update_security_qas"
    
    //Events & News
    static var couponInfo = "eventsandnews/show_coupon_info"
    static var couponUpdate = "eventsandnews/use_coupon_info"
    
    
}
