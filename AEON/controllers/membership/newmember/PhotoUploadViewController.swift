//
//  PhotoUploadViewController.swift
//  AEONVCS
//
//  Created by mac on 2/19/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON

class PhotoUploadViewController: BaseUIViewController {
    
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    @IBOutlet weak var lblBarLevel: UILabel!
    
    @IBOutlet weak var lblAnnounce: UILabel!
    @IBOutlet weak var lblNotice1: UILabel!
    @IBOutlet weak var lblNotice2: UILabel!
    @IBOutlet weak var lblNotice3: UILabel!
    @IBOutlet weak var lblNotice4: UILabel!
    @IBOutlet weak var lblNotice5: UILabel!
    @IBOutlet weak var btnUploadPhoto: UIButton!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var bbBack: UIBarButtonItem!
    
    var verifyData  = VerifyUserInfoBean()
    
    // for photo upload
    var customerId : Int = 0
    var isPhotoUpdate : Bool = false
    var isAlreadyCapture : Bool = false
    
    var imagePicker: ImagePicker!
    
//    var navToPhotoTakingView: UINavigationController!
//    var photoTakingView: PhotoTakingViewController!
    var navToPhotoTakingView: UIViewController!
    var photoTakingView: PhotoTakingViewController!
    
    var tokenInfo : TokenData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
        
        if self.isPhotoUpdate {
            lblBarLevel.text = "Lv3 : Member User"
        } else {
            lblBarLevel.text = "Lv2 : Login User"
        }
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))


        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        if !self.isPhotoUpdate {
            self.title = "membership.title".localized
        }
        self.lblAnnounce.text = "photoupload.announce.label".localized
        self.lblNotice1.text = "photoupload.notice1.label".localized
        self.lblNotice2.text = "photoupload.notice2.label".localized
        //self.lblNotice3.text = "photoupload.notice3.label".localized
        //self.lblNotice4.text = "photoupload.notice4.label".localized
        self.lblNotice3.isHidden = true
        self.lblNotice4.isHidden = true
        self.lblNotice5.isHidden = true
        //self.lblNotice5.text = "photoupload.notice5.label".localized
        self.btnUploadPhoto.setTitle("photoupload.upload.button".localized, for: UIControl.State.normal)
        
        if isPhotoUpdate {
            self.btnUploadPhoto.setTitle("photoupload.edit.button".localized, for: UIControl.State.normal)
        }
        
        // initialize for camera image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
//        self.navToPhotoTakingView = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_TAKING_VIEW_CONTROLLER) as? UINavigationController
//        self.photoTakingView = (self.navToPhotoTakingView.children.first as! PhotoTakingViewController)
        
        self.photoTakingView = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_TAKING_VIEW_CONTROLLER) as? PhotoTakingViewController

        NotificationCenter.default.addObserver(self, selector: #selector(dismissPhotoTakingView), name: NSNotification.Name(rawValue: "dismissPhotoTakingView"), object: nil)
    }
    
    @objc func dismissPhotoTakingView() {
        print("Notified dismissPhotoTakingView")
         self.checkCameraAccess() 
        self.isAlreadyCapture = false
       
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

    
    override func viewWillAppear(_ animated: Bool) {
        if isAlreadyCapture {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
    }
    
    @IBAction func onClickBackBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        if !self.isPhotoUpdate {
            self.title = "membership.title".localized
        }
        self.lblAnnounce.text = "photoupload.announce.label".localized
        self.lblNotice1.text = "photoupload.notice1.label".localized
        self.lblNotice2.text = "photoupload.notice2.label".localized
        //self.lblNotice3.text = "photoupload.notice3.label".localized
        //self.lblNotice4.text = "photoupload.notice4.label".localized
        //self.lblNotice5.text = "photoupload.notice5.label".localized
        self.btnUploadPhoto.setTitle("photoupload.upload.button".localized, for: UIControl.State.normal)
        
        if isPhotoUpdate {
            self.btnUploadPhoto.setTitle("photoupload.edit.button".localized, for: UIControl.State.normal)
        }
    }
    
    @IBAction func onClickUploadBtn(_ sender: UIButton) {
//        self.openPlainCamera(imagePickerControllerDelegate: self, isRegister: true)
//        self.openCustomCamera(imagePickerControllerDelegate: self)
        
        if self.isPhotoUpdate {
            let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.COUPON_POPUP_VIEW_CONTROLLER) as! CouponPopupViewController
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            popupVC.preferredContentSize = CGSize(width: 400, height: 300)
            popupVC.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
            //popupVC.ivMainView.alpha = 0.5
            let pVC = popupVC.popoverPresentationController
            pVC?.permittedArrowDirections = .any
            
            //pVC?.sourceView = sender
            pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
            
            self.definesPresentationContext = true
            popupVC.delegate = self
            popupVC.lblTitle.text = "Enter Password"
            self.present(popupVC, animated: true, completion: nil)
        } else {
            self.checkPermission()
            
        }
        
//        self.doPasswordVerification()
    }
    
    func checkPermission() {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            //already authorized
            self.imagePicker.present(from: UIButton())
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    self.imagePicker.present(from: UIButton())
                } else {
                    //access denied
                    print("Can't go to Camera View!!!!!!!!")
                }
            })
        }
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
            presentCameraSettings()
        case .authorized:
            print("Authorized, proceed")
            self.imagePicker.present(from: UIButton())
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                    self.imagePicker.present(from: UIButton())
                } else {
                    print("Permission denied")
                }
            }
        }
    }
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "To Allow Camera Access, Go to Settings",
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
    
    func doPasswordVerification(strPassword: UITextField, popup: UIViewController) {
        
        let cusID = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        let verifyUserInfoRequest = CheckPasswordRequest(
            customerId: cusID, password: "\(strPassword.text!)"
            )
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        CheckPasswordViewModel.init().checkPasswordvm(verifyUserRequest: verifyUserInfoRequest, token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if result.status == Constants.STATUS_200{
                //success(result)
                popup.dismiss(animated: false, completion: nil)
                self.checkCameraAccess()
                
            } else {
//                Utils.showAlert(viewcontroller: self, title: Constants.CHECK_PASSWORD_FAILED_TITIE, message: "")
                strPassword.text = Constants.BLANK
                strPassword.attributedPlaceholder = NSAttributedString(string: "Password is wrong.",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
            
        }) { (error) in
            popup.dismiss(animated: false, completion: nil)
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            } else if error == Constants.EXPIRE_TOKEN {
                Utils.showExpireAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: Messages.EXPIRE_TOKEN_ERROR.localized)
                
            } else {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            }
            
        }
    }
}

