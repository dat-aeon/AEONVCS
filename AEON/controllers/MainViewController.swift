//
//  MainViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MainViewController: BaseUIViewController {

    @IBOutlet weak var vLoginButton: UIView!
    @IBOutlet weak var vRegisterButton: UIView!
    @IBOutlet weak var vAboutUsButton: UIView!
    @IBOutlet weak var vFAQButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickLogin)))
        self.vRegisterButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickRegister)))
        self.vAboutUsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickAboutUs)))
        self.vFAQButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickFAQ)))
    }
    
    @objc func onClickLogin(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickRegister(){
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuesRegisterViewController") as! UINavigationController
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickAboutUs(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickFAQ(){
        let faqVC = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
        faqVC.showNavBar = true
        self.present(faqVC, animated: true, completion: nil)
    }
}
