//
//  RegisterPhotoUploadViewController.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import AVFoundation

class RegisterPhotoUploadViewController: BaseUIViewController {

    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var bbBackBtn: UIBarButtonItem!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var lblAnnounce: UILabel!
    @IBOutlet weak var lblNotice1: UILabel!
    @IBOutlet weak var lblNotice2: UILabel!
    @IBOutlet weak var lblNotice3: UILabel!
    @IBOutlet weak var lblNotice4: UILabel!
    @IBOutlet weak var lblNotice5: UILabel!
    
    var registerRequestData:RegisterRequestBean?
    var memberResponseData:CheckMemberResponse?
    var qaList:[SecQABean] = []
    
    var isPhotoEditing = false
    
    var imagePicker: ImagePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
//        self.title = "membership.title".localized
        self.lblAnnounce.text = "photoupload.announce.label".localized
        self.lblNotice1.text = "photoupload.notice1.label".localized
        self.lblNotice2.text = "photoupload.notice2.label".localized
        //self.lblNotice3.text = "photoupload.notice3.label".localized
        //self.lblNotice4.text = "photoupload.notice4.label".localized
        //self.lblNotice5.text = "photoupload.notice5.label".localized
        btnUpload.setTitle("photoupload.upload.button".localized, for: UIControl.State.normal)
        self.lblNotice3.isHidden = true
        self.lblNotice4.isHidden = true
        self.lblNotice5.isHidden = true
        
        // initialize for camera image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        if isPhotoEditing {
            btnUpload.setTitle("photoupload.edit.button".localized, for: UIControl.State.normal)
        }
        
    }
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
    }
    
    @IBAction func onClickBackBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
//        self.title = "membership.title".localized
        self.lblAnnounce.text = "photoupload.announce.label".localized
        self.lblNotice1.text = "photoupload.notice1.label".localized
        self.lblNotice2.text = "photoupload.notice2.label".localized
        //self.lblNotice3.text = "photoupload.notice3.label".localized
        //self.lblNotice4.text = "photoupload.notice4.label".localized
        //self.lblNotice5.text = "photoupload.notice5.label".localized
        btnUpload.setTitle("photoupload.upload.button".localized, for: UIControl.State.normal)
        
        if isPhotoEditing {
            btnUpload.setTitle("photoupload.edit.button".localized, for: UIControl.State.normal)
        }
    }
    
    @IBAction func onClickUploadBtn(_ sender: UIButton) {
        //self.openPlainCamera(imagePickerControllerDelegate: self, isRegister: true)
        //self.openCustomCamera(imagePickerControllerDelegate: self)
        self.checkCameraAccess()
//        self.imagePicker.present(from: sender)
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
}

// delegate with ImagePicker.swift
extension RegisterPhotoUploadViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        //self.imageView.image = image
        if image != nil {
            
//            print("image is not null")
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
                 resizeImage = image!.resizeWithPercent(percentage: 0.2)!
                
            }
//            let rejpegData = resizeImage.jpegData(compressionQuality: 1.0)
//            let rejpegSize: Int = rejpegData?.count ?? 0
//            print("resize size of image in KB: %f ", Double(rejpegSize) / 1024.0)
//            print("resize image width & height", resizeImage.size.width, resizeImage.size.height)
            
            // trasmit the data to next ViewController
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MEMBER_INFO_PREVIEW_VIEW_CONTROLLER) as! UINavigationController
            let vc = navigationVC.children.first as! MemberInfoPreviewViewController
            vc.registerRequestData = self.registerRequestData
            vc.profileImage = resizeImage
            vc.memberResponseData = self.memberResponseData!
            vc.qaList = self.qaList
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
            
        } else {
//            print("image is null")
        }
    }
}

// This is old code (for reference)
extension RegisterPhotoUploadViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
//            print("image is not null")
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MEMBER_INFO_PREVIEW_VIEW_CONTROLLER) as! UINavigationController
            let vc = navigationVC.children.first as! MemberInfoPreviewViewController
            vc.registerRequestData = self.registerRequestData
            vc.profileImage = pickedImage 
            vc.memberResponseData = self.memberResponseData!
            vc.qaList = self.qaList
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
            
        } else {
//            print("image is null")
        }
    }
}
