//
//  MainViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var vLoginButton: UIView!
    @IBOutlet weak var vAboutUsButton: UIView!
    @IBOutlet weak var vFAQButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickLogin)))
        
         self.vAboutUsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickAboutUs)))
    }
    
    @objc func onClickLogin(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickAboutUs(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
}
