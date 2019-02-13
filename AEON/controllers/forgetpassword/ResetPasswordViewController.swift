//
//  ResetPasswordViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ResetPasswordViewController: BaseUIViewController {

    @IBOutlet weak var btnResetPass: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    @IBAction func onClickResetPassword(_ sender:UIButton){
        
        
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }

}
