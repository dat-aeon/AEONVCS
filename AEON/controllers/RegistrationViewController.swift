//
//  RegistrationViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.btnRegister.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickRegister)))
    }
    
    @objc func onClickRegister(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuestRegisterViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    
}
