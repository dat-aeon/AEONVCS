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
        toggleContainer(position:containerIndex)
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
