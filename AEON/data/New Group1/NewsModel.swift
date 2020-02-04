//
//  NewsModel.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 4/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NewsModel:BaseModel {
    
    func getNewsList(token:String, success: @escaping (NewsResponse) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        let rawData = [
            "access_token" : ""
        ]
        let _ = super.requestDataWithGETToken(endPoint: ApiServiceEndPoint.newsInfo, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                //print("News Response result :::::::::::\(result)")
                
                if let newsResponse = try? JSONDecoder().decode(NewsResponse.self, from: responseValue){
                    success(newsResponse)
                }else{
                    failure(Constants.EXPIRE_TOKEN)
                }
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                
            }
        }
    }
}
