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
    
    func getCouponList(siteActivationKey:String, customerId:String,success: @escaping (CouponResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "siteActivationKey": siteActivationKey,
            "customerId" : customerId
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.couponInfo, rawData: rawData) { (result) in
             switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                print("Coupon Response result :::::::::::\(result)")
                if let otpResponse = try? JSONDecoder().decode(CouponResponse.self, from: responseValue){
                    success(otpResponse)
                }else{
                    failure("Coupon JSON parse error")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func updateCouponRequest(customerId:String, couponId:String, shopId:String, couponPassword:String,success: @escaping (CouponUpdateResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
            "customerId" : customerId,
            "couponId" : couponId,
            "shopId" : shopId,
            "couponPassword" : couponPassword
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.couponUpdate, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                print("Coupon Update Response result :::::::::::\(result)")
                if let otpResponse = try? JSONDecoder().decode(CouponUpdateResponse.self, from: responseValue){
                    success(otpResponse)
                }else{
                    failure("Coupon JSON parse error")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
}
