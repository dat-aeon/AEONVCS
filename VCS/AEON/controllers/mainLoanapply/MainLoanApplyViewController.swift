//
//  MainLoanApplyViewController.swift
//  AEONVCS
//
//  Created by Ant on 06/08/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Starscream
import AAViewAnimator

class MainLoanApplyViewController: BaseUIViewController {

    @IBOutlet weak var backView: UIImageView!
    
    @IBOutlet weak var customerInfoPress: UILabel!
    
    @IBOutlet weak var applyLoanPress: UILabel!
    
    @IBOutlet weak var cuInformationView: UIView!
    
    @IBOutlet weak var applyLoanView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backLoanBtn: UIButton!
    @IBOutlet weak var backCustomerInfoBtn: UIButton!
    
    @IBOutlet weak var engFlag: UIImageView!
    @IBOutlet weak var mmFlag: UIImageView!
    @IBOutlet weak var lblBarName: UILabel!
    @IBOutlet weak var lblBarPhNo: UILabel!
    
    @IBOutlet weak var applyLoanContainerVIew: UIView!
    @IBOutlet weak var customerInfoContainerView: UIView!

    @objc func applyLoans() {
      
        let storyboard = UIStoryboard(name: "DA", bundle: nil)

        let customViewController = storyboard.instantiateViewController(withIdentifier: "MainLoanApplyViewController") as! MainLoanApplyViewController
        customViewController.modalPresentationStyle = .overFullScreen
        self.present(customViewController, animated: true, completion: nil)
    }
    @objc func customerInfos() {
       // MainLoanApplyViewController
        let storyboard = UIStoryboard(name: "DA", bundle: nil)

        let customViewController = storyboard.instantiateViewController(withIdentifier: "MainLoanApplyViewController") as! MainLoanApplyViewController
        customViewController.modalPresentationStyle = .overFullScreen
        self.present(customViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backLoanBtn.layer.cornerRadius = 10
        backLoanBtn.isUserInteractionEnabled = true
        backCustomerInfoBtn.isUserInteractionEnabled = true
        
        updateViews()
        applyLoanContainerVIew.isUserInteractionEnabled = true
        customerInfoContainerView.isUserInteractionEnabled = true
        self.backLoanBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applyLoans)))
        self.backCustomerInfoBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customerInfos)))
        self.applyLoanContainerVIew.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applyLoans)))
        self.customerInfoContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customerInfos)))
        applyLoanContainerVIew.isHidden = true
        customerInfoContainerView.isHidden = true
        self.mmFlag.isUserInteractionEnabled = true
           self.engFlag.isUserInteractionEnabled = true
               
               self.mmFlag.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
               self.engFlag.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
       self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
       self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
        
        self.cuInformationView.layer.borderWidth = 1
        self.cuInformationView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.applyLoanView.layer.borderWidth = 1
        self.applyLoanView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        
        self.customerInfoPress.isUserInteractionEnabled = true
        self.applyLoanPress.isUserInteractionEnabled = true
        self.backView.isUserInteractionEnabled = true
       self.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtn)))
        self.customerInfoPress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customerInfo)))
        self.applyLoanPress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applyLoanInfo)))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
       
        mainView.aa_animate(duration: 1.5, repeatCount: 1 ,springDamping: .slight, animation: .toRight) { inAnimating, animView in
        
        if inAnimating {
            print("Animating ....")
            self.animateWithTransition(.toTop)
        }
        else {
            print("Animation Done 👍🏻")
            self.animateWithTransition(.fromBottom)
        }
        
        guard inAnimating else {
            return
        }
        
          //  self.animateWithTransition(.)
    }
    }
    func animateWithTransition(_ animator: AAViewAnimators) {
           mainView.aa_animate(duration: 0.9, springDamping: .slight, animation: animator) { inAnimating, animView in
                  
                  if inAnimating {
                      print("Animating ....")
                  }
                  else {
                      print("Animation Done 👍🏻")
                  }
              }
          }
    @objc func backBtn() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let customViewController = storyboard.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
        customViewController.modalPresentationStyle = .overFullScreen
        self.present(customViewController, animated: true, completion: nil)
    }
    @objc func customerInfo() {
        print("cuINFO")
      
        customerInfoContainerView.isHidden = false
        applyLoanContainerVIew.isHidden = true
//              let storyboard = UIStoryboard(name: "DA", bundle: nil)
//                     let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.CUSTOMER_INFOFORM)
//                    // applyLoanNav.modalPresentationStyle = .overFullScreen
//                     self.present(applyLoanNav, animated: true, completion: nil)
       
    }
    @objc func applyLoanInfo() {
        applyLoanContainerVIew.isHidden = false
        customerInfoContainerView.isHidden = true
//              let storyboard = UIStoryboard(name: "DA", bundle: nil)
//                     let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.LOAN_CHOOSE)
//                     applyLoanNav.modalPresentationStyle = .overFullScreen
//                     self.present(applyLoanNav, animated: true, completion: nil)
        
           
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
       @objc override func updateViews() {
             super.updateViews()
        self.customerInfoPress.text = "main.customerInformation".localized
        self.applyLoanPress.text = "main.applyLoan".localized
             
         }

}
