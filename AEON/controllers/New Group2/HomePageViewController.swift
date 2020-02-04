//
//  HomePageViewController.swift
//  AEONVCS
//
//  Created by mac on 5/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SideMenu
import SwiftyJSON
import Starscream

class HomePageViewController: BaseUIViewController {

    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    
    var currentContainer:Int = 1
    var customerType : String?
    
    private var pageViewController: UIPageViewController!
    private lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeViewController = storyboard.instantiateViewController(withIdentifier: CommonNames.WELCOME_VIEW_CONTROLLER)
        let memberCardInfoController = storyboard.instantiateViewController(withIdentifier: CommonNames.MEMBER_CARD_INFO_VIEW_CONTROLLER)
        let membershipController = storyboard.instantiateViewController(withIdentifier: CommonNames.MEMBERSHIP_VIEW_CONTROLLER)
        let infoUpdateViewController = storyboard.instantiateViewController(withIdentifier: CommonNames.INFORMATION_UPDATE_VIEW_CONTROLLER)
        let eventsViewController = storyboard.instantiateViewController(withIdentifier: CommonNames.EVENT_NEWS_VIEW_CONTROLLER)
        let contactUsViewController = storyboard.instantiateViewController(withIdentifier: CommonNames.MESSAGING_VIEW_CONTROLLER)
        let faqViewController = storyboard.instantiateViewController(withIdentifier: CommonNames.FAQ_AND_TERMS_VIEW_CONTROLLER)
        let outletInfoViewController = storyboard.instantiateViewController(withIdentifier: CommonNames.OUTLET_INFO_VIEW_CONTROLLER)
        let loanCalculatorViewController = storyboard.instantiateViewController(withIdentifier: CommonNames.LOAN_CALCULATOR_VIEW_CONTROLLER)
        let agentChannelViewController = storyboard.instantiateViewController(withIdentifier: CommonNames.AGENT_CHANNEL_VIEW_CONTROLLER)
        
        let dastoryboard = UIStoryboard(name: "DA", bundle: nil)
        let aeonServicesViewController = dastoryboard.instantiateViewController(withIdentifier: CommonNames.AEON_SERVICES_VIEW_CONTROLLER)
        
        
        viewControllers.append(welcomeViewController)
        viewControllers.append(memberCardInfoController)
        viewControllers.append(membershipController)
        viewControllers.append(infoUpdateViewController)
        viewControllers.append(aeonServicesViewController)
        viewControllers.append(loanCalculatorViewController)
        viewControllers.append(eventsViewController)
        viewControllers.append(outletInfoViewController)
        viewControllers.append(contactUsViewController)
        viewControllers.append(faqViewController)
        viewControllers.append(agentChannelViewController)
        
