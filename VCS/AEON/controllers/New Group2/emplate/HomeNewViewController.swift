//
//  HomeNewViewController.swift
//  AEONVCS
//
//  Created by Kyaw Kyaw Khing on 04/02/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit

import SwiftyJSON
import Starscream
import AVKit
import AVFoundation

class HomeNewViewController: BaseUIViewController {
    @IBOutlet weak var loanApplyViewPress: UIStackView!
    
    @IBOutlet weak var loanApplyStatusView: UIStackView!
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
    @IBOutlet weak var lblLogOut: UILabel!
    @IBOutlet weak var logoutImg: UIImageView!
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblMembership: UILabel!
    @IBOutlet weak var lblCustomerService: UILabel!
    @IBOutlet weak var lblLoanCalculaotr: UILabel!
    @IBOutlet weak var lblAnnouncement: UILabel!
    @IBOutlet weak var lblAskproduct: UILabel!
    @IBOutlet weak var lblGoodnews: UILabel!
    @IBOutlet weak var lblHowtouse: UILabel!
    @IBOutlet weak var lblOurService: UILabel!
    @IBOutlet weak var lblFindus: UILabel!
    @IBOutlet weak var lblInformationUpdate: UILabel!
    @IBOutlet weak var lblShare: UILabel!
    
    
    @IBOutlet weak var loanApplicationView: CardView!
    @IBOutlet weak var loanAppView: CardView!
    
    @IBOutlet weak var loanApplyBtn: UILabel!
    
    @IBOutlet weak var contactAppLabel: UILabel!
    @IBOutlet weak var unReadAskProductLabel: UILabel!
    @IBOutlet weak var loanAppBtn: UILabel!
    @IBOutlet weak var loanApplicationStatusBtn: UILabel!
    @IBOutlet weak var loancalculatorTop: NSLayoutConstraint!
    @IBOutlet weak var contactusTop: NSLayoutConstraint!
    @IBOutlet weak var goodnewTop: NSLayoutConstraint!
    @IBOutlet weak var ourserviceTop: NSLayoutConstraint!
    @IBOutlet weak var informationupdatTop: NSLayoutConstraint!
    var customerType : String?
    
    var sessionDataBean : SessionDataBean?
    
    var senderName: String?
  //  var senderId: Int!
 //   let customerId:Int = 303122
  //  let cid: Int = 77
  //  var userDeviceID: String!
    //AT websocket
    var socketReq : SocketReqBean?
    var param : SocketParam?
    var AutomessageBean = MessageBean()
    var vidoeFilePath : String = ""
    
    var senderId:Int = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
    
