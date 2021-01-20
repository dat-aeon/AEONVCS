//
//  SmallLoanViewController.swift
//  AEONVCS
//
//  Created by Ant on 11/01/2021.
//  Copyright © 2021 AEON microfinance. All rights reserved.
//

import UIKit

class SmallLoanViewController: UIViewController {

    @IBOutlet weak var backBtn: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.isUserInteractionEnabled = true
        self.backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
    }
    
    @IBAction func nextScreenBtn(_ sender: UIButton) {
//        LoanConfirmationViewController()
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoanConfirmationViewcon") as! LoanConfirmationViewcon
       // LoanConfirmationViewcon
        //LoanConfirmationVC
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
       
    }
    
    @objc func onTapBack() {
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
