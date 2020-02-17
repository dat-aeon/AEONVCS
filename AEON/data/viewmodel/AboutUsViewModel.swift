//
//  AboutUsViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class AboutUsViewModel{
    
    func getAboutUsData(siteActivationKey:String,success: @escaping (AboutUsResponse) -> Void,failure: @escaping (String) -> Void){
        AboutUsModel.init().getAboutUs(siteActivationKey: siteActivationKey, success: { (result) in
           
            if result.status == Constants.STATUS_200 {
                success(result)
            
            } else {
                failure(Constants.SERVER_FAILURE)
            }
           
        }) { (error) in
            failure(error)
        }
    }
    
    func getVideoFilePath(siteActivationKey:String,success: @escaping (VideoFileResponse) -> Void,failure: @escaping (String) -> Void){
        AboutUsModel.init().getVideoPath(siteActivationKey: siteActivationKey, success: { (result) in
           
            if result.status == Constants.STATUS_200 {
                success(result)
            
            } else {
                failure(Constants.SERVER_FAILURE)
            }
           
        }) { (error) in
            failure(error)
        }
    }
    
}
