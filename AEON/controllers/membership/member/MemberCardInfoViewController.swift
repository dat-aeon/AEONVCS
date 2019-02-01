//
//  MemberCardInfoViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MemberCardInfoViewController: UIViewController {

    @IBOutlet weak var cvCardInfoOne: UIView!
    
    @IBOutlet weak var cvCardInfoTwo: UIView!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleContainer(position:containerIndex)
    }
    
    @IBAction func onClickCardInfoSegmented(_ sender: UISegmentedControl) {
        toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    func toggleContainer(position:Int){
        switch position {
        case 1:
            cvCardInfoOne.alpha = 1
            cvCardInfoTwo.alpha = 0
            break
        case 2:
            cvCardInfoOne.alpha = 0
            cvCardInfoTwo.alpha = 1
            break
        default:
            cvCardInfoOne.alpha = 1
            cvCardInfoTwo.alpha = 0
            break
        }
    }


}
