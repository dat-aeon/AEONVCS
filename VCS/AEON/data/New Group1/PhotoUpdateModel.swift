//
//  PhotoUpdateModel.swift
//  AEONVCS
//
//  Created by mac on 7/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class PhotoUpdateModel : BaseModel {
    
    //Update member profile photo
    func updateImage(rawData:Data,token:String, success: @escaping (ProfileUpdateResponse) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataObjWithToken(endPoint: ApiServiceEndPoint.profileUpdate, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("verify register response : ", response)
                
                if Constants.STATUS_200 == response["status"] as? String {
                    let data = response["data"] as AnyObject
                    var updateResponse = ProfileUpdateResponse()
                    if (data["photoPath"]) != nil {
                        updateResponse.status = Constants.STATUS_200
                        updateResponse.data.photoPath = (data["photoPath"] as? String)!
                    }
                    success(updateResponse)
                    
                } else if Constants.STATUS_500 == response["status"] as? String {
                    failure(response["message"] as! String)
                    
                } else if Constants.EXPIRE_TOKEN == response["error"] as? String {
                    failure(response["error"] as! String)
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
            case .failure( _):
                print("Register New error",failure.self)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
}
