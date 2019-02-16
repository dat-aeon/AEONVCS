//
//  AboutUsViewController.swift
//  AEONVCS
//
//  Created by mac on 2/13/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

  
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblFacebookLink: UILabel!
    @IBOutlet weak var lblWebsiteLink: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AboutUsViewModel.init().getAboutUsData(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
            
            self.lblDescription.text = result.aboutCompany
            self.lblDescription.numberOfLines = 0
            self.lblPhoneNo.text = result.hotLinePhone
            self.lblPhoneNo.numberOfLines = 0
            self.lblFacebookLink.text = result.socialMediaAddress
            self.lblFacebookLink.numberOfLines = 0
            self.lblWebsiteLink.text = result.webAddress
            self.lblWebsiteLink.numberOfLines = 0
            self.lblAddress.text = result.address
            self.lblAddress.numberOfLines = 0
            self.lblAddress.lineBreakMode = .byWordWrapping

        }) { (error) in
            Utils.showAlert(viewcontroller: self, title: "Server is temporarily stopped now. Please contact to AEON.", message: error)
        }
    }

    @IBAction func onClickBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickCallBtn(_ sender: UIButton) {
        
        guard let number = URL(string: "tel://" + self.lblPhoneNo.text!) else { return }
        print("call phone No \(number)")
        UIApplication.shared.open(number)
    }
}
