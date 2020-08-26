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
    @IBOutlet weak var lbPassErrorMessage: UILabel!
    
    @IBOutlet weak var lblConPassword: UILabel!
    @IBOutlet weak var tfConPassword: UITextField!
    @IBOutlet weak var lbConPassErrorMessage: UILabel!
    
    @IBOutlet weak var btnResetPass: UIButton!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var lbPasswordWarning: UILabel!
    
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarPhoneNo: UILabel!
    
    var customerId : Int?
    var userTypeId : Int?
    var phoneNo : String?
    var nrcNo: String?
    var isAppLock: Bool?
    
    // Error message Language control
    var passMesgLocale : String?
    var conPassMesgLocale : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblBarPhoneNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        self.lbPassErrorMessage.text = Constants.BLANK
        self.lbConPassErrorMessage.text = Constants.BLANK
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.lblTitle.text = "resetpass.title".localized
        self.lblPassword.text = "resetpass.newpass.label".localized
        self.lblConPassword.text = "resetpass.conpass.label".localized
        self.lbPasswordWarning.text = "register.password.warning.label".localized
        self.btnResetPass.setTitle("resetpass.reset.button".localized, for: UIControl.State.normal)
        self.tfPassword.setMaxLength(maxLength: 16)
        self.tfConPassword.setMaxLength(maxLength: 16)
        //  print("Pass data :::::::::: \(String(describing: customerId)) \(String(describing: userTypeId))")
        
    }
    
    @objc func onTapBack() {
       print("click")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onTapMMLocale() {
       print("click")
        super.NewupdateLocale(flag: 1)
        updateViews()
    }
    @objc func onTapEngLocale() {
       print("click")
        super.NewupdateLocale(flag: 2)
        updateViews()
    }

    
    func isErrorExist() -> Bool {
        var isError = false
        
        if self.tfPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbPassErrorMessage.text = Messages.PASSWORD_EMPTY_ERROR.localized
            self.passMesgLocale = Messages.PASSWORD_EMPTY_ERROR
            isError = true
            
        } else if self.tfPassword?.text?.count ?? 0 < 6 || self.tfPassword?.text?.count ?? 0 > 16{
            self.tfPassword?.text = ""
            self.lbPassErrorMessage.text = Messages.PASSWORD_LENGTH_ERROR.localized
            self.passMesgLocale = Messages.PASSWORD_LENGTH_ERROR
            isError = true
            
        } else {
            self.lbPassErrorMessage.text = Constants.BLANK
            self.passMesgLocale = Constants.BLANK
        }
        
        if self.tfConPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbConPassErrorMessage.text = Messages.CON_PASSWORD_EMPTY_ERROR.localized
            self.conPassMesgLocale = Messages.CON_PASSWORD_EMPTY_ERROR
            isError = true
            
        } else if self.tfPassword?.text != self.tfConPassword?.text{
            self.tfConPassword?.text = ""
            self.lbConPassErrorMessage.text = Messages.PASSWORD_NOT_MATCH_ERROR.localized
            self.conPassMesgLocale = Messages.PASSWORD_NOT_MATCH_ERROR
            isError = true
            
        } else {
            self.lbConPassErrorMessage.text = Constants.BLANK
            self.conPassMesgLocale = Constants.BLANK
            
        }
        return isError
    }
    
    @IBAction func onClickResetPassword(_ sender:UIButton){
        
        if isErrorExist() {
            return
            
        }
        
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        if isAppLock == true {
            let forceRequest = ForceChangePasswordRequest(phoneNo:phoneNo!,nrcNo:nrcNo!,password:self.tfPassword.text!)
            ResetPasswordViewModel.init().forceChangePassword(forceRequest: forceRequest, success: { (result) in
                
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
                if result == Constants.PWD_WEAK {
                    Utils.showAlert(viewcontroller: self, title: Constants.PASSWORD_UPDATE_FAILED_TITLE, message: Messages.PASSWORD_WEAK_ERROR.localized)
                    return
                } else {
                    
                    let bio_phoneNo = UserDefaults.standard.string(forKey: Constants.BIOMETRIC_PHONE)
                    let bio_password = UserDefaults.standard.string(forKey: Constants.BIOMETRIC_PASSWORD)
                    
                    if bio_phoneNo != nil && bio_password != nil {
                        // also update for Biometric Data
                        UserDefaults.standard.set(self.phoneNo, forKey: Constants.BIOMETRIC_PHONE)
                        UserDefaults.standard.set(self.tfPassword.text, forKey: Constants.BIOMETRIC_PASSWORD)
                        
                    }
                    
                    let alertController = UIAlertController(title: "Update Success", message: "Your password is successfully changed. Please login again.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
//                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! UINavigationController
                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                        navigationVC.modalPresentationStyle = .overFullScreen
                        self.present(navigationVC, animated: true, completion: nil)
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }) { (error) in
                if error == Constants.SERVER_FAILURE {
                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                } else {
                    Utils.showAlert(viewcontroller: self, title: Constants.PASSWORD_UPDATE_FAILED_TITLE, message: error)
                }
            }
        } else {
        
            let resetRequest = ResetPasswordRequest(customerId:customerId!,userTypeId:userTypeId!,password:self.tfPassword.text!)
            
            ResetPasswordViewModel.init().changePassword(resetRequest: resetRequest, success: { (result) in
                
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
                if result == Constants.PWD_WEAK {
                    Utils.showAlert(viewcontroller: self, title: Constants.PASSWORD_UPDATE_FAILED_TITLE, message: Messages.PASSWORD_WEAK_ERROR.localized)
                    return
                } else {
                    
                    let bio_phoneNo = UserDefaults.standard.string(forKey: Constants.BIOMETRIC_PHONE)
                    let bio_password = UserDefaults.standard.string(forKey: Constants.BIOMETRIC_PASSWORD)
                    
                    if bio_phoneNo != nil && bio_password != nil {
                        // also update for Biometric Data
                        UserDefaults.standard.set(self.phoneNo, forKey: Constants.BIOMETRIC_PHONE)
                        UserDefaults.standard.set(self.tfPassword.text, forKey: Constants.BIOMETRIC_PASSWORD)
                        
                    }
                    
                    let alertController = UIAlertController(title: "Update Success", message: "Your password is successfully changed. Please login again.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
//                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! UINavigationController
                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                        navigationVC.modalPresentationStyle = .overFullScreen
                        self.present(navigationVC, animated: true, completion: nil)
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }) { (error) in
                if error == Constants.SERVER_FAILURE {
                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                } else {
                    Utils.showAlert(viewcontroller: self, title: Constants.PASSWORD_UPDATE_FAILED_TITLE, message: error)
                }
            }
        }
    }
    
    @IBAction func onClickBackBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
        self.lbPasswordWarning.text = "register.password.warning.label".localized
        self.btnResetPass.setTitle("resetpass.reset.button".localized, for: UIControl.State.normal)
        
        self.lbPassErrorMessage.text = self.passMesgLocale?.localized
        self.lbConPassErrorMessage.text = self.conPassMesgLocale?.localized
    }
}
