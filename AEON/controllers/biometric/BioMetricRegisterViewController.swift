//
//  BioMetricRegisterViewController.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import LocalAuthentication
import SwiftyJSON

class BioMetricRegisterViewController: BaseUIViewController {
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    

    @IBOutlet weak var svBioMetricVerify: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var lbPhoneMessage: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbPasswordMessage: UILabel!
    @IBOutlet weak var lbWarning: UILabel!
    @IBOutlet weak var lbWarningText: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var isAlreadyLogin: Bool = false
    var isUpdate : Bool = false
    var sessionData: SessionDataBean?
    var tokenInfo: TokenData?
    
    // Error message Language control
    var phoneMesgLocale : String?
    var passMesgLocale : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
        
        tfPhone.delegate = self
        tfPassword.delegate = self
        
        lbPhoneMessage.text = Constants.BLANK
        lbPasswordMessage.text = Constants.BLANK
        
        tfPhone.setMaxLength(maxLength: 11)
        tfPassword.setMaxLength(maxLength: 16)
        tfPhone.keyboardType = UIKeyboardType.phonePad
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        if self.isUpdate {
            self.lblTitle.text = "biometric.update.title".localized
        } else {
            self.lblTitle.text = "biometric.register.title".localized
        }
        
        self.tfPhone.placeholder = "biometric.phoneno.holder".localized
        self.tfPassword.placeholder = "biometric.password.holder".localized
        self.btnSubmit.setTitle("biometric.submit.button".localized, for: UIControl.State.normal)
        self.lbWarning.text = "biometric.warning.title".localized
        self.lbWarningText.text = "biometric.warning.text".localized
    }
    
    func isErrorExist() -> Bool {
        var isError = false
        if tfPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfPhone.text = Constants.BLANK
            self.lbPhoneMessage.text = Messages.PHONE_EMPTY_ERROR.localized
            self.phoneMesgLocale = Messages.PHONE_EMPTY_ERROR
            isError = true
            
        } else {
            self.lbPhoneMessage.text = Constants.BLANK
            self.phoneMesgLocale = Constants.BLANK
        }
        
        if tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfPassword.text = Constants.BLANK
            self.lbPasswordMessage.text = Messages.PASSWORD_EMPTY_ERROR.localized
            self.passMesgLocale = Messages.PASSWORD_EMPTY_ERROR
            isError = true
            
        } else {
            self.passMesgLocale = Constants.BLANK
            self.lbPasswordMessage.text = Constants.BLANK
        }
        return isError
    }
    
    @IBAction func onClickSubmitButton(_ sender: UIButton) {
        
        
        if isErrorExist() {
            return
        }
        
        if self.isAlreadyLogin {
            
            let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
            tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
            
            LoginViewModel.init().login(phoneNo: self.tfPhone.text!, token: (tokenInfo?.access_token)!,refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
                self.authenticateBioMetricData(phone: self.tfPhone.text!, password: self.tfPassword.text!)
                
            }) { (error) in
                Utils.showAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: error)
            }
            
        } else {
        
            LoginAuthViewModel.init().accessLoginToken(phoneNo: tfPhone.text!, password: tfPassword.text!, success: { (result) in
                
                self.authenticateBioMetricData(phone: self.tfPhone.text!, password: self.tfPassword.text!)
                
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: Constants.LOGIN_FAILED_TITIE, message: error)
            }
        }
        
        
    }
    @IBAction func onClickLocaleChange(_ sender: UIBarButtonItem) {
         super.updateLocale()
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
    
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        if self.isUpdate {
            self.lblTitle.text = "biometric.update.title".localized
        } else {
            self.lblTitle.text = "biometric.register.title".localized
        }
        self.tfPhone.placeholder = "login.phoneno.holder".localized
        self.tfPassword.placeholder = "login.password.holder".localized
        self.btnSubmit.setTitle("biometric.submit.button".localized, for: UIControl.State.normal)
        self.lbWarning.text = "biometric.warning.title".localized
        self.lbWarningText.text = "biometric.warning.text".localized
        self.lbPhoneMessage.text = self.phoneMesgLocale?.localized
        self.lbPasswordMessage.text = self.passMesgLocale?.localized
    }
    
    func authenticateBioMetricData(phone:String,password:String){
        let authContext = LAContext()
        let authReason = "Use your biometric data to login your account"
        var authError : NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: {success,evaluateError in
                
                if success {
                    
                    let defaults = UserDefaults.standard
                    defaults.set(phone, forKey: Constants.BIOMETRIC_PHONE)
                    defaults.set(password, forKey: Constants.BIOMETRIC_PASSWORD)
                    
                    if self.isAlreadyLogin {
                        self.isAlreadyLogin = false
                        
                         DispatchQueue.main.async {
//                            let navVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//                            let vc = navVC.children.first as! HomePageViewController
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
                            vc.sessionDataBean = self.sessionData
                            vc.modalPresentationStyle = .overFullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    } else {
//                        let navVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! UINavigationController
//                        self.present(navVC, animated: true, completion: nil)
                        //Fix: Auto login
                        self.doAutoLogin(phone: phone, password: password)
                    }
                    
                } else {
                    
                    if #available(iOS 11.0, *) {
                        let message: String
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
                    //                    completion(message)                            }
                }
            })
        }else{
            
            if "\(authError?.code ?? 0)" == "-6" {
                self.presentSettings()
            } else {
                let alertController = UIAlertController(title: Constants.VERIFY_FAILED_TITIE, message: Messages.BIOMETRIC_VERIFY_FAILED_ERROR.localized, preferredStyle: .alert) //
                let okAction = UIAlertAction(title: Constants.OK, style: .cancel, handler: { action in
                    
//                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//                    let vc = navigationVC.children.first as! HomePageViewController
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
                    vc.sessionDataBean = self.sessionData
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
            
                    
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
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
    
    func doAutoLogin(phone: String, password: String) {
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
            
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//            let vc = navigationVC.children.first as! HomePageViewController
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
            vc.sessionDataBean = self.sessionData
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            //Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
            let alert = UIAlertController(title: Constants.LOGIN_FAILED_TITIE, message: Messages.BIOMETRIC_FAILED_ERROR.localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: { (action) in
                
                let navVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! UINavigationController
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true, completion: nil)

            })
            
            let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        if self.isAlreadyLogin {
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//            let vc = navigationVC.children.first as! HomePageViewController
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
            vc.sessionDataBean = self.sessionData
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            
            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc override func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            svBioMetricVerify.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            svBioMetricVerify.contentInset = UIEdgeInsets.zero
            
        }
        
        svBioMetricVerify.scrollIndicatorInsets = svBioMetricVerify.contentInset
        
    }
}
