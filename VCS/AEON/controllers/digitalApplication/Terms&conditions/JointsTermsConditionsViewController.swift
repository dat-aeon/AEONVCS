//
//  JointsTermsConditionsViewController.swift
//  AEONVCS
//
//  Created by Ant on 12/01/2021.
//  Copyright © 2021 AEON microfinance. All rights reserved.
//

import UIKit

class JointsTermsConditionsViewController: UIViewController {

    @IBOutlet weak var backBtn: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backBtn.isUserInteractionEnabled = true
        self.backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        // Do any additional setup after loading the view.
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func nextBtnPress(_ sender: UIButton) {
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
