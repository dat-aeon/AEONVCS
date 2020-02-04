//
//  AeonServicesVC.swift
//  AEONVCS
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class AeonServicesVC: BaseUIViewController {
    
    @IBOutlet weak var btnApplyLoan: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func updateViews() {
        super.updateViews()
        self.btnApplyLoan.setTitle("applylone_title".localized, for: .normal)
    }
    
    
    @IBAction func doApplyLoan(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLY_LOAN_NAV) as! UINavigationController
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
    }
    

}
