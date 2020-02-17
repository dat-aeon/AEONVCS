//
//  ServiceUnavailableViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 3/6/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ServiceUnavailableViewController: UIViewController {

    @IBOutlet weak var bbClose: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onClickCloseBtn(_ sender: UIBarButtonItem) {

        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
        UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
        UserDefaults.standard.set(nil, forKey: Constants.CUSTOMER_TYPE)
        UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
        UserDefaults.standard.set(nil, forKey: Constants.HOTLINE_NO)
        
        let isLogout = UserDefaults.standard.bool(forKey: Constants.IS_LOGOUT)
        if isLogout {
            UserDefaults.standard.set(nil, forKey: Constants.LAST_USED_TIME)
            UserDefaults.standard.set(nil, forKey: Constants.USER_INFO_CUSTOMER_ID)
        }
        
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MainNewViewController") as! UIViewController
         navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
        
    }
}
