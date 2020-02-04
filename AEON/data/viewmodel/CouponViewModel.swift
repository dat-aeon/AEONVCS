//
//  CouponViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class CouponViewModel{
    
    func getCouponRequest(token:String,refreshToken:String, customerId:String,success: @escaping ([CouponBean]) -> Void,failure: @escaping (String) -> Void){
        
        CouponModel.init().getCouponList(token: token, customerId: customerId, success: { (result) in
            //print("Coupon View Model result ::::: \(result)")
            if result.status == Constants.STATUS_200 {
                
                let couponList = self.getCouponBeanList(couponResponse: result)
                success(couponList)
                
            } else {
                print("Coupon List failure:", result.status)
                failure(Constants.SERVER_INTERNAL_FAILURE)
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
                        
                        CouponModel.init().getCouponList(token: token.accessToken!, customerId: customerId, success: { (result) in
                            
                            if result.status == Constants.STATUS_200 {
                                let couponList = self.getCouponBeanList(couponResponse: result)
                                success(couponList)
                                
                            } else {
                                failure(result.status)
                            }
                            
                        }) { (error) in
                            failure(error)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
    // Update Coupon Info
    func updateCoupon(customerId:String,couponId:String,couponPassword:String,tokenInfo: TokenData, success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        
        CouponModel.init().updateCouponRequest(customerId: customerId,couponId:couponId, couponPassword: couponPassword, token: tokenInfo.access_token!, success: { (result) in
            
            //print("Coupon Update View Model result ::::: \(result)")
            success(result)
            
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
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
                        
                        CouponModel.init().updateCouponRequest(customerId: customerId, couponId:couponId, couponPassword: couponPassword, token: token.accessToken!, success: { (result) in
                            
                            //print("Coupon Update View Model result ::::: \(result)")
                            success(result)
                            
                        }) { (error) in
                            failure(error)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
    func getCouponBeanList (couponResponse: CouponResponse) -> [CouponBean] {
        var couponList = [CouponBean]()
        for couponResBean in couponResponse.data ?? [] {
            var couponBean = CouponBean()
            couponBean.couponId = "\(couponResBean.couponId)"
            couponBean.couponCode = couponResBean.couponCode
            couponBean.couponNameMM = couponResBean.couponNameMM
            couponBean.couponNameEN = couponResBean.couponNameEN
            couponBean.descriptionMM = couponResBean.descriptionMM
            couponBean.descriptionEN = couponResBean.descriptionEN
            couponBean.specialEventMM = couponResBean.specialEventMM ?? Constants.BLANK
            couponBean.specialEventEN = couponResBean.specialEventEN ?? Constants.BLANK
            couponBean.couponAmount = "\(couponResBean.couponAmount)"
            couponBean.goodsPrice = "\(couponResBean.goodsPrice)"
            couponBean.startTime = couponResBean.startTime
            couponBean.expiredTime = Utils.getDateFromDisplayDate(date: couponResBean.expiredTime)//Utils.changeDMYDateformat(date: couponResBean.expiredTime)
            if couponResBean.discountUnit == "Kyat"{
                couponBean.discountUnit = "mmk"
            } else {
                couponBean.discountUnit = "%"
            }
            couponBean.unuseImagePath = couponResBean.unuseImagePath
            couponBean.useImagePath = couponResBean.useImagePath
            couponBean.totalNum = "\(couponResBean.totalNo)"
            couponBean.customerId = "\(couponResBean.customerId)"
            couponBean.status = couponResBean.status
            couponList.append(couponBean)
        }
        return couponList
    }
}
