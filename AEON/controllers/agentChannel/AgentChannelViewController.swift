//
//  AgentChannelViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 11/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import Starscream
import GoogleMaps

class AgentChannelViewController: BaseUIViewController , UITextViewDelegate{
    
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    @IBOutlet weak var lblBarCusType: UILabel!
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    @IBOutlet weak var tvAgentChannel: UITableView!
    @IBOutlet weak var btSendToAgent: UIButton!
    @IBOutlet weak var popupBackView: UIView!
    @IBOutlet weak var popupScrollView: UIScrollView!
    
    @IBOutlet weak var btnCloseImg: UIImageView!
    @IBOutlet weak var lbCategoryTitle: UILabel!
    @IBOutlet weak var vCategoryList: UIView!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbBrandTitle: UILabel!
    @IBOutlet weak var vBrandList: UIView!
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbAddTextTitle: UILabel!
    @IBOutlet weak var txtAddText: UITextView!
    @IBOutlet weak var lbErrAddText: UILabel!
    @IBOutlet weak var lbAddressTitle: UILabel!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var lbErrAddress: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    
    var segmentIndex: Int!
    var orginBottom : CGFloat!
    var isDidLoad = false
    
    var messageBeanList: [ATmessageBean] = []
    var messageListForUI : [ATmessageBean] = []
    
    var senderName: String = Constants.BLANK
    var senderId: Int = 0
    var sessionInfo: SessionDataBean?
    var categoryList : [CategoryData] = []
    var brandList : [BrandData] = []
    var categoryNameList :[String] = []
    var brandNameList : [String] = []
    var socketReq = SocketReqBean()
    var param = SocketParam()
    
    //locale
    var addTextLocale : String?
    var addressLocale : String?
    
    // reload message
    var count:Int = 10
    var countTimer:Timer!
    
