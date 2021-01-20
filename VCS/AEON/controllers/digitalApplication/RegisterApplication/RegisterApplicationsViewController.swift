//
//  RegisterApplicationsViewController.swift
//  AEONVCS
//
//  Created by Ant on 12/01/2021.
//  Copyright © 2021 AEON microfinance. All rights reserved.
//

import UIKit

class RegisterApplicationsViewController: UIViewController {

    @IBOutlet weak var loginAlertView: UIView!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var submitBtnLabel: UIButton!
    @IBOutlet weak var registerAppLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtnLabel.layer.cornerRadius = 10
        registerAppLabel.layer.cornerRadius = 10
        backBtn.isUserInteractionEnabled = true
        loginAlertView.isHidden = true
        self.backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerBtnPress(_ sender: Any) {
        loginAlertView.isHidden = false
    }
    @IBAction func submitBtnPress(_ sender: UIButton) {
        loginAlertView.isHidden = true
       // ApplicationListVC
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplicationListVC") as! ApplicationListVC
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
        
    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
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
