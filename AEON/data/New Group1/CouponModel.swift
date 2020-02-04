//
//  CouponModel.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CouponModel:BaseModel {
    
    func getCouponList(token:String, customerId:String, success: @escaping (CouponResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId" : customerId
        ]
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataWithToken(endPoint: ApiServiceEndPoint.couponInfo, rawData: rawData, token: token) { (result) in
             switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                //print("Coupon Response result :::::::::::\(result)")
                if let otpResponse = try? JSONDecoder().decode(CouponResponse.self, from: responseValue){
                    success(otpResponse)
                }else{
                    failure(Constants.EXPIRE_TOKEN)
                }
            case .failure(let error):
                print("Failure on Coupon List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                
            }
        }
    }
    
    func updateCouponRequest(customerId:String, couponId:String, couponPassword:String, token: String, success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId" : customerId,
            "couponId" : couponId,
            "couponPassword" : couponPassword
        ]
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataWithToken(endPoint: ApiServiceEndPoint.couponUpdate, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("login response : ", response)
                
                if Constants.STATUS_200 == response["status"] as? String {
                    success(response["status"] as! String)
                
                } else if Constants.STATUS_500 == response["status"] as? String{
                    success(response["messageCode"] as! String)
                    
                } else if Constants.EXPIRE_TOKEN == response["error"] as? String{
                    failure(Constants.EXPIRE_TOKEN)
                }
//                let responseJsonData = JSON(result)
//                let responseValue  = try! responseJsonData.rawData()
//                //print("Coupon Update Response result :::::::::::\(result)")
//                if let otpResponse = try? JSONDecoder().decode(CouponUpdateResponse.self, from: responseValue){
//                    success(otpResponse)
//                }else{
//                    failure(Constants.JSON_FAILURE)
//                }
            case .failure(let error):
                print("Failure on Coupon List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
}