    // Google Map location
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        // for max length of textview
        txtAddText.delegate = self
        txtAddress.delegate = self
        
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
        self.senderName = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)!
        self.senderId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        // label setting
        self.btSendToAgent.setTitle("agentchannel.send.button".localized, for: UIControl.State.normal)
        
        super.at_socket.delegate = self
        if !self.socket.isConnected {
            super.at_socket.connect()
            
        } else {
            if (self.messageBeanList.count == 0){
                super.at_socket.write(string: "get-message-history")
                
            } else {
                super.at_socket.write(string: "get-unread-messages")
            }
        }
        
        UserDefaults.standard.set(0, forKey: Constants.AT_UNREAD_MESSAGE_COUNT)
        
        self.tvAgentChannel.register(UINib(nibName: CommonNames.MESG_MORE_BUTTON_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.MESG_MORE_BUTTON_TABLE_CELL)
        self.tvAgentChannel.register(UINib(nibName: CommonNames.AT_MESG_SEND_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.AT_MESG_SEND_TABLE_CELL)
        self.tvAgentChannel.register(UINib(nibName: CommonNames.AT_MESG_RECEIVE_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.AT_MESG_RECEIVE_TABLE_CELL)
        
        self.tvAgentChannel.dataSource = self
        self.tvAgentChannel.delegate = self
        
        //self.tvMessagingView.estimatedRowHeight = CGFloat(200.0)
        self.tvAgentChannel.rowHeight = UITableView.automaticDimension
        self.tvAgentChannel.tableFooterView = UIView()
        self.tvAgentChannel.reloadData()
        // open the socket
        UserDefaults.standard.set(false, forKey: Constants.AT_MESSAGE_SOCKET_CLOSE)
        
        self.btSendToAgent.setTitle("agentchannel.open.button".localized, for: UIControl.State.normal)
        
        
        if (UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME) == nil) {
                   self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
                   self.lblBarName.text = ""
                   self.lblBarCusType.text = "Lv.1 : Application user"
               }else{
                   self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
                              self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
                    self.lblBarCusType.text = "Lv.2 : Login user"
               }
        
        
        self.isDidLoad = true
        
        
        // ====================== Popup Setup Data ==========================
        
        self.popupBackView.alpha = 0
        self.popupScrollView.alpha = 0
        self.popupScrollView.layer.zPosition = 1
        
        self.vCategoryList.layer.borderWidth = 1
        self.vCategoryList.layer.cornerRadius = 4 as CGFloat
        self.vCategoryList.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vBrandList.layer.borderWidth = 1
        self.vBrandList.layer.cornerRadius = 4 as CGFloat
        self.vBrandList.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        // get current places
        
        self.locationManager = CLLocationManager()
        self.locationManager!.requestWhenInUseAuthorization()
        self.locationManager!.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager!.delegate = self
            self.locationManager!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager!.startUpdatingLocation()
        }
        
        self.vCategoryList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickCategoryDropDown)))
        self.vBrandList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickBrandDropDown)))
        
        self.btnCloseImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickClosePopup(tapGestureRecognizer:))))
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print ("appear")
        if self.isDidLoad {
            self.isDidLoad = false
            
        } else {
            let messageMenu = UserDefaults.standard.integer(forKey: Constants.MESSAGING_MENU)
            
            if messageMenu == 10 {
                self.socketReq.api = "get-unread-messages"
                let socketJson = try? JSONEncoder().encode(socketReq)
                let socketString = String(data: socketJson!, encoding: .utf8)!
                print(socketString)
                super.at_socket.write(string: socketString)
                self.countTimer = Timer.scheduledTimer(timeInterval: 1 ,
                                                       target: self,
                                                       selector: #selector(self.reloadMessage),
                                                       userInfo: nil,
                                                       repeats: true)
            } else if messageMenu == 11 {
                // close message socket
                UserDefaults.standard.set(true, forKey: Constants.AT_MESSAGE_SOCKET_CLOSE)
                super.at_socket.disconnect()
            }
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
    
    @objc override func updateViews() {
        super.updateViews()
        self.btSendToAgent.setTitle("agentchannel.open.button".localized, for: UIControl.State.normal)
        
        // ========== pop view update ==============
        self.lbCategoryTitle.text = "agentchannel.category.label".localized
        self.lbBrandTitle.text = "agentchannel.brand.label".localized
        self.lbAddTextTitle.text = "agentchannel.additional.label".localized
        self.lbAddressTitle.text = "agentchannel.location.label".localized
        self.btnSend.setTitle("agentchannel.send.button".localized, for: UIControl.State.normal)
        
        self.lbErrAddText.text = self.addTextLocale?.localized
        self.lbErrAddress.text = self.addressLocale?.localized
    }
    
    @IBAction func onClickSendBtn(_ sender: UIButton) {
        
        //Show popup view
        self.view.addSubview(popupBackView)
        self.view.addSubview(popupScrollView)
        
        popupBackView.center = view.center
        popupScrollView.center = view.center
        
        popupBackView.alpha = 0.8
        popupScrollView.alpha = 1
        popupScrollView.layer.zPosition = 1
        
        popupBackView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        popupScrollView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            self.popupBackView.transform = .identity
            self.popupScrollView.transform = .identity
        })
        
        self.lbCategoryTitle.text = "agentchannel.category.label".localized
        self.lbBrandTitle.text = "agentchannel.brand.label".localized
        self.lbAddTextTitle.text = "agentchannel.additional.label".localized
        self.lbAddressTitle.text = "agentchannel.location.label".localized
        self.btnSend.setTitle("agentchannel.send.button".localized, for: UIControl.State.normal)
        
        if self.brandNameList.count > 0 {
            lbBrand.text = self.brandNameList[0]
        }
        if self.categoryNameList.count > 0 {
            lbCategory.text = self.categoryNameList[0]
        }
        self.txtAddText.text = ""
        self.txtAddress.text = ""
        self.lbErrAddress.text = Constants.BLANK
        self.lbErrAddText.text = Constants.BLANK
        self.locationManager?.startUpdatingLocation()
        
    }
    
    // Timer for Reload message
    @objc func reloadMessage(){
        //print("reload message")
        //let messageMenu = UserDefaults.standard.integer(forKey: Constants.MESSAGING_MENU)
        //if messageMenu == 10 {
            if(self.count > 0) {
                self.count -= 1
                
            } else {
                
                self.socketReq.api = "get-unread-messages"
                let socketJson = try? JSONEncoder().encode(socketReq)
                let socketString = String(data: socketJson!, encoding: .utf8)!
                print(socketString)
                super.at_socket.write(string: socketString)
                self.count = 13
            }
//        } else {
//            self.countTimer.invalidate()
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.countTimer.invalidate()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count // for Swift use count(newText)
        return numberOfChars < 100;
    }
    
    @IBAction func onClickSendMesg(_ sender: UIButton) {
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        var isError = false
        
        if txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            txtAddress.text = Constants.BLANK
            lbErrAddress.text = Messages.AT_ADDRESS_EMPTY_ERROR.localized
            self.addressLocale = Messages.AT_ADDRESS_EMPTY_ERROR
            isError = true
            
        } else {
            self.addressLocale = Constants.BLANK
            lbErrAddress.text = Constants.BLANK
        }
        
        if txtAddText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            txtAddText.text = Constants.BLANK
            lbErrAddText.text = Messages.AT_ADDITION_TEXT_EMPTY_ERROR.localized
            self.addTextLocale = Messages.AT_ADDITION_TEXT_EMPTY_ERROR
            isError = true
            
        } else {
            lbErrAddText.text = Constants.BLANK
            self.addTextLocale = Constants.BLANK
        }
        
        if isError {
            self.popupScrollView.isUserInteractionEnabled = true
            self.view.bringSubviewToFront(popupScrollView)
            
        } else {
            
            if let selectedIndex = self.categoryNameList.firstIndex(of: "\(lbCategory.text!)"){
                param.categoryId = self.categoryList[selectedIndex].productTypeID
            }
            if let index = self.brandNameList.firstIndex(of: "\(lbBrand.text!)"){
                param.brandId = self.brandList[index].brandId
            }
            
            socketReq.api = "post-buy-info"
            param.categoryName = lbCategory.text!
            param.brandName = lbBrand.text!
            param.additionalText = txtAddText.text
            param.location = txtAddress.text
            param.userId = self.senderId
            param.sendFlag = 0
            param.sendTime = super.generateCurrentTimeStamp()
            param.readFlag = 0
            socketReq.param = param
            
            let socketJson = try? JSONEncoder().encode(socketReq)
            let socketString = String(data: socketJson!, encoding: .utf8)!
            print(socketString)
            super.at_socket.write(string: socketString)
        }
        
    }
    
    @objc func onClickCategoryDropDown(){
        self.txtAddText?.resignFirstResponder()
        self.txtAddress?.resignFirstResponder()
        openCategorySelectionPopUp()
    }
    
    @objc func onClickClosePopup(tapGestureRecognizer : UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //use if you wish to darken the background
            //self.viewDim.alpha = 0
            self.popupBackView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.popupScrollView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            
        }) { (success) in
            //self.popupBackView.removeFromSuperview()
            //self.popupScrollView.removeFromSuperview()
            self.popupBackView.alpha = 0
            self.popupScrollView.alpha = 0
        }
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
    }
    
    func openCategorySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: self.categoryNameList, action: { (value)  in
                self.lbCategory.text = value
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lbCategory
            }
            
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: self.categoryNameList, action: { (value)  in
                self.lbCategory.text = value
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(action, animated: true, completion: nil)
        }
    }
    
    @objc func onClickBrandDropDown(){
        self.txtAddText?.resignFirstResponder()
        self.txtAddress?.resignFirstResponder()
        openBrandSelectionPopUp()
    }
    
    func openBrandSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: self.brandNameList, action: { (value)  in
                self.lbBrand.text = value
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lbBrand
            }
            
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: self.brandNameList, action: { (value)  in
                self.lbBrand.text = value
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(action, animated: true, completion: nil)
        }
    }
}

