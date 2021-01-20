//
//  PersonalLoanViewController.swift
//  AEONVCS
//
//  Created by Ant on 11/01/2021.
//  Copyright © 2021 AEON microfinance. All rights reserved.
//

import UIKit

class PersonalLoanViewController: UIViewController {

    @IBOutlet weak var backBtn: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.isUserInteractionEnabled = true
        self.backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        // Do any additional setup after loading the view.
    }
    @IBAction func nextBtnPress(_ sender: UIButton) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoanConfirmationViewcon") as! LoanConfirmationViewcon
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
