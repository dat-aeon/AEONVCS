//
//  CouponViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class CouponViewModel{
    
    func getCouponRequest(siteActivationKey:String,customerId:String,success: @escaping ([CouponBean]) -> Void,failure: @escaping (String) -> Void){
        CouponModel.init().getCouponList(siteActivationKey: siteActivationKey, customerId: customerId, success: { (result) in
            print("Coupon View Model result ::::: \(result)")
            if result.statusCode == "200" {
                var couponList = [CouponBean]()
                for couponResBean in result.couponInfoResBeanList ?? [] {
                    var couponBean = CouponBean()
                    couponBean.couponId = couponResBean.couponId
                    couponBean.shopId = couponResBean.shopId
                    couponBean.couponCode = couponResBean.couponCode
                    couponBean.couponNameMM = couponResBean.couponNameMM
                    couponBean.couponNameEN = couponResBean.couponNameEN
                    couponBean.descriptionMM = couponResBean.descriptionMM
                    couponBean.descriptionEN = couponResBean.descriptionEN
                    couponBean.specialEventMM = couponResBean.specialEventMM
                    couponBean.specialEventEN = couponResBean.specialEventEN
                    couponBean.couponAmount = couponResBean.couponAmount
                    couponBean.goodsPrice = couponResBean.goodsPrice
                    couponBean.startTime = couponResBean.startTime
                    couponBean.expiredTime = couponResBean.expiredTime
                    couponBean.discountUnit = couponResBean.discountUnit
                    couponBean.unuseImagePath = couponResBean.unuseImagePath
                    couponBean.useImagePath = couponResBean.useImagePath
                    couponBean.totalNum = couponResBean.totalNum
                    couponBean.customerId = couponResBean.customerId
                    couponBean.status = couponResBean.status
                    couponList.append(couponBean)
                }
                
                success(couponList)
            } else if result.statusCode == "500" {
                
            } else {
                failure(result.statusMessage)
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
    // Update Coupon Info
    func updateCoupon(customerId:String,couponId:String,shopId:String,couponPassword:String,success: @escaping (CouponUpdateResponse) -> Void,failure: @escaping (String) -> Void){
        
        CouponModel.init().updateCouponRequest(customerId: customerId,couponId:couponId,shopId: shopId, couponPassword: couponPassword, success: { (result) in
            print("Coupon Update View Model result ::::: \(result)")
            if result.statusCode == "200" {
                success(result)
            } else {
                failure(result.statusMessage)
            }
            
        }) { (error) in
            failure(error)
        }
    }
}
