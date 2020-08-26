//
//  VideoFileData.swift
//  AEONVCS
//
//  Created by mac on 2/7/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation

struct VideoFileResponse: Codable {
    let status: String
    let data: DataClass
}

struct DataClass: Codable {
    let fileName: String
}
