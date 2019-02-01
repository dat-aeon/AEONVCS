//
//  SecQuestionResetPasswordViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuestionResetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onClickSecurityConfirmButton(_ sender: UIButton) {
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    

}
