//
//  CustomerTypeViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class CustomerTypeViewController: UIViewController {

    @IBOutlet weak var btnUsedCustomer: UIButton!
    @IBOutlet weak var btnNewCustomer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction  func onClickUsedCustomer(_ sender:UIButton){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyMemberViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }

    @IBAction func onClickNewCustomer(_ sender:UIButton){
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplyAeonServiceViewController") as! UINavigationController
//        self.present(navigationVC, animated: true, completion: nil)
        Utils.showAlert(viewcontroller: self, title: "Unavailable Service", message: "Coming Soon")
    }

}
