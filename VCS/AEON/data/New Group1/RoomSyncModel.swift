//
//  RoomSyncModel.swift
//  AEONVCS
//
//  Created by mac on 2/11/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RoomSyncModel:BaseModel {
    
    func makeroomSync(phoneNo:String, success: @escaping (RoomSyncResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "phoneNo": phoneNo
        ]

        let _ = super.requestPOSTWithoutToken(endPoint: ApiServiceEndPoint.roomsync, rawData: rawData) { (result) in
            
            //print("Login Response result :::::::::::\(result)")
            switch result{
            case .success(let result):
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let roomSynceResponse = try? JSONDecoder().decode(RoomSyncResponse.self, from: responseValue){
                    success(roomSynceResponse)
                }else{
                    failure(Constants.JSON_FAILURE)
                }
           
            case .failure(let error):
                //print("Login error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
            
        }
        
    }
    
    
}
