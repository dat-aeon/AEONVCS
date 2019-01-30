//
//  LoginViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var vLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickLogin)))
    }
    
    @objc func onClickLogin(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
