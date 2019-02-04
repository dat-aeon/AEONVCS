//
//  BaseUIViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(localeChanged), name: NSNotification.Name(Locale.ChangeNotification), object: nil)
    }
    @objc func localeChanged() {
        reloadDataIfVCVisible()
    }
    
    private func reloadDataIfVCVisible() {
        if viewIfLoaded?.window != nil {
            updateViews()
        }
    }
    
    //override this method if you want to change views in viewcontroller
    public func updateViews() {
        //update views in viewcontroller
    }
    
    
    //call this function when click in language icon
    public func updateLocale(){
        switch Locale.currentLocale {
        case .EN:
            Locale.currentLocale = .MY
        case .MY:
            Locale.currentLocale = .EN
        }
        NotificationCenter.default.post(NSNotification.init(name: NSNotification.Name(Locale.ChangeNotification), object: nil) as Notification)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
