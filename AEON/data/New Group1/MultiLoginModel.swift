//
//  MultiLoginModel.swift
//  AEONVCS
//
//  Created by Ant on 07/05/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MultiLoginModel:BaseModel {
    func makeMultiLogin(customerId: String,loginDeviceId: String ,success: @escaping (MultiLoginResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId": "\(customerId)",
            "loginDeviceId": loginDeviceId
            ]
        let _ = super.requestPOSTWithoutToken(endPoint: ApiServiceEndPoint.MULTI_LOGIN, rawData: rawData) { (result) in
            switch result{
                   case .success(let result):
                       
                       let responseJsonData = JSON(result)
                       let responseValue  = try! responseJsonData.rawData()
                       if let MultiResponse = try? JSONDecoder().decode(MultiLoginResponse.self, from: responseValue){
                           success(MultiResponse)
                       }else{
                         //  failure(Constants.JSON_FAILURE)
                       }
                  
            case .failure( _):
                       //print("Login error", error.localizedDescription)
                       failure(Constants.SERVER_FAILURE)
                   }
        }
    }
  
}

//func makeroomSync(phoneNo:String, success: @escaping (RoomSyncResponse) -> Void,failure: @escaping (String) -> Void){
//    let rawData = [
//        "phoneNo": phoneNo
//    ]
//
//    let _ = super.requestPOSTWithoutToken(endPoint: ApiServiceEndPoint.roomsync, rawData: rawData) { (result) in
//        
//        //print("Login Response result :::::::::::\(result)")
//        switch result{
//        case .success(let result):
//            
//            let responseJsonData = JSON(result)
//            let responseValue  = try! responseJsonData.rawData()
//            if let roomSynceResponse = try? JSONDecoder().decode(RoomSyncResponse.self, from: responseValue){
//                success(roomSynceResponse)
//            }else{
//                failure(Constants.JSON_FAILURE)
//            }
//       
//        case .failure(let error):
//            //print("Login error", error.localizedDescription)
//            failure(Constants.SERVER_FAILURE)
//        }
//        
//    }
//    
//}
