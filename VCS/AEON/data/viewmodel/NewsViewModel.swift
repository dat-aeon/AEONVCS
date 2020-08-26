//
//  NewsViewModel.swift
//  AEONVCS
//
//  Created by mac on 4/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
class NewsViewModel{
    
    func getNewsRequest(tokenInfo:TokenData, success: @escaping ([NewsInfoBean]) -> Void,failure: @escaping (String) -> Void){
        
        NewsModel.init().getNewsList(token: tokenInfo.access_token!, success: { (result) in
            //print("News View Model result ::::: \(result)")
            if result.status == Constants.STATUS_200 {
                
                let newsList = self.getNewsInfoBeanList(newsResponse: result)
                success(newsList)
            } else {
                print("News List failure:", result.status)
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
                        
                        NewsModel.init().getNewsList(token: tokenInfo.access_token!, success: { (result) in
                            //print("News View Model result ::::: \(result)")
                            if result.status == Constants.STATUS_200 {
                                
                                let newsList = self.getNewsInfoBeanList(newsResponse: result)
                                success(newsList)
                            } else {
                                print("News List failure:", result.status)
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
    
    func getNewNewsRequest(success: @escaping ([NewsInfoBean]) -> Void,failure: @escaping (String) -> Void){
        
        NewsModel.init().getNewNewsList(success: { (result) in
            //print("News View Model result ::::: \(result)")
            if result.status == Constants.STATUS_200 {
                
                let newsList = self.getNewsInfoBeanList(newsResponse: result)
                success(newsList)
            } else {
                print("News List failure:", result.status)
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
//                        NewsModel.init().getNewsList(token: tokenInfo.access_token!, success: { (result) in
//                            //print("News View Model result ::::: \(result)")
//                            if result.status == Constants.STATUS_200 {
//
//                                let newsList = self.getNewsInfoBeanList(newsResponse: result)
//                                success(newsList)
//                            } else {
//                                print("News List failure:", result.status)
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
    
    
    func getNewsInfoBeanList (newsResponse: NewsResponse) -> [NewsInfoBean] {
        var newsList = [NewsInfoBean]()
        for newsResBean in newsResponse.newsInfoDtoList ?? [] {
            var newsInfoBean = NewsInfoBean()
            newsInfoBean.newsInfoId = newsResBean.newsInfoId ?? 0
            newsInfoBean.contentEng = newsResBean.contentEng
            newsInfoBean.contentMyn = newsResBean.contentMyn
            newsInfoBean.titleEng = newsResBean.titleEng
            newsInfoBean.titleMyn = newsResBean.titleMyn
            newsInfoBean.displayDate = Utils.getDateFromDisplayDate(date: newsResBean.displayDate!)//Utils.changeDMYDateformat(date: newsResBean.displayDate!) // //
//            newsInfoBean.publishedFromDate = self.changeDateformat(date: newsResBean.publishedFromDate!)
            newsInfoBean.publishedFromDate = newsResBean.publishedFromDate!
            newsInfoBean.publishedToDate = newsResBean.publishedToDate
            newsInfoBean.imagePath = newsResBean.imagePath
            newsInfoBean.newsUrl = newsResBean.newsUrl
            
            if newsResBean.longitude == nil || newsResBean.longitude == Constants.BLANK {
                newsInfoBean.isLocationNull = true
            } else {
                newsInfoBean.longitude = Double(newsResBean.longitude!)
            }
            if newsResBean.latitude == nil || newsResBean.latitude == Constants.BLANK {
                newsInfoBean.isLocationNull = true
            } else {
                newsInfoBean.latitude = Double(newsResBean.latitude!)
            }
            
            newsList.append(newsInfoBean)
        }
        return newsList
    }
    
    func changeDateformat ( date: String) -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let convertDate = formatter.date(from: date)
        
        formatter.dateFormat = "dd-MM-yyyy HH:mm a"
        let myString = formatter.string(from: convertDate!)
        
        return myString
    }
    
    func changeDateFormatNewiOS(date: String) -> String {
        let dobtemp = date.strstr(needle: "T", beforeNeedle: true)
        let substrings = dobtemp?.split(separator: "-", maxSplits: 2, omittingEmptySubsequences: false)
        
        var formattedString = ""
        if substrings?.count == 3 {
            formattedString = "\(substrings![0])-\(substrings![1])-\(substrings![2])"
        }
        
         let hrmmtemp = date.strstr(needle: "T", beforeNeedle: false)
        let hrmmsubstrings = hrmmtemp?.split(separator: ":", maxSplits: 2, omittingEmptySubsequences: false)
        
        var hrmmString = ""
        if hrmmsubstrings!.count > 2 {
            hrmmString = "\(hrmmsubstrings![0]):\(hrmmsubstrings![1])"
        }
        
        
        return ""
    }
}
