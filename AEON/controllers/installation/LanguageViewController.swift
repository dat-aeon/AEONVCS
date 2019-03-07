//
//  LanguageViewController.swift
//  AEONVCS
//
//  Created by mac on 2/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class LanguageViewController: BaseUIViewController {

    @IBOutlet weak var ivMyanmarFlag: UIImageView!
    @IBOutlet weak var ivEnglishFlag: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isFirstOpen:Bool = UserDefaults.standard.bool(forKey: Constants.IS_ALREADY_ACCEPT)
        
        // if user already accept Terms & Conditions
        if isFirstOpen {
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
        }
         self.ivMyanmarFlag.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickMMFlag)))
        self.ivEnglishFlag.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickENGFlag)))
        
    }
    
    @objc func onClickMMFlag(){
        
        Locale.currentLocale = .MY
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionAgreeViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickENGFlag(){
        
        Locale.currentLocale = .EN
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionAgreeViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
}
