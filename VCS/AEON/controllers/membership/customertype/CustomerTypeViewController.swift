//
//  CustomerTypeViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class CustomerTypeViewController: BaseUIViewController {

    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    @IBOutlet weak var btnUsedCustomer: UIButton!
    
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    var logoutTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        //logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        self.btnUsedCustomer.setTitle("customertype.newcustomer.button".localized, for: UIControl.State.normal)
//        print("Start CustomerTypeViewController :::::::::::::::")
        
        self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
    }
    
    @IBAction  func onClickUsedCustomer(_ sender:UIButton){
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.VERIFY_MEMBER_VIEW_CONTROLLER) as! UINavigationController
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.VERIFY_MEMBER_VIEW_CONTROLLER) as! VerifyMemberViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    @objc func runTimedCode() {
          multiLoginGet()
      // print("kms\(logoutTimer)")
      }
    func multiLoginGet(){
         var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
               let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
          
           MultiLoginModel.init().makeMultiLogin(customerId: customerId
                   , loginDeviceId: deviceID, success: { (results) in
                  // print("kaungmyat san multi >>>  \(results)")
                   
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
        self.btnUsedCustomer.setTitle("customertype.newcustomer.button".localized, for: UIControl.State.normal)
        
    }
}
