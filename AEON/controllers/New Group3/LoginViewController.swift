//
//  LoginViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import LocalAuthentication
import Reachability

class LoginViewController: BaseUIViewController {

    
    @IBOutlet weak var svMemberLogin: UIScrollView!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var lbPhoneMessage: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbPasswordMessage: UILabel!
    @IBOutlet weak var ivPasswordVisible: UIImageView!
    @IBOutlet weak var vLoginButton: UIButton!
    @IBOutlet weak var lbForgetPass: UILabel!
    @IBOutlet weak var ivBiometric: UIImageView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var phoneMesgLocale : String?
    var passwordMesgLocale : String?
    
    override func viewDidLoad() {
        
        self.svMemberLogin.isScrollEnabled = false
        
        print("Start LoginViewController :::::::::::::::")
        super.viewDidLoad()
        self.lbPhoneMessage.text = Constants.BLANK
        self.lbPasswordMessage.text = Constants.BLANK
        
        // Update old Logout Time in Server
        let isFirstInstall = UserDefaults.standard.bool(forKey: Constants.IS_FIRST_INSTALL)
        print("First Install:", isFirstInstall)
        if(!isFirstInstall) {
            if !UserDefaults.standard.bool(forKey: Constants.IS_LOGOUT) {
              
                let customerId = UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID)
                let logoutTime = UserDefaults.standard.string(forKey: Constants.LAST_USED_TIME)
                
                if (customerId != nil && (logoutTime != nil && logoutTime != Constants.BLANK)) {
                    //print("\(customerId ?? "0") + \(logoutTime ?? "00")")
                    
                    CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                    
                    // check network
                    if Network.reachability.isReachable == false {
                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                        UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
                        UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
                        UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                        //UserDefaults.standard.set(self.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
//                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
//                        navigationVC.modalPresentationStyle = .overFullScreen
                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                        navigationVC.modalPresentationStyle = .overFullScreen
                        self.present(navigationVC, animated: true, completion:nil)
                        return
                    }
                    
                    LogoutViewModel.init().offlineLogout(customerId: customerId!, logoutTime: logoutTime!, success: { (result) in
                        
                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                        UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
                        UserDefaults.standard.set(nil, forKey: Constants.USER_INFO_CUSTOMER_ID)
                        UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
                        UserDefaults.standard.set(nil, forKey: Constants.HOTLINE_NO)
                        UserDefaults.standard.set(true, forKey: Constants.IS_LOGOUT)
                        UserDefaults.standard.set(Constants.BLANK, forKey: Constants.LAST_USED_TIME)
                        print("Logout success")
                        
                    }) { (error) in
                        print("Login error", error)
                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                        
                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                        UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
                        UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
                        UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                        UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
                        let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
//                            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
//                            navigationVC.modalPresentationStyle = .overFullScreen
                            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                            navigationVC.modalPresentationStyle = .overFullScreen
                            self.present(navigationVC, animated: true, completion: nil)
                        }))
                        self.present(alertController, animated: true, completion: nil)
                        
                        return
                    }
                }
            }
        } else {
            UserDefaults.standard.set(false, forKey: Constants.IS_FIRST_INSTALL)
        }
        //self.title = "Login"
        self.lbForgetPass.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickForgetPassword)))

        self.ivPasswordVisible.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickPasswordVisible)))

        self.ivBiometric.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBioMetricIcon)))

        tfPhoneNumber.delegate = self
        tfPassword.delegate = self
        tfPhoneNumber.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        //tfPhoneNumber.becomeFirstResponder()
        tfPhoneNumber.setMaxLength(maxLength: 11)
        tfPhoneNumber.keyboardType = UIKeyboardType.phonePad
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        
        self.checkConnection()
       
    }
    
    func checkConnection() {
        if !Network.reachability.isReachable {
        
            //view.backgroundColor = .red
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
        
        }
    }
    
