//
//  Messages.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 2/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct Messages {
    // LOGIN
    static let PHONE_EMPTY_ERROR = "PHONE_EMPTY_ERROR"
    static let PASSWORD_EMPTY_ERROR = "PASSWORD_EMPTY_ERROR"
    
    static let PHONE_LENGTH_ERROR = "PHONE_LENGTH_ERROR"
    static let PASSWORD_LENGTH_ERROR = "PASSWORD_LENGTH_ERROR"
    static var BAD_CREDENTIAL_ERROR = "BAD_CREDENTIAL_ERROR"
    
    
    // REGISTER
    static let NAME_EMPTY_ERROR = "NAME_EMPTY_ERROR"
    static let BUILD_NO_ERROR = "BUILD_NO_ERROR"
    static let ROOM_NO_ERROR = "ROOM_NO_ERROR"
    static let FLOOR_NO_ERROR = "FLOOR_NO_ERROR"
    static let STREET_ERROR = "STREET_ERROR"
    static let QUARTER_ERROR = "QUARTER_ERROR"
    static let NAME_REG_FORMAT_ERROR = "NAME_REG_FORMAT_ERROR"
    static let DOB_EMPTY_ERROR = "DOB_EMPTY_ERROR"
    static let DOB_FORMAT_ERROR = "DOB_FORMAT_ERROR"
    static let INVALID_AGE_ERROR = "INVALID_AGE_ERROR"
    
    static let NRC_TOWNSHIP_EMPTY_ERROR = "NRC_TOWNSHIP_EMPTY_ERROR"
    static let NRC_TOWNSHIP_INVALID_ERROR = "NRC_TOWNSHIP_INVALID_ERROR"
    static let NRC_NO_EMPTY_ERROR = "NRC_NO_EMPTY_ERROR"
    static let NRC_LENGTH_ERROR = "NRC_LENGTH_ERROR"
    
    static let PHONE_REG_EMPTY_ERROR = "PHONE_REG_EMPTY_ERROR"
    static let PHONE_REG_LENGTH_ERROR = "PHONE_REG_LENGTH_ERROR"
    
    static let CON_PASSWORD_EMPTY_ERROR = "CON_PASSWORD_EMPTY_ERROR"
    static let PASSWORD_NOT_MATCH_ERROR = "PASSWORD_NOT_MATCH_ERROR"
    static let PASSWORD_WRONG_ERROR = "PASSWORD_WRONG_ERROR"
    static let PASSWORD_WEAK_ERROR = "PASSWORD_WEAK_ERROR"
    
    static let PHONE_DUPLICATE_ERROR = "PHONE_DUPLICATE_ERROR"
    static let NRC_DUPLICATE_ERROR = "NRC_DUPLICATE_ERROR"
    static let REGISTER_DUPLICATE_ERROR = "REGISTER_DUPLICATE_ERROR"
    static let IMPORT_PH_DUPLICATE_ERROR = "IMPORT_PH_DUPLICATE_ERROR"
    static let NRC_DUPLICATE_ON_CORE_ERROR = "NRC_DUPLICATE_ON_CORE_ERROR"
    
    // SEC REGISTER
    static let ANSWER_EMPTY_ERROR = "ANSWER_EMPTY_ERROR"
    static let ANSWER_LENGTH_ERROR = "ANSWER_LENGTH_ERROR"
    static let ANSWER_LENGTH_ERROR_MM = "ANSWER_LENGTH_ERROR_MM"
    static let QUESTION_SAME_ERROR = "QUESTION_SAME_ERROR"
    static let ANSWER_FORMAT_ERROR = "ANSWER_FORMAT_ERROR"
    
    // OTP
    static let OTP_EMPTY_ERROR = "OTP_EMPTY_ERROR"
    static let OTP_LENGTH_ERROR = "OTP_LENGTH_ERROR"
    static let OTP_INVALID_ERROR = "OTP_INVALID_ERROR"
    static let OTP_WRONG_ERROR = "OTP_WRONG_ERROR"
    
    //VERIFY
    static let AGREEMENT_NO_EMPTY_ERROR = "AGREEMENT_NO_EMPTY_ERROR"
    static let AGREEMENT_NO_LENGTH_ERROR = "AGREEMENT_NO_LENGTH_ERROR"
    static let VERIFY_INVALID_ERROR = "VERIFY_INVALID_ERROR"
    static let AGREENO_INVALID_ERROR = "AGREENO_INVALID_ERROR"
    static let UPGRADE_SUCCESS = "UPGRADE_SUCCESS"
    static let UPGRADE_SUCCESS_2 = "UPGRADE_SUCCESS_2"
    static let VERIFY_INVALID_ANSWER = "VERIFY_INVALID_ANSWERS"
    
    // INFO UPDATE
    static let INCORRECT_PASSWORD_ERROR = "INCORRECT_PASSWORD_ERROR"
    static let UPDATE_INFO_SUCCESS = "UPDATE_INFO_SUCCESS"
    
    // FORGET PASSWORD SEC_QUES
    static let QUES_AND_ANSWER_WRONG_ERROR = "QUES_AND_ANSWER_WRONG_ERROR"
    static let NRC_OR_PHONE_INVALID_ERROR = "NRC_OR_PHONE_INVALID_ERROR"
    
    // COUPON
    static let COUPON_REDEEM_ERROR = "COUPON_REDEEM_ERROR"
    
    // SERVER ERROR
    static let SERVER_ERROR = "SERVER_ERROR"
    
    static let NETWORK_CONNECTION_ERROR = "NETWORK_CONNECTION_ERROR"
    static let SESSION_TIMEOUT_ERROR = "SESSION_TIMEOUT_ERROR"
    
    // VERSION
    static let NEW_VERSION_AVAILABLE_1 = "NEW_VERSION_AVAILABLE_1"
    static let NEW_VERSION_AVAILABLE_2 = "NEW_VERSION_AVAILABLE_2"
    
    // EXPIRE TOKEN
    static let EXPIRE_TOKEN_ERROR = "EXPIRE_TOKEN_ERROR"
    
    // BIOMETRIC
    static let BIOMETRIC_FAILED_ERROR = "BIOMETRIC_FAILED_ERROR"
    static let BIOMETRIC_REGISTER_INFO = "BIOMETRIC_REGISTER_INFO"
    static let BIOMETRIC_VERIFY_FAILED_ERROR = "BIOMETRIC_VERIFY_FAILED_ERROR"
    static let MAIN_BIOMETRIC_FAILED_ERROR = "MAIN_BIOMETRIC_FAILED_ERROR"
    
    // APP LOCK
    static let NOT_EXIST_CUSTOMER_INFO = "NOT_EXIST_CUSTOMER_INFO"
    
    // PHOTO UPDATE
    static let PROFILE_PHOTO_UPDATE_INFO = "PROFILE_PHOTO_UPDATE_INFO"
    
    //ACCOUNT LOCK
    static let ACCOUNT_LOCK = "ACCOUNT_LOCK"
    
    //APPLY LOAN (SMALL LOAN)
    static let ADDRESS_EMPTY_ERROR = "ADDRESS_EMPTY_ERROR"
    static let ADDRESS_INVALID_ERROR = "ADDRESS_INVALID_ERROR"
    static let PERMEMNENT_ADDRESS_EMPTY_ERROR = "PERMEMNENT_ADDRESS_EMPTY_ERROR"
    static let PHONE_RESIDENT_EMPTY_ERROR = "PHONE_RESIDENT_EMPTY_ERROR"
    
    static let EMAIL_EMPTY_ERROR = "EMAIL_EMPTY_ERROR"
    static let EMAIL_INVALID = "EMAIL_INVALID"
    static let NATIONALITY_EMPTY_ERROR = "NATIONALITY_EMPTY_ERROR"
    static let TYPE_RESIDENCE_EMPTY_ERROR = "TYPE_RESIDENCE_EMPTY_ERROR"
    static let YEAR_STAY_EMPTY_ERROR = "YEAR_STAY_EMPTY_ERROR"
    static let COMPANY_NAME_EMPTY_ERROR = "COMPANY_NAME_EMPTY_ERROR"
    static let COMPANY_ADDRESS_EMPTY_ERROR = "COMPANY_ADDRESS_EMPTY_ERROR"
    static let DEPARTMENT_EMPTY_ERROR = "DEPARTMENT_EMPTY_ERROR"
    static let POSITION_EMPTY_ERROR = "POSITION_EMPTY_ERROR"
    static let TEL_NO_EMPTY_ERROR = "TEL_NO_EMPTY_ERROR"
    static let PHONE_COMPANY_LENGTH_ERROR = "PHONE_COMPANY_LENGTH_ERROR"
    static let YEAR_SERVICE_EMPTY_ERROR = "YEAR_SERVICE_EMPTY_ERROR"
    static let OCCUPATION_STREET_ERROR = "OCCUPATION_STREET_ERROR"
    static let OCCUPATION_BULDING_ERROR = "OCCUPATION_BULDING_ERROR"
    static let OCCUPATION_FLOOR_NO_ERROR = "OCCUPATION_FLOOR_NO_ERROR"
    static let OCCUPATION_ROOM_NO_ERROR = "OCCUPATION_ROOM_NO_ERROR"
    static let OCCUPATION_QUARTER_ERROR = "OCCUPATION_QUARTER_ERROR"
    static let CONTACT_TIME_EMPTY_ERROR = "CONTACT_TIME_EMPTY_ERROR"
   
    static let COMPANY_STATUS_EMPTY_ERROR = "COMPANY_STATUS_EMPTY_ERROR"
    
    static let COMPANY_STATUS_INVALID_ERROR = "COMPANY_STATUS_INVALID_ERROR"
    
    static let MONTHLY_INCOME_EMPTY_ERROR = "MONTHLY_INCOME_EMPTY_ERROR"
    
    static let TOTAL_INCOME_EMPTY_ERROR = "TOTAL_INCOME_EMPTY_ERROR"
    
     static let SALARY_DATE_FORMAT_ERROR = "SALARY_DATE_FORMAT_ERROR"
    
    static let SALARY_DATE_EMPTY_ERROR = "SALARY_DATE_EMPTY_ERROR"
    
    static let RSWITHAPPLICANT_EMPTY_ERROR = "RSWITHAPPLICANT_EMPTY_ERROR"
    
    static let COMPANY_PHONE_EMPTY_ERROR = "COMPANY_PHONE_EMPTY_ERROR"
    
    static let PRODUCT_DESC_EMPTY_ERROR = "PRODUCT_DESC_EMPTY_ERROR"
    
    static let FINANCE_AMT_EMPTY_ERROR = "FINANCE_AMT_EMPTY_ERROR"
    
    static let FINANCE_AMT_LIMIT_ERROR = "FINANCE_AMT_LIMIT_ERROR"
    
    static let FINANCE_TERM_EMPTY_ERROR = "FINANCE_TERM_EMPTY_ERROR"
    
    static let NRC_FRONT_EMPTY_ERROR = "NRC_FRONT_EMPTY_ERROR"
    
     static let NRC_BACK_EMPTY_ERROR = "NRC_BACK_EMPTY_ERROR"
    
    static let INCOME_PROOF_EMPTY_ERROR = "INCOME_PROOF_EMPTY_ERROR"
    
    static let RESIDENCE_PROOF_EMPTY_ERROR = "RESIDENCE_PROOF_EMPTY_ERROR"
    
    static let GUARANTOR_FRONT_EMPTY_ERROR = "GUARANTOR_FRONT_EMPTY_ERROR"
    
    static let GUARANTOR_BACK_EMPTY_ERROR = "GUARANTOR_BACK_EMPTY_ERROR"
    
    static let APPLICANT_FOTO_EMPTY_ERROR = "APPLICANT_FOTO_EMPTY_ERROR"
    
    static let HOUSEHOLD_EMPTY_ERROR = "HOUSEHOLD_EMPTY_ERROR"
    
    static let CUSTOMER_SIGNATURE_EMPTY_ERROR = "CUSTOMER_SIGNATURE_EMPTY_ERROR"
    static let GUARANTOR_SIGNATURE_EMPTY_ERROR = "GUARANTOR_SIGNATURE_EMPTY_ERROR"
    // AGENT CHANNEL
    static let AT_ADDITION_TEXT_EMPTY_ERROR = "AT_ADDITION_TEXT_EMPTY_ERROR"
    static let AT_ADDRESS_EMPTY_ERROR = "AT_ADDRESS_EMPTY_ERROR"
    
    // DIGITAL APPLICATION
    static let DA_SUCCESS_INFO = "DA_SUCCESS_INFO"
    static let DA_FAILED_INFO = "DA_FAILED_INFO"
}