extension AgentChannelViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager!.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            self.txtAddress.text = ""
            if let place = placeMark {
                if let street = place.thoroughfare {
                    self.txtAddress.text += street + ", "
                }
                if let block = place.subLocality {
                    self.txtAddress.text += block + ", "
                }
                if let township = place.locality {
                    self.txtAddress.text += township + ", "
                }
                if let country = place.country {
                    self.txtAddress.text += country
                }
                //self.txtAddress.text = place.thoroughfare ?? Constants.BLANK + ", " + place.subLocality! + ", " + place.locality! + ", " + place.country!
                print(place.thoroughfare ?? "", place.subLocality ?? "", place.locality ?? "", place.country ?? "")
            }
            
        })
        locationManager?.stopUpdatingLocation()
    }
}

extension AgentChannelViewController : WebSocketDelegate {
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        
        param.customerId = self.senderId
        param.phoneNo = self.senderName
        param.roomName = self.senderName
        
        self.socketReq.param = param
        self.socketReq.api = "socket-connect"
        
        let socketJson = try? JSONEncoder().encode(socketReq)
        let socketString = String(data: socketJson!, encoding: .utf8)!
        print(socketString)
        socket.write(string: socketString)
        
        //super.at_socket.write(string: "userName:\(self.senderName)userId:\(self.senderId)")
        //super.at_socket.write(string: "cr:\(self.senderName)or:userWithAgency:")
        
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        //        print("message socket did disconnect")
        print("message socket disconnect \(String(describing: error))")
        
