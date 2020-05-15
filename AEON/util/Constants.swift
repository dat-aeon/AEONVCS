//
//  Constants.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
struct Constants {
//
    static var base_url:String = "https://ass.aeoncredit.com.mm/daso/"
    static let socket_url:String = "wss://ass.aeoncredit.com.mm/vcschat"
    static var assm_base_url :String = "https://ass.aeoncredit.com.mm/assm2/"
    static let at_socket_url:String = "wss://ass.aeoncredit.com.mm/vcsplchat"
    static let free_chat_socket_url:String = "wss://ass.aeoncredit.com.mm/free-chat-server"
    static var daso_url:String = "https://ass.aeoncredit.com.mm/daso/"
//
    
//    static var base_url:String = "https://amf.aeoncredit.com.mm/daso/"
//       static let socket_url:String = "wss://amf.aeoncredit.com.mm/vcschat"
//       static var assm_base_url :String = "https://amf.aeoncredit.com.mm/assm2/"
//       static let at_socket_url:String = "wss://amf.aeoncredit.com.mm/vcsplchat"
//       static let free_chat_socket_url:String = "wss://amf.aeoncredit.com.mm/free-chat-server"
//       static var daso_url:String = "https://amf.aeoncredit.com.mm/daso/"
       
    
//    static var base_url:String = "https://amf.aeoncredit.com.mm/vcsm2/"
//    static var daso_url:String = "https://amf.aeoncredit.com.mm/vcsm2/"
//
//    static let socket_url:String = "wss://amf.aeoncredit.com.mm/vcschat"
//    static var assm_base_url :String = "https://amf.aeoncredit.com.mm/assm2/"
//    static let at_socket_url:String = "wss://amf.aeoncredit.com.mm/vcsplchat"
//    static let free_chat_socket_url:String = "wss://amf.aeoncredit.com.mm/free-chat-server"
    
    static var site_activation_key = "12345678"
    
    static var SITE_ACTIVATION_KEY = "siteActivationKey"
    
    //PreDefine Data
    static var NRC_TOWNSHIP_List = "nrc_township"
    //static var REGISTER_RESPONSE = "register_response"
    
    // User Register Data
    static var PHONE_NO = "phone_no"
    static var NRC = "nrc"
    static var DOB = "dob"
    static var PASSWORD = "password"
    
    // User Import Information Data
    static var IMPORT_CUSTOMER_INFO_ID = "customer_info_id"
    static var IMPORT_CUSTOMER_NO = "customer_no"
    static var IMPORT_CUSTOMER_NAME = "name"
    static var IMPORT_GENDER = "gender"
    static var IMPORT_PHONE_NO = "phone_no"
    static var IMPORT_NRC_NO = "nrc_no"
    static var IMPORT_DOB = "date_of_birth"
    static var IMPORT_SALARY = "salary"
    static var IMPORT_AGE = "age"
    static var IMPORT_COMPANY_NAME = "company_name"
    static var IMPORT_ADDRESS = "township_address"
    static var IMPORT_STATUS = "status"
    static var IMPORT_AGREEMENT_NO_LIST = "agreementNoList"
    
    // User Registered Information Data
    static var CUSTOMER_TYPE = "customerType"
    
    static var STATUS_CODE = "status_code"
    static var STATUS_MESSAGE = "status_message"
    static var USER_INFO_CUSTOMER_ID = "user_customer_id"
    static var USER_INFO_CUSTOMER_NO = "user_customer_no"
    static var USER_INFO_PHONE_NO = "user_phone_no"
    static var USER_INFO_CUSTOMER_TYPE_ID = "user_customer_type_id"
    static var USER_INFO_USER_TYPE_ID = "user_user_type_id"
    static var USER_INFO_NAME = "user_name"
    static var USER_INFO_DOB = "user_dob"
    static var USER_INFO_NRC = "user_nrc"
    static var USER_INFO_STATUS = "user_status"
    static var USER_INFO_PHOTO_PATH = "user_photo_path"
    static var USER_INFO_AGREEMENT_LIST = "user_agreement_list"
    static var PROFILE_PHOTO_URL = base_url + "profile-image-files/"
    static var COUPON_PHOTO_URL = base_url + "coupon-image-files/"
    static var PROMOTION_PHOTO_URL = base_url + "promotion-image-files/"
    //OUTLET DETAIL PHOTO URL
    static var OUTLET_DETAIL_PHOTO_URL = base_url + "outlet-info/outlet-image-file/"
    static var NEWS_PHOTO_URL = base_url + "news-image-files/"
    static var OUTLET_PHOTO_URL = assm_base_url + "outlet-image-files/"
    
    //static var LOGIN_RESPONSE = "login_response"
    static var SESSION_INFO = "SESSION_CUSTOMER_INFO"
    static var TOKEN_DATA = "token_data"
    static var BLANK = ""
    static var ZERO = 0
    
