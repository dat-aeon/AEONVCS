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
