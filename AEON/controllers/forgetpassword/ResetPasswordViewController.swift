//
//  ResetPasswordViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ResetPasswordViewController: BaseUIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblConPassword: UILabel!
    @IBOutlet weak var tfConPassword: UITextField!
    @IBOutlet weak var btnResetPass: UIButton!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var customerId : Int?
    var userTypeId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.lblTitle.text = "resetpass.title".localized
        self.lblPassword.text = "resetpass.newpass.label".localized
        self.lblConPassword.text = "resetpass.conpass.label".localized
        self.btnResetPass.setTitle("resetpass.reset.button".localized, for: UIControl.State.normal)
        
        print("Pass data :::::::::: \(String(describing: customerId)) \(String(describing: userTypeId))")
    }
    
    @IBAction func onClickResetPassword(_ sender:UIButton){
        var isError = false
        
        if self.tfPassword?.text?.isEmpty ?? true{
            self.tfPassword?.showError(message: "Please input password")
            isError = true
        }
        
        if self.tfConPassword?.text?.isEmpty ?? true{
            self.tfConPassword?.showError(message: "Please input confirm password")
            isError = true
        }
        if isError {
            return
        }else if self.tfPassword?.text != self.tfConPassword?.text{
            self.tfConPassword?.text = ""
            self.tfConPassword?.showError(message: "Not Match Password")
            return
        }
        
        if self.tfPassword?.text?.count ?? 0 < 6{
            self.tfPassword?.text = ""
            self.tfPassword?.showError(message: "mubst be 6 digits")
            return
        }
        if self.tfConPassword?.text?.count ?? 0 < 6{
            self.tfConPassword?.text = ""
            self.tfConPassword?.showError(message: "must be 6 digits")
            return
        }
        
        let resetRequest = ResetPasswordRequest(customerId:customerId!,userTypeId:userTypeId!,password:self.tfPassword.text!)
        
        ResetPasswordViewModel.init().changePassword(resetRequest: resetRequest, success: { (result) in
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            
        }) { (error) in
            Utils.showAlert(viewcontroller: self, title: "Server is temporarily stopped now. Please contact to AEON.", message: error)
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
        self.lblTitle.text = "resetpass.title".localized
        self.lblPassword.text = "resetpass.newpass.label".localized
        self.lblConPassword.text = "resetpass.conpass.label".localized
        self.btnResetPass.setTitle("resetpass.reset.button".localized, for: UIControl.State.normal)
        
    }
}
