//
//  LoanCalculatorData.swift
//  AEONVCS
//
//  Created by mac on 8/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct LoanCalculatorResponse: Codable {
    var status: String = ""
    var data = LoanCalculator()
}

struct LoanCalculator: Codable {
    var processingFees:Int? = 0
    var totalRepayment:Int? = 0
    var firstPayment:Int? = 0
    var monthlyPayment:Int? = 0
    var lastPayment:Int? = 0
    var conSaving:Int? = 0
    var totalConSaving:Int? = 0
    
}

struct LoanCalculatorRequest: Codable{
    
    var financeAmount:String
    var loanTerm:String
    var motorCycleLoanFlag:String
    
    enum CodingKeys: String, CodingKey {
        case financeAmount
        case loanTerm
        case motorCycleLoanFlag
    }
    init(financeAmount:String, loanTerm:String, motorCycleLoanFlag:String) {
        
        self.financeAmount = financeAmount
        self.loanTerm = loanTerm
        self.motorCycleLoanFlag = motorCycleLoanFlag
        
    }

}
