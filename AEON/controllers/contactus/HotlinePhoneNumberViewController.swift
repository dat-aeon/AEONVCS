//
//  HotlinePhoneNumberViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class HotlinePhoneNumberViewController: BaseUIViewController {

    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var btnCallNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("Hotline Phone VC:::::::")
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        self.btnCallNow.setTitle("contactus.callnow.button".localized, for: UIControl.State.normal)
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        HotlineViewModel.init().getHotlineData(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.lblPhoneNo.text = result.data.hotlinePhone
            UserDefaults.standard.set(result.data.hotlinePhone, forKey: Constants.HOTLINE_NO)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if error == Constants.SERVER_FAILURE {
                
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                 navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
                     navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewDidLoad()
    }
    
    @IBAction func onClickCallNow(_ sender: UIButton) {
        self.lblPhoneNo.text?.makeCall()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.btnCallNow.setTitle("contactus.callnow.button".localized, for: UIControl.State.normal)
    }
}
