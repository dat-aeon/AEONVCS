//
//  CustomMessageActivity.swift
//  AEONVCS
//
//  Created by mac on 2/6/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//
import Foundation
import MessageUI

class CustomMessageActivity: UIActivity,MFMessageComposeViewControllerDelegate{
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private var messageBody:String?
    init(message:String) {
        self.messageBody = message
    }
    // returns activity title
    override var activityTitle: String?{
        return "Message"
    }
    
    //thumbnail image for the activity
    override var activityImage: UIImage?{
        return UIImage(named: "sms_icon")
    }
    
    var activitySettingsImage: UIImage? {
        return UIImage(named: "sms_icon")
    }
    
    //activiyt type
    override var activityType: UIActivity.ActivityType{
        return UIActivity.ActivityType.mail
    }
    
    public override static var activityCategory: UIActivity.Category {
        return .share;
    }
    
    //view controller for the activity
    override var activityViewController: UIViewController?{
        return nil
    }
    
    //here check whether this activity can perfor with given list of items
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    //prepare the data to perform with
    override func prepare(withActivityItems activityItems: [Any]) {
        
    }
    
    override func perform() {
        let composeVC = MFMessageComposeViewController()
        composeVC.body = messageBody ?? ""
        composeVC.messageComposeDelegate = self
        print("user did tap on my activity")
        if MFMessageComposeViewController.canSendText() { UIApplication.shared.keyWindow?.rootViewController?.present(composeVC, animated: true,completion: {
            composeVC.navigationBar.isHidden = true
        })
        }
    }
    
}

