//
//  FAQDataModel.swift
//  AEON
//
//  Created by AcePlus101 on 2/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FAQDataModel: BaseModel{
    func getFAQHeaderListItemData() -> [FAQHeaderListItem] {
        var data = [FAQHeaderListItem]()
        
        
        
        let faqItem1 = FAQItem(subQuestion: "Q1 This is my question", answer: "Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer ", isCollapsed: false)
        let faqItem2 = FAQItem(subQuestion: "Q2 This is my question", answer: "A1Answer Answer Answer Answer Answer Answer Answer Answer ", isCollapsed: false)
        let faqItem3 = FAQItem(subQuestion: "Q3 This is my question", answer: "A1Answer Answer Answer Answer Answer Answer Answer Answer Answer Answer ", isCollapsed: false)
        let faqItem4 = FAQItem(subQuestion: "Q4 This is my questionQ4 This is my questionQ4 This is my question", answer: "A1Answer Answer Answer ", isCollapsed: false)
        let faqItem5 = FAQItem(subQuestion: "Q5 This is my question", answer: "A1Answer Answer Answer A1Answer Answer Answer A1Answer Answer Answer A1Answer Answer Answer A1Answer Answer Answer A1Answer Answer Answer ", isCollapsed: false)
        let faqItem6 = FAQItem(subQuestion: "Q6 This is my question", answer: "A1Answer Answer Answer ", isCollapsed: false)
        let faqItem7 = FAQItem(subQuestion: "Q7 This is my question", answer: "A1Answer Answer Answer Answer ", isCollapsed: false)
        let faqItem8 = FAQItem(subQuestion: "Q8 This is my question", answer: "A1Answer Answer Answer Answer Answer ", isCollapsed: false)
        let faqItem9 = FAQItem(subQuestion: "Q9 This is my question", answer: "A1Answer Answer Answer Answer ", isCollapsed: false)
        let faqItem10 = FAQItem(subQuestion: "Q10 This is my question", answer: "A1Answer Answer Answer Answer ", isCollapsed: false)
        let faqItem11 = FAQItem(subQuestion: "Q11 This is my question", answer: "A1Answer Answer Answer Answer ", isCollapsed: false)
        
        let faqItemList1 = [faqItem1,faqItem2,faqItem3]
        let faqItemList2 = [faqItem4,faqItem5,faqItem6]
        let faqItemList3 = [faqItem7,faqItem8,faqItem9]
        let faqItemList4 = [faqItem10,faqItem11]
        
        let faqHeaderListItem1 = FAQHeaderListItem(question: "This is my question1. This is my question. This is my question. This is my question. ",subFaqList: faqItemList1)
        
        let faqHeaderListItem2 = FAQHeaderListItem(question: "This is my question2",subFaqList: faqItemList2)
        
        let faqHeaderListItem3 = FAQHeaderListItem(question: "This is my question3",subFaqList: faqItemList3)
        
        let faqHeaderListItem4 = FAQHeaderListItem(question: "This is my question4",subFaqList: faqItemList4)
        
        
        data.append(faqHeaderListItem1)
        data.append(faqHeaderListItem2)
        data.append(faqHeaderListItem3)
        data.append(faqHeaderListItem4)
        
        return data
    }
    
    func getFaqData(siteActivationKey:String,success: @escaping (FAQCateoryDataBean) -> Void,failure: @escaping (String) -> Void){
        let rawData = [
           "siteActivationKey" : siteActivationKey
        ]
        let _ = super.performRequest(endPoint: ApiServiceEndPoint.faqList, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                print("call data model result :::::::::::\(responseValue)")
                
                //if let loginResponse = try? JSONDecoder().decode(FAQResponse.self, from: responseValue){
                
                do {
                    if let fAQCateoryDataBean:FAQCateoryDataBean = try? JSONDecoder().decode(FAQCateoryDataBean.self, from: responseValue){
                        success(fAQCateoryDataBean)
                        print("call data model :::::::::::\(fAQCateoryDataBean)")
                        
                        //return fAQCateoryDataBean;
                    }else{
                        failure("Cannot load any data")
                    }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
}
