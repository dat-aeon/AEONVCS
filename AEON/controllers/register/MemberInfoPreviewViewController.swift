//
//  MemberInfoPreviewViewController.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/14/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class MemberInfoPreviewViewController: UIViewController {

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
            RegisterViewModel.init().makeRegisterExistedMember(registerRequestData: registerRequestData!, profileImage: profileImage ?? UIImage(named: "Image")!, memberResponseData: memberResponseData!, qaList: qaList, success: { (registerResponse) in
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
                let vc = navigationVC.children.first as! HomeViewController
                vc.registerResponse = registerResponse
                self.present(navigationVC, animated: true, completion: nil)
            }) { (error) in
                Utils.showAlert(viewcontroller: self, title: "Register Failed", message: "You cannot register now.")
            }
        } else {
            //register new member
        }
    }
    
    @IBAction func onClickRetryButton(_ sender: UIButton) {
    }
}
