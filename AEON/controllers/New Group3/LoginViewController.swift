//
//  LoginViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: BaseUIViewController {

    @IBOutlet weak var svMemberLogin: UIScrollView!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var ivPasswordVisible: UIImageView!
    @IBOutlet weak var vLoginButton: UIButton!
    @IBOutlet weak var lbForgetPass: UILabel!
    @IBOutlet weak var ivBiometric: UIImageView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        
        print("Start LoginViewController :::::::::::::::")
        super.viewDidLoad()
        self.title = "Login"
        self.lbForgetPass.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickForgetPassword)))
        
        self.ivPasswordVisible.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickPasswordVisible)))
    
        self.ivBiometric.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBioMetricIcon)))
        
        tfPhoneNumber.delegate = self
        tfPassword.delegate = self
        tfPhoneNumber.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        tfPhoneNumber.becomeFirstResponder()
        tfPhoneNumber.keyboardType = UIKeyboardType.phonePad
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
    }
    
    
    @IBAction func onClickLocalChangeButton(_ sender: UIBarButtonItem) {
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
        self.title = "login.title".localized
        self.tfPhoneNumber.placeholder = "login.phoneno.holder".localized
        self.tfPassword.placeholder = "login.password.holder".localized
        self.vLoginButton.setTitle("login.login.button".localized, for: UIControl.State.normal)
        self.lbForgetPass.text = "login.forgetpassword.link".localized
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
        var isError = false
        
        if (self.tfPhoneNumber?.text?.isEmpty)!{
            self.tfPhoneNumber?.showError(message: Messages.PHONE_EMPTY_ERROR)
            isError = true
        } else {
            if ((self.tfPhoneNumber.text?.count)! < 9) {
                self.tfPhoneNumber?.showError(message: Messages.PHONE_LENGTH_ERROR)
                self.tfPhoneNumber.text = Constants.BLANK
                isError = true
            }
        }
        
        if (self.tfPassword?.text?.isEmpty)!{
            self.tfPassword?.showError(message: Messages.PASSWORD_EMPTY_ERROR)
            isError = true
        }
        
        if (isError) {
            return
        }else{
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            LoginViewModel.init().login(phoneNo: tfPhoneNumber.text!,password:tfPassword.text!, success: { (result) in
                
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                let loginResponse: LoginResponse? = result
                if (result.customerNo ?? "").isEmpty {
                    UserDefaults.standard.set(Constants.NON_MEMBER, forKey: Constants.CUSTOMER_TYPE)
                } else {
                    UserDefaults.standard.set(Constants.MEMBER, forKey: Constants.CUSTOMER_TYPE)
                }
                print("RESULT CUSTOMER-ID:::::::: \(result.customerId ?? 0)")
                UserDefaults.standard.set(result.customerId, forKey: Constants.USER_INFO_CUSTOMER_ID)
                UserDefaults.standard.set(self.generateCurrentTimeStamp(), forKey : Constants.LOGIN_TIME)
                print("CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
                
                //set nil to response
                if let loginResponseData = loginResponse{
                    let jsonData = try? JSONEncoder().encode(loginResponseData)
                    let jsonString = String(data: jsonData!, encoding: .utf8)!
                    UserDefaults.standard.set(jsonString, forKey: Constants.LOGIN_RESPONSE)
                }
                
                UserDefaults.standard.set(nil, forKey: Constants.REGISTER_RESPONSE)
                
                // LoginResponse Data
                let jsonData = try? JSONEncoder().encode(result)
                let jsonString = String(data: jsonData!, encoding: .utf8)!
                UserDefaults.standard.set(jsonString, forKey: Constants.LOGIN_RESPONSE)
                
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
                self.present(navigationVC, animated: true, completion: nil)
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
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
    
    @objc func onClickBioMetricIcon(){
        let userDefaults = UserDefaults.standard
        let phone = userDefaults.string(forKey: "phone")
        let password = userDefaults.string(forKey: "password")
        if phone != nil && password != nil{
            self.authenticateBioMetricData(phone: phone!, password: password!)
        }else{
            let navVC = self.storyboard?.instantiateViewController(withIdentifier: "BioMetricRegisterViewController") as! UINavigationController
            self.present(navVC, animated: true, completion: nil)
        }
    }
    
    func authenticateBioMetricData(phone:String,password:String){
        let authContext = LAContext()
        let authReason = "Use your biometric data to login your account"
        var authError : NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: {success,evaluateError in
                
                if success{
                    //call api to check username and password
                    CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                    LoginViewModel.init().login(phoneNo: phone, password: password, success: { (result) in
                        
                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                        //set nil to response
                        UserDefaults.standard.set(nil, forKey: Constants.LOGIN_RESPONSE)
                        UserDefaults.standard.set(nil, forKey: Constants.REGISTER_RESPONSE)
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.LOGIN_RESPONSE)
                        
                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
                        self.present(navigationVC, animated: true, completion: nil)
                    }) { (error) in
                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                        Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
                    }
                    
                    if phone == "Constants.phoneNumber" &&
                        password == "Constants.password"{
                        let navVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
                        self.present(navVC, animated: true, completion: nil)
                    }
                }else {
                    let message: String
                    if #available(iOS 11.0, *) {
                        switch evaluateError {
                        case LAError.authenticationFailed?:
                            message = "There was a problem verifying your identity."
                        case LAError.userCancel?:
                            message = "You pressed cancel."
                        case LAError.userFallback?:
                            message = "You pressed password."
                        case LAError.biometryNotAvailable?:
                            message = "Face ID/Touch ID is not available."
                        case LAError.biometryNotEnrolled?:
                            message = "Face ID/Touch ID is not set up."
                        case LAError.biometryLockout?:
                            message = "Face ID/Touch ID is locked."
                        default:
                            message = "Face ID/Touch ID may not be configured"
                        }
                        print(message);
                    } else {
                        // Fallback on earlier versions
                    }
                    //                    completion(message)
                }
                
            })
        }else{
            let alertController = UIAlertController(title: "Verification Failed", message: "You cann't verify with your biometric data", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: {
                
            })
        }
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            svMemberLogin.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            svMemberLogin.contentInset = UIEdgeInsets.zero
            
        }
        
        svMemberLogin.scrollIndicatorInsets = svMemberLogin.contentInset
        
    }
    
    override func generateCurrentTimeStamp () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
}
