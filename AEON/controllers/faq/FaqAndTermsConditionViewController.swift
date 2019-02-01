//
//  FaqAndTermsConditionViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class FaqAndTermsConditionViewController: UIViewController {

    @IBOutlet weak var cvFaq: UIView!
    @IBOutlet weak var cvTermAndCondition: UIView!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleContainer(position:containerIndex)
    }
    
    @IBAction func onClickFaqConditionSegmented(_ sender: UISegmentedControl) {
         toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    func toggleContainer(position:Int){
        switch position {
        case 1:
            cvFaq.alpha = 1
            cvTermAndCondition.alpha = 0
            break
        case 2:
            cvFaq.alpha = 0
            cvTermAndCondition.alpha = 1
            break
        default:
            cvFaq.alpha = 1
            cvTermAndCondition.alpha = 0
            break
        }
    }
}
