//
//  MainNewViewController.swift
//  AEONVCS
//
//  Created by mac on 2/5/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit
import LocalAuthentication

class MainNewViewController: BaseUIViewController {

    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var loginView: CardView!
    @IBOutlet weak var freeChatView: CardView!
    @IBOutlet weak var loanCalculatorView: CardView!
    @IBOutlet weak var registerView: CardView!
    @IBOutlet weak var goodnewsView: CardView!
    @IBOutlet weak var findusView: CardView!
    @IBOutlet weak var ourserviceView: CardView!
    @IBOutlet weak var announcementView: CardView!
    @IBOutlet weak var howtouseView: CardView!
    @IBOutlet weak var facebookView: CardView!
    @IBOutlet weak var shareView: CardView!
    
    
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblRegister: UILabel!
    @IBOutlet weak var lblFreeChat: UILabel!
    @IBOutlet weak var lblGoodNews: UILabel!
    @IBOutlet weak var lblLoanCallulator: UILabel!
    @IBOutlet weak var lblFindUs: UILabel!
    @IBOutlet weak var lblOurService: UILabel!
    @IBOutlet weak var lblAnnouncement: UILabel!
    @IBOutlet weak var lblHowtouse: UILabel!
    @IBOutlet weak var lblFacebook: UILabel!
    @IBOutlet weak var lblShare: UILabel!
    
    @IBOutlet weak var viewoverScrollView: UIView!
    
    var vidoeFilePath : String = ""
    
    @IBOutlet weak var lblBarPhNo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
        self.viewoverScrollView.isHidden = true
        
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.viewoverScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapViewOverScrollView)))
        
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        self.loginView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapLoginView)))

        self.freeChatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFreeChatView)))
        self.loanCalculatorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapLoanCalculatorView)))
        self.registerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapRegisterView)))
        self.goodnewsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapGoodNewsView)))
        self.findusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFindUsView)))
        self.ourserviceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapOurServiceView)))
        self.announcementView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAnnouncementView)))
        self.howtouseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapHowToUseView)))
        self.facebookView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFacebookView)))
        self.shareView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapShareView)))

      
        self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(!(UserDefaults.standard.bool(forKey: Constants.IS_LOGOUT)) &&
            UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO) != nil){
            UserDefaults.standard.set(nil, forKey: Constants.USER_INFO_NAME)
        }
        
        print("InfoName\(UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME))")
        
//        RoomSyncViewModel.init().roomSync(phoneNo: UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE) ?? "09", success: {(result) in
//
//            let freeCustomerInfoId = result.data.freeCustomerInfoID
//
//             UserDefaults.standard.set(freeCustomerInfoId, forKey: Constants.FREECUS_INFO_ID)
//
//        }) { (error) in
//
//        }
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
        self.lblLogin.text = "home.login.button".localized
        self.lblLoanCallulator.text = "main.loancalculator".localized
        self.lblRegister.text = "main.register".localized
        self.lblGoodNews.text = "main.goodnews".localized
        self.lblFindUs.text = "main.findus".localized
        self.lblOurService.text = "main.ourservice".localized
        self.lblAnnouncement.text = "main.announcement".localized
        self.lblHowtouse.text = "main.howtouse".localized
        self.lblShare.text = "main.share".localized
        self.lblFreeChat.text = "contactus.title".localized
    
    }
    
    @objc func onTapViewOverScrollView(){
        self.viewoverScrollView.isHidden = true
    }
    
    @objc func onTapLoginView() {
        print("click")
        
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
             self.viewoverScrollView.isHidden = false
        }
        
       
        
    }
    
     @objc func onTapFreeChatView() {
        print("click")
         let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "FreeChatViewController") as! UIViewController
              navigationVC.modalPresentationStyle = .overFullScreen
              self.present(navigationVC, animated: true, completion: nil)
     }
    
    @objc func onTapRegisterView() {
       print("click")
      let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! UIViewController
       navigationVC.modalPresentationStyle = .overFullScreen
       self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapLoanCalculatorView() {
        print("click")
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoanCalculatorViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    
    }
    
    @objc func onTapAnnouncementView() {
         
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PromotionViewController") as! UIViewController
               navigationVC.modalPresentationStyle = .overFullScreen
               self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapGoodNewsView() {
       
         UserDefaults.standard.set(1, forKey: Constants.togoodnewsfrom)
        
         let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "GoodNewsViewController") as! UIViewController
         navigationVC.modalPresentationStyle = .overFullScreen
         self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapHowToUseView() {
        print("click")
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HowToUseViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
//        var vc = navigationVC.children.first as! HowToUseViewController
//        vc.vdoPath = self.vidoeFilePath
        self.present(navigationVC, animated: true, completion: nil)
        
    }
    
    @objc func onTapOurServiceView() {
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "FaqAndTermsConditionViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapFindUsView() {
        print("click")
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "OutletInfoViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
       
    }
    
    
    @objc func onTapFacebookView() {
        print("click")
        
        UIApplication.tryURL(urls: [
        "fb://profile/116374146706", // App
        "https://www.facebook.com/AeonMicrofinance/" // Website if app fails
        ])
        
    }
    
    @objc func onTapShareView() {
        print("clickShare")
        
        let shareText = "https://apps.apple.com/pe/app/aeon-myanmar-app/id1462606788?l=en"
        
        let messageVC = CustomMessageActivity(message:shareText)
        let vc = UIActivityViewController(activityItems: [shareText],   applicationActivities: [messageVC])
        vc.excludedActivityTypes = [UIActivity.ActivityType.init(rawValue: "com.linkedin.LinkedIn.ShareExtension"),.message]
        
        vc.completionWithItemsHandler = { activity, success, items, error in
            if !success{
                print("cancelled")
                return
            }
            
        }
        present(vc, animated: true)
        
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
                            UserDefaults.standard.set(result.data.name, forKey: Constants.USER_INFO_NAME)
                            UserDefaults.standard.set(Utils.generateLogoutTime(), forKey : Constants.LOGIN_TIME)
                            UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                            //UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
                            
                            //print("CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
                            
                            let sessionJson = try? JSONEncoder().encode(sessionData)
                            let sessionString = String(data: sessionJson!, encoding: .utf8)!
                            UserDefaults.standard.set(sessionString, forKey: Constants.SESSION_INFO)
                            
//                            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//                            let vc = navigationVC.children.first as! HomePageViewController
                             let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
                            vc.sessionDataBean = sessionData
                             vc.modalPresentationStyle = .overFullScreen
                            self.present(vc, animated: true, completion: nil)
                            
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
                                        self.viewoverScrollView.isHidden = false
                                    }
                                }))
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        
                        if phone == "Constants.phoneNumber" &&
                            password == "Constants.password"{
                            let navVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
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
                                    self.viewoverScrollView.isHidden = false
                                }
                            case LAError.userFallback?:
                                message = "You pressed password."
                                DispatchQueue.main.async {
                                    self.viewoverScrollView.isHidden = false
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
                        self.viewoverScrollView.isHidden = false
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
            self.viewoverScrollView.isHidden = false
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
//           let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_PHONE_CONFIRM_VIEW_CONTROLLER) as! UINavigationController
         let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_PHONE_CONFIRM_VIEW_CONTROLLER) as! UIViewController
            navigationVC.modalPresentationStyle = .overFullScreen
           self.present(navigationVC, animated: true, completion: nil)
       }
    
    


}


extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                if #available(iOS 10.0, *) {
                    application.open(URL(string: url)!, options: [:], completionHandler: nil)
                }
                else {
                    application.openURL(URL(string: url)!)
                }
                return
            }
        }
    }
}
