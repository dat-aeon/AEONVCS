//
//  ContactUsViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseUIViewController {

    @IBOutlet weak var cvHotLine: UIView!
    @IBOutlet weak var cvMessaging: UIView!
    @IBOutlet weak var segHotline: UISegmentedControl!
    
    var containerIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        segHotline.setTitle("contactus.tag1.title".localized, forSegmentAt: 0)
        segHotline.setTitle("contactus.tag2.title".localized, forSegmentAt: 1)
        toggleContainer(position:containerIndex)
        segHotline.selectedSegmentIndex = 0
//        print("Contact Us VC:::::::")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    @IBAction func onClickContactusSegmented(_ sender: UISegmentedControl) {
        toggleContainer(position: sender.selectedSegmentIndex+1)
    }
    
    func toggleContainer(position:Int){
        switch position {
        case 2:
            cvHotLine.alpha = 0
            cvMessaging.alpha = 1
//            // change read_flag on DB
//            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
//            var unreadArray = UserDefaults.standard.array(forKey: Constants.UNREAD_MESSAGE_ARRAY)  as? [Int] ?? [Int]()
//            if unreadArray.count > 0 {
//                for messageId in unreadArray {
//                    super.messagingSocket.send("ChangeReadFlagWithMsgId:\(messageId)")
//                    print("socket:: change read flag")
//                }
//                unreadArray.removeAll()
//                UserDefaults.standard.set(unreadArray, forKey: Constants.UNREAD_MESSAGE_ARRAY)
//            }
//            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            break
            
        case 1:
            cvHotLine.alpha = 1
            cvMessaging.alpha = 0
            break
            
        default:
            cvHotLine.alpha = 1
            cvMessaging.alpha = 0
            break
        }
        UserDefaults.standard.set(position, forKey: Constants.MESSAGING_SEGMENT)
    }
    
    @objc override func updateViews() {
        super.updateViews()
        segHotline.setTitle("contactus.tag1.title".localized, forSegmentAt: 0)
        segHotline.setTitle("contactus.tag2.title".localized, forSegmentAt: 1)
    }
}
