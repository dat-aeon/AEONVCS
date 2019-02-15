//
//  VerifyMemberViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class VerifyMemberViewController: UIViewController {

    @IBOutlet weak var btnVerify: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    
    @IBAction func onClickVerify(_ sender:UIButton){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoTakingViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
