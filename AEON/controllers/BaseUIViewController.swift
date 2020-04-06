//
//  BaseUIViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import Reachability
import Starscream
import SwiftyJSON

class BaseUIViewController: UIViewController,UITextFieldDelegate {
    
    var messageImagePicker = UIImagePickerController()
    var registerImagePicker = UIImagePickerController()
    
    //let messagingSocket = WebSocket(Constants.socket_url)
    //let menuSocket = WebSocket(Constants.socket_url)
    
    var socket = WebSocket(url: URL(string: Constants.socket_url)!, protocols: ["chat"])
    var at_socket = WebSocket(url: URL(string: Constants.at_socket_url)!, protocols: ["chat"])
    var free_chat_socket_url = WebSocket(url: URL(string: Constants.free_chat_socket_url)!, protocols: ["chat"])
    
    static let baseController = BaseUIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "PyidaungsuBook-Bold", size: 21)!]
        
        //Locale Change Observer
        NotificationCenter.default.addObserver(self, selector: #selector(localeChanged), name: NSNotification.Name(Locale.ChangeNotification), object: nil)
        
        //Keyboard Show Hide Observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        //Hide Keyboard when click view
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        // Network connection Observer
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(statusManager),
                                               name: .flagsChanged,
                                               object: nil)
        updateUserInterface()
        
        //self.printfont()
        
    }
    
    func updateUserInterface() {
        if !Network.reachability.isReachable {
            
            //view.backgroundColor = .red
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            
        }
        //        print("Reachability Summary")
        //        print("Status:", Network.reachability.status)
        //        print("HostName:", Network.reachability.hostname ?? "nil")
        //        print("Reachable:", Network.reachability.isReachable)
        //        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    @objc func applicationWillResignActive() {
        let lastUseTime = Utils.generateLogoutTime()
        UserDefaults.standard.set(lastUseTime, forKey: Constants.LAST_USED_TIME)
        //        print("App is inactive.")
        //        print("Lastest Time: ", lastUseTime)
        
    }
    
    @objc public func applicationWillEnterForeground() {
        //        print("App is active.")
        
        let sessionTime = 180.0
        let lastUsedTime = UserDefaults.standard.string(forKey: Constants.LAST_USED_TIME)
        let currentTime = Utils.generateLogoutTime()
        //        print("Lastest Time: ", lastUsedTime ?? Constants.BLANK)
        
        if lastUsedTime != nil && lastUsedTime != Constants.BLANK {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let last = formatter.date(from: lastUsedTime!) ?? formatter.date(from: currentTime)
            let current = formatter.date(from: currentTime)
            
            let elapsedTime = current!.timeIntervalSince(last!)
            print("Session time : \(elapsedTime)")
            
            if elapsedTime > sessionTime {
                let customerId = UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID)
                let logoutTime = UserDefaults.standard.string(forKey: Constants.LAST_USED_TIME)
                let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
                let tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
                
                if tokenInfo == nil {
                    UserDefaults.standard.set(Constants.BLANK, forKey: Constants.LAST_USED_TIME)
                    return
                }
                
                let alertController = UIAlertController(title: "Session Timeout", message: Messages.SESSION_TIMEOUT_ERROR.localized, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    
                    UserDefaults.standard.set(false, forKey: CommonNames.VERSION_ALERT_SHOWN)
                    
                    if (customerId != nil && logoutTime != nil && logoutTime != Constants.BLANK) {
                        //                        print("Session::\(customerId ?? "0") + \(logoutTime ?? "00")")
                        
                        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                        
                        // check network
                        if Network.reachability.isReachable == false {
                            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                            UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
                            UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
                            UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                            UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
                            UserDefaults.standard.set(nil, forKey: Constants.USED_COUPON_LIST)
                            
                            UserDefaults.standard.set(8, forKey: Constants.MESSAGING_MENU)
                            UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
                            UserDefaults.standard.set(true, forKey: Constants.MENU_SOCKET_CLOSE)
                            self.socket.disconnect()
                            
                            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER)
                            navigationVC.modalPresentationStyle = .overFullScreen
                            self.present(navigationVC, animated: true, completion:nil)
                            //
                            //                            let storyboard = UIStoryboard(name: CommonNames.MAIN_STORYBOARD, bundle: nil)
                            //                            let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.HOME_NEW_VIEW_CONTROLLER) as! UINavigationController
                            //                             navigationVC.modalPresentationStyle = .overFullScreen
                            //                            self.present(navigationVC, animated: true, completion:nil)
                            return
                        }
                        
                        LogoutViewModel.init().logout(customerId: customerId!, logoutTime: logoutTime!,tokenInfo: tokenInfo!, success: { (result) in
                            
                            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                            UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
                            UserDefaults.standard.set(nil, forKey: Constants.USER_INFO_CUSTOMER_ID)
                            UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
                            UserDefaults.standard.set(nil, forKey: Constants.HOTLINE_NO)
                            UserDefaults.standard.set(true, forKey: Constants.IS_LOGOUT)
                            UserDefaults.standard.set(Constants.BLANK, forKey: Constants.LAST_USED_TIME)
                            UserDefaults.standard.set(nil, forKey: Constants.USED_COUPON_LIST)
                            UserDefaults.standard.set(nil, forKey: Constants.USER_INFO_NAME)
                            UserDefaults.standard.set(8, forKey: Constants.MESSAGING_MENU)
                            UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
                            UserDefaults.standard.set(true, forKey: Constants.MENU_SOCKET_CLOSE)
                            self.socket.disconnect()
                            
                            //                            let storyboard = UIStoryboard(name: CommonNames.MAIN_STORYBOARD, bundle: nil)
                            //                            let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
                            //                             navigationVC.modalPresentationStyle = .overFullScreen
                            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER)
                            navigationVC.modalPresentationStyle = .overFullScreen
                            
                            let currVC = self.presentingViewController
                            self.dismiss(animated: true, completion: {
                                currVC?.present(navigationVC,  animated: true, completion: nil)
                            })
                        }) { (error) in
                            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                            UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
                            UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
                            UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                            UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
                            UserDefaults.standard.set(nil, forKey: Constants.USED_COUPON_LIST)
                            
                            UserDefaults.standard.set(8, forKey: Constants.MESSAGING_MENU)
                            UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
                            UserDefaults.standard.set(true, forKey: Constants.MENU_SOCKET_CLOSE)
                            self.socket.disconnect()
                            
                            //                            let storyboard = UIStoryboard(name: CommonNames.MAIN_STORYBOARD, bundle: nil)
                            //                            let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
                            //                             navigationVC.modalPresentationStyle = .overFullScreen
                            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER)
                            navigationVC.modalPresentationStyle = .overFullScreen
                            
                            let currVC = self.presentingViewController
                            self.dismiss(animated: true, completion: {
                                currVC?.present(navigationVC,  animated: true, completion: nil)
                            })
                            
                            return
                        }
                    }
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                UserDefaults.standard.set(Constants.BLANK, forKey: Constants.LAST_USED_TIME)
            }
        }
    }
    
    func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    //Remove Observer
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("FlagsChanged"), object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //        print("Remove observer.")
    }
    
    
    //Locale Change Functions Start
    @objc func localeChanged() {
        reloadDataIfVCVisible()
    }
    
    private func reloadDataIfVCVisible() {
        if viewIfLoaded?.window != nil {
            updateViews()
        }
    }
    
    //override this method if you want to change views in viewcontroller
    public func updateViews() {
        //update views in viewcontroller
    }
    
    
    //call this function when click in language icon
    public func updateLocale(){
        switch Locale.currentLocale {
        case .EN:
            Locale.currentLocale = .MY
        case .MY:
            Locale.currentLocale = .EN
        }
        NotificationCenter.default.post(NSNotification.init(name: NSNotification.Name(Locale.ChangeNotification), object: nil) as Notification)
    }
    
    
    public func NewupdateLocale(flag : Int){
        //        switch Locale.currentLocale {
        //        case .EN:
        //            Locale.currentLocale = .MY
        //        case .MY:
        //            Locale.currentLocale = .EN
        switch flag {
        case 1:
            Locale.currentLocale = .MY
        case 2:
            Locale.currentLocale = .EN
        default:
            Locale.currentLocale = .MY
            
        }
        NotificationCenter.default.post(NSNotification.init(name: NSNotification.Name(Locale.ChangeNotification), object: nil) as Notification)
    }
    //Locale Change Functions End
    
    func generateCurrentTimeStamp () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
    func generateCurrentTimeForMessage () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertDate = formatter.date(from: (formatter.string(from: Date()) as NSString) as String)
        
        formatter.dateFormat = "dd-MM-yyyy HH:mm a"
        let myString = formatter.string(from: convertDate!)
        
        return myString
    }
    
    // Change date format
    func changeDateformat ( date: String) -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Foundation.Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 23400)
        let convertDate = formatter.date(from: date)
        
        formatter.dateFormat = "dd-MM-yyyy h:mm a"
        let myString = formatter.string(from: convertDate!)
        
        return myString
    }

    
    // Change date format
    func changeMessageDateformat ( date: String) -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertDate = formatter.date(from: date)
        
        formatter.dateFormat = "dd-MM-yyyy h:mm a"
        let myString = formatter.string(from: convertDate!)
        
        return myString
    }
    
    // Change date format
    func changeYMDformat ( date: String) -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "dd-MM-yyyy"
        let convertDate = formatter.date(from: date)
        
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: convertDate!)
        
        return myString
    }
    
    // Network Connection Error Alert
    @objc func networkConnectionError () {
        let alertController = UIAlertController(title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
            let storyboard = UIStoryboard(name: CommonNames.MAIN_STORYBOARD, bundle: nil)
            let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Resize image for iPad
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        //        print("new size", newSize)
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func printfont() {
        for family in UIFont.familyNames {
            print("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}

//Keyboard Show Hide Functions
extension BaseUIViewController{
    @objc func keyboardWillChange(notification : Notification) {
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//Open Camera
extension BaseUIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCustomCamera(imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            registerImagePicker.delegate = imagePickerControllerDelegate
            registerImagePicker.sourceType = UIImagePickerController.SourceType.camera
            registerImagePicker.allowsEditing = true
            
            //            print("allow camera")
            let mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-200))
            let dimX = mainView.frame.size.width - mainView.frame.size.height
            let frame             = CGRect.init(x: dimX/2, y: 0, width: mainView.frame.size.height, height: mainView.frame.size.height)
            let blockView         = UIImageView.init(frame: frame)
            //blockView.contentMode = .scaleAspectFit
            blockView.image       = UIImage(named: "camera-grid")
            //mainView.backgroundColor = UIColor.blue
            //blockView.backgroundColor = UIColor.red
            let textFrame        = CGRect.init(x: 5, y: mainView.frame.size.height-50, width: mainView.frame.size.height, height: 50)
            let textView         = UILabel.init(frame: textFrame)
            textView.text        = "Please don't have glass on your face during the photo shoot."
            textView.textColor = UIColor.red
            textView.backgroundColor = UIColor.white
            textView.font = UIFont.systemFont(ofSize: 15)
            textView.numberOfLines = 0
            mainView.addSubview(blockView)
            mainView.addSubview(textView)
            registerImagePicker.cameraOverlayView = mainView
            //            print("allow camera \(dimX) +\(mainView.frame.size.width) + \(mainView.frame.size.height)")
            self.present(registerImagePicker, animated: true)
            
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            registerImagePicker.delegate = imagePickerControllerDelegate
            registerImagePicker.sourceType = UIImagePickerController.SourceType.camera
            registerImagePicker.allowsEditing = true
            //            print("not allow camera")
            
            self.present(registerImagePicker, animated: true)
        }
    }
    
    func openPlainCamera(imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate, isRegister: Bool)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            messageImagePicker.delegate = imagePickerControllerDelegate
            messageImagePicker.sourceType = UIImagePickerController.SourceType.camera
            messageImagePicker.allowsEditing = true
            //            print("allow camera")
            
            self.present(messageImagePicker, animated: true)
            
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            messageImagePicker.delegate = imagePickerControllerDelegate
            messageImagePicker.sourceType = UIImagePickerController.SourceType.camera
            messageImagePicker.allowsEditing = true
            //            print("not allow camera")
            
            self.present(messageImagePicker, animated: true)
        }
    }
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

