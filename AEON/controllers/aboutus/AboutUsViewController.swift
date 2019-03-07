//
//  AboutUsViewController.swift
//  AEONVCS
//
//  Created by mac on 2/13/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseUIViewController {

  
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblFacebookLink: UILabel!
    @IBOutlet weak var lblWebsiteLink: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var aboutUsData : AboutUsResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Start AboutUsViewController :::::::::::::::")
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        AboutUsViewModel.init().getAboutUsData(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
            
            self.aboutUsData = result
            switch Locale.currentLocale {
            case .EN:
                self.bbLocaleFlag.image = UIImage(named: "mm_flag")
                self.lblDescription.text = result.aboutCompanyEn
                self.lblAddress.text = result.addressEn
                
            case .MY:
                self.bbLocaleFlag.image = UIImage(named: "en_flag")
                self.lblDescription.text = result.aboutCompanyMm
                self.lblAddress.text = result.addressMm
                
            }
            self.lblDescription.numberOfLines = 0
            self.lblPhoneNo.text = result.hotLinePhone
            self.lblPhoneNo.numberOfLines = 0
            self.lblFacebookLink.text = result.socialMediaAddress
            self.lblFacebookLink.numberOfLines = 0
            self.lblWebsiteLink.text = result.webAddress
            self.lblWebsiteLink.numberOfLines = 0
            self.lblAddress.numberOfLines = 0
            self.lblAddress.lineBreakMode = .byWordWrapping
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Server is temporarily stopped now. Please contact to AEON.", message: error)
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
            self.lblDescription.text = self.aboutUsData.aboutCompanyEn
            self.lblAddress.text = self.aboutUsData.addressEn
            
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
            self.lblDescription.text = self.aboutUsData.aboutCompanyMm
            self.lblAddress.text = self.aboutUsData.addressMm
            
        }
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickCallBtn(_ sender: UIButton) {
        
        self.lblPhoneNo.text?.makeCall()
    }
}