        let isClose = UserDefaults.standard.bool(forKey: Constants.AT_MESSAGE_SOCKET_CLOSE)
        if isClose {
            super.at_socket.disconnect()
            
        } else {
            super.at_socket.connect()
        }
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        
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
                        
                        if (type == "at-room"){
                            // get messages
                            self.socketReq.api = "get-message-history"
                            var socketJson = try? JSONEncoder().encode(socketReq)
                            var socketString = String(data: socketJson!, encoding: .utf8)!
                            print(socketString)
                            socket.write(string: socketString)
                            
                            // get categories
                            self.socketReq.api = "get-device-categories"
                            socketJson = try? JSONEncoder().encode(socketReq)
                            socketString = String(data: socketJson!, encoding: .utf8)!
                            print(socketString)
                            socket.write(string: socketString)
                            
                            // get brands
                            socketReq.api = "get-device-brands"
                            socketJson = try? JSONEncoder().encode(socketReq)
                            socketString = String(data: socketJson!, encoding: .utf8)!
                            socket.write(string: socketString)
                            
                            
                        } else if (type == "get-msg-history"){
                            if let content = jsonData["data"] as? NSArray {
                                if (content.count > 0){
                                    //let messageMenu = UserDefaults.standard.integer(forKey: Constants.AT_MESSAGING_MENU)
                                    print("AT Message count :\(content.count)")
                                    // show latest 25 messages
                                    
                                    if content.count >= 25 {
                                        var messageBean = ATmessageBean()
                                        messageBean.isButton = true
                                        messageBean.messageId = content.count - 26
                                        
                                        print("latest index ::", messageBean.messageId)
                                        self.messageListForUI.append(messageBean)
                                        
                                    }
                                    
                                    for index in stride(from: 0, through: content.count-1, by: 1) {
                                        // print(content[index])
                                        
                                        var messageBean = ATmessageBean()
                                        messageBean.contentMessage = (content[index] as AnyObject).value(forKey: "contentMessage") as! String
                                        messageBean.sendTime = super.changeDateformat(date: (content[index] as AnyObject).value(forKey: "sendTime") as! String)
                                        //print("convert time : \(messageBean.contentMessage),\(messageBean.sendTime)")
                                        
                                        if 1 == (content[index] as AnyObject).value(forKey: "opSendFlag") as? Int {
                                            messageBean.isReceiveMesg = true
                                            messageBean.agentName = (content[index] as AnyObject).value(forKey: "agentName") as! String
                                            messageBean.price = (content[index] as AnyObject).value(forKey: "price") as! String
                                            messageBean.phoneNo = (content[index] as AnyObject).value(forKey: "phoneNo") as! String
                                            messageBean.urlLink = (content[index] as AnyObject).value(forKey: "urlLink") as? String ?? ""
                                            
                                        } else {
                                            messageBean.isReceiveMesg = false
                                        }
                                        messageBean.agentId = (content[index] as AnyObject).value(forKey: "agentId") as! Int
                                        messageBean.messageId = (content[index] as AnyObject).value(forKey: "messageId") as! Int
                                        messageBean.senderId = (content[index] as AnyObject).value(forKey: "senderId") as! Int
                                        
                                        messageBean.brandId = (content[index] as AnyObject).value(forKey: "brandId") as! Int
                                        messageBean.brandName = (content[index] as AnyObject).value(forKey: "brandName") as! String
                                        messageBean.location = (content[index] as AnyObject).value(forKey: "location") as? String ?? ""
                                        messageBean.categoryId = (content[index] as AnyObject).value(forKey: "categoryId") as! Int
                                        messageBean.categoryName = (content[index] as AnyObject).value(forKey: "categoryName") as! String
                                        self.messageBeanList.append(messageBean)
                                    }
                                    
                                    if self.messageBeanList.count > 25 {
                                        for i in stride(from: self.messageBeanList.count - 25, through: self.messageBeanList.count - 1, by: 1) {
                                            
                                            self.messageListForUI.append(self.messageBeanList[i])
                                        }
                                        
                                    } else {
                                        for i in stride(from: 0, through: self.messageBeanList.count - 1, by: 1) {
                                            
                                            self.messageListForUI.append(self.messageBeanList[i])
                                        }
                                        
                                    }
                                    
                                    
                                    self.tvAgentChannel.reloadData()
                                    let indexPath:IndexPath = IndexPath(row: self.messageListForUI.count - 1, section: 0)
                                    self.tvAgentChannel.scrollToRow(at: indexPath, at: .bottom, animated: false)
                                    
                                    self.countTimer = Timer.scheduledTimer(timeInterval: 1 ,
                                                                           target: self,
                                                                           selector: #selector(self.reloadMessage),
                                                                           userInfo: nil,
                                                                           repeats: true)
                                }
                            }
                        } else if (type == "get-unread-messages"){
                            if let content = jsonData["data"] as? NSArray {
                                if (content.count > 0){
                                    //let messageMenu = UserDefaults.standard.integer(forKey: Constants.AT_MESSAGING_MENU)
                                    print("AT urread Message count :\(content.count)")
                                    var unreadArray = UserDefaults.standard.array(forKey: Constants.AT_UNREAD_MESSAGE_ARRAY)  as? [Int] ?? [Int]()
                                    
                                    if unreadArray.count > 0 {
                                        unreadArray.removeAll()
                                    }
                                    for index in stride(from: 0, through: content.count-1, by: 1) {
                                        // print(content[index])
                                        
                                        var messageBean = ATmessageBean()
                                        messageBean.contentMessage = (content[index] as AnyObject).value(forKey: "contentMessage") as! String
                                        messageBean.sendTime = super.changeDateformat(date: (content[index] as AnyObject).value(forKey: "sendTime") as! String)
                                        
                                        if 1 == (content[index] as AnyObject).value(forKey: "opSendFlag") as? Int {
                                            messageBean.isReceiveMesg = true
                                            messageBean.agentName = (content[index] as AnyObject).value(forKey: "agentName") as! String
                                            messageBean.price = (content[index] as AnyObject).value(forKey: "price") as! String
                                            messageBean.phoneNo = (content[index] as AnyObject).value(forKey: "phoneNo") as! String
                                            messageBean.urlLink = (content[index] as AnyObject).value(forKey: "urlLink") as? String ?? ""
                                            
                                        } else {
                                            messageBean.isReceiveMesg = false
                                        }
                                        messageBean.agentId = (content[index] as AnyObject).value(forKey: "agentId") as! Int
                                        messageBean.messageId = (content[index] as AnyObject).value(forKey: "messageId") as! Int
                                        messageBean.senderId = (content[index] as AnyObject).value(forKey: "senderId") as! Int
                                        
                                        messageBean.brandId = (content[index] as AnyObject).value(forKey: "brandId") as! Int
                                        messageBean.brandName = (content[index] as AnyObject).value(forKey: "brandName") as! String
                                        messageBean.location = (content[index] as AnyObject).value(forKey: "location") as? String ?? ""
                                        messageBean.categoryId = (content[index] as AnyObject).value(forKey: "categoryId") as! Int
                                        messageBean.categoryName = (content[index] as AnyObject).value(forKey: "categoryName") as! String
                                        self.messageListForUI.append(messageBean)
                                        
                                        self.socketReq.api = "read-messages"
                                        self.socketReq.param.messageId = messageBean.messageId
                                        let socketJson = try? JSONEncoder().encode(socketReq)
                                        let socketString = String(data: socketJson!, encoding: .utf8)!
                                        //print(socketString)
                                        socket.write(string: socketString)
                                        
                                    }
                                    UserDefaults.standard.set(0, forKey: Constants.AT_UNREAD_MESSAGE_COUNT)
                                    self.tvAgentChannel.reloadData()
                                    let indexPath:IndexPath = IndexPath(row: self.messageListForUI.count-1, section: 0)
                                    self.tvAgentChannel.scrollToRow(at: indexPath, at: .top, animated: false)
                                    
                                }
                            }
                        } else if (type == "get-categories"){
                            if let content = jsonData["data"] as? NSArray {
                                if (content.count > 0){
                                    print("category count :\(content.count)")
                                    
                                    for index in stride(from: content.count-1, through: 0, by: -1) {
                                        var category = CategoryData()
                                        category.productTypeID = (content[index] as AnyObject).value(forKey: "product_type_id") as! Int
                                        category.name = (content[index] as AnyObject).value(forKey: "product_name") as! String
                                        self.categoryList.append(category)
                                        self.categoryNameList.append(category.name)
                                    }
                                    
                                }
                            }
                        } else if (type == "get-brands"){
                            if let content = jsonData["data"] as? NSArray {
                                if (content.count > 0){
                                    print("brand count :\(content.count)")
                                    
                                    for index in stride(from: content.count-1, through: 0, by: -1) {
                                        var brand = BrandData()
                                        brand.brandId = (content[index] as AnyObject).value(forKey: "brand_id") as! Int
                                        brand.brandName = (content[index] as AnyObject).value(forKey: "brand_name") as! String
                                        self.brandList.append(brand)
                                        self.brandNameList.append(brand.brandName)
                                    }
                                }
                            }
                        } else if (type == "post-buy-ok"){
                            //self.dismiss(animated: true, completion: nil)
                            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                            var messageBean = ATmessageBean()
                            messageBean.contentMessage = self.param.additionalText
                            messageBean.sendTime = super.changeMessageDateformat(date:self.param.sendTime)
                            messageBean.isReceiveMesg = false
                            messageBean.brandId = self.param.brandId
                            messageBean.brandName = self.param.brandName
                            messageBean.categoryId = self.param.categoryId
                            messageBean.categoryName = self.param.categoryName
                            messageBean.location = self.param.location
                            
                            self.messageListForUI.append(messageBean)
                            self.tvAgentChannel.reloadData()
                            let indexPath:IndexPath = IndexPath(row: self.messageListForUI.count-1, section: 0)
                            self.tvAgentChannel.scrollToRow(at: indexPath, at: .bottom, animated: false)
                            self.presentedViewController?.dismiss(animated: true, completion: nil)
                            
                            
                            //Close popup view
                            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                                self.popupBackView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                                self.popupScrollView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                                
                            }) { (success) in
                                //                                self.popupBackView.removeFromSuperview()
                                //                                self.popupScrollView.removeFromSuperview()
                                self.popupBackView.alpha = 0
                                self.popupScrollView.alpha = 0
                                
                            }
                            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                            
                            
                        } else if (type == "post-buy-not-ok"){
                            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                            let error = jsonData["data"] as! String
                            print(error)
                            let socketJson = try? JSONEncoder().encode(socketReq)
                            let socketString = String(data: socketJson!, encoding: .utf8)!
                            print(socketString)
                            socket.write(string: socketString)
                        }
                    }
                }
            }catch {
                //print(error.localizedDescription)
                
            }
        }
    }
}

