//
//  LevelTwoMessageModel.swift
//  AEONVCS
//
//  Created by Ant on 07/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LevelTwoMessageUnreadModel:BaseModel {



func levelTwoMessageUnreadSync(customerId: Int, success: @escaping (levelTwoMessageUnReadResponse) -> Void,failure: @escaping (String) -> Void){
    let rawData = ["customerId": customerId]
    _ = super.getAskProductUnreadPostWithoutToken(endPoint: ApiServiceEndPoint.LEVEL_TWO_MESSAGE_UNREAD, rawData: rawData) { (result) in
    print("askProductunread Response result kaungmyatsan:::::::::::\(result)")
        switch result{
        case .success(let result):
            let responseJsonData = JSON(result)
            let responseValue = try! responseJsonData.rawData()
            if let levelTwoUnReadResponse = try?
                JSONDecoder().decode(levelTwoMessageUnReadResponse.self, from: responseValue){
                success(levelTwoUnReadResponse)
            }else{
                failure(Constants.JSON_FAILURE)
            }
        case .failure(let error):
            print("error kms", error.localizedDescription)
            failure(Constants.SERVER_FAILURE)
        }
    }
}
}
