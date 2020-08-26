//
//  OutletInfoViewController.swift
//  AEONVCS
//
//  Created by mac on 7/27/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class OutletInfoViewController: BaseUIViewController {

    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    @IBOutlet weak var segOutletInfo: UISegmentedControl!
    @IBOutlet weak var cvOutletMap: UIView!
    @IBOutlet weak var cvOutletList: UIView!
    
    
    @IBOutlet weak var lblBarCusType: UILabel!
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    var containerIndex = 1
    var logoutTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        self.updateViews()
        let segAttributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "PyidaungsuBook", size: 14)!
        ]
        let segAttributes1: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "PyidaungsuBook", size: 14)!
        ]
        
        segOutletInfo.setTitleTextAttributes(segAttributes as? [NSAttributedString.Key : Any],
                                             for: .normal)
        segOutletInfo.setTitleTextAttributes(segAttributes as? [NSAttributedString.Key : Any],
                                             for: .selected)
        
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

    
    override func updateViews() {
        super.updateViews()
        segOutletInfo.setTitle("findnearby.map".localized, forSegmentAt: 0)
        segOutletInfo.setTitle("findnearby.outlet_list".localized, forSegmentAt: 1)

    }
   
    @IBAction func onClickSegControl(_ sender: UISegmentedControl) {
        
        toggleContainer(position: sender.selectedSegmentIndex + 1)
    }
    
    func toggleContainer(position:Int){
        switch position {
        case 1:
            cvOutletMap.alpha = 1
            cvOutletList.alpha = 0
            break
        case 2:
            cvOutletMap.alpha = 0
            cvOutletList.alpha = 1
            break
        default:
            cvOutletMap.alpha = 1
            cvOutletList.alpha = 0
            break
        }
    }
}
