//
//  Locale.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit

enum Locale: String {
    case EN = "en"
    case MY = "my_MM"
    
    private static let defaultLocale = MY
    
    
    static let ChangeNotification = "Locale.ChangeNotification"
    private static let defaultsSuitName = "com.aeon.vcs.localechange"
    
    static var currentLocale: Locale {
        get { return Locale(rawValue: current) ?? defaultLocale }
        set { current = newValue.rawValue }
    }
    
    var nsLocale: Foundation.Locale {
        switch self {
        case .EN: return Foundation.Locale(identifier: "en_EN")
        case .MY: return Foundation.Locale(identifier: "my_MM")
        }
    }
    
    static var current: String {
        get {
            let name = UserDefaults.standard.string(forKey: defaultsSuitName) ?? defaultLocale.rawValue
            return name
        }
        set {
            guard newValue != current else { return }
            UserDefaults.standard.set(newValue,forKey:defaultsSuitName)
            
            #if TARGET_IS_APP
            UIApplication.shared.localize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: ChangeNotification), object: nil)
            #endif
        }
    }
}

extension String {
    var localized: String {
        return Bundle.main.localizedString(forKey: self, value: "", table: Locale.current)
    }
}

