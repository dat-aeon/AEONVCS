//
//  NewVersionModel.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 4/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NewVersionModel:BaseModel {
    
    func getVersionInfo(newVersion:String,success: @escaping (NewVersionResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "versionNo": newVersion,
            "osType" : "2"
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.newVersionInfo, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                var versionResponse = NewVersionResponse()
                if response["status"] as? String != nil {
                    let data = response["data"] as AnyObject
                    versionResponse.status = response["status"] as? String
                    versionResponse.forceUpdFlag = data["forceUpdFlag"] as? String
                    versionResponse.appStoreUrl = data["appStoreUrl"] as? String
                    versionResponse.messageCode = data["messageCode"] as? String
                    versionResponse.versionUpdateInfo = data["versionUpdateInfo"] as? String
                    success(versionResponse)
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
                
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                if let newVersionResponse = try? JSONDecoder().decode(NewVersionResponse.self, from: responseValue){
//                    success(newVersionResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
            case .failure(let error):
                print("version error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
}
