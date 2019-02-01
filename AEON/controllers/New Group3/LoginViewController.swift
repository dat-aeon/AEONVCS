//
//  LoginViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var vLoginButton: UIButton!
    @IBOutlet weak var lbForgetPass: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.lbForgetPass.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickForgetPassword)))
    }
    
    @IBAction func onClickLogin(_ sender:UIButton){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickForgetPassword(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuestionResetPasswordViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }

}
