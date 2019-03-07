//
//  Messages.swift
//  AEONVCS
//
//  Created by mac on 2/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct Messages {
    // LOGIN
    static let PHONE_EMPTY_ERROR = "Please enter Login Phone No."
    static let PASSWORD_EMPTY_ERROR = "Please enter Password."
    
    static let PHONE_LENGTH_ERROR = "Phone No. must be greater than 9."
    static let PASSWORD_LENGTH_ERROR = "Length of Password must be 6."
    
    // REGISTER
    static let NAME_EMPTY_ERROR = "Please enter Name."
    static let DOB_EMPTY_ERROR = "Please enter Date Of Birth."
    static let NRC_EMPTY_ERROR = "Please enter NRC No."
    static let NRC_LENGTH_ERROR = "6 digits."
    static let PHONE_REG_EMPTY_ERROR = "Please enter Phone No."
    static let CON_PASSWORD_EMPTY_ERROR = "Please enter Confirm Password."
    static let PASSWORD_NOT_MATCH_ERROR = "Passward does not match."
    
    static let PHONE_DUPLICATE_ERROR = "Phone No is duplicated."
    static let NRC_DUPLICATE_ERROR = "NRC is duplicated."
    static let REGISTER_DUPLICATE_ERROR = "Your data is already registered."
    
    // SEC REGISTER
    static let ANSWER_EMPTY_ERROR = "Please enter all security answers."
    static let QUESTION_SAME_ERROR = "Questions are same."
    
    // OTP
    static let OTP_EMPTY_ERROR = "Please enter OTP code."
    static let OTP_LENGTH_ERROR = "Length of OTP must be 4."
    static let OTP_WRONG_ERROR = "Your OTP is wrong."
    
    static let SERVER_ERROR = "Server is temporarily stopped now. Please contact to AEON."
}
