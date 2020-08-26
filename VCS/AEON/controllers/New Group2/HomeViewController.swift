//
//  HomeViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SideMenu
import SwiftyJSON

class HomeViewController: BaseUIViewController {

    @IBOutlet weak var cvWelcome: UIView!
    @IBOutlet weak var cvMembership: UIView!
   // @IBOutlet weak var cvInformationUpdate: UIView!
    @IBOutlet weak var cvInfoUpdateForPh1: UIView!
    @IBOutlet weak var cvApplyService: UIView!
    @IBOutlet weak var cvEventNews: UIView!
    @IBOutlet weak var cvContactUs: UIView!
    @IBOutlet weak var cvContactUsForPh1: UIView!
    @IBOutlet weak var cvFAQ: UIView!
    @IBOutlet weak var cvLoanCalculator: UIView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var containerIndex:Int = 1
    var currentContainer:Int = 1
    
    //var loginResponse:LoginResponse?
    var sessionDataBean : SessionDataBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Start HomeViewController :::::::::::::::")
//
//        if let sessionData = sessionDataBean{
//            let jsonData = try? JSONEncoder().encode(sessionData)
//            let jsonString = String(data: jsonData!, encoding: .utf8)!
//            UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
//        }
//        //print("Home session data ::::::::::::::: \(String(describing: sessionDataBean))")
//
//        switch Locale.currentLocale {
//        case .EN:
//            bbLocaleFlag.image = UIImage(named: "mm_flag")
//        case .MY:
//            bbLocaleFlag.image = UIImage(named: "en_flag")
//        }
//
//        cvContactUsForPh1.alpha = 0
//
//        // setup side menu
//        setupSideMenu()
//
//        //show hide containers
//        toggleContainer(position:containerIndex)
//        NotificationCenter.default.addObserver(self, selector: #selector(changeContainer(_ :)), name: NSNotification.Name("ChangeContainer"), object:nil)
//
//        // session timeout
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(applicationWillResignActive),
//                                               name: UIApplication.didEnterBackgroundNotification,
//                                               object: nil)
//
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(applicationWillEnterForeground),
//                                               name: UIApplication.didBecomeActiveNotification,
//                                               object: nil)
//
//
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissKeyboard), name: NSNotification.Name("dismissKeyboard"), object:nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
        print("call dismisskeyboard")
    }
    
    @objc func changeContainer(_ notification:NSNotification) {
        //show hide containers
//        if let position = notification.userInfo?["position"] as? Int {
//            toggleContainer(position:position)
//        }
        //print(notification.userInfo ?? "")
//        if let dict = notification.userInfo as NSDictionary? {
//            if let position = dict["position"] as? Int{
//                //if position == 8 { // if aeon_service is included.
//                if position == 7 {
//                    CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
//                    
//                    let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
//                    let logoutTime = Utils.generateLogoutTime()
//                    
//                    print("\(customerId) + \(logoutTime)")
//                    
//                    // check network
//                    if Network.reachability.isReachable == false {
//                        print("socket close for logout")
//                        //super.messagingSocket.close()
//                        
//                        UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
//                        UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
//                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
//                        self.present(navigationVC, animated: true, completion:nil)
//                        return
//                    }
//                    
//                    print("socket close for logout")
//                    //super.messagingSocket.close()
//                    
//                    let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
//                    let tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
//                    
//                    LogoutViewModel.init().logout(customerId: customerId, logoutTime: logoutTime, tokenInfo: tokenInfo!, success: { (result) in
//
//                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//                        UserDefaults.standard.set(nil, forKey: Constants.LOGIN_TIME)
//                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
//                        UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
//                        UserDefaults.standard.set(nil, forKey: Constants.HOTLINE_NO)
//                        UserDefaults.standard.set(true, forKey: Constants.IS_LOGOUT)
//                        UserDefaults.standard.set(Constants.BLANK, forKey: Constants.LAST_USED_TIME)
//                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
//                        self.present(navigationVC, animated: true, completion:nil)
//                        
//                    }) { (error) in
//                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//                        //Utils.showAlert(viewcontroller: self, title: "Logout Failed", message: error)
//                        UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
//                        UserDefaults.standard.set(nil, forKey: Constants.TOKEN_DATA)
//                        UserDefaults.standard.set(nil, forKey: Constants.HOTLINE_NO)
//                        UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
//                        UserDefaults.standard.set(Utils.generateLogoutTime(), forKey: Constants.LAST_USED_TIME)
//                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
//                        self.present(navigationVC, animated: true, completion:nil)
//                        return
//                    }
//                }else{
//                    toggleContainer(position:position)
//                }
//                self.currentContainer = position
//            }
//            
//        }
//        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func setupSideMenu() {
        
        // Define the menus
        
        let leftSidemenu = storyboard!.instantiateViewController(withIdentifier: CommonNames.SIDE_MENU_TABLE_VIEW_CONTROLLER) as? UISideMenuNavigationController
        
        leftSidemenu?.delegate = self
        SideMenuManager.default.menuLeftNavigationController = leftSidemenu
        
        
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // Set up a cool background image for demo purposes
        //        SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.gray
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth  = self.view.frame.width-100
    }
    
    func toggleContainer(position:Int){
        
        //print("position : \(position)")
        switch position {
        case 1:
            cvWelcome.alpha = 1
            cvMembership.alpha = 0
            //cvInformationUpdate.alpha = 0
            cvInfoUpdateForPh1.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            //cvContactUsForPh1.alpha = 0
            cvFAQ.alpha = 0
            self.title = "welcome.title".localized
            break
        case 2:
            cvWelcome.alpha = 0
            cvMembership.alpha = 1
            //cvInformationUpdate.alpha = 0
            cvInfoUpdateForPh1.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            //cvContactUsForPh1.alpha = 0
            cvFAQ.alpha = 0
            self.title = "membership.title".localized
            break
        case 3:
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            cvWelcome.alpha = 0
            cvMembership.alpha = 0
            //cvInformationUpdate.alpha = 0
            cvInfoUpdateForPh1.alpha = 1
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            //cvContactUsForPh1.alpha = 0
            cvFAQ.alpha = 0
            self.title = "infoupdate.title".localized
            break
//        case 4:
//            cvWelcome.alpha = 0
//            cvMembership.alpha = 0
//            cvInformationUpdate.alpha = 0
//            cvApplyService.alpha = 1
//            cvEventNews.alpha = 0
//            cvContactUs.alpha = 0
//            cvFAQ.alpha = 0
//            self.title = "aeonservice.title".localized
//            break
        case 4:
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            cvWelcome.alpha = 0
            cvMembership.alpha = 0
            //cvInformationUpdate.alpha = 0
            cvInfoUpdateForPh1.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 1
            cvContactUs.alpha = 0
            //cvContactUsForPh1.alpha = 0
            cvFAQ.alpha = 0
            self.title = "eventnews.title".localized
            //self.title = "eventnews.tab1.title".localized
            break
        case 6:
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            cvMembership.alpha = 0
            //cvInformationUpdate.alpha = 0
            cvInfoUpdateForPh1.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 1
            //cvContactUsForPh1.alpha = 1
            cvFAQ.alpha = 0
            self.title = "contactus.title".localized
            
            break
        case 7:
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            cvWelcome.alpha = 0
            cvMembership.alpha = 0
            //cvInformationUpdate.alpha = 0
            cvInfoUpdateForPh1.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            //cvContactUsForPh1.alpha = 0
            cvFAQ.alpha = 1
            self.title = "faq.title".localized
            break
        default:
            cvWelcome.alpha = 1
            cvMembership.alpha = 0
            //cvInformationUpdate.alpha = 0
            cvInfoUpdateForPh1.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            //cvContactUsForPh1.alpha = 0
            cvFAQ.alpha = 0
            self.title = "welcome.title".localized
            break
        }
    }
    
    @IBAction func onClickSideMenu(_ sender: UIBarButtonItem) {
        
        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.SIDE_MENU_TABLE_VIEW_CONTROLLER) as! UINavigationController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
        
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        switch self.currentContainer {
        case 1:
            self.title = "welcome.title".localized
            break
        case 2:
            self.title = "membership.title".localized
            break
        case 3:
            self.title = "infoupdate.title".localized
            break
//        case 4:
//            self.title = "aeonservice.title".localized
//            break
        case 4:
            self.title = "eventnews.title".localized
            //self.title = "eventnews.tab1.title".localized
            break
        case 5:
            self.title = "contactus.title".localized
            break
        case 6:
            self.title = "faq.title".localized
            break
        default:
            self.title = "welcome.title".localized
            break
        }
    }
    
}
extension HomeViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        self.view.endEditing(true)
    }
    
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
        // setup side menu
//        setupSideMenu()
        
    }
    
}
