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
    let message: String
    let dataBean: FAQCateoryDataBean
}

typealias FAQCateoryDataBean = [FAQCateoryDataBeanElement]

struct FAQCateoryDataBeanElement: Codable {
    let faqCategory: String
    let faqInfoResInfoList: [FAQInfoResInfoList]
}

struct FAQInfoResInfoList: Codable {
    let faqID: Int
    let questionMM, questionEN, answerMM, answerEN: String
    let categoryID, delFlag: Int
    
    enum CodingKeys: String, CodingKey {
        case faqID = "faqId"
        case questionMM, questionEN, answerMM, answerEN
        case categoryID = "categoryId"
        case delFlag
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


