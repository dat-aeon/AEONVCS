//
//  OTPRegisterViewController.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class OTPRegisterViewController: BaseUIViewController {
    
    var registerRequestData:RegisterRequestBean?
    var profileImage:UIImage?
    var memberResponseData:CheckMemberResponse?
    var qaList:[SecQABean] = []
    var registerResponse:RegisterResponse?
    var otpCode:String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfOTPtext: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var count:Int = 30
    var countTimer:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("generate otp code ::: \(self.otpCode ?? "")")
        
        Utils.showAlert(viewcontroller: self, title: "YOUR OTP", message: self.otpCode!)
        
        self.btnResend.isEnabled = false
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
        self.lblTitle.text = "otp.title".localized
        self.btnSend.setTitle("otp.send.button".localized, for: UIControl.State.normal)
        self.btnResend.setTitle("otp.resend.button".localized, for: UIControl.State.normal)
    }
    
    @IBAction func onClickSendBtn(_ sender: Any) {
        
        if self.tfOTPtext.text?.isEmpty ?? true {
            self.tfOTPtext?.showError(message: Messages.OTP_EMPTY_ERROR)
            return
            
        } else if self.tfOTPtext.text?.count ?? 0 < 4 {
            self.tfOTPtext?.showError(message: Messages.OTP_LENGTH_ERROR)
            return
            
        } else if self.tfOTPtext.text != self.otpCode {
            self.tfOTPtext?.showError(message: Messages.OTP_WRONG_ERROR)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().makeRegisterExistedMember(registerRequestData: registerRequestData!, profileImage: profileImage ?? UIImage(named: "Image")!, memberResponseData: memberResponseData!, qaList: qaList, success: { (registerResponse) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.registerResponse = registerResponse
            
            //set nil to response
            UserDefaults.standard.set(nil, forKey: Constants.LOGIN_RESPONSE)
            UserDefaults.standard.set(registerResponse.phoneNo, forKey: Constants.USER_INFO_PHONE_NO)
            
            if let registerResponseData = self.registerResponse{
                let jsonData = try? JSONEncoder().encode(registerResponseData)
                let jsonString = String(data: jsonData!, encoding: .utf8)!
                UserDefaults.standard.set(jsonString, forKey: Constants.REGISTER_RESPONSE)
            }
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
            let vc = navigationVC.children.first as! HomeViewController
            vc.registerResponse = registerResponse
            self.present(navigationVC, animated: true, completion: nil)
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Register Failed", message: "You cannot register now.")
        }
    }
    
    @objc func changeTitle(){
        if(self.count == 0) {
            //self.btnResend.setTitle("SEND OTP AGAIN \(self.count)", for: .normal)
            self.lblTimer.text = "SEND OTP AGAIN \(self.count)"
            self.count -= 1
                    
        } else {
            //t.invalidate()
            self.btnResend.isEnabled = true
        }
        
    }
    
    @IBAction func onClickResend(_ sender: Any) {
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        OTPViewModel.init().sendOTPRequest(siteActivationKey: Constants.SITE_ACTIVATION_KEY, phoneNo: (self.registerRequestData?.phoneNo)!, success: { (result) in
            
            self.otpCode = result.otpCode
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "YOUR OTP", message: self.otpCode!)
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "OTP resend Failed. Please click again.", message: error)
        }
    }
}
