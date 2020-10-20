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
   var logoutTimer: Timer?
    override func viewWillAppear(_ animated: Bool) {
        self.segFAQ.makeMultiline(numberOfLines: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        segFAQ.isUserInteractionEnabled = true
        self.segFAQ.makeMultiline(numberOfLines: 0)
//        let font = UIFont(name: "PyidaungsuBook", size: 14)
//
//        segFAQ.setTitleTextAttributes([NSAttributedString.Key.font: font],
//                                                for: .normal)
        segFAQ.setTitle("faq.tag1.title".localized, forSegmentAt: 0)
        segFAQ.setTitle("faq.tag2.title".localized, forSegmentAt: 1)
        segFAQ.setTitle("aboutus.title".localized, forSegmentAt: 2)
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
       
        
    
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
        if lblBarCusType.text == "Lv.2 : Login user" {
                        
                    logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
                      }
    }
   @objc func runTimedCode() {
                  multiLoginGet()
              // print("kms\(logoutTimer)")
              }
      func multiLoginGet(){
                 let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
              var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
             MultiLoginModel.init().makeMultiLogin(customerId: customerId
                     , loginDeviceId: deviceID, success: { (results) in
                   //  print("kaungmyat san multi >>>  \(results)")
                     
                     if results.data.logoutFlag == true {
                         print("success stage logout")
                         // create the alert
                                let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)

                                // add an action (button)
                         alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                             self.logoutTimer?.invalidate()
                             let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                             navigationVC.modalPresentationStyle = .overFullScreen
                             self.present(navigationVC, animated: true, completion:nil)
                             
                         }))

                                // show the alert
                                self.present(alert, animated: true, completion: nil)
                         
                         
                     }
                 }) { (error) in
                     print(error)
                 }
             }
    @objc func onTapBack() {
       print("click")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onTapMMLocale() {
       print("click")
        self.segFAQ.isUserInteractionEnabled = true
        self.segFAQ.makeMultiline(numberOfLines: 0)
        super.NewupdateLocale(flag: 1)
        updateViews()
    }
    @objc func onTapEngLocale() {
       print("click")
        self.segFAQ.isUserInteractionEnabled = true
        self.segFAQ.makeMultiline(numberOfLines: 2)
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
//        let font = UIFont(name: "PyidaungsuBook", size: 14)
//
//        segFAQ.setTitleTextAttributes([NSAttributedString.Key.font: font!],
//                                                for: .normal)
        self.segFAQ.isUserInteractionEnabled = true
       
        
        segFAQ.setTitle("faq.tag1.title".localized, forSegmentAt: 0)
        segFAQ.setTitle("faq.tag2.title".localized, forSegmentAt: 1)
        segFAQ.setTitle("aboutus.title".localized, forSegmentAt: 2)
        self.segFAQ.makeMultiline(numberOfLines: 0)
    }
}
extension UISegmentedControl
{
    func makeMultiline(numberOfLines: Int)
    {
        for segment in self.subviews
        {
            let labels = segment.subviews.filter { $0 is UILabel }
            // [AnyObject]
            
            labels.map { ($0 as! UILabel).numberOfLines = numberOfLines }
        }
    }
}