    @IBAction func loanViewHidePress(_ sender: UITapGestureRecognizer) {
        loanAppView.isHidden = true
        
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        contactUpMessageUnRead(customerId: customerId)
    //        levelTwoUnRead(customerId: cid)
    //         loanAppView.isHidden = true
    //    }
   
   
    override func viewWillAppear(_ animated: Bool) {
       // USER_INFO_CUSTOMER_ID
        var player = AVPlayer()
        player.pause()
        logoutTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
       self.senderId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
       currentLanguage()
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(contactUsnoti), userInfo: nil, repeats: true)
//        DispatchQueue.main.async {
//            self.levelTwoUnRead(customerId: self.senderId!)
//           
//         //   self.askProductMessageUnRead(customerId: self.senderId!, levelType: 2)
//        }
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(currentLanguage), userInfo: nil, repeats: true)
    }
    @objc func contactUsnoti() {
        self.levelTwoUnRead(customerId: self.senderId)
    }
    
 var logoutTimer: Timer?
   @objc func currentLanguage(){
        switch Locale.currentLocale {
        case .MY:
            mmTop()
            break
            
        case .EN:
            engTop()
            break
        }
    }
   
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.currentLanguage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
            self.contactAppLabel.isHidden = true
            self.notiIcon()
       
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(contactUsnoti), userInfo: nil, repeats: true)
        currentLanguage()
        askProductView.isHidden = true
        loanApplicationView.isHidden = true
        logoutTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
       
    
        print("kaungmyat usertypeid \(UserDefaults.standard.integer(forKey: Constants.USER_INFO_USER_TYPE_ID))")
     //   self.deviceID = sessionDataBean?.loginDeviceId ?? ""
     
        self.senderId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
       // askProductMessageUnRead(customerId: senderId!, levelType: 2)
        self.levelTwoUnRead(customerId: self.senderId)
        uiSetup()
        loanAppView.isHidden = true
        updateViews()
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
        
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
        
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
        self.loanApplicationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTaploanApplicationView)))
        self.loanApplyViewPress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTaploanAppView)))
        self.loanApplyStatusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTaploanApplyStatusView)))
        self.lblLogOut.isUserInteractionEnabled = true
        self.logoutImg.isUserInteractionEnabled = true
        self.logoutImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action:
            #selector(onTapLogOut)))
        self.lblLogOut.addGestureRecognizer(UITapGestureRecognizer(target: self, action:
            #selector(onTapLogOut)))
        
        self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
        
        
        
        if let sessionData = sessionDataBean{
            let jsonData = try? JSONEncoder().encode(sessionData)
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
        }
        self.customerType = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE)
        //print("Home Page session data ::::::::::::::: \(String(describing: sessionDataBean))")
        
        //        switch Locale.currentLocale {
        //        case .EN:
        //            bbLocaleFlag.image = UIImage(named: "mm_flag")
        //        case .MY:
        //            bbLocaleFlag.image = UIImage(named: "en_flag")
        //        }
       
        self.senderName = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO) ?? "09"
        self.senderId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        //        super.socket.delegate = self
        //        if !super.socket.isConnected {
        //            super.socket.connect()
        //
        //        }
        //        self.socketReq = SocketReqBean()
        //        self.param = SocketParam()
        //        super.at_socket.delegate = self
        //        if !super.at_socket.isConnected {
        //            super.at_socket.connect()
        //        }
        //        param!.customerId = self.senderId!
        //        param!.phoneNo = self.senderName!
        //        param!.roomName = self.senderName!
        
        
        // session timeout
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillResignActive),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissKeyboard), name: NSNotification.Name("dismissKeyboard"), object:nil)
        
        
    }
    @objc func runTimedCode() {
        multiLoginGet()
    // print("kms\(logoutTimer)")
    }
  func multiLoginGet(){
       var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
             let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
        
         MultiLoginModel.init().makeMultiLogin(customerId: customerId
                 , loginDeviceId: deviceID, success: { (results) in
              //   print("kaungmyat san multi >>>  \(results)")
                 
                 if results.data.logoutFlag == true {
                     print("success stage logout")
                     // create the alert
                            let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)

                            // add an action (button)
                     alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                         self.logoutTimer?.invalidate()
                         let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                         navigationVC.modalPresentationStyle = .overFullScreen
                         self.present(navigationVC, animated: true, completion:nil)
                         
                     }))

                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                     
                     
                 }
             }) { (error) in
                 print(error)
             }
         }
    
   
    @objc func dismissKeyboard() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
        print("call dismisskeyboard")
    }
    
    func mmTop(){
        self.loancalculatorTop.constant = 9
        self.contactusTop.constant = 9
        self.ourserviceTop.constant = 9
        self.informationupdatTop.constant = 5
        
    }
    func engTop(){
        self.informationupdatTop.constant = 5
        self.ourserviceTop.constant = 18
        self.contactusTop.constant = 18
        self.loancalculatorTop.constant = 18
    }
    @objc func onTapMMLocale() {
        print("click")
        mmTop()
        super.NewupdateLocale(flag: 1)
        updateViews()
    }
    @objc func onTapEngLocale() {
        print("click")
       engTop()
        super.NewupdateLocale(flag: 2)
        updateViews()
    }
    @objc func onTaploanApplicationView() {
        
        loanAppView.isHidden = false
        
    }
    
    func notiIcon(){
        contactAppLabel.layer.cornerRadius = contactAppLabel.frame.size.height / 2
        contactAppLabel.layer.masksToBounds = true
        contactAppLabel?.layer.borderColor = UIColor.red.cgColor
        contactAppLabel?.layer.borderWidth = 1.0
    }
    
    func uiSetup() {
        loanApplyBtn.layer.borderColor  = UIColor.orange.cgColor
        loanApplyBtn.layer.backgroundColor = UIColor.white.cgColor
        loanApplyBtn.layer.cornerRadius = 5
        loanApplyBtn.layer.masksToBounds = true
        loanApplyBtn.layer.borderWidth = 2
        
        loanApplicationStatusBtn.layer.borderColor  = UIColor.orange.cgColor
        loanApplicationStatusBtn.layer.backgroundColor = UIColor.white.cgColor
        loanApplicationStatusBtn.layer.cornerRadius = 5
        loanApplicationStatusBtn.layer.masksToBounds = true
        loanApplicationStatusBtn.layer.borderWidth = 2
        
        unReadAskProductLabel.layer.cornerRadius = unReadAskProductLabel.frame.size.height / 2
        unReadAskProductLabel.layer.masksToBounds = true
        unReadAskProductLabel?.layer.borderColor = UIColor.red.cgColor
        unReadAskProductLabel?.layer.borderWidth = 1.0
        contactAppLabel.layer.cornerRadius = contactAppLabel.frame.size.height / 2
        contactAppLabel.layer.masksToBounds = true
        contactAppLabel?.layer.borderColor = UIColor.red.cgColor
        contactAppLabel?.layer.borderWidth = 1.0
    }
    @IBAction func loanApplyBtnPress(_ sender: UIButton) {
       
        
      
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.lblMembership.text = "sidemenu.membership".localized
        Utils.setLineSpacing(data: "contactus.title".localized, label: lblCustomerService)
        //self.lblCustomerService.text = "contactus.title".localized
        Utils.setLineSpacing(data: "main.loancalculator".localized, label: lblLoanCalculaotr)
        //self.lblLoanCalculaotr.text = "main.loancalculator".localized
        self.lblAnnouncement.text = "main.announcement".localized
        self.lblAskproduct.text = "main.askproduct".localized
        self.lblGoodnews.text = "main.goodnews".localized
        self.lblHowtouse.text = "main.howtouse".localized
        self.lblOurService.text = "main.ourservice".localized
        self.lblFindus.text = "main.findus".localized
        Utils.setLineSpacing(data: "main.informationupdate".localized, label: lblInformationUpdate)
        //self.lblInformationUpdate.text = "main.informationupdate".localized
        self.lblShare.text = "main.share".localized
        self.lblLogOut.text = "sidemenu.logout".localized
        self.loanApplyBtn.text = "main.loanapplybtn".localized
        self.loanAppBtn.text = "main.loanapplybtn".localized
        self.loanApplicationStatusBtn.text = "main.loanApplicationStatusBtn".localized
    }
    func levelTwoUnRead(customerId: Int) {
   
        LevelTwoMessageUnreadViewModel.init().levelTwoUnreadMessageSync(customerId: customerId, success: { (result) in
           
            print("result..<<...  \(result.data.level2MessageUnReadCount)")
            if "\(result.data.level2MessageUnReadCount)" == "0" {
                self.contactAppLabel.isHidden = true
            }else{
                self.contactAppLabel.isHidden = false
                if self.contactAppLabel.text?.count ?? 0 > 99 {
                    self.contactAppLabel.text = "+99"
                }else{
                    self.contactAppLabel.text = "\(result.data.level2MessageUnReadCount)" //"\(result.data.level2MessageUnReadCount)"
                }
            }
            
        }) { (error) in
            print(error)
        }
    }
    
    
    func askProductMessageUnRead(customerId: Int,levelType: Int) {
        
        AskProductViewModel.init().askProductSync(customerId: customerId, levelType: levelType, success: { (result) in
            print("result ,,,.,,..,.kaungmyatsan \(result.data.askProductUnReadCount)")
            if "\(result.data.askProductUnReadCount)" == "0" {
                self.unReadAskProductLabel.isHidden = true
            }else{
                self.unReadAskProductLabel.isHidden = false
                if self.unReadAskProductLabel.text?.count ?? 0 > 99 {
                    self.unReadAskProductLabel.text = "+99"
                }else{
                    self.unReadAskProductLabel.text =  "\(result.data.askProductUnReadCount)"
                }
            }
        }) { (error) in
            print(error)
        }
        
        //        contactUsModel.init().contactUsMessage(customerId: customerId, success: { (result) in
        //
        //            print("result ,,,.,,..,.kaungmyatsan \(result.data.askProductUnReadCount)")
        //            if "\(result.data.askProductUnReadCount)" == "0" {
        //                self.contactAppLabel.isHidden = true
        //            }else{
        //                 self.contactAppLabel.isHidden = false
        //                if self.contactAppLabel.text?.count ?? 0 > 99 {
        //                    self.contactAppLabel.text = "+99"
        //                }else{
        //                    self.contactAppLabel.text =  "\(result.data.askProductUnReadCount)"
        //                }
        //            }
        //        }) { (error) in
        //            print(error)
        //        }
        //        askProductModel.init().askProductSync(customerId: customerId, success: { (result) in
        //            print(result)
        //        }) { (error) in
        //            print(error)
        //        }
    }
    
    @objc func onTapMemberShipView() {
        print("click")
        loanAppView.isHidden = true
        if self.customerType == Constants.MEMBER {
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberShipNewViewController") as! UIViewController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        } else {
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomerTypeViewController") as! UIViewController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func onTapCustomerServiceView() {
        print("click")
        loanAppView.isHidden = true
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MessagingViewController") as! MessagingViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
       
    }
    
    @objc func onTapLoanCalculatorView() {
        print("click")
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        loanAppView.isHidden = true
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoanCalculatorViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapAnnouncementView() {
        loanAppView.isHidden = true
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PromotionViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapAskProductView() {
        loanAppView.isHidden = true
        print("click")
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "AgentChannelLevelTwoViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapGoodNewsView() {
        print("click")
        loanAppView.isHidden = true
        
        UserDefaults.standard.set(2, forKey: Constants.togoodnewsfrom)
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "EventNewViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapHowToUseView() {
        loanAppView.isHidden = true
        print("click")
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HowToUseViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapOurServiceView() {
        loanAppView.isHidden = true
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "FaqAndTermsConditionViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapFindUsView() {
        loanAppView.isHidden = true
        print("click")
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "OutletInfoViewController") as! UIViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    
    @objc func onTapInformationUpdateView() {
        print("click")
        loanAppView.isHidden = true
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.INFORMATION_UPDATE_VIEW_CONTROLLER) as! UIViewController
//        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.INFORMATIONUPDATE_VIEW_CONTROLLER) as! UIViewController
        
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
        
    }
    @objc func onTaploanAppView(){
//        let storyboard = UIStoryboard(name: "DA", bundle: nil)
//               let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLY_LOAN_NAV)
//               applyLoanNav.modalPresentationStyle = .overFullScreen
//               self.present(applyLoanNav, animated: true, completion: nil)
//               loanAppView.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLY_LOAN_MAIN)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
        loanAppView.isHidden = true
    }
    @objc func onTaploanApplyStatusView(){
       let applyLoanN = UIStoryboard(name: "DA", bundle: nil).instantiateViewController(withIdentifier: CommonNames.INQUIRY_LOAN_NAV) as! UIViewController
       
             applyLoanN.modalPresentationStyle = .fullScreen
             self.present(applyLoanN, animated: true, completion: nil)
             loanAppView.isHidden = true
    }
 
    
    @objc func onTapFacebookView() {
        print("click")
        loanAppView.isHidden = true
        UIApplication.tryURL(urls: [
            "fb://profile/116374146706", // App
            "https://www.facebook.com/AeonMicrofinance/" // Website if app fails
        ])
    }
    
    @objc func onTapShareView() {
        print("click")
        loanAppView.isHidden = true
        let shareText = Constants.AEON_SHARE_LINK
        
        //let messageVC = CustomMessageActivity(message:shareText)
        let vc = UIActivityViewController(activityItems: [shareText],   applicationActivities: nil)
        vc.excludedActivityTypes = [UIActivity.ActivityType.init(rawValue: "com.linkedin.LinkedIn.ShareExtension"),.message]
        
        vc.completionWithItemsHandler = { activity, success, items, error in
            if !success{
                print("cancelled")
                return
            }
            
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverPresentationController = vc.popoverPresentationController {
                popoverPresentationController.sourceView = self.shareView
                
            }
        }
        present(vc, animated: true)
        
    }
    
    @objc func onTapLogOut(){
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        //               UserDefaults.standard.set(position, forKey: Constants.MESSAGING_MENU)
        
        let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
        let logoutTime = Utils.generateLogoutTime()
        
        print("\(customerId) + \(logoutTime)")
        UserDefaults.standard.set(true, forKey: Constants.MENU_SOCKET_CLOSE)
        //self.menuSocket.close()
        //super.messagingSocket.close()
        UserDefaults.standard.set(false, forKey: CommonNames.VERSION_ALERT_SHOWN)
        
        // check network
        if Network.reachability.isReachable == false {
            //print("socket close for logout")
            
            UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
            UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
            UserDefaults.standard.set(nil, forKey: Constants.USED_COUPON_LIST)
            
            UserDefaults.standard.set(true, forKey: Constants.MENU_SOCKET_CLOSE)
            UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
            super.socket.disconnect()
            
            UserDefaults.standard.set(true, forKey: Constants.AT_MENU_SOCKET_CLOSE)
            UserDefaults.standard.set(true, forKey: Constants.AT_MESSAGE_SOCKET_CLOSE)
            super.at_socket.disconnect()
            
            //                   let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
            //                   navigationVC.modalPresentationStyle = .overFullScreen
            //                   self.present(navigationVC, animated: true, completion:nil)
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion:nil)
            return
        }
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        let tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        LogoutViewModel.init().logout(customerId: customerId, logoutTime: logoutTime, tokenInfo: tokenInfo!, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
            UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
            UserDefaults.standard.set(nil, forKey: Constants.HOTLINE_NO)
            UserDefaults.standard.set(true, forKey: Constants.IS_LOGOUT)
            UserDefaults.standard.set(nil, forKey: Constants.USER_INFO_NAME)
            UserDefaults.standard.set(Constants.BLANK, forKey: Constants.LAST_USED_TIME)
            UserDefaults.standard.set(nil, forKey: Constants.USED_COUPON_LIST)
            
            //print("socket close for logout")
            UserDefaults.standard.set(true, forKey: Constants.MENU_SOCKET_CLOSE)
            UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
            super.socket.disconnect()
            
            UserDefaults.standard.set(true, forKey: Constants.AT_MENU_SOCKET_CLOSE)
            UserDefaults.standard.set(true, forKey: Constants.AT_MESSAGE_SOCKET_CLOSE)
            super.at_socket.disconnect()
            
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER)
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion:nil)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            //Utils.showAlert(viewcontroller: self, title: "Logout Failed", message: error)
            UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
            UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
            UserDefaults.standard.set(nil, forKey: Constants.HOTLINE_NO)
            UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
            UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
            UserDefaults.standard.set(nil, forKey: Constants.USED_COUPON_LIST)
            
            //print("socket close for logout")
            UserDefaults.standard.set(true, forKey: Constants.MENU_SOCKET_CLOSE)
            UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
            super.socket.disconnect()
            
            UserDefaults.standard.set(true, forKey: Constants.AT_MENU_SOCKET_CLOSE)
            UserDefaults.standard.set(true, forKey: Constants.AT_MESSAGE_SOCKET_CLOSE)
            super.at_socket.disconnect()
            
            //            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
            //            navigationVC.modalPresentationStyle = .overFullScreen
            //            self.present(navigationVC, animated: true, completion:nil)
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion:nil)
            return
        }
        
        
    }
    
    
    
}



