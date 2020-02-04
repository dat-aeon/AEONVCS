//
//  MemberInfoPreviewViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class MemberInfoPreviewViewController: BaseUIViewController {

    var registerRequestData:RegisterRequestBean?
    var profileImage:UIImage?
    var memberResponseData:CheckMemberResponse?
    var qaList:[SecQABean] = []
    var registerResponse:RegisterResponse?
    
    @IBOutlet weak var btnRetry: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var lbCaption: UILabel!
    
    var imagePicker : ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivProfile.image = profileImage
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.lbCaption.text = "photoconfirm.confirm.title".localized
        self.btnRetry.setTitle("photoconfirm.retry.button".localized, for: UIControl.State.normal)
        self.btnConfirm.setTitle("photoconfirm.confirm.button".localized, for: UIControl.State.normal)
        
        // initialize for camera image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }

    @IBAction func onClickConfirmButton(_ sender: UIButton) {
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        OTPViewModel.init().sendOTPRequest(siteActivationKey: Constants.SITE_ACTIVATION_KEY, phoneNo: (self.memberResponseData?.data?.memberPhoneNo)!, success: { (result) in

            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.OTP_REGISTER_VIEW_CONTROLLER) as! UINavigationController
            let vc = navigationVC.children.first as! OTPRegisterViewController
            vc.registerRequestData = self.registerRequestData
            vc.memberResponseData = self.memberResponseData!
            vc.qaList = self.qaList
            vc.otpCode = result.data.otpCode
            vc.profileImage = self.ivProfile.image
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: error)
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
        self.lbCaption.text = "photoconfirm.confirm.title".localized
        self.btnRetry.setTitle("photoconfirm.retry.button".localized, for: UIControl.State.normal)
        self.btnConfirm.setTitle("photoconfirm.confirm.button".localized, for: UIControl.State.normal)
    }
    
    @IBAction func onClickRetryButton(_ sender: UIButton) {
        //self.openPlainCamera(imagePickerControllerDelegate: self, isRegister: true)
        //self.openCustomCamera(imagePickerControllerDelegate: self)
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// delegate with ImagePicker.swift
extension MemberInfoPreviewViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        //self.imageView.image = image
        if image != nil {
            
//            print("image is not null")
            
            //self.ivProfile.image = image
            
            // resize image
            let jpegData = image!.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
//            print("original size of image in KB: %f ", Double(jpegSize) / 1024.0)
//            print("original image width & height", image!.size.width, image!.size.height)
            
            if jpegSize <= Constants.LOW_QUALITY_IMAGE_250 {
                self.ivProfile.image = image!.resizeWithPercent(percentage: 1.0)!
                
            } else if jpegSize > Constants.LOW_QUALITY_IMAGE_250 && jpegSize <= Constants.MEDIUM_QUALITY_IMAGE_500 {
                self.ivProfile.image = image!.resizeWithPercent(percentage: 0.8)!
                
            } else if jpegSize > Constants.MEDIUM_QUALITY_IMAGE_500 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_1500 {
                self.ivProfile.image = image!.resizeWithPercent(percentage: 0.7)!
                
            } else {
//                self.ivProfile.image = image!.resizeWithPercent(percentage: 0.5)!
                 self.ivProfile.image = image!.resizeWithPercent(percentage: 0.2)!
                
            }
//            let rejpegData = image!.jpegData(compressionQuality: 1.0)
//            let rejpegSize: Int = rejpegData?.count ?? 0
//            print("resize size of image in KB: %f ", Double(rejpegSize) / 1024.0)
//            print("resize image width & height", image!.size.width, image!.size.height)
            
            
        } else {
//            print("image is null")
        }
    }
}

// This is old code (for reference)
extension MemberInfoPreviewViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            self.ivProfile.image = pickedImage
        } else {
//            print("image is null")
        }
        
    }
    
}
