//
//  ApiService.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct ApiServiceEndPoint {
    
    //Http header value
    static var GET_METHOD = "GET"
    static var POST_METHOD = "POST"
    static var APPLICATION_JSON = "application/json"
    static var APPLICAITON_X_WWW_FORM_URLENCODED = "application/x-www-form-urlencoded"
    static var CONTENT_TYPE = "Content-Type"
    
    static var BASIC_AUTHORIZE_CODE = "Basic dmNzLWFwaS1jbGllbnQ6dmNzLWFwaS1jbGllbnQ="
    static var AUTHORIZATION = "Authorization"
    static var API_USER_NAME = "vcs-api-client"
    static var API_USER_PASSWORD = "vcs-api-client"
    
    //Login API end Point
    static var authenticate = "oauth/token"
    static var login = "customer-info-manage/get-user-information"
    static var logout = "customer-info-manage/update-app-usage-detail-for-logout"
    static var offline_logout = "offline-logout/logout"
    
    //Information
    static var secQuesList = "reset-password/security-question-list"
    static var faqList = "information/faq-info-list"
    static var nrcList = "information/township-code-list"
    static var aboutUs = "information/about-us"
    static var hotline = "information/hotline"
    
    //Register
    static var checkMember = "customer-info-registration/check-member"
    static var registerNew = "customer-info-registration/register-new-customer"
    static var registerExisted = "customer-info-registration/register-old-customer"
    static var otpRequest = "customer-info-registration/send-otp"
    
    //Verify
    static var checkRegisterVerifyNewMember = "customer-info-manage/verify-member-info"
    static var verifyQAList = "customer-info-manage/confirm-security-question-answer"
    static var registVerifyMember = "customer-info-manage/upgrade-member"
    
    //Update Information
    static var userQAList = "customer-info-manage/get-customer-security-question-list"
    static var updateUserQAList = "customer-info-manage/update-customer-security-question-answer"
    
    //Reset Password
    static var selectedQuesList = "security_questions"
    static var confirmUser = "reset-password/confirm-security-question-answer"
    static var changePassword = "reset-password/reset-password"
    static var resetSecQuesList = "registration/get_security_questions"
    
    //Force Password Change
    static var checkAccountLock = "reset-password/check-account-lock"
    static var forceChangePassword = "reset-password/force-password-change"
    
    //Events & News
    static var couponInfo = "coupon-info/customer-coupon-info-list"
    static var couponUpdate = "coupon-info/use-coupon-info"
    
    static var promoInfo = "promotions-info/promotions-info-list"
    static var newpromoInfo = "free-token/promotions-info-list"
    static var newsInfo = "news-info/news-info-list"
    static var newnewsInfo = "free-token/news-info-list"
    
    //Version Update
    static var newVersionInfo = "mobile-version-config/check-update-status"
    
    // Profile Update
    static var profileUpdate = "customer-info-manage/update-customer-profile-image"
    
    // Outlet Info
    static var outletInfo = "outlet-info/outlet-info-list"
    
    // Loan Calculator
    static var loanCalculator = "free-token/loan-calculate"
    //static var loanCalculator = "loan-calculator/loan-calculate"
    
    //Check Password
    static var checkPasswordToVerifyUser = "customer-info-manage/check-password"
    
    static var daRegister = "application/register"
    
    static var daLoadSaveData = "application/last-application-info"
    
    static var daSave = "application/save-draft"
    
    static var daListRequest = "application/application-inquries-list"
    
    static var daPurchaseInfoDetail = "application/purchase-info-detail"
    static var daApplicationInfoDetail = "application/application-info-detail"
    static var daApplicationCancel = "application/application-cancel"
    static var agreementlist = "customer-info-manage/get-customer-agreement-list"
    static var qrcodeproductinfo = "application/get-purchase-info-confirm-waiting"
    
    static var productinfoconfirm = "application/purchase-info-confirm"
    
    static var productinfocancel = "application/purchase-info-cancel"
    
    static var attachmentedit = "application/attachment-edit"
    static var attachmenteditMultipart = "application/attachment-edit-multipart"
    
    static var producttypelist = "information/product-type-list"
    
    static var cityTownshipInfoList = "information/city-township-info-list"
    
    static var videofilepath = "information/get-how-to-use-video-file-name"
    
    static var roomsync = "free-message/room-sync"
    
    //ask product
    
    static var contactUpMessageApi = "free-token/get-ask-product-unread-count"
    static var LEVEL_TWO_MESSAGE_UNREAD = "free-token/get-level-2-message-unread-count"
}
