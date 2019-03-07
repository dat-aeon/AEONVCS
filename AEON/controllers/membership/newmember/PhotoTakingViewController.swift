//
//  PhotoTakingViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class PhotoTakingViewController: BaseUIViewController {

    var profileImage:UIImage?
    var customerNo:String?
    var customerId:String?
    var registerResponse:RegisterResponse?
    
    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var btnTakePhoto: UIButton!
    @IBOutlet weak var btnRetry: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivProfileImage.image = profileImage ?? UIImage(named: "Image")
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.btnRetry.setTitle("photoconfirm.retry.button".localized, for: UIControl.State.normal)
        self.btnTakePhoto.setTitle("photoconfirm.confirm.button".localized, for: UIControl.State.normal)
    }
    
    @IBAction func onClickRetryButton(_ sender: UIButton) {
        self.openCamera(imagePickerControllerDelegate: self)
    }
    
    @IBAction func onClickConfirmButton(_ sender:UIButton){
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuestConfirmViewController") as! UINavigationController
//        self.present(navigationVC, animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
        let customerId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().updateVerifiedNewMember(customerId: "\(customerId)", customerNo: self.customerNo!, profileImage: profileImage ?? UIImage(named: "Image")!, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            UserDefaults.standard.set(Constants.MEMBER, forKey: Constants.CUSTOMER_TYPE)
            self.registerResponse = result
            if let registerResponseData = self.registerResponse{
                let jsonData = try? JSONEncoder().encode(registerResponseData)
                let jsonString = String(data: jsonData!, encoding: .utf8)!
                UserDefaults.standard.set(jsonString, forKey: Constants.REGISTER_RESPONSE)
            }
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
            let vc = navigationVC.children.first as! HomeViewController
            vc.registerResponse = result
            
            print("Verify Register Response ::::::::::\(result.custAgreementListDtoList?.count ?? 9)")
            self.present(navigationVC, animated: true, completion: nil)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Failed", message: error)
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
        self.btnRetry.setTitle("photoconfirm.retry.button".localized, for: UIControl.State.normal)
        self.btnTakePhoto.setTitle("photoconfirm.confirm.button".localized, for: UIControl.State.normal)
    }
    
}

extension PhotoTakingViewController{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            print("image is not null")
            ivProfileImage.image = pickedImage
        } else {
            print("image is null")
        }
        
    }
}
