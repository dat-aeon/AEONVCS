//
//  HotlinePhoneNumberViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class HotlinePhoneNumberViewController: UIViewController {

    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var btnCallNow: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        HotlineViewModel.init().getHotlineData(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
            
            self.lblPhoneNo.text = result.hotLinePhone
            
        }) { (error) in
            Utils.showAlert(viewcontroller: self, title: "Server is temporarily stopped now. Please contact to AEON.", message: error)
        }
        
    }
    @IBAction func onClickCallNow(_ sender: UIButton) {
        self.lblPhoneNo.text?.makeCall()
    }
}
