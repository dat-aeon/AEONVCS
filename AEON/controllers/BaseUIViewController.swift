//
//  BaseUIViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController,UITextFieldDelegate {
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Locale Change Observer
        NotificationCenter.default.addObserver(self, selector: #selector(localeChanged), name: NSNotification.Name(Locale.ChangeNotification), object: nil)
        
        //Keyboard Show Hide Observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Hide Keyboard when click view
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    //Remove Observer
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self)
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
    //Locale Change Functions End
    
    func applicationDidEnterBackground(application: UIApplication) {
        
        print("we are in the background...")
    }
    
    func applicationWillTerminate(application: UIApplication) {
        
        print("we have terminated")
    }
    
    func generateCurrentTimeStamp () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return (formatter.string(from: Date()) as NSString) as String
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
    
    func openCamera(imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = imagePickerControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            
            let mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-200))
            let dimX = mainView.frame.size.width - mainView.frame.size.height
            let frame             = CGRect.init(x: dimX/2, y: 0, width: mainView.frame.size.height, height: mainView.frame.size.height)
            let blockView         = UIImageView.init(frame: frame)
            //blockView.contentMode = .scaleAspectFit
            blockView.image       = UIImage(named: "camera-grid")
            //mainView.backgroundColor = UIColor.blue
            //blockView.backgroundColor = UIColor.red
            let textFrame        = CGRect.init(x: 0, y: mainView.frame.size.height-50, width: mainView.frame.size.height, height: 50)
            let textView         = UILabel.init(frame: textFrame)
            textView.text        = "Please don't have glass on your face during the photo shoot."
            textView.textColor = UIColor.red
            textView.backgroundColor = UIColor.white
            textView.font = UIFont.systemFont(ofSize: 15)
            textView.numberOfLines = 0
            mainView.addSubview(blockView)
            mainView.addSubview(textView)
            imagePicker.cameraOverlayView = mainView
            print("allow camera \(dimX) +\(mainView.frame.size.width) + \(mainView.frame.size.height)")
            self.present(imagePicker, animated: true)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            imagePicker.delegate = imagePickerControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            
            let mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-200))
            let dimX = mainView.frame.size.width - mainView.frame.size.height
            let frame             = CGRect.init(x: dimX/2, y: 0, width: mainView.frame.size.height, height: mainView.frame.size.height)
            let blockView         = UIImageView.init(frame: frame)
            //blockView.contentMode = .scaleAspectFit
            blockView.image       = UIImage(named: "camera-grid")
            //mainView.backgroundColor = UIColor.blue
            //blockView.backgroundColor = UIColor.red
            let textFrame        = CGRect.init(x: 0, y: mainView.frame.size.height-50, width: mainView.frame.size.height, height: 50)
            let textView         = UILabel.init(frame: textFrame)
            textView.text        = "Please don't have glass on your face during the photo shoot."
            textView.textColor = UIColor.red
            textView.backgroundColor = UIColor.white
            textView.font = UIFont.systemFont(ofSize: 15)
            textView.numberOfLines = 0
            mainView.addSubview(blockView)
            mainView.addSubview(textView)
            imagePicker.cameraOverlayView = mainView
            print("not allow camera")
            
            self.present(imagePicker, animated: true)
        }
        
    }
    
    
}
