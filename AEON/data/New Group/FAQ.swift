//
//  FAQ.swift
//  AEON
//
//  Created by AcePlus101 on 2/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
protocol FAQHeaderItem {
    var rowCount: Int { get }
    var isCollapsed: Bool { get set }
}

extension FAQHeaderItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        return true
    }
}

class FAQHeaderListItem: FAQHeaderItem {
    var isCollapsed: Bool = false
    var isFirstLoading:Bool = true
    var question:String
    var faqList = [FAQItem]()
    init(question:String,subFaqList:[FAQItem]) {
        self.question = question
        self.faqList = subFaqList
    }
    var rowCount: Int{
        return faqList.count
    }
    
}

struct FAQItem {
    var subQuestion:String = ""
    var answer:String = ""
    var isCollapsed:Bool = false
}

struct FAQResponse: Codable {
    let status: String
    let data: [FAQCategoryDataBean]
}

struct FAQCategoryDataBean: Codable {
    let faqCategoryID: Int
    let faqCategory: String
    let faqCategoryEng: String
    let faqCategoryMyn: String
    let faqInfoResDtoList: [FAQInfoResDtoList]
    
    enum CodingKeys: String, CodingKey {
        case faqCategoryID = "faqCategoryId"
        case faqCategory, faqInfoResDtoList, faqCategoryEng, faqCategoryMyn
    }
}

struct FAQInfoResDtoList: Codable {
    let faqID: Int
    let questionMM, questionEN, answerMM, answerEN: String
    let categoryID: Int
    
    enum CodingKeys: String, CodingKey {
        case faqID = "faqId"
        case questionMM, questionEN, answerMM, answerEN
        case categoryID = "categoryId"
    }
}

//
//struct FAQCateoryDataBean: Codable {
//
//    let faqCategory: Int!
//    let faqDataBean: FAQDataBean
//
//    enum CodingKeys: String, CodingKey {
//        case faqCategory = "faqCategory"
//        case faqDataBean = "faqInfoResInfoList"
//
//    }
//}
//
//struct FAQDataBean: Codable {
//    let faqId: Double
//    let questionMM: String
//    let questionEN: String
//    let answerMM: String
//    let answerEN: String
//    let categoryId: Int
//    let delFlag: Int
//
//    enum  CodingKeys: String, CodingKey {
//        case faqId = "faqId"
//        case questionMM = "questionMM"
//        case questionEN = "questionEN"
//        case answerMM = "answerMM"
//        case answerEN = "answerEN"
//        case categoryId = "categoryId"
//        case delFlag = "delFlag"
//    }
//
//}


