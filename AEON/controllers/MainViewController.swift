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
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    @IBOutlet weak var lblLoginBtn: UILabel!
    @IBOutlet weak var lblRegisterBtn: UILabel!
    @IBOutlet weak var lblAboutUsBtn: UILabel!
    @IBOutlet weak var lblFAQbtn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickLogin)))
        self.vRegisterButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickRegister)))
        self.vAboutUsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickAboutUs)))
        self.vFAQButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickFAQ)))
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
    }
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.title = "home.title".localized
        self.lblLoginBtn.text = "home.login.button".localized
        self.lblRegisterBtn.text = "home.register.button".localized
        self.lblAboutUsBtn.text = "home.aboutus.button".localized
        self.lblFAQbtn.text = "home.faq.button".localized
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
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickFAQ(){
        let faqVC = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
        faqVC.showNavBar = true
        self.present(faqVC, animated: true, completion: nil)
    }
}
