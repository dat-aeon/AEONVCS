//
//  HomeNewViewController.swift
//  AEONVCS
//
//  Created by Kyaw Kyaw Khing on 04/02/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit

class HomeNewViewController: BaseUIViewController {

    @IBOutlet weak var memberShipView: CardView!
    @IBOutlet weak var customerServiceView: CardView!
    @IBOutlet weak var loanCalculatorView: CardView!
    @IBOutlet weak var announcementView: CardView!
    @IBOutlet weak var askProductView: CardView!
    @IBOutlet weak var goodNewsView: CardView!
    @IBOutlet weak var howToUseView: CardView!
    @IBOutlet weak var ourServiceView: CardView!
    @IBOutlet weak var findUsView: CardView!
    @IBOutlet weak var informationUpdateView: CardView!
    @IBOutlet weak var facebookView: CardView!
    @IBOutlet weak var shareView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memberShipView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMemberShipView)))
        self.customerServiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapCustomerServiceView)))
        self.loanCalculatorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapLoanCalculatorView)))
        self.announcementView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAnnouncementView)))
        self.askProductView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAskProductView)))
        self.goodNewsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapGoodNewsView)))
        self.howToUseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapHowToUseView)))
        self.ourServiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapOurServiceView)))
        self.findUsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFindUsView)))
        self.informationUpdateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapInformationUpdateView)))
        self.facebookView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFacebookView)))
        self.shareView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapShareView)))
    }
    
    @objc func onTapMemberShipView() {
        print("click")
        self.performSegue(withIdentifier: "FreeChatViewController", sender: self)
    }
    
     @objc func onTapCustomerServiceView() {
        print("click")
        self.performSegue(withIdentifier: "FreeChatViewController", sender: self)
     }
    
    @objc func onTapLoanCalculatorView() {
        print("click")
        self.performSegue(withIdentifier: "FreeChatViewController", sender: self)
    }
    
    @objc func onTapAnnouncementView() {
        print("click")
    }
    
    @objc func onTapAskProductView() {
        print("click")
    }
    
    @objc func onTapGoodNewsView() {
        print("click")
    }
    
    @objc func onTapHowToUseView() {
        print("click")
    }
    
    @objc func onTapOurServiceView() {
        print("click")
    }
    
    @objc func onTapFindUsView() {
        print("click")
    }
    
    
    @objc func onTapInformationUpdateView() {
        print("click")
    }
    
    @objc func onTapFacebookView() {
        print("click")
    }
    
    @objc func onTapShareView() {
        print("click")
    }
    
    
    
}
