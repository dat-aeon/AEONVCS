//
//  LoanCalculatorModel.swift
//  AEONVCS
//
//  Created by mac on 8/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoanCalculatorModel:BaseModel {
    
    func calculateLoan(calculatorInfo: LoanCalculatorRequest, success: @escaping (LoanCalculatorResponse) -> Void,failure: @escaping (String) -> Void){
//        let token = [
//            "access_token" : token
//        ]
//
        let rawData = [
            "financeAmount": calculatorInfo.financeAmount,
            "loanTerm": calculatorInfo.loanTerm,
            "motorCycleLoanFlag": calculatorInfo.motorCycleLoanFlag
        ]
        
        let _ = super.requestPOSTWithoutToken(endPoint: ApiServiceEndPoint.loanCalculator, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                //print("News Response result :::::::::::\(result)")
                
                if let newsResponse = try? JSONDecoder().decode(LoanCalculatorResponse.self, from: responseValue){
                    success(newsResponse)
                }else{
                    failure(Constants.EXPIRE_TOKEN)
                }
            case .failure(let error):
                print("Failure on loan calculator:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                
            }
        }
    }
}
