//
//  LoanCalculatorViewModel.swift
//  AEONVCS
//
//  Created by mac on 8/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class LoanCalculatorViewModel {
    
    func executeLoanCalculator(tokenInfo:TokenData, calculatorInfo: LoanCalculatorRequest, success: @escaping (LoanCalculator) -> Void,failure: @escaping (String) -> Void){
        
        LoanCalculatorModel.init().calculateLoan(token: "\(tokenInfo.access_token ?? "")", calculatorInfo: calculatorInfo, success: { (result) in
            
            if result.status == Constants.STATUS_200 {
                let calculatorResult = self.getLoanCalculaterResult(loanCalculatorResponse: result)
                success(calculatorResult)
                
            } else {
                failure(result.status)
            }
            
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        LoanCalculatorModel.init().calculateLoan(token: "\(token.refreshToken ?? "")", calculatorInfo: calculatorInfo, success: { (result) in
                            
                            if result.status == Constants.STATUS_200 {
                                let calculatorResult = self.getLoanCalculaterResult(loanCalculatorResponse: result)
                                success(calculatorResult)
                                
                            } else {
                                failure(result.status)
                            }
                            
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
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
