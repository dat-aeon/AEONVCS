//
//  HomeViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: BaseUIViewController {

    @IBOutlet weak var cvWelcome: UIView!
    @IBOutlet weak var cvMembership: UIView!
    
    @IBOutlet weak var cvInformationUpdate: UIView!
    @IBOutlet weak var cvApplyService: UIView!
    @IBOutlet weak var cvEventNews: UIView!
    @IBOutlet weak var cvContactUs: UIView!
    @IBOutlet weak var cvFAQ: UIView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var containerIndex:Int = 1
    var currentContainer:Int = 1
    
    var registerResponse:RegisterResponse?
    var loginResponse:LoginResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start HomeViewController :::::::::::::::")
        
        if let registerResponseData = registerResponse{
            let jsonData = try? JSONEncoder().encode(registerResponseData)
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            UserDefaults.standard.set(jsonString, forKey: Constants.REGISTER_RESPONSE)
        }
        if let loginResponseData = loginResponse{
            let jsonData = try? JSONEncoder().encode(loginResponseData)
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            UserDefaults.standard.set(jsonString, forKey: Constants.LOGIN_RESPONSE)
        }
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
//        UserDefaults.standard.set(registerResponse, forKey: Constants.REGISTER_RESPONSE)
        // setup side menu
        setupSideMenu()
        
        //show hide containers
        toggleContainer(position:containerIndex)
        NotificationCenter.default.addObserver(self, selector: #selector(changeContainer(_ :)), name: NSNotification.Name("ChangeContainer"), object:nil)
        
    }
    
    @objc func changeContainer(_ notification:NSNotification) {
        //show hide containers
//        if let position = notification.userInfo?["position"] as? Int {
//            toggleContainer(position:position)
//        }
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let position = dict["position"] as? Int{
                if position == 8 {
                    
                    let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
                    let loginTime = UserDefaults.standard.string(forKey: Constants.LOGIN_TIME)
                    let logoutTime = super.generateCurrentTimeStamp()
                    
                    print("\(customerId) + \(loginTime ?? "") + \(logoutTime)")
                    
                    CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                    LogoutViewModel.init().logout(customerId: customerId,loginTime: loginTime!,logoutTime: logoutTime, success: { (result) in

                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                        UserDefaults.standard.set(nil, forKey: Constants.LOGIN_RESPONSE)
                        UserDefaults.standard.set(nil, forKey: Constants.REGISTER_RESPONSE)
                        
                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "MainViewController") as! UINavigationController
                        self.present(navigationVC, animated: true, completion:nil)
                        
                    }) { (error) in
                        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                        Utils.showAlert(viewcontroller: self, title: "Logout Failed", message: error)
                    }
                }else{
                    toggleContainer(position:position)
                }
                self.currentContainer = position
            }
            
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func setupSideMenu() {
        
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "SideMenuTableViewController") as? UISideMenuNavigationController
        
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
        switch position {
        case 1:
            cvWelcome.alpha = 1
            cvMembership.alpha = 0
            cvInformationUpdate.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            cvFAQ.alpha = 0
            self.title = "welcome.title".localized
            break
        case 2:
            cvWelcome.alpha = 0
            cvMembership.alpha = 1
            cvInformationUpdate.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            cvFAQ.alpha = 0
            self.title = "membership.title".localized
            break
        case 3:
            cvWelcome.alpha = 0
            cvMembership.alpha = 0
            cvInformationUpdate.alpha = 1
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            cvFAQ.alpha = 0
            self.title = "infoupdate.title".localized
            break
        case 4:
            cvWelcome.alpha = 0
            cvMembership.alpha = 0
            cvInformationUpdate.alpha = 0
            cvApplyService.alpha = 1
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            cvFAQ.alpha = 0
            self.title = "aeonservice.title".localized
            break
        case 5:
            cvWelcome.alpha = 0
            cvMembership.alpha = 0
            cvInformationUpdate.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 1
            cvContactUs.alpha = 0
            cvFAQ.alpha = 0
            self.title = "eventnews.title".localized
            break
        case 6:
            cvMembership.alpha = 0
            cvInformationUpdate.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 1
            cvFAQ.alpha = 0
            self.title = "contactus.title".localized
            break
        case 7:
            cvWelcome.alpha = 0
            cvMembership.alpha = 0
            cvInformationUpdate.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            cvFAQ.alpha = 1
            self.title = "faq.title".localized
            break
        default:
            cvWelcome.alpha = 1
            cvMembership.alpha = 0
            cvInformationUpdate.alpha = 0
            cvApplyService.alpha = 0
            cvEventNews.alpha = 0
            cvContactUs.alpha = 0
            cvFAQ.alpha = 0
            self.title = "welcome.title".localized
            break
        }
    }
    
    @IBAction func onClickSideMenu(_ sender: UIBarButtonItem) {
        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "SideMenuTableViewController") as! UINavigationController
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
        case 4:
            self.title = "aeonservice.title".localized
            break
        case 5:
            self.title = "eventnews.title".localized
            break
        case 6:
            self.title = "contactus.title".localized
            break
        case 7:
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
