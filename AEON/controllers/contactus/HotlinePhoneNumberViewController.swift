//
//  HotlinePhoneNumberViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class HotlinePhoneNumberViewController: BaseUIViewController {

    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var btnCallNow: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        HotlineViewModel.init().getHotlineData(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.lblPhoneNo.text = result.hotLinePhone
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Server is temporarily stopped now. Please contact to AEON.", message: error)
        }
        
    }
    @IBAction func onClickCallNow(_ sender: UIButton) {
        self.lblPhoneNo.text?.makeCall()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.btnCallNow.setTitle("contactus.callnow.button", for: UIControl.State.normal)
    }
}
