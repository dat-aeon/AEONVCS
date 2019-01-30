//
//  MainViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var vLoginButton: UIView!
    @IBOutlet weak var vAboutUsButton: UIView!
    @IBOutlet weak var vFAQButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickLogin)))
    }
    
    @objc func onClickLogin(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
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
