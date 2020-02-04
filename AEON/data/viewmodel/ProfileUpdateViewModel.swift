//
//  ProfileUpdateViewModel.swift
//  AEONVCS
//
//  Created by mac on 7/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit
class ProfileUpdateViewModel {
    
    //MAKE VERIFY MEMBER REGISTER
    func updateProfileImage(customerId:String, customerNo:String, profileImage:UIImage, phoneNo:String, token:String, refreshToken:String, success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        
        let imageData:NSData = profileImage.pngData()! as NSData
        let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        
        let rawData = [
            "customerId" : customerId,
            "photoByte" : imageBase64
        ]
        
        let jsonEncoder = JSONEncoder()
        let verifyData = try! jsonEncoder.encode(rawData)
        //let verifyData = String(data: jsonData, encoding: String.Encoding.utf8)
        
        PhotoUpdateModel.init().registerVerifyMember(rawData:verifyData, token: token, success: { (result) in
            if result.status == Constants.STATUS_200 {
                success(result)
                
            } else {
                failure(result.status)
            }
            
        }) { (error) in
            
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: refreshToken, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        RegisterModel.init().registerVerifyMember(rawData:verifyData,token: token.accessToken!, success: { (result) in
                            if result.status == Constants.STATUS_200 {
                                success(result)
                                
                            } else {
                                failure(result.status)
                            }
                            
                        }) { (error) in
                            failure(error)
                        }
                        
                    } else {
                        failure(result.status ?? "FAILED")
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
}
