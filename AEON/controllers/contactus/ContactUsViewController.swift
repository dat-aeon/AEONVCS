//
//  ContactUsViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var cvHotLine: UIView!
    @IBOutlet weak var cvMessaging: UIView!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleContainer(position:containerIndex)
    }
    @IBAction func onClickContactusSegmented(_ sender: UISegmentedControl) {
        toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    
    func toggleContainer(position:Int){
        switch position {
        case 1:
            cvHotLine.alpha = 1
            cvMessaging.alpha = 0
            break
        case 2:
            cvHotLine.alpha = 0
            cvMessaging.alpha = 1
            break
        default:
            cvHotLine.alpha = 1
            cvMessaging.alpha = 0
            break
        }
    }
}
