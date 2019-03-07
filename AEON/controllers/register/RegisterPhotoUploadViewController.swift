//
//  RegisterPhotoUploadViewController.swift
//  AEONVCS
//
//  Created by mac on 2/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.lblAnnounce.text = "photoupload.announce.label".localized
        self.lblNotice1.text = "photoupload.notice1.label".localized
        self.lblNotice2.text = "photoupload.notice2.label".localized
        self.lblNotice3.text = "photoupload.notice3.label".localized
        self.lblNotice4.text = "photoupload.notice4.label".localized
        self.lblNotice5.text = "photoupload.notice5.label".localized
        btnUpload.setTitle("photoupload.upload.button".localized, for: UIControl.State.normal)
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
        self.lblAnnounce.text = "photoupload.announce.label".localized
        self.lblNotice1.text = "photoupload.notice1.label".localized
        self.lblNotice2.text = "photoupload.notice2.label".localized
        self.lblNotice3.text = "photoupload.notice3.label".localized
        self.lblNotice4.text = "photoupload.notice4.label".localized
        self.lblNotice5.text = "photoupload.notice5.label".localized
        btnUpload.setTitle("photoupload.upload.button".localized, for: UIControl.State.normal)
    }
    
    @IBAction func onClickUploadBtn(_ sender: UIButton) {
        self.openCamera(imagePickerControllerDelegate: self)
    }
}


extension RegisterPhotoUploadViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            //            self.ivPreview.image = pickedImage
            //nextvc.data = previousData
            //nextvc.image = pickedImage
            //present(nextvc)
            print("image is not null")
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberInfoPreviewViewController") as! UINavigationController
            let vc = navigationVC.children.first as! MemberInfoPreviewViewController
            vc.registerRequestData = self.registerRequestData
            vc.profileImage = pickedImage 
            vc.memberResponseData = self.memberResponseData!
            vc.qaList = self.qaList
            self.present(navigationVC, animated: true, completion: nil)
            
            //            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberInfoPreviewViewController") as! UINavigationController
            //            let vc = navigationVC.children.first as! MemberInfoPreviewViewController
            //            vc.registerRequestData = self.registerRequestData
            //            vc.profileImage = UIImage(named: "Image")!
            //            vc.memberResponseData = self.memberResponseData!
            //            vc.qaList = secQuestionAndAnswer
            //            self.present(navigationVC, animated: true, completion: nil)
        } else {
            print("image is null")
        }
    }
}
