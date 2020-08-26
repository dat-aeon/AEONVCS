//
//  LoanViewController.swift
//  AEONVCS
//
//  Created by Ant on 03/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class LoanViewController: UIViewController {

    @IBOutlet weak var loanApplyLabel: UILabel!
    @IBOutlet weak var loanApplicationStatusLabel: UILabel!
    @IBOutlet weak var loanApplyView: UIStackView!
    @IBOutlet weak var loanApplicationStatusView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loanApplyUi()
      self.loanApplyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTaploanApplyView)))
    }
    func loanApplyUi() {
        loanApplyLabel.layer.backgroundColor  = UIColor.orange.cgColor
        loanApplyLabel.layer.cornerRadius = 5
        loanApplyLabel.layer.masksToBounds = true
        loanApplyLabel.layer.borderWidth = 2
    }

    @objc func onTaploanApplyView() {
       
        
    }

}
