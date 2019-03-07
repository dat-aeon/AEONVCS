//
//  MembershipViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
class MembershipViewController: UIViewController {

    @IBOutlet weak var cvCustomerType: UIView!
    
    @IBOutlet weak var cvMemberCardInfo: UIView!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start MembershipViewController :::::::::::::::")
        
        let registerResponseString = UserDefaults.standard.string(forKey: Constants.REGISTER_RESPONSE)
        
        let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: JSON(parseJSON: registerResponseString ?? "").rawData())
        
        
        let memberValue:String = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE) ?? ""
        print("MembershipViewController ::::: memberValue \(memberValue)")
        
        if memberValue == Constants.MEMBER {
            containerIndex = 2
        }else{
            containerIndex = 1
        }
        toggleContainer(position:containerIndex)
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