// delegate with ImagePicker.swift
extension PhotoUploadViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        //self.imageView.image = image
        if image != nil {
            
            print("image is not null")
            // resize image
            var resizeImage = UIImage()
            let jpegData = image!.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
//            print("original size of image in KB: %f ", Double(jpegSize) / 1024.0)
//            print("original image width & height", image!.size.width, image!.size.height)
            
            if jpegSize <= Constants.LOW_QUALITY_IMAGE_250 {
                resizeImage = image!.resizeWithPercent(percentage: 1.0)!
                
            } else if jpegSize > Constants.LOW_QUALITY_IMAGE_250 && jpegSize <= Constants.MEDIUM_QUALITY_IMAGE_500 {
                resizeImage = image!.resizeWithPercent(percentage: 0.8)!
                
            } else if jpegSize > Constants.MEDIUM_QUALITY_IMAGE_500 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_1500 {
                resizeImage = image!.resizeWithPercent(percentage: 0.7)!
                
            } else {
//                resizeImage = image!.resizeWithPercent(percentage: 0.5)!
//                resizeImage = image!.resizeWithPercent(percentage: 0.3)!
                resizeImage = image!.resizeWithPercent(percentage: 0.2)!
                
            }
//            let rejpegData = resizeImage.jpegData(compressionQuality: 1.0)
//            let rejpegSize: Int = rejpegData?.count ?? 0
//            print("resize size of image in KB: %f ", Double(rejpegSize) / 1024.0)
            print("resize image width & height", resizeImage.size.width, resizeImage.size.height)
            
            let resizeData = resizeImage.jpegData(compressionQuality: 1.0)
            let resizeDataSize: Int = resizeData?.count ?? 0
            
            print("resize image size ", resizeDataSize)
            
            // trasmit the data to next ViewController
            if self.isPhotoUpdate {
//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_TAKING_VIEW_CONTROLLER) as! UINavigationController
//                let vc = navigationVC.children.first as! PhotoTakingViewController
                self.photoTakingView.profileImage = resizeImage
                self.photoTakingView.isPhotoUpdate = true
                self.isAlreadyCapture = true
//                self.present(navigationVC, animated: true, completion: { () -> Void in
//                    self.dismiss(animated: true, completion: nil)
//                })
                self.photoTakingView.modalPresentationStyle = .overFullScreen
                self.present(self.photoTakingView, animated: true, completion: nil)
                
            } else {
//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_TAKING_VIEW_CONTROLLER) as! UINavigationController
//                let vc = navigationVC.children.first as! PhotoTakingViewController
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_TAKING_VIEW_CONTROLLER) as! PhotoTakingViewController
                vc.profileImage = resizeImage
                vc.customerNo = self.verifyData.customerNo
                vc.isPhotoUpdate = false
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
                
            }
            
        } else {
//            print("image is null")
        }
    }
}

// This is old code (for reference)
extension PhotoUploadViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            //            self.ivPreview.image = pickedImage
            //nextvc.data = previousData
            //nextvc.image = pickedImage
            //present(nextvc)
//            print("image is not null")
            
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_TAKING_VIEW_CONTROLLER) as! UINavigationController
//            let vc = navigationVC.children.first as! PhotoTakingViewController
            let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_TAKING_VIEW_CONTROLLER) as! PhotoTakingViewController
            //            vc.registerRequestData = self.registerRequestData
            vc.profileImage = pickedImage
            vc.customerNo = self.verifyData.customerNo
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            
        } else {
//            print("image is null")
        }
        
    }
}

extension PhotoUploadViewController: PopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController) {
        if password.text!.count > 0 {
            self.doPasswordVerification(strPassword: password, popup: popUpView)
        
        } else {
            //password.placeholder = "Please enter password."
            password.attributedPlaceholder = NSAttributedString(string: "Please enter password.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
    }
    
}
