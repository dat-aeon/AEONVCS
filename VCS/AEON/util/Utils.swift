//
//  Utils.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication
import SwiftyJSON

class Utils{
    
    static func setLineSpacing(data:String , label : UILabel) {
        let attributedString = NSMutableAttributedString(string: data)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        // *** Set Attributed String to your label ***
        label.attributedText = attributedString
        
    }
    static func showAlert(viewcontroller:UIViewController,title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: nil)
        alert.addAction(okAction)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(viewcontroller:UIViewController,title:String,message:String,action:@escaping ()->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: { _ in
            action()
        })
        alert.addAction(okAction)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    func generateQRCode(data input:String) -> UIImage? {
        let data = input.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                let outputImage = UIImage(ciImage: output)
                return outputImage
            }
        }
        return nil
    }
    
    static func showExpireAlert(viewcontroller:UIViewController,title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
            UserDefaults.standard.set(nil, forKey: Constants.USER_INFO_CUSTOMER_ID)
            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
            UserDefaults.standard.set(nil, forKey: Constants.HOTLINE_NO)
            UserDefaults.standard.set(true, forKey: Constants.IS_LOGOUT)
            UserDefaults.standard.set(Constants.BLANK, forKey: Constants.LAST_USED_TIME)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
            navigationVC.modalPresentationStyle = .overFullScreen
            viewcontroller.present(navigationVC, animated: true, completion: nil)
            
        })
        
        alert.addAction(okAction)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    static func changeDMYDateformat ( date: String) -> String{
        //        let strconstant = "2019-10-16T17:30:00.000+0000"
        let formatter = DateFormatter()
        //        self.convertDateFormatterOh(date: strconstant)
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let convertDate = formatter.date(from: date)
        
        formatter.dateFormat = "dd-MM-yyyy"
        let myString = formatter.string(from: convertDate!)
        
        
        
        return myString
    }
    
    // user for Membership Last repayment date
    static func newchangeDMYDateformat ( date: String?) -> String{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Foundation.Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 23400)
        let convertDate = formatter.date(from: date!)
        
        formatter.dateFormat = "dd-MM-yyyy"
        let myString = formatter.string(from: convertDate!)

        return myString
    }
    
    
    static func changeYMDDateformat ( date: String) -> String{
        //        let strconstant = "2019-10-16T17:30:00.000+0000"
        //        self.convertDateFormatterOh(date: strconstant)
        // initially set the format based on your datepicker date / server String
        //        if #available(iOS 11.0, *) {
        //            let f = ISO8601DateFormatter()
        //            //f.formatOptions = [.withDashSeparatorInDate]
        //            let conDate = f.date(from: date)
        //            let f2 = ISO8601DateFormatter()
        //            //f2.formatOptions = [.withDashSeparatorInDate]
        //            return f2.string(from: conDate!)
        //
        //        } else {
        // Fallback on earlier versions
        if date.isEmpty {
            return date
        } else if date.count == 10 {
            return date
        }
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter1.locale = Foundation.Locale(identifier: "en_US_POSIX")
        formatter1.timeZone = TimeZone(secondsFromGMT: 0)
        let convertDate = formatter1.date(from: date)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd"
        let myString = formatter2.string(from: convertDate!)
        return myString
        //}
        
    }
    
    static func convertDateFormatterOh(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Foundation.Locale(identifier: "en_EN")
        let convertedDate = dateFormatter.date(from: date)
        
        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "yyyy MMM HH:mm EEEE"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        
        return timeStamp
    }
    
    static func getDateFromDisplayDate(date: String) -> String {
        let dobtemp = date.strstr(needle: "T", beforeNeedle: true)
        let substrings = dobtemp?.split(separator: "-", maxSplits: 2, omittingEmptySubsequences: false)
        
        var formattedString = ""
        if substrings?.count == 3 {
            formattedString = "\(substrings![2])-\(substrings![1])-\(substrings![0])"
        }
        return formattedString
    }
    
    //    static func changeDMYDateformatForNewiOS ( date: String) -> String{
    //        let formatter = DateFormatter()
    //        // initially set the format based on your datepicker date / server String
    //        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSSZ"
    //        let convertDate = formatter.date(from: date)
    //
    //        formatter.dateFormat = "dd-MM-yyyy"
    //        let myString = formatter.string(from: convertDate!)
    //
    //        return myString
    //    }
    
    static func changeOldMesgDateformat ( date: String) -> String{
        
         let formatter = DateFormatter()
                  // initially set the format based on your datepicker date / server String
                  formatter.dateFormat = "dd MMM yy hh:mm aaa"
                  let convertDate = formatter.date(from: date)

                 // formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
                  let myString = formatter.string(from: convertDate!)

                  return myString
//        let formatter = DateFormatter()
//               formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//               let convertDate = formatter.date(from: (formatter.string(from: Date()) as NSString) as String)
//               
//               formatter.dateFormat = "dd-MM-yyyy HH:mm a"
//               let myString = formatter.string(from: convertDate!)
//               
//               return myString
    }
    
    static func isNameValidate (name: String) -> Bool {
        let regex = "[a-zA-Z0-9 ]*"
        let isAlpha = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: name)
        if isAlpha {
            return true
        }
        return false
    }
    
    static func isDobValidate (dob: String) -> Bool {
        let regex = "[0-9]{1,2}-[0-9]{1,2}-[0-9]{1,4}"
        let isAlpha = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: dob)
        if isAlpha {
            return true
        }
        return false
    }
    
    static func isDobValidateDA (dob: String) -> Bool {
        let regex = "[0-9]{1,4}-[0-9]{1,2}-[0-9]{1,2}"
        let isAlpha = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: dob)
        if isAlpha {
            return true
        }
        return false
    }
    
    static func isPhoneValidate (phoneNo: String) -> Bool {
        let regex = "09[0-9]{7,9}"
        let isAlpha = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNo)
        if isAlpha {
            
            return true
        }
        return false
    }
    
    static func isNumberValidate (phoneNo: String) -> Bool {
        let zeroone = "[0-9]{6,11}"
        let isphnumber = NSPredicate(format: "SELF MATCHES %@", zeroone).evaluate(with: phoneNo)
        if isphnumber {
            return true
        }
        return false
    }
    
    static func isNrcNoValidate (nrcNo: String) -> Bool {
        let regex = "[0-9]{6}"
        let isAlpha = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: nrcNo)
        if isAlpha {
            return true
        }
        return false
    }
    
    static func isPasswordValidate (password: String) -> Bool {
        let regex = "[a-zA-Z0-9 ]*"
        let isAlpha = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
        if isAlpha {
            return true
        }
        return false
    }
    
    static func isAgreementNoValidate (agreementNo: String) -> Bool {
        let regex = "[0-9]{4}-[0-9]{1}-[0-9]{10}-[0-9]{1}"
        let isAlpha = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: agreementNo)
        if isAlpha {
            return true
        }
        return false
    }
    
    static func isAnswerValidate (name: String) -> Bool {
        let regex = "[a-zA-Z0-9 ]{1,}"
        let isAlpha = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: name)
        if isAlpha {
            return true
        }
        return false
    }
    
    static func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    static func authenticateBioMetricData(viewController: UIViewController, phone:String,password:String){
        let authContext = LAContext()
        let authReason = "Use your biometric data to login your account"
        var authError : NSError?
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: {success,evaluateError in
                
                if success{
                    // check network
                    if Network.reachability.isReachable == false {
                        Utils.showAlert(viewcontroller: viewController, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                        
                        // set default value to BIO_FINGERPRINT_LOGIN
                        UserDefaults.standard.set(false, forKey: Constants.IS_BIO_LOGIN)
                        return
                    }
                    
                    //call api to check username and password
                    LoginAuthViewModel.init().accessLoginToken(phoneNo: phone, loginDeviceId: deviceId, password: password, success: { (result) in
                        
                        //set nil to response
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
                        UserDefaults.standard.set(self.generateLogoutTime(), forKey : Constants.LOGIN_TIME)
                        UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                        UserDefaults.standard.set(self.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
                        
                        print("CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
                        
                        let jsonData = try? JSONEncoder().encode(sessionData)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
                        
//                        let navigationVC = viewController.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//                        let vc = navigationVC.children.first as! HomePageViewController
                        let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
                        vc.sessionDataBean = sessionData
                        vc.modalPresentationStyle = .overFullScreen
                        viewController.present(vc, animated: true, completion: nil)
                        
                        
                    }) { (error) in
                        
                        // set default value to BIO_FINGERPRINT_LOGIN
                        UserDefaults.standard.set(false, forKey: Constants.IS_BIO_LOGIN)
                        
                        let alert = UIAlertController(title: Constants.LOGIN_FAILED_TITIE, message: Messages.MAIN_BIOMETRIC_FAILED_ERROR.localized, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: { action in
                            
                            //                            let navigationVC = viewController.storyboard?.instantiateViewController(withIdentifier: CommonNames.BIOMETRIC_VIEW_CONTROLLER) as! UINavigationController
                            //                            let vc = navigationVC.children.first as! BioMetricRegisterViewController
                            //                            vc.isUpdate = true
                            
//                            let navigationVC = viewController.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! UINavigationController
                            let navigationVC = viewController.storyboard?.instantiateViewController(withIdentifier: "MainNewViewController") as! MainNewViewController
                            navigationVC.modalPresentationStyle = .overFullScreen
                            viewController.present(navigationVC, animated: true, completion: nil)
                            
                        })
                        let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: nil)
                        alert.addAction(okAction)
                        alert.addAction(cancelAction)
                        viewController.present(alert, animated: true, completion: nil)
                    }
                    
                    if phone == "Constants.phoneNumber" &&
                        password == "Constants.password" {
//                        let navVC = viewController.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
                        let navVC = viewController.storyboard?.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
                        navVC.modalPresentationStyle = .overFullScreen
                        viewController.present(navVC, animated: true, completion: nil)
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
                    
                    // set default value to BIO_FINGERPRINT_LOGIN
                    UserDefaults.standard.set(false, forKey: Constants.IS_BIO_LOGIN)
                }
            })
        }else{
            // set default value to BIO_FINGERPRINT_LOGIN
            UserDefaults.standard.set(false, forKey: Constants.IS_BIO_LOGIN)
            
            let alertController = UIAlertController(title: Constants.VERIFY_FAILED_TITIE, message: Messages.BIOMETRIC_VERIFY_FAILED_ERROR.localized, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                let navigationVC = viewController.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                viewController.present(navigationVC, animated: true, completion: nil)
            }))
            viewController.present(alertController, animated: true, completion: {
                
            })
        }
    }
    
    static func isAuthenticateBiometric() -> Bool{
        let authContext = LAContext()
        let authReason = "Use your biometric data to login your account"
        var authError : NSError?
        
        var isSuccess : Bool = false
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: {success,evaluateError in
                
                if success{
                    //return success
                    isSuccess = true
                } else {
                    //return false
                    isSuccess = false
                }
            })
            return isSuccess
        } else{
            isSuccess = false
        }
        return isSuccess
    }
    
    static func generateLogoutTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return(formatter.string(from: Date()) as NSString) as String
    }
    
    static func setLineSpacing(data:String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: data)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        // *** Set Attributed String to your label ***
        return attributedString
        
    }
    
}

// For member card
extension Collection {
    var pairs: [SubSequence] {
        var startIndex = self.startIndex
        let count = self.count
        let n = count/2 + count % 2
        return (0..<n).map { _ in
            let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return self[startIndex..<endIndex]
        }
    }
}

// For member card
extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert(separator: Self, every n: Int) {
        for index in indices.reversed() where index != startIndex &&
            distance(from: startIndex, to: index) % n == 0 {
                insert(contentsOf: separator, at: index)
        }
    }
    
    func inserting(separator: Self, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
    
}
