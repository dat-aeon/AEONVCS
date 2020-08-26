//
//  FirstTimePhoneViewController.swift
//  AEONVCS
//
//  Created by mac on 2/23/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class FirstTimePhoneViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tfPhoneNo: UITextField!
    @IBOutlet weak var labelErrMesg: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onTappedNext(_ sender: UIButton) {
        
        if isErrorExist() {
            return
        }
        
        UserDefaults.standard.set(true, forKey: Constants.IS_ALREADY_ACCEPT)
        UserDefaults.standard.set(true, forKey: Constants.IS_FIRST_INSTALL)
        UserDefaults.standard.set(self.tfPhoneNo.text, forKey: Constants.FIRST_TIME_PHONE)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func isErrorExist() -> Bool{
            
            var isError = false
            
            if self.tfPhoneNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
                self.tfPhoneNo?.text = Constants.BLANK
                self.labelErrMesg.text = Messages.PHONE_REG_EMPTY_ERROR.localized
    //            self.phoneMesgLocale = Messages.PHONE_REG_EMPTY_ERROR
                isError = true
                
            } else if !Utils.isPhoneValidate(phoneNo: (self.tfPhoneNo?.text)!){
                // validate phone no format
                self.labelErrMesg.text = Messages.PHONE_REG_LENGTH_ERROR.localized
    //            self.phoneMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
                isError = true
                
            } else {
    //            self.phoneMesgLocale = Constants.BLANK
                self.labelErrMesg.text = Constants.BLANK
            }
            
            return isError
        }
}
