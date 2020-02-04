//
//  LanguageViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 2/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var ivMyanmarFlag: UIImageView!
    @IBOutlet weak var ivEnglishFlag: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            
            let isFirstOpen:Bool = UserDefaults.standard.bool(forKey: Constants.IS_ALREADY_ACCEPT)
            
            // if user already accept Terms & Conditions
            if isFirstOpen {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            }
            
            self.ivMyanmarFlag.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickMMFlag)))
            self.ivEnglishFlag.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickENGFlag)))
            
        }
        
    }
    
    @objc func onClickMMFlag(){
        
        Locale.currentLocale = .MY
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.TERMS_CONS_AGREE_VIEW_CONTROLLER) as! UINavigationController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickENGFlag(){
        
        Locale.currentLocale = .EN
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.TERMS_CONS_AGREE_VIEW_CONTROLLER) as! UINavigationController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
}
