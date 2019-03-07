//
//  EventNewViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class EventNewViewController: BaseUIViewController {

    @IBOutlet weak var cvCupon: UIView!
    
    @IBOutlet weak var cvPromotion: UIView!
    @IBOutlet weak var cvNews: UIView!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleContainer(position:containerIndex)
    }
    
    @IBAction func onClickEventNewsCuponSegmented(_ sender: UISegmentedControl) {
         toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    func toggleContainer(position:Int){
        switch position {
        case 1:
            cvCupon.alpha = 1
            cvPromotion.alpha = 0
            cvNews.alpha = 0
            break
        case 2:
            cvCupon.alpha = 0
            cvPromotion.alpha = 1
            cvNews.alpha = 0
            break
        case 3:
            cvCupon.alpha = 0
            cvPromotion.alpha = 0
            cvNews.alpha = 1
            break
        default:
            cvCupon.alpha = 1
            cvPromotion.alpha = 0
            cvNews.alpha = 0
            break
        }
    }
}