//extension HomeNewViewController : WebSocketDelegate {
//    func webSocketOpen() {
//
//    }
//
//    func webSocketClose(_ code: Int, reason: String, wasClean: Bool) {
//
//    }
//
//    func websocketDidConnect(socket: WebSocketClient) {
//
//        //print("socket opened home page : \(self.senderName!)userId:\(self.senderId!)")
//        super.socket.write(string: "userName:\(self.senderName!)userId:\(self.senderId!)")
//        super.socket.write(string: "cr:\(self.senderName!)or:userWithAgency:")
//        UserDefaults.standard.set(false, forKey: Constants.MENU_SOCKET_CLOSE)
//
//        // Agent Channel
//        self.socketReq!.param = param!
//        self.socketReq!.api = "socket-connect"
//        let socketJson = try? JSONEncoder().encode(socketReq)
//        let socketString = String(data: socketJson!, encoding: .utf8)!
//        print(socketString)
//        super.at_socket.write(string: socketString)
//        UserDefaults.standard.set(false, forKey: Constants.AT_MENU_SOCKET_CLOSE)
//
//    }
//
//    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
//        //print("socket onMessage \(message as? String)")
//        if let text = text as? String {
//            //print("recv: \(text)")
//            do{
//                if let json = text.data(using: String.Encoding.utf8){
//                    if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
//
//                        let type = jsonData["type"] as! String
//                        print("type", type)
//
//                        if (type == "room"){
//                            super.socket.write(string: "unReadMesgCount:")
//
//                        } else if (type == "unReadMesgCountForMobile") {
//                            let data = jsonData["data"] as! NSObject
//                            let count = data.value(forKey: "count") as? String
//                            //print("message count:", count!)
//                            UserDefaults.standard.set(Int(count ?? "0"), forKey: Constants.UNREAD_MESSAGE_COUNT)
//
//                        }
//
//                        if (type == "at-room"){
//
//                            self.socketReq!.param = self.param!
//                            self.socketReq!.api = "get-unread-message-count"
//
//                            let socketJson = try? JSONEncoder().encode(socketReq)
//                            let socketString = String(data: socketJson!, encoding: .utf8)!
//                            print(socketString)
//                            super.at_socket.write(string: socketString)
//
//                        } else if (type == "get-unread-message-count") {
//                            let count = jsonData["data"] as! String
//                            UserDefaults.standard.set(Int(count), forKey: Constants.AT_UNREAD_MESSAGE_COUNT)
//
//                        }
//                    }
//                }
//            }catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
//
//    }
//
//    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
//        //print("socket did disconnect")
//        // print("menu socket disconnect \(String(describing: error))")
//
//        let isClose = UserDefaults.standard.bool(forKey: Constants.MENU_SOCKET_CLOSE)
//        if isClose {
//            super.socket.disconnect()
//            //print("socket close permenant")
//
//        } else {
//            super.socket.connect()
//        }
//        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//
//        let atIsClose = UserDefaults.standard.bool(forKey: Constants.AT_MENU_SOCKET_CLOSE)
//        if atIsClose {
//            super.at_socket.disconnect()
//            //print("socket close permenant")
//
//        } else {
//            super.at_socket.connect()
//        }
//        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//
//    }
//}
