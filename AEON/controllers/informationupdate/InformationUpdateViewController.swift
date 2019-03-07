//
//  InformationUpdateViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class InformationUpdateViewController: BaseUIViewController {

    @IBOutlet weak var cvSecurityQuestionUpdate: UIView!
    @IBOutlet weak var cvCustomerInfoUpdate: UIView!
    
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleContainer(position:containerIndex)
    }
    @IBAction func onClickInformationUpdateSegmented(_ sender: UISegmentedControl) {
         toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    
    func toggleContainer(position:Int){
        switch position {
        case 1:
            cvSecurityQuestionUpdate.alpha = 1
            cvCustomerInfoUpdate.alpha = 0
            break
        case 2:
            cvSecurityQuestionUpdate.alpha = 0
            cvCustomerInfoUpdate.alpha = 1
            break
        default:
            cvSecurityQuestionUpdate.alpha = 1
            cvCustomerInfoUpdate.alpha = 0
            break
        }
    }
    
    @objc override func updateViews() {
        super.updateViews()
//        self.lblMemberLabel.text = "membership.card2.photo.label".localized
//        
    }
}
