//
//  AboutUsViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 2/13/19.
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
        // dismiss if network is off
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        switch Locale.currentLocale {
        case .EN:
            self.bbLocaleFlag.image = UIImage(named: "mm_flag")
            
        case .MY:
            self.bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.title = "aboutus.title".localized
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        AboutUsViewModel.init().getAboutUsData(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
            
            self.aboutUsData = result
            switch Locale.currentLocale {
            case .EN:
                self.bbLocaleFlag.image = UIImage(named: "mm_flag")
                self.lblDescription.text = result.data.aboutCompanyEn
                self.lblAddress.text = result.data.addressEn
                
            case .MY:
                self.bbLocaleFlag.image = UIImage(named: "en_flag")
                self.lblDescription.text = result.data.aboutCompanyMm
                self.lblAddress.text = result.data.addressMm
                
            }
            self.lblDescription.numberOfLines = 0
            
            self.setLineSpacing(data: self.lblDescription.text!)
            
            self.lblPhoneNo.text = result.data.hotlinePhone
            self.lblPhoneNo.numberOfLines = 0
            self.lblFacebookLink.text = result.data.socialMediaAddress
            self.lblFacebookLink.numberOfLines = 0
            self.lblWebsiteLink.text = result.data.webAddress
            self.lblWebsiteLink.numberOfLines = 0
            self.lblAddress.numberOfLines = 0
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.SERVER_FAILURE {
                // service unavailable
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                // server internal error
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
        
        self.lblFacebookLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickSocialLink)))
        self.lblWebsiteLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickWebsiteLink)))
        
        
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
            self.lblDescription.text = self.aboutUsData.data.aboutCompanyEn
            self.lblAddress.text = self.aboutUsData.data.addressEn
            setLineSpacing(data: self.lblDescription.text!)
            
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
            self.lblDescription.text = self.aboutUsData.data.aboutCompanyMm
            self.lblAddress.text = self.aboutUsData.data.addressMm
            setLineSpacing(data: self.lblDescription.text!)
        }
        self.title = "aboutus.title".localized
        
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickCallBtn(_ sender: UIButton) {
        
        self.lblPhoneNo.text?.makeCall()
    }
    
    @objc func setLineSpacing(data:String) {
        let attributedString = NSMutableAttributedString(string: data)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        // *** Set Attributed String to your label ***
        self.lblDescription.attributedText = attributedString
        
    }
    
    @objc func onClickSocialLink(){
        super.openUrl(urlString: self.lblFacebookLink.text!)
    }

    @objc func onClickWebsiteLink(){
        super.openUrl(urlString: self.lblWebsiteLink.text!)
    }
    
}
