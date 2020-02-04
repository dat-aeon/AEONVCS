//
//  FaqAndTermsConditionViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class FaqAndTermsConditionViewController: BaseUIViewController {

    @IBOutlet weak var cvFaq: UIView!
    @IBOutlet weak var cvTermAndCondition: UIView!
    @IBOutlet weak var segFAQ: UISegmentedControl!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font = UIFont(name: "PyidaungsuBook", size: 14)
        segFAQ.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        segFAQ.setTitle("faq.tag1.title".localized, forSegmentAt: 0)
        segFAQ.setTitle("faq.tag2.title".localized, forSegmentAt: 1)
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
    
    @objc override func updateViews() {
        super.updateViews()
        segFAQ.setTitle("faq.tag1.title".localized, forSegmentAt: 0)
        segFAQ.setTitle("faq.tag2.title".localized, forSegmentAt: 1)
    }
}
