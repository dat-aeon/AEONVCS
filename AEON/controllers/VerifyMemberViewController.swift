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

    self.btnVerify.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickVerify)))
    }
    
    @objc func onClickVerify(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuestConfirmViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }

}
