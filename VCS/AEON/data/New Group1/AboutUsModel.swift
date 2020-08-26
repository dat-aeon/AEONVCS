//
//  AboutUsModel.swift
//  AEONVCS
//
//  Created by mac on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AboutUsModel:BaseModel {
    
    func getAboutUs(siteActivationKey:String,success: @escaping (AboutUsResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "siteActivationKey": siteActivationKey
        ]
        let _ = super.requestGETWithoutToken(endPoint: ApiServiceEndPoint.aboutUs, rawData: [:]) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let aboutUsResponse = try? JSONDecoder().decode(AboutUsResponse.self, from: responseValue){
                    success(aboutUsResponse)
                }else{
                    failure(Constants.JSON_FAILURE)
                }
            case .failure(let error):
                print("AboutUs error ",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
    
    func getVideoPath(siteActivationKey:String,success: @escaping (VideoFileResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "siteActivationKey": siteActivationKey
        ]
       
        
               let _ = super.getVideoFilePath(endPoint: ApiServiceEndPoint.videofilepath, rawData: [:]) { (result) in
                   switch result{
                   case .success(let result):
                       let responseJsonData = JSON(result)
                       let responseValue  = try! responseJsonData.rawData()
                       if let videofilerResponse = try? JSONDecoder().decode(VideoFileResponse.self, from: responseValue){
                           success(videofilerResponse)
                       }else{
                           failure(Constants.JSON_FAILURE)
                       }
                   case .failure(let error):
                       print("AboutUs error ",error.localizedDescription)
                       failure(Constants.SERVER_FAILURE)
                   }
               }
    }
    
    
    
    
}
