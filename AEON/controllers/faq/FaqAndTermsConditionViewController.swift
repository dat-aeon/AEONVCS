//
//  FaqAndTermsConditionViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class FaqAndTermsConditionViewController: BaseUIViewController {

    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarCusType: UILabel!
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    
    @IBOutlet weak var cvAboutUs: UIView!
    @IBOutlet weak var cvFaq: UIView!
    @IBOutlet weak var cvTermAndCondition: UIView!
    @IBOutlet weak var segFAQ: UISegmentedControl!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        let font = UIFont(name: "PyidaungsuBook", size: 14)
        segFAQ.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        segFAQ.setTitle("faq.tag1.title".localized, forSegmentAt: 0)
        segFAQ.setTitle("faq.tag2.title".localized, forSegmentAt: 1)
        segFAQ.setTitle("aboutus.title".localized, forSegmentAt: 2)
        
    
        toggleContainer(position:containerIndex)
        
        if (UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME) == nil) {
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
            self.lblBarName.text = ""
            self.lblBarCusType.text = "Lv.1 : Application user"
        }else{
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
                       self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
             self.lblBarCusType.text = "Lv.2 : Login user"
        }
    }
    
    @objc func onTapBack() {
       print("click")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onTapMMLocale() {
       print("click")
        super.NewupdateLocale(flag: 1)
        updateViews()
    }
    @objc func onTapEngLocale() {
       print("click")
        super.NewupdateLocale(flag: 2)
        updateViews()
    }
    
    @IBAction func onClickFaqConditionSegmented(_ sender: UISegmentedControl) {
         toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    func toggleContainer(position:Int){
        switch position {
        case 1:
            cvFaq.alpha = 1
            cvTermAndCondition.alpha = 0
            cvAboutUs.alpha = 0
            
            break
        case 2:
            cvFaq.alpha = 0
            cvTermAndCondition.alpha = 1
            cvAboutUs.alpha = 0
            break
        case 3:
            cvAboutUs.alpha = 1
            cvFaq.alpha = 0
            cvTermAndCondition.alpha = 0
            
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
        segFAQ.setTitle("aboutus.title".localized, forSegmentAt: 2)
    }
}
