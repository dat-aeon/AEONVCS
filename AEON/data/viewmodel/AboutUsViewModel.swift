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
           success(result)
           
        }) { (error) in
            failure(error)
        }
    }
}
