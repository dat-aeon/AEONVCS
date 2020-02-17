//
//  OTPRegisterViewController.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class OTPRegisterViewController: BaseUIViewController {
    
    
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    @IBOutlet weak var lblBarPhNo: UILabel!
    
    var registerRequestData:RegisterRequestBean?
    var profileImage:UIImage?
    var memberResponseData:CheckMemberResponse?
    var qaList:[SecQABean] = []
    var registerResponse:RegisterResponse?
    var otpCode:String?
    var isValid:Bool! = true
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfOTPtext: UITextField!
    @IBOutlet weak var lbOTPMessage: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var count:Int = 120
    var countTimer:Timer!
    
    // Error message Language control
    var otpMesgLocale: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("generate otp code ::: \(self.otpCode ?? "")")
        
        //Utils.showAlert(viewcontroller: self, title: "YOUR OTP", message: self.otpCode!)
        
        
        
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
        
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        self.btnResend.isEnabled = false
        self.btnResend.alpha = 0.5
        self.countTimer = Timer.scheduledTimer(timeInterval: 1 ,
                                               target: self,
                                               selector: #selector(self.changeTitle),
                                               userInfo: nil,
                                               repeats: true)
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.lblTitle.text = "otp.title".localized
        self.btnSend.setTitle("otp.send.button".localized, for: UIControl.State.normal)
        self.btnResend.setTitle("otp.resend.button".localized, for: UIControl.State.normal)
        self.tfOTPtext.keyboardType = UIKeyboardType.numberPad
        self.tfOTPtext.setMaxLength(maxLength: 4)
        self.lbOTPMessage.text = Constants.BLANK
        self.isValid = true
        
         self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showOTPCode()
    }
    
    func showOTPCode() {
        let alertController = UIAlertController(title: "OTP", message: "\(self.otpCode ?? "")", preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
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
        self.lblTitle.text = "otp.title".localized
        self.btnSend.setTitle("otp.send.button".localized, for: UIControl.State.normal)
        self.btnResend.setTitle("otp.resend.button".localized, for: UIControl.State.normal)
        self.lbOTPMessage.text = self.otpMesgLocale?.localized
    }
    
    func isErrorExist() -> Bool {
        
        var isError = false
        if self.tfOTPtext.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            //self.tfOTPtext?.showError(message: Messages.OTP_EMPTY_ERROR)
            self.tfOTPtext.text = Constants.BLANK
            self.lbOTPMessage.text = Messages.OTP_EMPTY_ERROR.localized
            self.otpMesgLocale = Messages.OTP_EMPTY_ERROR
            isError = true
            
        } else if self.tfOTPtext.text?.count ?? 0 < 4 {
            self.tfOTPtext?.text = Constants.BLANK
            self.lbOTPMessage.text = Messages.OTP_LENGTH_ERROR.localized
            self.otpMesgLocale = Messages.OTP_LENGTH_ERROR
            isError = true
            
        } else if !self.isValid {
            self.tfOTPtext?.text = Constants.BLANK
            self.lbOTPMessage.text = Messages.OTP_INVALID_ERROR.localized
            self.otpMesgLocale = Messages.OTP_INVALID_ERROR
            isError = true
            
        } else if self.tfOTPtext.text != self.otpCode {
            self.tfOTPtext?.text = Constants.BLANK
            self.lbOTPMessage.text = Messages.OTP_WRONG_ERROR.localized
            self.otpMesgLocale = Messages.OTP_WRONG_ERROR
            isError = true
            
        } else {
            self.lbOTPMessage.text = Constants.BLANK
            self.otpMesgLocale = Constants.BLANK
        }
        return isError
        
    }
    @IBAction func onClickSendBtn(_ sender: Any) {
        
        if isErrorExist() {
            return
        }
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().makeRegisterExistedMember(registerRequestData: registerRequestData!, profileImage: profileImage ?? UIImage(named: "Image")!, memberResponseData: memberResponseData!, qaList: qaList, success: { (registerResponse) in
            
            LoginAuthViewModel.init().accessLoginToken(phoneNo: (self.memberResponseData?.data?.memberPhoneNo)!, password: (self.registerRequestData?.password)!, success: { (result) in
                
//                let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
//                let tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
//
//                LoginViewModel.init().login(phoneNo: (self.memberResponseData?.data?.memberPhoneNo)!,token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
                // success
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
                
                if (result.data.customerNo == nil) {
                    UserDefaults.standard.set(Constants.NON_MEMBER, forKey: Constants.CUSTOMER_TYPE)
                } else {
                    UserDefaults.standard.set(Constants.MEMBER, forKey: Constants.CUSTOMER_TYPE)
                }
                
                UserDefaults.standard.set(result.data.customerId, forKey: Constants.USER_INFO_CUSTOMER_ID)
                UserDefaults.standard.set(result.data.phoneNo, forKey: Constants.USER_INFO_PHONE_NO)
                UserDefaults.standard.set(super.generateCurrentTimeStamp(), forKey : Constants.LOGIN_TIME)
                UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                UserDefaults.standard.set(super.generateCurrentTimeStamp(), forKey: Constants.LAST_USED_TIME)
                
                let jsonData = try? JSONEncoder().encode(sessionData)
                let jsonString = String(data: jsonData!, encoding: .utf8)!
                UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
                
//                print("REGISTER CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
                
                
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
                let alert = UIAlertController(title: Constants.LOGIN_SUCCESS_TITLE, message: Messages.BIOMETRIC_REGISTER_INFO.localized, preferredStyle: .alert)
                let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: { action in
                    
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.BIOMETRIC_VIEW_CONTROLLER) as! UINavigationController
                    let vc = navigationVC.children.first as! BioMetricRegisterViewController
                    vc.isAlreadyLogin = true
                    vc.sessionData = sessionData
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                })
                let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: { action in
                    
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
                    let vc = navigationVC.children.first as! HomePageViewController
                    vc.sessionDataBean = sessionData
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                })
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                
                
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            }
            
        }) { (error) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
            
        }
    }
    
    @objc func changeTitle(){
        if(self.count > 0) {
            //self.btnResend.setTitle("\(self.count)", for: .normal)
            let minutes = Int(count) / 60 % 60
            let seconds = Int(count) % 60
            self.lblTimer.text = String(format:"%02i:%02i", minutes, seconds)
            self.count -= 1
                    
        } else {
            self.btnResend.isEnabled = true
            self.btnResend.alpha = 1.0
            let minutes = Int(count) / 60 % 60
            let seconds = Int(count) % 60
            self.lblTimer.text = String(format:"%02i:%02i", minutes, seconds)
            self.isValid = false
        }
    }
    
    var timer = Timer()
    let timeInterval:TimeInterval = 0.5
    let timerEnd:TimeInterval = 0.0
    var timeCount:TimeInterval = 300.0 // seconds or 2 hours
    
    @IBAction func onClickResend(_ sender: Any) {
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        OTPViewModel.init().sendOTPRequest(siteActivationKey: Constants.SITE_ACTIVATION_KEY, phoneNo: (self.registerRequestData?.phoneNo)!, success: { (result) in
            
            self.otpCode = result.data.otpCode
            self.showOTPCode()
            self.isValid = true
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.count = 120
            self.btnResend.isEnabled = false
            self.btnResend.alpha = 0.5
            
            //Utils.showAlert(viewcontroller: self, title: "YOUR OTP", message: self.otpCode!)
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "OTP resend Failed. Please click again.", message: error)
        }
    }
}
