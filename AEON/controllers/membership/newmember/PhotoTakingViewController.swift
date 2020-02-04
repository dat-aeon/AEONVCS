//
//  PhotoTakingViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVFoundation

class PhotoTakingViewController: BaseUIViewController {

    var profileImage:UIImage?
    var customerNo:String?
    var customerId:String?
    var isPhotoUpdate : Bool = false
    //var registerResponse:RegisterResponse?
    var sessionData : SessionDataBean?
    var tokenInfo: TokenData?
    var imagePicker: ImagePicker!
    
    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var lblConfirmTitle: UILabel!
    @IBOutlet weak var btnTakePhoto: UIButton!
    @IBOutlet weak var btnRetry: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.lblConfirmTitle.text = "photoconfirm.confirm.title".localized
        self.btnRetry.setTitle("photoconfirm.retry.button".localized, for: UIControl.State.normal)
        self.btnTakePhoto.setTitle("photoconfirm.confirm.button".localized, for: UIControl.State.normal)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.title = "sidemenu.membership".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.ivProfileImage.image = profileImage ?? UIImage(named: "Image")
    }
    
    @IBAction func onClickRetryButton(_ sender: UIButton) {
        //self.openPlainCamera(imagePickerControllerDelegate: self, isRegister: true)
        //self.openCustomCamera(imagePickerControllerDelegate: self)
//        self.imagePicker.present(from: sender)
//        self.checkCameraAccess()
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissPhotoTakingView"), object: self)
        
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
    
    @IBAction func onClickConfirmButton(_ sender:UIButton){

        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        let customerId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        let phoneNo = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        //self.ivProfileImage.image = profileImage!
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        if self.isPhotoUpdate {
            // Update profile photo
            PhotoUpdateViewModel.init().updateProfileImage(customerId: "\(customerId)", profileImage: self.ivProfileImage.image ?? UIImage(named: "Image")!, token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
                
                let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
                var sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
                
                sessionInfo?.photoPath = result.data.photoPath
                
                let jsonData = try? JSONEncoder().encode(sessionInfo)
                let jsonString = String(data: jsonData!, encoding: .utf8)!
                UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
                
                let alert = UIAlertController(title: Constants.UPDATE_SUCCESS_TITLE, message: Messages.PROFILE_PHOTO_UPDATE_INFO.localized, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: { action in
//                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//                    let vc = navigationVC.children.first as! HomePageViewController
//                    navigationVC.modalPresentationStyle = .overFullScreen
//                    vc.sessionDataBean = sessionInfo
//
//                    self.present(navigationVC, animated: true, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
                
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
                if error == Constants.SERVER_FAILURE {
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: Constants.UPDATE_FAILED_TITLE, message: error, preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: nil)
                    let backAction = UIAlertAction(title: Constants.BACK, style: .default, handler: { action in
                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
                        navigationVC.modalPresentationStyle = .overFullScreen
                        self.present(navigationVC, animated: true, completion: nil)
                    })
                    alert.addAction(okAction)
                    alert.addAction(backAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
            
        } else {
            self.customerNo = self.customerNo!
            
            RegisterViewModel.init().updateVerifiedNewMember(customerId: "\(customerId)", customerNo: self.customerNo!, profileImage: self.ivProfileImage.image ?? UIImage(named: "Image")!, phoneNo: phoneNo!, token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
                
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                UserDefaults.standard.set(Constants.MEMBER, forKey: Constants.CUSTOMER_TYPE)
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
                
                UserDefaults.standard.set(sessionData.phoneNo, forKey: Constants.USER_INFO_PHONE_NO)
                UserDefaults.standard.set(sessionData.customerId, forKey: Constants.USER_INFO_CUSTOMER_ID)
                
                let jsonData = try? JSONEncoder().encode(sessionData)
                let jsonString = String(data: jsonData!, encoding: .utf8)!
                UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
                
                let alert = UIAlertController(title: Constants.UPGRADE_MEMBER_SUCCESS_TITLE, message: Messages.UPGRADE_SUCCESS.localized + sessionData.phoneNo! + Messages.UPGRADE_SUCCESS_2.localized, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
                    let vc = navigationVC.children.first as! HomePageViewController
                    vc.sessionDataBean = sessionData
                    
                    //                print("Verify Register Response ::::::::::\(result.data.customerAgreementDtoList?.count ?? 0)")
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
                
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
                if error == Constants.SERVER_FAILURE {
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: Constants.VERIFY_FAILED_TITIE, message: error, preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: nil)
                    let backAction = UIAlertAction(title: Constants.BACK, style: .default, handler: { action in
                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
                        navigationVC.modalPresentationStyle = .overFullScreen
                        self.present(navigationVC, animated: true, completion: nil)
                    })
                    alert.addAction(okAction)
                    alert.addAction(backAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    //Utils.showAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: error)
                }
            }
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
        self.lblConfirmTitle.text = "photoconfirm.confirm.title".localized
        self.btnRetry.setTitle("photoconfirm.retry.button".localized, for: UIControl.State.normal)
        self.btnTakePhoto.setTitle("photoconfirm.confirm.button".localized, for: UIControl.State.normal)
        
        self.title = "sidemenu.membership".localized
    }
    
}

// delegate with ImagePicker.swift
extension PhotoTakingViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        //self.imageView.image = image
        if image != nil {
            
//            print("image is not null")
            //ivProfileImage.image = image
            // resize image
            
            let jpegData = image!.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
//            print("original size of image in KB: %f ", Double(jpegSize) / 1024.0)
//            print("original image width & height", image!.size.width, image!.size.height)
            
            if jpegSize <= Constants.LOW_QUALITY_IMAGE_250 {
                ivProfileImage.image = image!.resizeWithPercent(percentage: 1.0)!
                
            } else if jpegSize > Constants.LOW_QUALITY_IMAGE_250 && jpegSize <= Constants.MEDIUM_QUALITY_IMAGE_500 {
                ivProfileImage.image = image!.resizeWithPercent(percentage: 0.8)!
                
            } else if jpegSize > Constants.MEDIUM_QUALITY_IMAGE_500 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_1500 {
                ivProfileImage.image = image!.resizeWithPercent(percentage: 0.7)!
                
            } else {
//                ivProfileImage.image = image!.resizeWithPercent(percentage: 0.5)!
                 ivProfileImage.image = image!.resizeWithPercent(percentage: 0.2)!
                
            }
//            let rejpegData = ivProfileImage.image!.jpegData(compressionQuality: 1.0)
//            let rejpegSize: Int = rejpegData?.count ?? 0
//            print("resize size of image in KB: %f ", Double(rejpegSize) / 1024.0)
//            print("resize image width & height", ivProfileImage.image!.size.width, ivProfileImage.image!.size.height)
            
            // trasmit the data to next ViewController
            
            
        } else {
//            print("image is null")
        }
    }
}

// This is old code (for reference)
extension PhotoTakingViewController{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
//            print("image is not null")
            ivProfileImage.image = pickedImage
        } else {
//            print("image is null")
        }
        
    }
}