        return viewControllers
    }()

    var sessionDataBean : SessionDataBean?
    
    var senderName: String?
    var senderId: Int?
    
    //AT websocket
    var socketReq : SocketReqBean?
    var param : SocketParam?
    
    var afterSeftRegister = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let sessionData = sessionDataBean{
            let jsonData = try? JSONEncoder().encode(sessionData)
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
        }
        self.customerType = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE)
        //print("Home Page session data ::::::::::::::: \(String(describing: sessionDataBean))")
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        
        self.senderName = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)!
        self.senderId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        super.socket.delegate = self
        if !super.socket.isConnected {
            super.socket.connect()
            
        }
        self.socketReq = SocketReqBean()
        self.param = SocketParam()
        super.at_socket.delegate = self
        if !super.at_socket.isConnected {
            super.at_socket.connect()
        }
        param!.customerId = self.senderId!
        param!.phoneNo = self.senderName!
        param!.roomName = self.senderName!
        
        setupSideMenu()
        
        //show hide containers
        toggleContainer(position:currentContainer)
        NotificationCenter.default.addObserver(self, selector: #selector(changeContainer(_ :)), name: NSNotification.Name("ChangeContainer"), object:nil)
        
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
    //Decide Goto Member Card Or Not
    func doCheckMemberGotoMemberCard() {
        
        guard self.afterSeftRegister else {
            return
        }
        
        let memberValue:String = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE) ?? ""
        
        if memberValue == Constants.MEMBER {
            //Goto Member Card
        }
    }
    
    @objc func dismissKeyboard() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
        print("call dismisskeyboard")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController {
            pageViewController = vc
            pageViewController.dataSource = self
            pageViewController.delegate = self
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
            print("segue ", vc)
        }
    }
    
    @objc func changeContainer(_ notification:NSNotification) {
        //show hide containers
        //        if let position = notification.userInfo?["position"] as? Int {
        //            toggleContainer(position:position)
        //        }
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let position = dict["position"] as? Int{
                //if position == 8 { // if aeon_service is included.
                if position == 11 {
                    CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                    UserDefaults.standard.set(position, forKey: Constants.MESSAGING_MENU)
                    
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

                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
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
                        UserDefaults.standard.set(Constants.BLANK, forKey: Constants.LAST_USED_TIME)
                        UserDefaults.standard.set(nil, forKey: Constants.USED_COUPON_LIST)
                        
                        //print("socket close for logout")
                        UserDefaults.standard.set(true, forKey: Constants.MENU_SOCKET_CLOSE)
                        UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
                        super.socket.disconnect()
                        
                        UserDefaults.standard.set(true, forKey: Constants.AT_MENU_SOCKET_CLOSE)
                        UserDefaults.standard.set(true, forKey: Constants.AT_MESSAGE_SOCKET_CLOSE)
                        super.at_socket.disconnect()

                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
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

                        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
                        navigationVC.modalPresentationStyle = .overFullScreen
                        self.present(navigationVC, animated: true, completion:nil)
                        return
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
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: CommonNames.SIDE_MENU_TABLE_VIEW_CONTROLLER) as? UISideMenuNavigationController
        
        SideMenuManager.default.menuLeftNavigationController?.delegate = self
        
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
            self.title = "welcome.title".localized
            pageViewController.setViewControllers([viewControllers[position - 1]], direction: .forward, animated: true, completion: nil)
            break
        case 2:
            self.title = "membership.title".localized
            if self.customerType == Constants.MEMBER {
                pageViewController.setViewControllers([viewControllers[position - 1]], direction: .forward, animated: true, completion: nil)
            } else {
                pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
            }
            
            break
        case 3:
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            self.title = "infoupdate.title".localized
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
            break
           
        case 4:
            self.title = "aeonservices.title".localized
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)

            break
            
        case 5:
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            self.title = "loan.title".localized
            
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
            break
            
        case 6:
            //check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            self.title = "eventnews.title".localized
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
            //self.title = "eventnews.tab1.title".localized
            break
            
        case 7:
            
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            self.title = "findnearby.title".localized
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
            break
            
        case 8:
            // check network
            
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            self.title = "contactus.title".localized
            
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
            break
            
        case 9:
        
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            self.title = "faq.title".localized
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
            
            break
            
        case 10:
                   
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                           return
            }
            self.title = "agentchannel.title".localized
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
                       
            break
                      
        default:
            self.title = "welcome.title".localized
            pageViewController.setViewControllers([viewControllers[position]], direction: .forward, animated: true, completion: nil)
            break
        }
        UserDefaults.standard.set(position, forKey: Constants.MESSAGING_MENU)
    }
    
    @IBAction func onClickSideMenu(_ sender: UIBarButtonItem) {
        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.SIDE_MENU_TABLE_VIEW_CONTROLLER) as! UINavigationController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
        
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        updateViews()
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
            self.title = "aeonservices.title".localized
            break
            
        case 5:
            self.title = "loan.title".localized
            break
            
        case 6:
            self.title = "eventnews.title".localized
            break
            
        case 7:
            self.title = "findnearby.title".localized
            break
            
        case 8:
            self.title = "contactus.title".localized
            break
            
        case 9:
            self.title = "faq.title".localized
            break
            
        case 10:
            self.title = "agentchannel.title".localized
            break
            
        default:
            self.title = "welcome.title".localized
            break
        }
    }
}
extension HomePageViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        //self.menuSocket.send("unReadMesgCount:")
        super.socket.write(string: "unReadMesgCount:")
        
        self.socketReq!.api = "get-unread-message-count"
        
        let socketJson = try? JSONEncoder().encode(socketReq)
        let socketString = String(data: socketJson!, encoding: .utf8)!
        print(socketString)
        super.at_socket.write(string: socketString)
        //print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
        
    }
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        //print("SideMenu Disappeared! (animated: \(animated))")
        // setup side menu
        //        setupSideMenu()
        
    }
    
}
extension HomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
//            return nil
//        }
//        print("paging before ", viewControllerIndex)
//
//        let previousIndex = viewControllerIndex - 1
//
//        guard previousIndex >= 0 else {
//            return nil
//        }
//
//        guard viewControllers.count > previousIndex else {
//            return nil
//        }
//        return viewControllers[previousIndex]
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
//            return nil
//        }
//        print("paging after", viewControllerIndex)
//
//        let nextIndex = viewControllerIndex + 1
//        let viewControllersCount = viewControllers.count
//
//        guard viewControllersCount != nextIndex else {
//            return nil
//        }
//
//        guard viewControllersCount > nextIndex else {
//            return nil
//        }
//        return viewControllers[nextIndex]
        return nil
    }
}
// MARK: UIPageViewControllerDelegate
extension HomePageViewController: UIPageViewControllerDelegate {
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
extension HomePageViewController : WebSocketDelegate {
    func webSocketOpen() {
        
    }
    
