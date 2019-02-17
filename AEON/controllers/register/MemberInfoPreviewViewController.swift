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
    
    @IBOutlet weak var ivProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivProfile.image = profileImage

    }

    @IBAction func onClickConfirmButton(_ sender: UIButton) {
        let memberValue:String = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE) ?? ""
        
        if memberValue == Constants.MEMBER {
           //register existed member
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            RegisterViewModel.init().makeRegisterExistedMember(registerRequestData: registerRequestData!, profileImage: profileImage ?? UIImage(named: "Image")!, memberResponseData: memberResponseData!, qaList: qaList, success: { (registerResponse) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
                let vc = navigationVC.children.first as! HomeViewController
                vc.registerResponse = registerResponse
                
                //set nil to response
                UserDefaults.standard.set(nil, forKey: Constants.LOGIN_RESPONSE)
                UserDefaults.standard.set(nil, forKey: Constants.REGISTER_RESPONSE)
                
                self.present(navigationVC, animated: true, completion: nil)
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: "Register Failed", message: "You cannot register now.")
            }
        } else {
            //register new member
        }
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