    static var IS_ALREADY_ACCEPT = "is_first_install"
    static var LOGIN_TIME = "LOGIN_TIME"
    static var HOTLINE_NO = "HOTLINE_NO"
    
    // Response DATA
    static var STATUS_200 = "SUCCESS"
    static var STATUS_500 = "FAILED"
    
    static var MEMBER = "MEMBER"
    static var NON_MEMBER = "NON_MEMBER"
    static var DUPLICATE_DATA = "DUPLICATE_DATA"
    static var PHONE_DUPLICATE = "DUPLICATED_PHONE_NO"
    static var NRC_DUPLICATE = "DUPLICATED_NRC_NO"
    static var NRC_PH_DUPLICATE = "NRC_PH_DUPLICATE"
    static var IMPORT_PH_DUPLICATE = "DUPLICATED_IMPORT_PHONE_NO"
    static var DUPLICATED_NRC_NO_CORE_SYSTEM = "DUPLICATED_NRC_NO_CORE_SYSTEM"
    static var DUPLICATED_CUSTOMER_INFO = "DUPLICATED_CUSTOMER_INFO"
    static var INVALID_AGE = "INVALID_AGE"
    
    static var VALID_MEMBER = "VALID"
    static var INVALID_MEMBER = "NOT_VALID"
    static var OK = "OK"
    static var CANCEL = "Cancel"
    static var BACK = "BACK TO HOME"
    static var CALL_NOW = "Call Now"
    static var UPDATE_OK = "UPDATE_OK"
    static var INCORRECT_PWD = "INCORRECT_PASSWORD"
    static var PHONE_OR_NRC_INVALID = "PH_OR_NRC_INVALID"
    static var COUPON_REDEEM = "COUPON_REDEEM"
    static var PWD_WEAK = "PASSWORD_WEAK"
    static var BAD_CREDENTIAL = "BAD_CREDENTIAL"
    
    // Session Constants
    static var LAST_USED_TIME = "LAST_USED_TIME"
    static var IS_LOGOUT = "IS_LOGOUT"
    static var IS_FIRST_INSTALL = "IS_FIRST_INSTALL"
    
    // Error Type
    static var JSON_FAILURE = "Data parsing error!"
    static var SERVER_INTERNAL_FAILURE = "Process is not success!"
    static var SERVER_FAILURE = "Service is unavailable."
    static var NETWORK_FAILURE = "NETWORK_FAILURE"
    static var EXPIRE_TOKEN = "invalid_token"
    
    // Alert title
    static var VERIFY_FAILED_TITIE = "Verification Failed"
    static var LOGIN_FAILED_TITIE = "Login Failed"
    static var NETWORK_CONNECTION_TITLE = "Network Connection"
    static var SERVER_ERROR_TITLE = "Server error"
    static var PASSWORD_UPDATE_FAILED_TITLE = "Password Update Failed"
    static var CONFIRM_ERROR_TITLE = "Confirm Error"
    static var REGISTER_ERROR_TITLE = "Register Failed"
    static var LOADING_ERROR_TITLE = "Loading Error"
    static var FAQ_LOADING_ERROR_TITLE = "FAQ Loading Error"
    static var UPGRADE_MEMBER_SUCCESS_TITLE = "Upgrade Success"
    static var UPDATE_SUCCESS_TITLE = "Update Success"
    static var UPDATE_FAILED_TITLE = "Update Failed"
    static var EDIT_SUCCESS_TITLE = "Attachment Edit Success"
    static var EDIT_FAILED_TITLE = "Edit Failed"
    
    // Version Update title
    static var NEW_VERSION_TITLE = "New Version"
    static var MUST_UPDATE = "MUST_UPDATE"
    static var SHOULD_UPDATE="SHOULD_UPDATE";
    static var SKIP = "SKIP"
    
    // Messaging unread message Array
    static var UNREAD_MESSAGE_ARRAY = "unread_message_array"
    static var UNREAD_MESSAGE_COUNT = "unread_message_count"
    static var MESSAGING_SEGMENT = "message_segment"
    static var MESSAGING_MENU = "message_menu"
    
    // Messaging unread message Array
    static var AT_UNREAD_MESSAGE_ARRAY = "at_unread_message_array"
    static var AT_UNREAD_MESSAGE_COUNT = "at_unread_message_count"
    static var AT_MESSAGING_SEGMENT = "at_message_segment"
    static var AT_MESSAGING_MENU = "at_message_menu"
    
    // Biometric Data
    static var BIOMETRIC_PHONE = "bio_phone"
    static var BIOMETRIC_PASSWORD = "bio_password"
    static let BIOMETRIC_REGISTER_TOKEN = "BIOMETRIC_REGISTER_TOKEN"
    static let LOGIN_SUCCESS_TITLE = "Login Success"
    static let BIOMETRIC_FAILED_TITLE = "Biometric Login Failed"
    
