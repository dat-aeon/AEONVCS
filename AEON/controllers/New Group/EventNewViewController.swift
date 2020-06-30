//
//  EventNewViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class EventNewViewController: BaseUIViewController {

    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    @IBOutlet weak var cvCupon: UIView!
    @IBOutlet weak var cvPromotion: UIView!
    @IBOutlet weak var cvNews: UIView!
    @IBOutlet weak var segEventsNews: UISegmentedControl!
    
    @IBOutlet weak var lblBarCusType: UILabel!
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    
    var containerIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        
        let font = UIFont(name: "PyidaungsuBook", size: 14)
        segEventsNews.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        
//        segEventsNews.setTitle("eventnews.tab1.title".localized, forSegmentAt: 0)
//        segEventsNews.setTitle("eventnews.tab2.title".localized, forSegmentAt: 1)
//        segEventsNews.setTitle("eventnews.tab3.title".localized, forSegmentAt: 2)
        segEventsNews.setTitle("eventnews.tab3.title".localized, forSegmentAt: 1)
        segEventsNews.setTitle("eventnews.tab1.title".localized, forSegmentAt: 0)
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
    
    @IBAction func onClickEventNewsCuponSegmented(_ sender: UISegmentedControl) {
         toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    func toggleContainer(position:Int) {
        switch position {
//        case 2:
//            cvCupon.alpha = 0
//            cvPromotion.alpha = 1
//            cvNews.alpha = 0
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismiss"), object: nil, userInfo: nil)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissCoupon"), object: nil, userInfo: nil)
//            break
//        case 1:
//            cvCupon.alpha = 0
//            cvPromotion.alpha = 0
//            cvNews.alpha = 1
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissPromo"), object: nil, userInfo: nil)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissCoupon"), object: nil, userInfo: nil)
//            break
//        case 3:
//            cvCupon.alpha = 1
//            cvPromotion.alpha = 0
//            cvNews.alpha = 0
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismiss"), object: nil, userInfo: nil)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissPromo"), object: nil, userInfo: nil)
            
            
            case 1:
                cvCupon.alpha = 0
                cvPromotion.alpha = 0
                cvNews.alpha = 1
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissPromo"), object: nil, userInfo: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissCoupon"), object: nil, userInfo: nil)
                break
            case 2:
                cvCupon.alpha = 1
                cvPromotion.alpha = 0
                cvNews.alpha = 0
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismiss"), object: nil, userInfo: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doForceDismissPromo"), object: nil, userInfo: nil)
            
            break
        default:
            cvCupon.alpha = 0
            cvPromotion.alpha = 0
            cvNews.alpha = 1
            break
        }
    }
    
    @objc override func updateViews() {
        super.updateViews()
//        segEventsNews.setTitle("eventnews.tab1.title".localized, forSegmentAt: 0)
//        segEventsNews.setTitle("eventnews.tab2.title".localized, forSegmentAt: 1)
//        segEventsNews.setTitle("eventnews.tab3.title".localized, forSegmentAt: 2)
        segEventsNews.setTitle("eventnews.tab3.title".localized, forSegmentAt: 1)
        segEventsNews.setTitle("eventnews.tab1.title".localized, forSegmentAt: 0)
       
    }
}
