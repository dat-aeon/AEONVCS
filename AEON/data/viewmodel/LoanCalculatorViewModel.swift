//
//  LoanCalculatorViewModel.swift
//  AEONVCS
//
//  Created by mac on 8/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class LoanCalculatorViewModel {
    
    func executeLoanCalculator(calculatorInfo: LoanCalculatorRequest, success: @escaping (LoanCalculator) -> Void,failure: @escaping (String) -> Void){
        
        LoanCalculatorModel.init().calculateLoan(calculatorInfo: calculatorInfo, success: { (result) in
            
            if result.status == Constants.STATUS_200 {
                let calculatorResult = self.getLoanCalculaterResult(loanCalculatorResponse: result)
                success(calculatorResult)
                
            } else {
                failure(result.status)
            }
            
        }) { (error) in
            
            failure(error)
        }
        
    }
    
    func getLoanCalculaterResult (loanCalculatorResponse: LoanCalculatorResponse) -> LoanCalculator {
       
        let dataFromResponse = loanCalculatorResponse.data
        var loanCalculatorData = LoanCalculator()
        loanCalculatorData.firstPayment = dataFromResponse.firstPayment
        loanCalculatorData.conSaving = dataFromResponse.conSaving
        loanCalculatorData.lastPayment = dataFromResponse.lastPayment
        loanCalculatorData.monthlyPayment = dataFromResponse.monthlyPayment
        loanCalculatorData.processingFees = dataFromResponse.processingFees
        loanCalculatorData.totalConSaving = dataFromResponse.totalConSaving
        loanCalculatorData.totalRepayment = dataFromResponse.totalRepayment
            
        return loanCalculatorData
    }
        
}
