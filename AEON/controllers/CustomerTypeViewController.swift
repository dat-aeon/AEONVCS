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
        self.btnUsedCustomer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickUsedCustomer)))
        
        self.btnNewCustomer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickNewCustomer)))
    }
    
    @objc func onClickUsedCustomer(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyMemberViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }

    @objc func onClickNewCustomer(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplyAeonServiceViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }

}
