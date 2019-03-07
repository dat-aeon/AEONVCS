//
//  SecQuesVerifyModel.swift
//  AEONVCS
//
//  Created by mac on 2/19/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON
class SecQuesVerifyModel:BaseModel {
    
    func verifyUserQAList(userVerifyBeanRequest:UserSecQuesVerifyRequest,success: @escaping (UserQAVerifyResponse) -> Void,failure: @escaping (String) -> Void){
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try! jsonEncoder.encode(userVerifyBeanRequest.secQuesVerifyList)
//        let qaString = String(data: jsonData, encoding: String.Encoding.utf8)
//
//        let rawData = [
//            "customerId" : userVerifyBeanRequest.customerId,
//            "secQuesList" : qaString
//        ]
        let rawData = getVerifyUserRequestData(userVerifyBeanRequest: userVerifyBeanRequest)
        
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.verifyQAList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let userQuesResponse = try? JSONDecoder().decode(UserQAVerifyResponse.self, from: responseValue){
                    success(userQuesResponse)
                }else{
                    failure("Cannot load any data")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    //GET REQUEST DATA FOR VERIFY MEMBER
    func getVerifyUserRequestData(userVerifyBeanRequest:UserSecQuesVerifyRequest)->Data{
        
        do {
            let jsonData = try JSONEncoder().encode(userVerifyBeanRequest)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print("Encode \(jsonString)")
            
            return jsonData
        } catch { print("Error \(error)") }
        
        return Data()
    }
    
}
