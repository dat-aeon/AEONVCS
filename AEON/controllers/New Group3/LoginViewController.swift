//
//  LoginViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class LoginViewController: BaseUIViewController {

    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var ivPasswordVisible: UIImageView!
    @IBOutlet weak var vLoginButton: UIButton!
    @IBOutlet weak var lbForgetPass: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let button = UIButton(type: .custom)
//        //set image for button
//        button.setImage(UIImage(named: "mm_flag.png"), for: .normal)
//        //add function for button
//        button.addTarget(self, action: #selector(onClickCloseButton(_:)), for: .touchUpInside)
//        //set frame
//        button.frame = CGRect(x: 0, y: 0, width: 50, height: 32)
//        
//        let barButton = UIBarButtonItem(customView: button)
//        //assign button to navigationbar
//        self.navigationItem.rightBarButtonItem = barButton
//        
        self.title = "Login"
        self.lbForgetPass.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickForgetPassword)))
        
        self.ivPasswordVisible.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickPasswordVisible)))
    }
    
    
    @objc func onClickPasswordVisible(){
        if tfPassword.isSecureTextEntry{
        tfPassword.isSecureTextEntry = false
            ivPasswordVisible.tintColor = UIColor.gray // change icon here
        }else{
            tfPassword.isSecureTextEntry = true
            ivPasswordVisible.tintColor = UIColor(netHex: 0xB70081) // change icon here
        }
    }
        
    @IBAction func onClickLogin(_ sender:UIButton){
        if (tfPhoneNumber.text?.isEmpty)! || (tfPassword.text?.isEmpty)!{
            Utils.showAlert(viewcontroller: self, title: "Login Error", message: "Phone Number or Password is empty")
        }else{
            LoginViewModel.init().login(username: tfPhoneNumber.text!,password:tfPassword.text!, success: { (result) in
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
                self.present(navigationVC, animated: true, completion: nil)
            }) { (error) in
                Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
            }
        }
    }
    
    @objc func onClickForgetPassword(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuestConfirmViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }

    @IBAction func onClickCloseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
