//
//  MainViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import LocalAuthentication

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
    @IBOutlet weak var lblVersionNo: UILabel!
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    
    var isFirstInstall:Bool = false
    var isDidLoad = false
    var deviceID: String?
    var logoutTimer: Timer?
     var sessionDataBean : SessionDataBean?
    override func viewDidLoad() {
        super.viewDidLoad()
         self.deviceID = sessionDataBean?.loginDeviceId ?? ""
       // logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        DispatchQueue.main.async {

            self.vLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickLogin)))
            self.vRegisterButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickRegister)))
            self.vAboutUsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickAboutUs)))
            self.vFAQButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickFAQ)))
            
            switch Locale.currentLocale {
            case .EN:
                self.bbLocaleFlag.image = UIImage(named: "mm_flag")
            case .MY:
                self.bbLocaleFlag.image = UIImage(named: "en_flag")
            }
            self.title = "home.title".localized
            self.lblLoginBtn.text = "home.login.button".localized
            self.lblRegisterBtn.text = "home.register.button".localized
            self.lblAboutUsBtn.text = "home.aboutus.button".localized
            self.lblFAQbtn.text = "home.faq.button".localized
            
            self.checkVersionUpdate()

            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            UserDefaults.standard.set(false, forKey: Constants.IS_BIO_LOGIN)
            
        }
        self.isDidLoad = true
        
