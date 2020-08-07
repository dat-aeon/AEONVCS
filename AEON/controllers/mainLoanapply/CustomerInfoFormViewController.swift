//
//  CustomerInfoFormViewController.swift
//  AEONVCS
//
//  Created by Ant on 06/08/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class CustomerInfoFormViewController: UIViewController {

    @IBOutlet weak var myscrollView: UIScrollView!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var applicationDataLabel: UILabel!
    @IBOutlet weak var occupationDataLabel: UILabel!
    @IBOutlet weak var emergencyContactLabel: UILabel!
    @IBOutlet weak var guarantorLabel: UILabel!
    @IBOutlet weak var loanConfirmationLabel: UILabel!
    @IBOutlet weak var saveLabel: UIButton!
    @IBOutlet weak var applicationChangeLabel: UIButton!
    @IBOutlet weak var occupationChangeLabel: UIButton!
    @IBOutlet weak var emergencyContactChangeLabel: UIButton!
    @IBOutlet weak var guarantorChangeLabel: UIButton!
    @IBOutlet weak var loanConfirmationChangeLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       self.backView.isUserInteractionEnabled = true
             self.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtn)))
    }
    @objc func backBtn() {
           self.dismiss(animated: true, completion: nil)
       }
    @IBAction func applicationDataChangeBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
                           let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DATA_VC)
                           applyLoanNav.modalPresentationStyle = .overFullScreen
                           self.present(applyLoanNav, animated: true, completion: nil)
    }
    @IBAction func occupationDataChangeBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.OCCUPATION_DATA_VC)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
       
    }
    @IBAction func emergencyContactBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
                                  let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.EMERGENCY_CONTACT_VC)
                                  applyLoanNav.modalPresentationStyle = .overFullScreen
                                  self.present(applyLoanNav, animated: true, completion: nil)
      
    }
    @IBAction func GuarantorBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.GUARANTOR_VC)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
    }
    @IBAction func loanConfirmationBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.LOAN_CONFIRMATION_VC)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
    }
    
}
