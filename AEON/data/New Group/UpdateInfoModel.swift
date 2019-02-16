//
//  UpdateInfoModel.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/16/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON
class UpdateInfoModel:BaseModel {
    
    func loadUserQAList(customerId:String,success: @escaping ([UserQAResponse]) -> Void,failure: @escaping (String) -> Void){
        let rawData = ["customerId":customerId]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.userQAList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let checkMemberResponse = try? JSONDecoder().decode([UserQAResponse].self, from: responseValue){
                    success(checkMemberResponse)
                }else{
                    failure("Cannot load any data")
                }
                break
            case .failure(let error):
                failure(error.localizedDescription)
                break
            }
        }
    }
    
    
    func updateUserQAList(rawData:Data,success: @escaping (UpdateUserQAResponse) -> Void,failure: @escaping (String) -> Void){
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.updateUserQAList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let checkMemberResponse = try? JSONDecoder().decode(UpdateUserQAResponse.self, from: responseValue){
                    success(checkMemberResponse)
                }else{
                    failure("Cannot load any data")
                }
                break
            case .failure(let error):
                failure(error.localizedDescription)
                break
            }
        }
    }
    
}