//        self.imgLogo.layer.cornerRadius = 13
//        self.imgLogo.clipsToBounds = true
    }
    @objc func runTimedCode() {
                 multiLoginGet()
             // print("kms\(logoutTimer)")
             }
    func multiLoginGet(){
            let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
       
            MultiLoginModel.init().makeMultiLogin(customerId: customerId
                , loginDeviceId: deviceID ?? "", success: { (results) in
                print("kaungmyat san multi >>>  \(results)")
                
                if results.data.logoutFlag == true {
                    print("success stage logout")
                    // create the alert
                           let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)

                           // add an action (button)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                        self.logoutTimer?.invalidate()
                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                        navigationVC.modalPresentationStyle = .overFullScreen
                        self.present(navigationVC, animated: true, completion:nil)
                        
                    }))

                           // show the alert
                           self.present(alert, animated: true, completion: nil)
                    
                    
                }
            }) { (error) in
                print(error)
            }
        }
    
    override func applicationWillEnterForeground() {
        let isBioLogin = UserDefaults.standard.bool(forKey: Constants.IS_BIO_LOGIN)
        if  !isBioLogin {
            self.checkVersionUpdate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateViews()
        if self.isDidLoad {
            self.isDidLoad = false
        } else {
            self.checkVersionUpdate()
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
    
    func checkVersionUpdate() {
        //First get the nsObject by defining as an optional anyObject
        //CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        let current_version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        
//        print("Version :", current_version)
        self.lblVersionNo.text = current_version
        
        _ = try? self.isUpdateAvailable { (update, error, version) in
            if let error = error {
                print(error)
            } else if update == false {
//                print("New Version")
                
                //let appStoreUrl = "https://itunes.apple.com/us/app/aeon-myanmar-app/id1462606788?mt=8"
                
                if Network.reachability.isReachable == false {
                    Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                    return
                }
                
                NewVersionViewModel.init().getVersionData(newVersion: version!, success: { (result) in
                    
//                    print("version result", result.forceUpdFlag!, result.appStoreUrl!)
                    if !UserDefaults.standard.bool(forKey: CommonNames.VERSION_ALERT_SHOWN) {
                        // Swift 4.2++
                        let message = Messages.NEW_VERSION_AVAILABLE_1.localized + self.rewriteMessageInfo(message: result.versionUpdateInfo ?? Constants.BLANK) + Messages.NEW_VERSION_AVAILABLE_2.localized
                        
                        let paragraphStyle = NSMutableParagraphStyle()
                        paragraphStyle.alignment = NSTextAlignment.left
                        let attributedString = NSMutableAttributedString(string: message, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)])
                        
                        let alertController = UIAlertController(title: Constants.NEW_VERSION_TITLE, message: nil, preferredStyle: .alert)
                        alertController.setValue(attributedString, forKey: "attributedMessage")
                        alertController.addAction(UIAlertAction(title: Constants.UPDATE, style: UIAlertAction.Style.default, handler: { action in
                            super.openUrl(urlString: result.appStoreUrl!)
                        }))
                        
                        // If should_update status, add SKIP button
                        if result.forceUpdFlag == Constants.SHOULD_UPDATE {
                            alertController.addAction(UIAlertAction(title: Constants.SKIP, style: UIAlertAction.Style.default, handler: nil))
                        }
                        
                        self.present(alertController, animated: true, completion: nil)
                        UserDefaults.standard.set(true, forKey: CommonNames.VERSION_ALERT_SHOWN)
                        //CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    }
                    
                }) { (error) in
                    //CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                     navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    func rewriteMessageInfo(message: String) -> String{
        var str = "\nUpdated features are\n"
        if message != Constants.BLANK {
            str = str + message.replacingOccurrences(of: "/", with: "\n") + "\n\n"
            return str
        }
        return message
    }
    
    @objc func onClickLogin(){
        
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        let userDefaults = UserDefaults.standard
        let phone = userDefaults.string(forKey: Constants.BIOMETRIC_PHONE)
        let password = userDefaults.string(forKey: Constants.BIOMETRIC_PASSWORD)
        
        if phone != nil && password != nil{
            self.authenticateBioMetricData(phone: phone!, password: password!)
        } else {
            self.gotoLoginPage()
        }
        
    }
    
    func gotoLoginPage() {
        
        UserDefaults.standard.set(false, forKey: Constants.IS_BIO_LOGIN)
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! LoginViewController
         navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickRegister(){
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.REGISTER_VIEW_CONTROLLER) as! RegistrationViewController
         navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickAboutUs(){
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.ABOUT_US_VIEW_CONTROLLER) as! AboutUsViewController
         navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onClickFAQ(){
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        let faqVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FAQ_MAIN_VIEW_CONTROLLER) as! FAQMainViewController
         faqVC.modalPresentationStyle = .overFullScreen
        //faqVC.showNavBar = true
        self.present(faqVC, animated: true, completion: nil)
    }
    
    //BIOMETRIC LOGIN : CLICKED ON LOGIN BTN AFTER REGISTERING WITH BIOMETRIC DATA
    func authenticateBioMetricData(phone:String,password:String){
        let authContext = LAContext()
        let authReason = "Use your biometric data to login your account"
        var authError : NSError?
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
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
                    LoginAuthViewModel.init().accessLoginToken(phoneNo: phone, loginDeviceId: deviceId, password: password, success: { (result) in
                        
                        //                        let jsonData = try? JSONEncoder().encode(result)
                        //                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        //                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        //
                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
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
                        UserDefaults.standard.set(Utils.generateLogoutTime(), forKey : Constants.LOGIN_TIME)
                        UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                        //UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
                        
                        //print("CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
                        
                        let sessionJson = try? JSONEncoder().encode(sessionData)
                        let sessionString = String(data: sessionJson!, encoding: .utf8)!
                        UserDefaults.standard.set(sessionString, forKey: Constants.SESSION_INFO)
                        
                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_NEW_VIEW_CONTROLLER) as! HomeNewViewController
                        let vc = navigationVC.children.first as! HomePageViewController
                        vc.sessionDataBean = sessionData
                         navigationVC.modalPresentationStyle = .overFullScreen
                        self.present(navigationVC, animated: true, completion: nil)
                        
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
//                            Utils.showAlert(viewcontroller: self, title: Constants.LOGIN_FAILED_TITIE, message: error)
                            
                            let alertController = UIAlertController(title: Constants.LOGIN_FAILED_TITIE, message: error, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                DispatchQueue.main.async {
                                    self.gotoLoginPage()
                                }
                            }))
                            self.present(alertController, animated: true, completion: nil)
                        }
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
                            DispatchQueue.main.async {
                                self.gotoLoginPage()
                            }
                        case LAError.userFallback?:
                            message = "You pressed password."
                            DispatchQueue.main.async {
                                self.gotoLoginPage()
                            }
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
            //User Clicked "Don't Allow"
            if "\(authError?.code ?? 0)" == "-6" {
                self.presentSettings()
            } else {
                let alertController = UIAlertController(title: "Verification Failed", message: "You cann't verify with your biometric data", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.gotoLoginPage()
                }))
//                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: {
                    
                })
            }
            
        }
    }
    
    func presentSettings() {
        let alertController = UIAlertController(title: "To Allow Biometric Access, Go to Settings",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            self.gotoLoginPage()
        }))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
    
    func gotoForceChangePhVerify() {
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_PHONE_CONFIRM_VIEW_CONTROLLER) as! UINavigationController
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_PHONE_CONFIRM_VIEW_CONTROLLER) as! ForceChangePhoneConfirmViewController
         navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }

    /*
     * Check new version on app store
     */
    func isUpdateAvailable(completion: @escaping (Bool?, Error?, String?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let _ = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=mm.com.aeonmicrofinance.vcsaeon.AEONVCS") else {
                throw VersionError.invalidBundleInfo
        }
//        print("store url: ",url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                    throw VersionError.invalidResponse
                }
//                print("store version : ", version , currentVersion)
                completion(version == currentVersion, nil, version)
            } catch {
                completion(nil, error, nil)
            }
        }
        task.resume()
        return task
    }
    
    enum VersionError: Error {
        case invalidResponse, invalidBundleInfo
    }
}
