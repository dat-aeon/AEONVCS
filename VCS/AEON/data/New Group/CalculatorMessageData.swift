//
//  CalculatorMessageData.swift
//  AEONVCS
//
//  Created by Ant on 24/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//


import Foundation
import SwiftyJSON


struct CalculatorMessageResponse: Codable {
    let status: String
    let data : CalculatorMessageData
}

struct CalculatorMessageData: Codable {
    var decriptionEng: String
    var descriptionMm: String

    enum CodingKeys: String, CodingKey {
        case decriptionEng = "decriptionEng"
        case descriptionMm = "descriptionMm"
    }
}
struct CalculatorMessageDatas {
    var messageEng: String = ""
    var messageMya: String = ""
}
