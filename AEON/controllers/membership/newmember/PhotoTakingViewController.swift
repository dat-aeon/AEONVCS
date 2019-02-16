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
    
    @IBOutlet weak var ivProfileImage: UIImageView!
    
    @IBOutlet weak var btnTakePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivProfileImage.image = profileImage ?? UIImage(named: "Image")
    }
    
    @IBAction func onClickRetryButton(_ sender: UIButton) {
        self.openCamera(imagePickerControllerDelegate: self)
    }
    
    @IBAction func onClickConfirmButton(_ sender:UIButton){
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuestConfirmViewController") as! UINavigationController
//        self.present(navigationVC, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        
//        RegisterViewModel.init().makeRegisterNewMember(registerRequestData: <#T##RegisterRequestBean#>, memberResponseData: <#T##CheckMemberResponse#>, qaList: <#T##[SecQABean]#>, success: <#T##(RegisterResponse) -> Void#>, failure: <#T##(String) -> Void#>)
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
