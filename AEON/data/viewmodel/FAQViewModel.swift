//
//  FAQViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

class FAQViewModel{
    
    var dataEnList = [FAQHeaderListItem]()
    var dataMyList = [FAQHeaderListItem]()
    var faqDataList = [FAQCategoryDataBean]()
    
    func getFAQData(siteActivationKey:String ,success: @escaping ([FAQHeaderListItem],[FAQHeaderListItem]) -> Void,failure: @escaping (String) -> Void){
        FAQDataModel.init().getFaqData(siteActivationKey: siteActivationKey, success: { (result) in
            
            self.faqDataList = result.data
            
            for catagoryData in self.faqDataList {
                
                var faqEnItemList = [FAQItem]()
                var faqMyItemList = [FAQItem]()
                for faqdata in catagoryData.faqInfoResDtoList {
            
                    var faqEnItem = FAQItem()
                    faqEnItem.isCollapsed = false
                    faqEnItem.answer = faqdata.answerEN;
                    faqEnItem.subQuestion = faqdata.questionEN
                    faqEnItemList.append(faqEnItem)
                    
                    var faqMyItem = FAQItem()
                    faqMyItem.isCollapsed = false
                    faqMyItem.answer = faqdata.answerMM;
                    faqMyItem.subQuestion = faqdata.questionMM
                    faqMyItemList.append(faqMyItem)
                }
                
                let dataEN = FAQHeaderListItem(question: catagoryData.faqCategoryEng,subFaqList: faqEnItemList)
                let dataMM = FAQHeaderListItem(question: catagoryData.faqCategoryMyn,subFaqList: faqMyItemList)
                
                self.dataEnList.append(dataEN)
                self.dataMyList.append(dataMM)
            }
            success(self.dataEnList,self.dataMyList)
            
        }) { (error) in
            failure(error)
        }
    }
   
}
