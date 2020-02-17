//
//  PromotionViewModel.swift
//  AEONVCS
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class PromotionViewModel{
    
    func getPromoRequest(tokenInfo:TokenData, success: @escaping ([PromotionBean]) -> Void,failure: @escaping (String) -> Void){
        
        PromotionModel.init().getPromoList(token: tokenInfo.access_token!, success: { (result) in
            //print("Promo View Model result ::::: \(result)")
            if result.status == Constants.STATUS_200 {
                
                let promoList = self.getPromotionBeanList(promotionResponse: result)
                success(promoList)
            } else {
                print("Promo List failure:", result.status)
                failure(Constants.SERVER_INTERNAL_FAILURE)
                
            }
            
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
                        
                        PromotionModel.init().getPromoList(token: tokenInfo.access_token!, success: { (result) in
                            //print("Promo View Model result ::::: \(result)")
                            
                            if result.status == Constants.STATUS_200 {
                                
                                let promoList = self.getPromotionBeanList(promotionResponse: result)
                                success(promoList)
                            } else {
                                print("Promo List failure:", result.status)
                                failure(Constants.SERVER_INTERNAL_FAILURE)
                                
                            }
                            
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
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
    
    func getNewPromoRequest( success: @escaping ([PromotionBean]) -> Void,failure: @escaping (String) -> Void){
        
        PromotionModel.init().getNewPromoList(success: { (result) in
            //print("Promo View Model result ::::: \(result)")
            if result.status == Constants.STATUS_200 {
                
                let promoList = self.getPromotionBeanList(promotionResponse: result)
                success(promoList)
            } else {
                print("Promo List failure:", result.status)
                failure(Constants.SERVER_INTERNAL_FAILURE)
                
            }
            
        }) { (error) in
//            if error == Constants.EXPIRE_TOKEN {
//                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
//
//                    if result.status == Constants.STATUS_200 {
//                        var token = TokenBean()
//                        token.accessToken = result.data.access_token
//                        token.refreshToken = result.data.refresh_token
//                        token.tokenType = result.data.token_type
//                        token.scope = result.data.scope
//                        token.expireIn = result.data.expire_in
//
//                        let jsonData = try? JSONEncoder().encode(result)
//                        let jsonString = String(data: jsonData!, encoding: .utf8)!
//                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
//
//                        PromotionModel.init().getPromoList(token: tokenInfo.access_token!, success: { (result) in
//                            //print("Promo View Model result ::::: \(result)")
//
//                            if result.status == Constants.STATUS_200 {
//
//                                let promoList = self.getPromotionBeanList(promotionResponse: result)
//                                success(promoList)
//                            } else {
//                                print("Promo List failure:", result.status)
//                                failure(Constants.SERVER_INTERNAL_FAILURE)
//
//                            }
//
//                        }) { (error) in
//                            failure(Constants.EXPIRE_TOKEN)
//                        }
//
//                    } else {
//                        failure(Constants.EXPIRE_TOKEN)
//                    }
//
//                }) { (error) in
//                    failure(Constants.EXPIRE_TOKEN)
//                }
//            }
            failure(error)
        }
    }
    
    func getPromotionBeanList (promotionResponse: PromotionResponse) -> [PromotionBean] {
        var promoList = [PromotionBean]()
        for promoResBean in promotionResponse.promotionDtoBeanList ?? [] {
            var promoBean = PromotionBean()
            promoBean.promotionsInfoId = promoResBean.promotionsInfoId ?? 0
            promoBean.contentEng = promoResBean.contentEng
            promoBean.contentMyn = promoResBean.contentMyn
            promoBean.titleEng = promoResBean.titleEng
            promoBean.titleMyn = promoResBean.titleMyn
//            promoBean.displayDate = Utils.changeDMYDateformat(date: promoResBean.displayDate!)
            promoBean.displayDate = Utils.getDateFromDisplayDate(date: promoResBean.displayDate!)
            promoBean.publishedFromDate = promoResBean.publishedFromDate
            promoBean.publishedToDate = promoResBean.publishedToDate
            promoBean.imagePath = promoResBean.imagePath
            promoBean.announcementUrl = promoResBean.announcementUrl
            
            if promoResBean.longitude == nil || promoResBean.longitude == Constants.BLANK {
                promoBean.isLocationNull = true
            } else {
                promoBean.longitude = Double(promoResBean.longitude!)
            }
            if promoResBean.latitude == nil || promoResBean.latitude == Constants.BLANK {
                promoBean.isLocationNull = true
            } else {
                promoBean.latitude = Double(promoResBean.latitude!)
            }
            
            promoList.append(promoBean)
        }
        return promoList
    }
    
    func changeDateformat ( date: String) -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let convertDate = formatter.date(from: date)
        
        formatter.dateFormat = "dd-MM-yyyy"
        let myString = formatter.string(from: convertDate!)
        
        return myString
    }
}
