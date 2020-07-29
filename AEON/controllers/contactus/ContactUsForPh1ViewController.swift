//
//  ContactUsForPh1ViewController.swift
//  AEONVCS
//
//  Created by mac on 4/8/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ContactUsForPh1ViewController: BaseUIViewController {

    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var btnCallNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        self.btnCallNow.setTitle("contactus.callnow.button".localized, for: UIControl.State.normal)
        self.lblPhoneNo.text = UserDefaults.standard.string(forKey: Constants.HOTLINE_NO)
    }
    
    @IBAction func onClickCallBtn(_ sender: UIButton) {
        self.lblPhoneNo.text?.makeCall()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.btnCallNow.setTitle("contactus.callnow.button".localized, for: UIControl.State.normal)
    }
}