extension AgentChannelViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("count", self.messageBeanList.count)
        return self.messageListForUI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageData = self.messageListForUI[indexPath.row]
        if (messageData.isButton){
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.MESG_MORE_BUTTON_TABLE_CELL, for: indexPath) as! MoreButtonTableViewCell
            cell.delegate = self
            cell.setData(messageId: messageData.messageId)
            cell.selectionStyle = .none
            return cell
        }
        if (!messageData.isReceiveMesg) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.AT_MESG_SEND_TABLE_CELL, for: indexPath) as! ATsendMessageTableViewCell
            cell.setData(messageBean: messageData)
            cell.selectionStyle = .none
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.AT_MESG_RECEIVE_TABLE_CELL, for: indexPath) as! ATreceiveMessageTableViewCell
        cell.setData(messageBean: messageData)
        cell.selectionStyle = .none
        cell.callDelegate = self
        return cell
    }
}


extension AgentChannelViewController : MoreMessageDelegate {
    func onClickMoreMesg(messageId: Int) {
        // messageid means index in agent channel
        print("on click index ::", messageId)
        let firstIndex = messageId    // 45
        var lastIndex = 0
        if firstIndex > 25 {
            lastIndex = firstIndex - 24 // 45 - 24 = 21
        }
        
        var oldMessageList = [ATmessageBean]()
        
        if firstIndex > 25 {
            var messageBean = ATmessageBean()
            messageBean.isButton = true
            messageBean.messageId = lastIndex - 1
            
            print("latest index ::", messageBean.messageId)
            oldMessageList.append(messageBean)
            
        }
        
        for index in stride(from: lastIndex, through: firstIndex, by: 1){
            oldMessageList.append(self.messageBeanList[index])
        }
        
        self.messageListForUI.remove(at: 0)
        self.messageListForUI.insert(contentsOf: oldMessageList, at: 0)
        let scrollIndex:IndexPath = IndexPath(row: firstIndex , section: 0)
        
        self.tvAgentChannel.reloadData()
        self.tvAgentChannel.scrollToRow(at: scrollIndex, at: .top, animated: false)
    }
}


extension AgentChannelViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AgentChannelViewController : CallAgentDelegate {
    func onClickCallAgent(phoneNo: String , agentId : Int, messageId : Int) {
        phoneNo.makeCall()
        
        self.socketReq.api = "update-call-count"
        self.socketReq.param.agentId = agentId
        self.socketReq.param.messageId = messageId
        let socketJson = try? JSONEncoder().encode(socketReq)
        let socketString = String(data: socketJson!, encoding: .utf8)!
        print(socketString)
        super.at_socket.write(string: socketString)
    }
    
    
}

