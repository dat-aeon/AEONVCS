//
//  askProductModel.swift
//  AEONVCS
//
//  Created by Ant on 06/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class contactUsModel:BaseModel {
    
    
    
    func contactUsMessage(customerId: Int,levelType: Int, success: @escaping (contactUsResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = ["customerId": customerId,"levelType": levelType]
        _ = super.getAskProductUnreadPostWithoutToken(endPoint: ApiServiceEndPoint.contactUpMessageApi, rawData: rawData) { (result) in
      //  print("askProductunread Response result kaungmyatsan:::::::::::\(result)")
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue = try! responseJsonData.rawData()
                if let askProductUnReadResponse = try?
                    JSONDecoder().decode(contactUsResponse.self, from: responseValue){
                    success(askProductUnReadResponse)
                }else{
                    failure(Constants.JSON_FAILURE)
                }
            case .failure(let error):
                print("error kms", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
//    func makeroomSync(phoneNo:String, success: @escaping (RoomSyncResponse) -> Void,failure: @escaping (String) -> Void){
//          let rawData = [
//              "phoneNo": phoneNo
//          ]
//
//          let _ = super.requestPOSTWithoutToken(endPoint: ApiServiceEndPoint.roomsync, rawData: rawData) { (result) in
//
//              //print("Login Response result :::::::::::\(result)")
//              switch result{
//              case .success(let result):
//
//                  let responseJsonData = JSON(result)
//                  let responseValue  = try! responseJsonData.rawData()
    //              if let roomSynceResponse = try? JSONDecoder().decode(RoomSyncResponse.self, from: responseValue){
//                      success(roomSynceResponse)
//                  }else{
//                      failure(Constants.JSON_FAILURE)
//                  }
//
//              case .failure(let error):
//                  //print("Login error", error.localizedDescription)
//                  failure(Constants.SERVER_FAILURE)
//              }
//
//          }
//
//      }
      
    
//////////////////
//    func askProductSync(customerId:Int, success: @escaping (askProductResponse) -> Void,failure: @escaping (String) -> Void){
//        let rawData = [
//            "customerId": customerId
//        ]
//
//        let _ = super.getAskProductUnread(endPoint: ApiServiceEndPoint.askproductunread, rawData: rawData) { (result) in
//            switch result{
//                       case .success(let result):
//
//                           let responseJsonData = JSON(result)
//                           let responseValue  = try! responseJsonData.rawData()
//                           if let askProductsResponse = try? JSONDecoder().decode(askProductResponse.self, from: responseValue){
//                               success(askProductsResponse)
//                           }else{
//                               failure(Constants.JSON_FAILURE)
//                           }
//                       case .failure(let error):
//                           //print("Login error", error.localizedDescription)
//                           failure(Constants.SERVER_FAILURE)
//                       }
//        }
//
//
//
//    }
    
    
}
