//
//  MainLoanApplyViewController.swift
//  AEONVCS
//
//  Created by Ant on 06/08/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class MainLoanApplyViewController: UIViewController {

    @IBOutlet weak var backView: UIImageView!
    
    @IBOutlet weak var customerInfoPress: UILabel!
    
    @IBOutlet weak var applyLoanPress: UILabel!
    
           
           
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customerInfoPress.isUserInteractionEnabled = true
        self.applyLoanPress.isUserInteractionEnabled = true
        self.backView.isUserInteractionEnabled = true
       self.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtn)))
        self.customerInfoPress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customerInfo)))
        self.applyLoanPress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applyLoanInfo)))
        
    }
    @objc func backBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func customerInfo() {
        print("cuINFO")
      
             
              let storyboard = UIStoryboard(name: "DA", bundle: nil)
                     let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.CUSTOMER_INFOFORM)
                     applyLoanNav.modalPresentationStyle = .overFullScreen
                     self.present(applyLoanNav, animated: true, completion: nil)
           
    }
    @objc func applyLoanInfo() {
       
              let storyboard = UIStoryboard(name: "DA", bundle: nil)
                     let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.LOAN_CHOOSE)
                     applyLoanNav.modalPresentationStyle = .overFullScreen
                     self.present(applyLoanNav, animated: true, completion: nil)
           
    }

}
