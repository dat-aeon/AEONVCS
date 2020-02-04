//
//  OutletInfoViewController.swift
//  AEONVCS
//
//  Created by mac on 7/27/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class OutletInfoViewController: BaseUIViewController {

    @IBOutlet weak var segOutletInfo: UISegmentedControl!
    @IBOutlet weak var cvOutletMap: UIView!
    @IBOutlet weak var cvOutletList: UIView!
    
    var containerIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateViews()
        
        let font = UIFont(name: "PyidaungsuBook", size: 14)
        segOutletInfo.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        
        toggleContainer(position:containerIndex)
        
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
