//
//  BioMetricRegisterViewController.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import LocalAuthentication

class BioMetricRegisterViewController: BaseUIViewController {

    @IBOutlet weak var svBioMetricVerify: UIScrollView!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPhone.delegate = self
        tfPassword.delegate = self

    }
    @IBAction func onClickSubmitButton(_ sender: UIButton) {
        guard let phone = tfPhone.text else{
            return
        }
        guard let password = tfPassword.text else{
            return
        }
        
        //call api to check username and password
        
        LoginViewModel.init().login(phoneNo: phone, password: password, success: { (result) in
            self.authenticateBioMetricData(phone: phone, password: password)
        }) { (error) in
            Utils.showAlert(viewcontroller: self, title: "Verification Failed", message: error)
        }
    }
    
    func authenticateBioMetricData(phone:String,password:String){
        let authContext = LAContext()
        let authReason = "Use your bimetric data to login your account"
        var authError : NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: {success,evaluateError in
                
                
                if success {
                    //                    DispatchQueue.main.async {
                    // User authenticated successfully, take appropriate action
                    //                        completion(nil)
                    //                    }
                    let defaults = UserDefaults.standard
                    defaults.set(phone, forKey: "phone")
                    defaults.set(password, forKey: "password")
                    let navVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
                    self.present(navVC, animated: true, completion: nil)
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
            let alertController = UIAlertController(title: "Vericfiation Failed", message: "You cann't verfiy with your biometric data", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: {
                
            })
        }
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
