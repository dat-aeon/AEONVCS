//
//  FAQViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class FAQViewModel{
    var dataList = [FAQHeaderListItem]()
    var faqDataList = [FAQCateoryDataBeanElement]()
    
    func getFAQData(loginId:String ,success: @escaping ([FAQHeaderListItem]) -> Void,failure: @escaping (String) -> Void){
        FAQDataModel.init().getFaqData(loginId: loginId, success: { (result) in
            
            self.faqDataList = result
            
            for catagoryData in self.faqDataList {
                
                var faqItemList = [FAQItem]()
                for faqdata in catagoryData.faqInfoResInfoList {
            
                    var faqItem = FAQItem()
                    faqItem.isCollapsed = false
                    faqItem.answer = faqdata.answerEN;
                    faqItem.subQuestion = faqdata.questionEN
                    
                    faqItemList.append(faqItem)
                }
                
                let data = FAQHeaderListItem(question: catagoryData.faqCategory,subFaqList: faqItemList)
                
                self.dataList.append(data)
            }
            success(self.dataList)
            
            print("call View Model :::::::::::\(self.dataList.count)")
            
            
        }) { (error) in
            failure(error)
        }
    }
   
}