//    override func updateUserInterface() {
//        super.updateUserInterface()
//    }
    
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
        self.lbPhoneMessage.text = self.phoneMesgLocale?.localized
        self.lbPasswordMessage.text = self.passwordMesgLocale?.localized
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    @objc func onClickPasswordVisible(){
        if tfPassword.isSecureTextEntry{
        tfPassword.isSecureTextEntry = false
            ivPasswordVisible.tintColor = UIColor.gray // change icon here
            ivPasswordVisible.image = UIImage(named: "invisible-icon")
            
        }else{
            tfPassword.isSecureTextEntry = true
            ivPasswordVisible.tintColor = UIColor(netHex: 0xB70081) // change icon here
            ivPasswordVisible.image = UIImage(named: "visible-icon")
        }
    }
    
    func isErrorExist() -> Bool{
        var isError = false
        if self.tfPhoneNumber?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfPhoneNumber.text = Constants.BLANK
            self.phoneMesgLocale = Messages.PHONE_EMPTY_ERROR
            self.lbPhoneMessage.text = Messages.PHONE_EMPTY_ERROR.localized
            isError = true
            
        } else {
            self.phoneMesgLocale = Constants.BLANK
            self.lbPhoneMessage.text = Constants.BLANK
        }
        
        if (self.tfPassword?.text?.isEmpty)!{
            self.lbPasswordMessage.text = Messages.PASSWORD_EMPTY_ERROR.localized
            self.passwordMesgLocale = Messages.PASSWORD_EMPTY_ERROR
            isError = true
        } else {
            self.lbPasswordMessage.text = Constants.BLANK
            self.passwordMesgLocale = Constants.BLANK
        }
        
        return isError
    }
        
    @IBAction func onClickLogin(_ sender:UIButton){

        if (isErrorExist()) {
            return
        }else{
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            LoginAuthViewModel.init().accessLoginToken(phoneNo: tfPhoneNumber.text!, password: tfPassword.text!, success: { (result) in
                
//                let jsonData = try? JSONEncoder().encode(result)
//                let jsonString = String(data: jsonData!, encoding: .utf8)!
//                UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                
                print("result login : \(result)")
                
                var sessionData = SessionDataBean()
                sessionData.customerId = result.data.customerId
                sessionData.customerNo = result.data.customerNo
                sessionData.customerTypeId = result.data.customerTypeId
                sessionData.dateOfBirth = result.data.dateOfBirth
                sessionData.memberNo = result.data.memberNo
                sessionData.name = result.data.name
                sessionData.nrcNo = result.data.nrcNo
                sessionData.phoneNo = result.data.phoneNo
                sessionData.photoPath = result.data.photoPath
                sessionData.userTypeId = result.data.userTypeId
                sessionData.hotlineNo = result.data.hotlinePhone
                sessionData.customerAgreementDtoList = result.data.customerAgreementDtoList
                sessionData.memberNoValid = result.data.memberNoValid
                
                //print("valid : \(result.data.memberNoValid)")
                
                if result.data.customerTypeId == 2 {
                    UserDefaults.standard.set(Constants.NON_MEMBER, forKey: Constants.CUSTOMER_TYPE)
                } else {
                    UserDefaults.standard.set(Constants.MEMBER, forKey: Constants.CUSTOMER_TYPE)
                }
                UserDefaults.standard.set(result.data.customerId, forKey: Constants.USER_INFO_CUSTOMER_ID)
                UserDefaults.standard.set(result.data.phoneNo, forKey: Constants.USER_INFO_PHONE_NO)
                UserDefaults.standard.set(result.data.name, forKey: Constants.USER_INFO_NAME)
                UserDefaults.standard.set(Utils.generateLogoutTime(), forKey : Constants.LOGIN_TIME)
                UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                //UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
                UserDefaults.standard.set(nil, forKey: Constants.USED_COUPON_LIST)
                
                //print("CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
                
                let sessionJson = try? JSONEncoder().encode(sessionData)
                let sessionString = String(data: sessionJson!, encoding: .utf8)!
                UserDefaults.standard.set(sessionString, forKey: Constants.SESSION_INFO)
                
//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
               
                let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_NEW_VIEW_CONTROLLER) as! HomeNewViewController
                                
                                
                                vc.sessionDataBean = sessionData
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                
                // login with access token
                //self.LoginWithToken(token: result.access_token!, refreshToken: result.refresh_token!)
                
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                if error == Constants.ACCOUNT_LOCK {
                   
                    let alertController = UIAlertController(title: Constants.LOGIN_FAILED_TITIE, message: Messages.ACCOUNT_LOCK.localized, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                          DispatchQueue.main.async {
                            self.gotoForceChangePhVerify()
                        }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    Utils.showAlert(viewcontroller: self, title: Constants.LOGIN_FAILED_TITIE, message: error)
                }
            }
        }
    }
    
    func gotoForceChangePhVerify() {
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_PHONE_CONFIRM_VIEW_CONTROLLER) as! UINavigationController
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_PHONE_CONFIRM_VIEW_CONTROLLER) as! ForceChangePhoneConfirmViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    func LoginWithToken(token: String, refreshToken: String) {
        LoginViewModel.init().login(phoneNo: self.tfPhoneNumber.text!,token: token, refreshToken: refreshToken, success: { (result) in
            // success
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            //let loginResponse: LoginResponse? = result
            
            var sessionData = SessionDataBean()
            sessionData.customerId = result.data.customerId
            sessionData.customerNo = result.data.customerNo
            sessionData.customerTypeId = result.data.customerTypeId
            sessionData.dateOfBirth = result.data.dateOfBirth
            sessionData.memberNo = result.data.memberNo
            sessionData.name = result.data.name
            sessionData.nrcNo = result.data.nrcNo
            sessionData.phoneNo = result.data.phoneNo
            sessionData.photoPath = result.data.photoPath
            sessionData.userTypeId = result.data.userTypeId
            sessionData.hotlineNo = result.data.hotlinePhone
            sessionData.customerAgreementDtoList = result.data.customerAgreementDtoList
            
            if result.data.customerNo == nil {
                UserDefaults.standard.set(Constants.NON_MEMBER, forKey: Constants.CUSTOMER_TYPE)
            } else {
                UserDefaults.standard.set(Constants.MEMBER, forKey: Constants.CUSTOMER_TYPE)
            }
            UserDefaults.standard.set(result.data.customerId, forKey: Constants.USER_INFO_CUSTOMER_ID)
            UserDefaults.standard.set(result.data.phoneNo, forKey: Constants.USER_INFO_PHONE_NO)
            UserDefaults.standard.set(result.data.name, forKey: Constants.USER_INFO_NAME)
            UserDefaults.standard.set(Utils.generateLogoutTime(), forKey : Constants.LOGIN_TIME)
            UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
            //UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
            
            //print("CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
            
            let jsonData = try? JSONEncoder().encode(sessionData)
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
            
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//            let vc = navigationVC.children.first as! HomePageViewController
            let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_NEW_VIEW_CONTROLLER) as! HomeNewViewController
            vc.sessionDataBean = sessionData
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: Constants.LOGIN_FAILED_TITIE, message: error)
        }
    }
    
    @objc func onClickForgetPassword(){
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            
        } else {
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_PHONE_CONFIRM_VIEW_CONTROLLER) as! UINavigationController
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_PHONE_CONFIRM_VIEW_CONTROLLER) as! ForceChangePhoneConfirmViewController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }
    }

    @IBAction func onClickCloseButton(_ sender: UIBarButtonItem) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
        
    }
    
    @objc func onClickBioMetricIcon(){
        let userDefaults = UserDefaults.standard
        let phone = userDefaults.string(forKey: Constants.BIOMETRIC_PHONE)
        let password = userDefaults.string(forKey: Constants.BIOMETRIC_PASSWORD)
        
        if phone != nil && password != nil{
//            self.authenticateBioMetricData(phone: phone!, password: password!)
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.BIOMETRIC_VIEW_CONTROLLER) as! UINavigationController
//            let vc = navigationVC.children.first as! BioMetricRegisterViewController
//            vc.isUpdate = true
             let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.BIOMETRIC_VIEW_CONTROLLER) as! BioMetricRegisterViewController
            navigationVC.isUpdate = true
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }else{
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.BIOMETRIC_VIEW_CONTROLLER) as! BioMetricRegisterViewController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }
    }
    
    func authenticateBioMetricData(phone:String,password:String){
        let authContext = LAContext()
        let authReason = "Use your biometric data to login your account"
        var authError : NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: {success,evaluateError in
                
                if success{
                    // check network
                    if Network.reachability.isReachable == false {
                        Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                        return
                    }
                    
                    //call api to check username and password
                    DispatchQueue.main.async {
                        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                    }
                    LoginAuthViewModel.init().accessLoginToken(phoneNo: phone, password: password, success: { (result) in
                        
//                        let jsonData = try? JSONEncoder().encode(result)
//                        let jsonString = String(data: jsonData!, encoding: .utf8)!
//                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
//
                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                        var sessionData = SessionDataBean()
                        sessionData.customerId = result.data.customerId
                        sessionData.customerNo = result.data.customerNo
                        sessionData.customerTypeId = result.data.customerTypeId
                        sessionData.dateOfBirth = result.data.dateOfBirth
                        sessionData.memberNo = result.data.memberNo
                        sessionData.name = result.data.name
                        sessionData.nrcNo = result.data.nrcNo
                        sessionData.phoneNo = result.data.phoneNo
                        sessionData.photoPath = result.data.photoPath
                        sessionData.userTypeId = result.data.userTypeId
                        sessionData.hotlineNo = result.data.hotlinePhone
                        sessionData.customerAgreementDtoList = result.data.customerAgreementDtoList
                        sessionData.memberNoValid = result.data.memberNoValid
                        
                        if result.data.customerNo == nil {
                            UserDefaults.standard.set(Constants.NON_MEMBER, forKey: Constants.CUSTOMER_TYPE)
                        } else {
                            UserDefaults.standard.set(Constants.MEMBER, forKey: Constants.CUSTOMER_TYPE)
                        }
                        UserDefaults.standard.set(result.data.customerId, forKey: Constants.USER_INFO_CUSTOMER_ID)
                        UserDefaults.standard.set(result.data.phoneNo, forKey: Constants.USER_INFO_PHONE_NO)
                        UserDefaults.standard.set(result.data.name, forKey: Constants.USER_INFO_NAME)
                        UserDefaults.standard.set(Utils.generateLogoutTime(), forKey : Constants.LOGIN_TIME)
                        UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                        //UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
                        
                        //print("CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
                        
                        let sessionJson = try? JSONEncoder().encode(sessionData)
                        let sessionString = String(data: sessionJson!, encoding: .utf8)!
                        UserDefaults.standard.set(sessionString, forKey: Constants.SESSION_INFO)
                        
//                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//                        let vc = navigationVC.children.first as! HomePageViewController
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_NEW_VIEW_CONTROLLER) as! HomeNewViewController
                        vc.sessionDataBean = sessionData
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                        
                    }) { (error) in
                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                        //Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
                        let alert = UIAlertController(title: Constants.LOGIN_FAILED_TITIE, message: Messages.BIOMETRIC_FAILED_ERROR.localized, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: { action in
                            
                            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.BIOMETRIC_VIEW_CONTROLLER) as! BioMetricRegisterViewController
                            let vc = navigationVC.children.first as! BioMetricRegisterViewController
                            vc.isUpdate = true
                            navigationVC.modalPresentationStyle = .overFullScreen
                            self.present(navigationVC, animated: true, completion: nil)
                            
                        })
                        let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: nil)
                        alert.addAction(okAction)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    if phone == "Constants.phoneNumber" &&
                        password == "Constants.password"{
                        let navVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_NEW_VIEW_CONTROLLER) as! HomeNewViewController
                        navVC.modalPresentationStyle = .overFullScreen
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
            if "\(authError?.code ?? 0)" == "-6" {
                self.presentSettings()
            } else {
                let alertController = UIAlertController(title: "Verification Failed", message: "You cann't verify with your biometric data", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: {
                    
                })
            }
        }
    }
    
    func presentSettings() {
        let alertController = UIAlertController(title: "To Allow Biometric Access, Go to Settings",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
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
}
