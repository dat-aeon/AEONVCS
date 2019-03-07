//
//  MemberInfoPreviewViewController.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/14/19.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivProfile.image = profileImage
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.btnRetry.setTitle("photoconfirm.retry.button".localized, for: UIControl.State.normal)
        self.btnConfirm.setTitle("photoconfirm.confirm.button".localized, for: UIControl.State.normal)
    }

    @IBAction func onClickConfirmButton(_ sender: UIButton) {
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        OTPViewModel.init().sendOTPRequest(siteActivationKey: Constants.SITE_ACTIVATION_KEY, phoneNo: (self.registerRequestData?.phoneNo)!, success: { (result) in

            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPRegisterViewController") as! UINavigationController
            let vc = navigationVC.children.first as! OTPRegisterViewController
            vc.registerRequestData = self.registerRequestData
            vc.memberResponseData = self.memberResponseData!
            vc.qaList = self.qaList
            vc.otpCode = result.otpCode
            vc.profileImage = self.ivProfile.image
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.present(navigationVC, animated: true, completion: nil)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "OTP send Failed", message: error)
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
        self.btnRetry.setTitle("photoconfirm.retry.button", for: UIControl.State.normal)
        self.btnConfirm.setTitle("photoconfirm.confirm.button", for: UIControl.State.normal)
    }
    
    @IBAction func onClickRetryButton(_ sender: UIButton) {
        self.openCamera(imagePickerControllerDelegate: self)
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MemberInfoPreviewViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            self.ivProfile.image = pickedImage
        } else {
            print("image is null")
        }
        
    }
    
}
