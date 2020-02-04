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
    @IBOutlet weak var segEventsNews: UISegmentedControl!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        
        let font = UIFont(name: "PyidaungsuBook", size: 14)
        segEventsNews.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        
        segEventsNews.setTitle("eventnews.tab1.title".localized, forSegmentAt: 0)
        segEventsNews.setTitle("eventnews.tab2.title".localized, forSegmentAt: 1)
        segEventsNews.setTitle("eventnews.tab3.title".localized, forSegmentAt: 2)
        toggleContainer(position:containerIndex)
    }
    
    @IBAction func onClickEventNewsCuponSegmented(_ sender: UISegmentedControl) {
         toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    func toggleContainer(position:Int) {
        switch position {
        case 2:
            cvCupon.alpha = 0
            cvPromotion.alpha = 1
            cvNews.alpha = 0
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismiss"), object: nil, userInfo: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissCoupon"), object: nil, userInfo: nil)
            break
        case 1:
            cvCupon.alpha = 0
            cvPromotion.alpha = 0
            cvNews.alpha = 1
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissPromo"), object: nil, userInfo: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissCoupon"), object: nil, userInfo: nil)
            break
        case 3:
            cvCupon.alpha = 1
            cvPromotion.alpha = 0
            cvNews.alpha = 0
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismiss"), object: nil, userInfo: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissPromo"), object: nil, userInfo: nil)
            
            break
        default:
            cvCupon.alpha = 0
            cvPromotion.alpha = 1
            cvNews.alpha = 0
            break
        }
    }
    
    @objc override func updateViews() {
        super.updateViews()
        segEventsNews.setTitle("eventnews.tab1.title".localized, forSegmentAt: 0)
        segEventsNews.setTitle("eventnews.tab2.title".localized, forSegmentAt: 1)
        segEventsNews.setTitle("eventnews.tab3.title".localized, forSegmentAt: 2)
    }
}