    func webSocketClose(_ code: Int, reason: String, wasClean: Bool) {
        
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        
        //print("socket opened home page : \(self.senderName!)userId:\(self.senderId!)")
        super.socket.write(string: "userName:\(self.senderName!)userId:\(self.senderId!)")
        super.socket.write(string: "cr:\(self.senderName!)or:userWithAgency:")
        UserDefaults.standard.set(false, forKey: Constants.MENU_SOCKET_CLOSE)
        
        // Agent Channel
        self.socketReq!.param = param!
        self.socketReq!.api = "socket-connect"
        let socketJson = try? JSONEncoder().encode(socketReq)
        let socketString = String(data: socketJson!, encoding: .utf8)!
        print(socketString)
        super.at_socket.write(string: socketString)
        UserDefaults.standard.set(false, forKey: Constants.AT_MENU_SOCKET_CLOSE)
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        //print("socket onMessage \(message as? String)")
        if let text = text as? String {
            //print("recv: \(text)")
            do{
                if let json = text.data(using: String.Encoding.utf8){
                    if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                        
                        let type = jsonData["type"] as! String
                        print("type", type)
                        
                        if (type == "room"){
                            super.socket.write(string: "unReadMesgCount:")
                            
                        } else if (type == "unReadMesgCountForMobile") {
                            let data = jsonData["data"] as! NSObject
                            let count = data.value(forKey: "count") as? String
                            //print("message count:", count!)
                            UserDefaults.standard.set(Int(count ?? "0"), forKey: Constants.UNREAD_MESSAGE_COUNT)
                            
                        }
                        
                        if (type == "at-room"){
                            
                            self.socketReq!.param = self.param!
                            self.socketReq!.api = "get-unread-message-count"
                            
                            let socketJson = try? JSONEncoder().encode(socketReq)
                            let socketString = String(data: socketJson!, encoding: .utf8)!
                            print(socketString)
                            super.at_socket.write(string: socketString)
                            
                        } else if (type == "get-unread-message-count") {
                            let count = jsonData["data"] as! String
                            UserDefaults.standard.set(Int(count), forKey: Constants.AT_UNREAD_MESSAGE_COUNT)
                            
                        }
                    }
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        //print("socket did disconnect")
       // print("menu socket disconnect \(String(describing: error))")
        
        let isClose = UserDefaults.standard.bool(forKey: Constants.MENU_SOCKET_CLOSE)
        if isClose {
            super.socket.disconnect()
            //print("socket close permenant")
            
        } else {
            super.socket.connect()
        }
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        
        let atIsClose = UserDefaults.standard.bool(forKey: Constants.AT_MENU_SOCKET_CLOSE)
        if atIsClose {
            super.at_socket.disconnect()
            //print("socket close permenant")
            
        } else {
            super.at_socket.connect()
        }
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        
    }
}