    //Confirm Password
    static var NOT_EXIST_CUSTOMER_INFO = "NOT_EXIST_CUSTOMER_INFO"
    static var INVALID_CUSTOMER_ANSWER = "INVALID_CUSTOMER_ANSWER"
    
    // Messsaging
    static let LOW_QUALITY_IMAGE_250 = 262145;    //0.25MB.
    static let MEDIUM_QUALITY_IMAGE_500 = 524289; //0.5MB.
    static let HIGH_QUALITY_IMAGE_1000 = 1048576; //1.0MB.
    static let HIGH_QUALITY_IMAGE_1500 = 1572865; //1.5MB.
    static let HIGH_QUALITY_IMAGE_2000 = 2097152 // 2.0MB.
    static let HIGH_QUALITY_IMAGE_3000 = 3145728; //3.0MB.
    static let HIGH_QUALITY_IMAGE_5000 = 5242880; //5.0MB.
    static let HIGH_QUALITY_IMAGE_6000 = 6291456; //6.0MB.
    
    static let MENU_SOCKET_CLOSE = "menu_socket_close"
    static let MESSAGE_SOCKET_CLOSE = "message_socket_close"
    
    static let AT_MENU_SOCKET_CLOSE = "at_menu_socket_close"
    static let AT_MESSAGE_SOCKET_CLOSE = "at_message_socket_close"
    
    //Digital Application
    static let SUCCESS = "SUCCESS"
    static let FAILED = "FAILED"
    
    // VERIFY
    static let INVALID_MEMBER_INFO = "INVALID_MEMBER_INFO"
    
    // COUPON
    static let USED_COUPON_LIST = "USED_COUPON_LIST"
    static let ALREADY_INSERT = "ALREADY_INSERT"
    
    // NEW VERSION
    static let UPDATE = "UPDATE"

    // BIOMETRIC
    static let IS_BIO_LOGIN = "IS_BIO_LOGIN"
    
    // ACCOUNT LOCK
    static let ACCOUNT_LOCK = "ACCOUNT_LOCKED"
    
    //CHECK PASSWORD
    static var CHECK_PASSWORD_FAILED_TITIE = "Verification Failed"
    
    static var APP_DATA_ERROR_COUNT = "APP_DATA_ERROR_COUNT"
    
    static var OCCUPATION_DATA_ERROR_COUNT = "OCCUPATION_DATA_ERROR_COUNT"
    
    static var EMERGENCY_CONTACT_ERROR_COUNT = "EMERGENCY_CONTACT_ERROR_COUNT"
    
    static var GUARANTOR_ERROR_COUNT = "GUARANTOR_ERROR_COUNT"
    
    static var DA_UPLOAD_SUCCESS = "Application Upload Success"
    
    static var DA_UPLOAD_FAILED = "Application Upload Failed"
    
    static var LOAN_CONFIRMATION_ERROR_COUNT = "LOAN_CONFIRMATION_ERROR_COUNT"
    
    static var  APPLICATION_LIMIT = "APPLICATION_LIMIT"
    
    static var  INVALID_TOTAL_FINANCE_AMOUNT = "INVALID_TOTAL_FINANCE_AMOUNT"
    
    static var  INVALID_FINANCE_AMOUNT = "INVALID_FINANCE_AMOUNT"
    
    static var INVALID_REQUEST_PARAMETER = "INVALID_REQUEST_PARAMETER"
    
    static var  INVALID_TOTAL_FINANCE_AMOUNT_TITLE = "Total of previous finance amount and current finance amount are exceed your double of salary."
    
    static var APPLICATION_LIMIT_TITLE = "Can't apply more than 2 application."
    
    // Constant Array
    static var companyStatusList = ["Public Company","Factory", "Police","Private Company","SME Owner","Goverment Office", "Taxi Owner", "Specialist", "SME officer", "Military", "NGO", "Other"]
    
    static var rsWithList = ["Parent", "Sponse", "Relative", "Friend", "Other"]
    
    static var rsWithGuarantorList = ["Parent", "Sponse", "Relative", "Friend", "Other"]
    
    static var categoriesList = ["Smart Phone", "IT", "Furniture", "Aircon", "Refrigerator"]
    
    static var typeResidenceList = ["Owner","Parental","Rental","Relative","Hostel/Other"]
    
    static var livingWithList = ["Parent", "Sponse", "Relative", "Friend", "Alone"]
    
    // First Time PhNo Constant
    
    static var FIRST_TIME_PHONE = "FIRST_TIME_PHONE"
    static var FREECUS_INFO_ID = "FREECUS_INFO_ID"
    
    // To goodnews From
    
    static var togoodnewsfrom = "TO_GOODNEWS_FROM"
    
    // Share link
    static var AEON_SHARE_LINK = "Let me recommend you this application\n\n https://apps.apple.com/pe/app/aeon-myanmar-app/id1462606788?l=en\n\n"
}
