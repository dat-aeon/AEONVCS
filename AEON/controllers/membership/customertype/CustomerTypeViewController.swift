//
//  CustomerTypeViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class CustomerTypeViewController: BaseUIViewController {

    @IBOutlet weak var btnUsedCustomer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnUsedCustomer.setTitle("customertype.newcustomer.button".localized, for: UIControl.State.normal)
//        print("Start CustomerTypeViewController :::::::::::::::")
        
    }
    
    @IBAction  func onClickUsedCustomer(_ sender:UIButton){
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.VERIFY_MEMBER_VIEW_CONTROLLER) as! UINavigationController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }

    
    @objc override func updateViews() {
        super.updateViews()
        self.btnUsedCustomer.setTitle("customertype.newcustomer.button".localized, for: UIControl.State.normal)
        
    }
}
