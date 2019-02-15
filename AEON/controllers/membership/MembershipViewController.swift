//
//  MembershipViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MembershipViewController: UIViewController {

    @IBOutlet weak var cvCustomerType: UIView!
    
    @IBOutlet weak var cvMemberCardInfo: UIView!
    
    var containerIndex = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        let memberValue:String = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE) ?? ""
        
        if memberValue == Constants.MEMBER {
            containerIndex = 1
        }else{
            containerIndex = 2
        }
        toggleContainer(position:containerIndex)
        let registerResponse = UserDefaults.standard.object(forKey: Constants.REGISTER_RESPONSE)
        print("Register Response \(String(describing: registerResponse))")
    }

    func toggleContainer(position:Int){
        switch position {
        case 1:
            cvCustomerType.alpha = 1
            cvMemberCardInfo.alpha = 0
            break
        case 2:
            cvCustomerType.alpha = 0
            cvMemberCardInfo.alpha = 1
            break
        default:
            cvCustomerType.alpha = 1
            cvCustomerType.alpha = 0
            break
        }
    }

}
