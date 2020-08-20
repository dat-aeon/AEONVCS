//
//  FreeChatViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import Starscream


class FreeChatViewController: BaseUIViewController {
   
    
   
    @IBOutlet weak var sendBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var questionTwo: UIView!
    @IBOutlet weak var questionOne: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    @IBOutlet weak var lblBarPhNo: UILabel!
    
    @IBOutlet weak var tvMessagingView: UITableView!
    //    @IBOutlet weak var lbHotline: UILabel!
    //    @IBOutlet weak var btnHotline: UIImageView!
    @IBOutlet weak var vSendview: UIView!
    @IBOutlet weak var btnSendImg: UIButton!
    @IBOutlet weak var tfTypeMessage: UITextField!
    @IBOutlet weak var btnSendMesg: UIButton!
    @IBOutlet weak var vSendBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuHeight: NSLayoutConstraint!
    @IBOutlet weak var menuBtnLabel: UIButton!
    
        var oldMessageBeanList = [MessageBean]()
        var typeLists:String = ""
        var flagLanNo:Int = 1
        var segmentIndex: Int!
        var orginBottom : CGFloat!
        var isDidLoad = false
        var messageBeanList: [MessageBean] = []
        var senderName: String = Constants.BLANK
        var senderId: Int = 0
        var sessionInfo: SessionDataBean?
        var imagePicker: ImagePicker?
         var AutomessageBean = MessageBean()
        //    let messagingSocket = WebSocket(Constants.socket_url)
        //    var socket = WebSocket(url: URL(string: Constants.socket_url)!, protocols: ["chat"])
        var mmLan = ""
        var engLan = ""
        var mainLan = ""
//
    @objc func myTargetFunction(textField: UITextField) {
        print("myTargetFunction")
  
                  buttonHasNoText = true
        menuHeight.constant = 0
        if tfTypeMessage.text!.count == 0 {
            sendBtnWidth.constant = 0
        }
        if tfTypeMessage.text!.count > 0 {
            sendBtnWidth.constant = 60
        }
    }
    override func viewDidAppear(_ animated: Bool) {
         AutomessageBean.message = mmLan
       
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tfTypeMessage.addTarget(self, action: #selector(myTargetFunction(textField:)), for: UIControl.Event.touchDown)
            autoReplyMessage()
        
            questionOne.layer.cornerRadius = questionOne.frame.width / 2
            questionTwo.layer.cornerRadius = questionOne.frame.width / 2
            AutomessageBean.isReceiveMesg = true
            AutomessageBean.message = mainLan
                           
           self.messageBeanList.append(AutomessageBean)
            self.imgBack.isUserInteractionEnabled = true
            self.imgMMlocale.isUserInteractionEnabled = true
            self.imgEnglocale.isUserInteractionEnabled = true
            self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
            self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
            self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
            self.senderName = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE) ?? "09123456789"
            
            //        RoomSyncViewModel.init().roomSync(phoneNo: UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE) ?? "09", success: {(result) in
            //
            //            let freeCustomerInfoId = result.data.freeCustomerInfoID
            //
            //             UserDefaults.standard.set(freeCustomerInfoId, forKey: Constants.FREECUS_INFO_ID)
            //
            //        }) { (error) in
            //
            //        }
            //        self.senderId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? 0
            self.senderId = UserDefaults.standard.integer(forKey: Constants.FREECUS_INFO_ID)
            //        self.senderId = 100
            print("SenderId \(self.senderId)")
            // initialize for camera image picker
            self.imagePicker = ImagePicker(presentationController: self, delegate: self)
            super.free_chat_socket_url.delegate = self
            if !self.free_chat_socket_url.isConnected {
                super.free_chat_socket_url.connect()
                
            } else {
                if (self.messageBeanList.count == 0){
                    super.free_chat_socket_url.write(string: "messageList:")
                    
                } else {
                    super.free_chat_socket_url.write(string: "unReadMessageList:")
                }
            }
            
            let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
            sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
            
            //        self.lbHotline.text = sessionInfo?.hotlineNo
            //        self.btnHotline.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickHotline)))
            UserDefaults.standard.set(0, forKey: Constants.UNREAD_MESSAGE_COUNT)
            self.tvMessagingView.register(UINib(nibName: CommonNames.MESG_MORE_BUTTON_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.MESG_MORE_BUTTON_TABLE_CELL)
            self.tvMessagingView.register(UINib(nibName: CommonNames.MESG_SENDER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.MESG_SENDER_TABLE_CELL)
            self.tvMessagingView.register(UINib(nibName: CommonNames.MESG_RECEIVER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.MESG_RECEIVER_TABLE_CELL)
            self.tvMessagingView.register(UINib(nibName: CommonNames.MESG_SEND_PHOTO_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.MESG_SEND_PHOTO_TABLE_CELL)
            self.tvMessagingView.dataSource = self
            self.tvMessagingView.delegate = self
            self.tfTypeMessage.delegate = self
            //self.tvMessagingView.estimatedRowHeight = CGFloat(200.0)
            self.tvMessagingView.rowHeight = UITableView.automaticDimension
            self.tvMessagingView.tableFooterView = UIView()
            self.orginBottom = vSendBottomConstraint.constant
            self.tvMessagingView.reloadData()
            // open the socket
            UserDefaults.standard.set(false, forKey: Constants.MESSAGE_SOCKET_CLOSE)
            self.btnSendImg.setTitle("messaging.send.button".localized, for: UIControl.State.normal)
            self.isDidLoad = true
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
        }
        
        @objc func onTapBack() {
            print("click")
            self.dismiss(animated: true, completion: nil)
        }
        @objc func onTapMMLocale() {
            print("click")
            super.NewupdateLocale(flag: 1)
            updateViews()
          mainLan = mmLan
           tvMessagingView.reloadData()
        }
        @objc func onTapEngLocale() {
            print("click")
            super.NewupdateLocale(flag: 2)
            updateViews()
       mainLan = engLan
            tvMessagingView.reloadData()
            
        }
 var buttonHasNoText: Bool = true
    @IBAction func menuBtnPress(_ sender: UIButton) {
        print(sender.isSelected)
       // sender.isSelected = !sender.isSelected
       if buttonHasNoText {
           menuHeight.constant = 271
           buttonHasNoText = false
       } else {
            menuHeight.constant = 0
           buttonHasNoText = true
       }
//        if sender.isSelected == false {
//             sender.isSelected = true
//             menuHeight.constant = 271
//           self.vSendBottomConstraint.constant = 0
//        }else{
//             self.vSendBottomConstraint.constant = 0
//            menuHeight.constant = 0
//            sender.isSelected = false
//        }
//        if sender.isSelected == false {
//            menuHeight.constant = 271
//        }
//        if sender.isSelected{
//            
//             menuHeight.constant = 271
//        }else{
//            menuHeight.constant = 0
//        }
    }
  
        func autoReplyMessage() {
             CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                          AutoReplyMessageModel.init().AutoReplyMessageSync(success: { (result) in
                            
                           self.mainLan = result.data.messageMya
                            self.mmLan = result.data.messageMya
                            self.engLan = result.data.messageEng
                            
                                        }) { (error) in
                                             print(error.localized)
                                        }
               self.tvMessagingView.reloadData()
             CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                      }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //super.free_chat_socket_url.send("unReadMessageList:")
    
            if tfTypeMessage.text!.isEmpty {
                sendBtnWidth.constant = 0
            }
            if self.isDidLoad {
                self.isDidLoad = false
                
            } else {
                let messageMenu = UserDefaults.standard.integer(forKey: Constants.MESSAGING_MENU)
                
                if messageMenu == 8 {
                    // change read_flag on DB
                    //CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                    var unreadArray = UserDefaults.standard.array(forKey: Constants.UNREAD_MESSAGE_ARRAY)  as? [Int] ?? [Int]()
                    if unreadArray.count > 0 {
                        for messageId in unreadArray {
                            //self.messagingSocket.send("ChangeReadFlagWithMsgId:\(messageId)")
                            super.free_chat_socket_url.write(string: "ChangeReadFlagWithMsgId:\(messageId)")
                            //                        print("socket:: change read flag")
                        }
                        unreadArray.removeAll()
                        UserDefaults.standard.set(unreadArray, forKey: Constants.UNREAD_MESSAGE_ARRAY)
                    }
                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    UserDefaults.standard.set(0, forKey: Constants.UNREAD_MESSAGE_COUNT)
                    
                    self.tvMessagingView.reloadData()
                    // reopen message socket
                    //self.connectChatServer()
                    
                } else if messageMenu == 11 {
                    // close message socket
                    UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
                    //self.messagingSocket.close()
                    super.free_chat_socket_url.disconnect()
                }
            }
        }
        
        @objc func onClickHotline(){
            //        self.lbHotline.text?.makeCall()
        }
        
        @IBAction func onClickSendImgBtn(_ sender: UIButton) {
            takePhoto(sender, imagePickerControllerDelegate: self)
        }
        
        @objc override func updateViews() {
            super.updateViews()
            self.btnSendImg.setTitle("messaging.send.button".localized, for: UIControl.State.normal)
        }
    
        // send message
        @IBAction func sendMessage(_ sender: UIButton) {
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                return
            }
            if self.tfTypeMessage.text != Constants.BLANK {
                //self.messagingSocket.send("msg:\(self.tfTypeMessage.text!)op_send_flag:0message_type:0")
                //self.messagingSocket.send("ChangeFinishFlagByMobile:\(self.senderName)")
                super.free_chat_socket_url.write(string: "msg:\(self.tfTypeMessage.text!)op_send_flag:0message_type:0")
                super.free_chat_socket_url.write(string: "ChangeFinishFlagByMobile:\(self.senderName)")
            }
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        }
        
        // Select image type
        func takePhoto(_ sender: UIButton, imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
            
            self.imagePicker?.presentMessageCamera(from: sender)
            
        }
        
        func openGallary(imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        {
            messageImagePicker.delegate = imagePickerControllerDelegate
            messageImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            messageImagePicker.allowsEditing = true
            messageImagePicker.modalPresentationStyle = .overFullScreen
            self.present(messageImagePicker, animated: true)
        }
        
        
        @objc override func keyboardWillChange(notification : Notification) {
            
            guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            
            if notification.name == UIResponder.keyboardWillShowNotification {
                self.vSendBottomConstraint.constant = keyboardReact.height
                self.tvMessagingView.scrollToRow(at: IndexPath(item: self.messageBeanList.count-1, section: 0), at: .bottom, animated: false)
            } else {
                self.vSendBottomConstraint.constant = orginBottom
            }
            print("bottom height : \(self.vSendBottomConstraint.constant)")
            
        }
        
        @objc func socketClose(){
            //self.messagingSocket.close()
            UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
            super.free_chat_socket_url.disconnect()
        }
    }

    // delegate with ImagePicker.swift
    extension FreeChatViewController: ImagePickerDelegate {
        
        func didSelect(image: UIImage?) {
            //self.imageView.image = image
            if image != nil {
                //            print("image is not null")
                
                CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                if var pickedImage = image {
                    
                    let jpegData = pickedImage.jpegData(compressionQuality: 1.0)
                    let jpegSize: Int = jpegData?.count ?? 0
                    print("original size of message image in KB: %f ", Double(jpegSize) / 1024.0)
                    print("original image width & height", pickedImage.size.width, pickedImage.size.height)
                    
                    //resize image
                    if jpegSize <= Constants.LOW_QUALITY_IMAGE_250 {
                        pickedImage = pickedImage.resizeWithPercent(percentage: 1.0)!
                        print("resize with percentage 1.0")
                        
                    } else if jpegSize > Constants.LOW_QUALITY_IMAGE_250 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_1000 {
                        pickedImage = pickedImage.resizeWithPercent(percentage: 0.8)!
                        print("resize with percentage 0.8")
                        
                    } else if jpegSize > Constants.HIGH_QUALITY_IMAGE_1000 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_1500 {
                        pickedImage = pickedImage.resizeWithPercent(percentage: 0.7)!
                        print("resize with percentage 0.7")
                        
                    } else if jpegSize > Constants.HIGH_QUALITY_IMAGE_1500 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_2000 {
                        pickedImage = pickedImage.resizeWithPercent(percentage: 0.4)!
                        print("resize with percentage 0.4")
                        
                    } else if jpegSize > Constants.HIGH_QUALITY_IMAGE_3000 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_5000 {
                        //pickedImage = pickedImage.resizeWithPercent(percentage: 0.3)!
                        pickedImage = pickedImage.resizeWithWidth(width: 700)!
                        print("resize with width 700")
                        
                    } else if jpegSize > Constants.HIGH_QUALITY_IMAGE_5000 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_6000 {
                        //pickedImage = pickedImage.resizeWithPercent(percentage: 0.2)!
                        pickedImage = pickedImage.resizeWithWidth(width: 650)!
                        print("resize with width 650")
                        
                    } else {
                        //pickedImage = pickedImage.resizeWithPercent(percentage: 0.1)!
                        pickedImage = pickedImage.resizeWithWidth(width: 600)!
                        print("resize with width 600")
                    }
                    let rejpegData = pickedImage.jpegData(compressionQuality: 1.0)
                    let rejpegSize: Int = rejpegData?.count ?? 0
                    print("resize size of message image in KB: %f ", Double(rejpegSize) / 1024.0)
                    print("resize image width & height", pickedImage.size.width, pickedImage.size.height)
                    
                    let imageData:NSData = pickedImage.pngData()! as NSData
                    let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                    
                    //self.messagingSocket.send("msg:\(strBase64)op_send_flag:0message_type:1")
                    //self.messagingSocket.send("ChangeFinishFlagByMobile:\(self.senderName)")
                    //print("socket image :::::::\(strBase64)")
                    super.free_chat_socket_url.write(string: "msg:\(strBase64)op_send_flag:0message_type:1")
                    super.free_chat_socket_url.write(string: "ChangeFinishFlagByMobile:\(self.senderName)")
                    
                }
            }
            //CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)

        }
    }

    extension FreeChatViewController : WebSocketDelegate {
        
        func webSocketOpen() {
            print("message socket opened")
            super.free_chat_socket_url.write(string: "userName:\(self.senderName)userId:\(self.senderId)")
            super.free_chat_socket_url.write(string: "cr:\(self.senderName)or:userWithAgency:")
            
        }
        
        func webSocketClose(_ code: Int, reason: String, wasClean: Bool) {
            //        print("message socket close", reason)
            let isClose = UserDefaults.standard.bool(forKey: Constants.MESSAGE_SOCKET_CLOSE)
            if isClose {
                super.free_chat_socket_url.disconnect()
                //            print("messaging socket close permenant")
                
            } else {
                self.webSocketOpen()
            }
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        }
        
        func webSocketError(_ error: NSError) {
            print("message socket error \(error)")
            
            let isClose = UserDefaults.standard.bool(forKey: Constants.MESSAGE_SOCKET_CLOSE)
            if isClose {
                super.free_chat_socket_url.disconnect()
                //print("message socket close permenant")
                
            } else {
                super.free_chat_socket_url.connect()
            }
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        }
        
        func websocketDidConnect(socket: WebSocketClient) {
            //        print("socket did connect")
            //        print("socket opened")
            super.free_chat_socket_url.write(string: "userName:\(self.senderName)userId:\(self.senderId)")
            super.free_chat_socket_url.write(string: "cr:\(self.senderName)or:userWithAgency:")
            
        }
        
        func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
            //        print("message socket did disconnect")
            print("message socket disconnect \(String(describing: error))")
            
            let isClose = UserDefaults.standard.bool(forKey: Constants.MESSAGE_SOCKET_CLOSE)
            if isClose {
                super.free_chat_socket_url.disconnect()
                print("message socket close permenant")
                
            } else {
                super.free_chat_socket_url.connect()
            }
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        }
        
        func websocketDidReceiveMessage(socket: WebSocketClient, text : String) {
            print("socket onMessage \(text)")
            
            if let text = text as? String {
                //print("recv: \(text)")
                do{
                    if let json = text.data(using: String.Encoding.utf8){
                        if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                            
                            let type = jsonData["type"] as! String
                            //print("type", type)
                            typeLists = type
                            if (type == "message"){
                                
                                CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                                
                                let messageMenu = UserDefaults.standard.integer(forKey: Constants.MESSAGING_MENU)
                                
                                if messageMenu == 11 {
                                    UserDefaults.standard.set(true, forKey: Constants.MESSAGE_SOCKET_CLOSE)
                                    super.free_chat_socket_url.disconnect()
                                    return
                                }
                                // retrieve unread message list
                                var unreadArray = UserDefaults.standard.array(forKey: Constants.UNREAD_MESSAGE_ARRAY)  as? [Int] ?? [Int]()
                                
                                // if someone is send a message
                                let data = jsonData["data"] as! NSObject
                                //print("message_type", data.value(forKey: "message_type") as! String)
                                
                                var messageBean = MessageBean()
                                messageBean.message = data.value(forKey: "text") as? String
                                messageBean.sendTime = super.generateCurrentTimeForMessage()
                                //print("type = message : messageBean.sendtime \(messageBean.sendTime)")
                                // if message is image
                                if (data.value(forKey: "message_type") as! String == "1"){
                                    
                                    messageBean.isPhoto = true
                                    messageBean.isReceiveMesg = false
                                    
                                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                                } else {
                                    
                                    // add array size
                                    messageBean.isPhoto = false
                                    
                                    // if message is sent from operator
                                    if(data.value(forKey: "op_send_flag") as! String == "1"){
                                        messageBean.isReceiveMesg = true
                                        
                                        //check if segment is message
                                        if messageMenu == 8 {
                                            super.free_chat_socket_url.write(string: "ChangeReadFlagWithMsgId:\((data.value(forKey: "message_id") as? Int)!)")
                                        } else {
                                            unreadArray.append((data.value(forKey: "message_id") as? Int)!)
                                            UserDefaults.standard.set(unreadArray, forKey: Constants.UNREAD_MESSAGE_ARRAY)
                                            UserDefaults.standard.set(0, forKey: Constants.UNREAD_MESSAGE_COUNT)
                                        }
                                    } else {
                                        messageBean.isReceiveMesg = false
                                    }
                                    self.tfTypeMessage.text = Constants.BLANK
                                }
                                
                                self.messageBeanList.append(messageBean)
                                self.tvMessagingView.beginUpdates()
                                let indexPath:IndexPath = IndexPath(row: self.messageBeanList.count-1, section: 0)
                                self.tvMessagingView.insertRows(at: [indexPath], with: .automatic)
                                self.tvMessagingView.endUpdates()
                                self.tvMessagingView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                                
                                // clear unread message array
                            }
                            else if (type == "mobileOldMessage") {
                                
                                CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                                
                                if let content = jsonData["data"] as? NSArray {
                                    //print("more message list array size :", content.count)
                                    
                                   
                                    
                                    if (content.count > 0){
                                        
                                        var unreadArray = UserDefaults.standard.array(forKey: Constants.UNREAD_MESSAGE_ARRAY)  as? [Int] ?? [Int]()
                                        
                                        if unreadArray.count > 0 {
                                            unreadArray.removeAll()
                                        }
                                        
                                        if content.count == content.count {
                                            var messageBean = MessageBean()
                                            messageBean.isButton = true
                                            messageBean.messageId = (content[content.count - 1] as AnyObject).value(forKey: "message_id") as? Int
                                            
                                            //print("latest index ::", messageBean.messageId!)
                                            oldMessageBeanList.append(messageBean)
                                            
                                        }
                                        for index in stride(from: content.count-1, through: 0, by: -1) {
                                            print(content[index])
                                            
                                            var messageBean = MessageBean()
                                            
                                            messageBean.message = (content[index] as AnyObject).value(forKey: "text") as? String
                                            messageBean.sendTime = Utils.changeOldMesgDateformat(date: (content[index] as AnyObject).value(forKey: "time") as! String)
                                            //print("type = mobile old msg : messageBean.sendtime \(messageBean.sendTime)")
                                            messageBean.sender = "AEON"
                                            if 1 == (content[index] as AnyObject).value(forKey: "message_type") as? Int {
                                                messageBean.isPhoto = true
                                            } else {
                                                messageBean.isPhoto = false
                                            }
                                            if 1 == (content[index] as AnyObject).value(forKey: "op_send_flag") as? Int {
                                                messageBean.isReceiveMesg = true
                                                
                                            } else {
                                                messageBean.isReceiveMesg = false
                                            }
                                             
                                            oldMessageBeanList.append(messageBean)
                                            
                                        }
                                        //print("unread message list array size :", unreadArray.count)
                                        
                                        UserDefaults.standard.set(unreadArray, forKey: Constants.UNREAD_MESSAGE_ARRAY)
                                        
                                    } else {
//                                        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
//                                        let cell = self.tvMessagingView.cellForRow(at: indexPath) as? MoreButtonTableViewCell
//                                        cell?.btnMoreButton.setTitle("No more messages", for: UIControl.State.normal)
//                                        cell?.btnMoreButton.isUserInteractionEnabled = false
                                        
                                    }
//                                   self.messageBeanList.remove(at: 0)
                                   
                                   
                                    
                                    //  self.messageBeanList.append(contentsOf: oldMessageBeanList)
                              
                                    self.messageBeanList.insert(contentsOf: oldMessageBeanList, at: 1)
                               
                                   self.tvMessagingView.reloadData()
                                   
                                   
                                    
                                }
                                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
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
        
    }

    extension FreeChatViewController:UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //print("count", self.messageBeanList.count)
            return self.messageBeanList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var messageData = self.messageBeanList[indexPath.row]
            
            if messageData.isButton {
                let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.MESG_MORE_BUTTON_TABLE_CELL, for: indexPath) as! MoreButtonTableViewCell
                cell.setData(messageId: messageData.messageId!)
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
                
            } else if (messageData.isPhoto){
                let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.MESG_SEND_PHOTO_TABLE_CELL, for: indexPath) as! SendPhotoTableViewCell
               
                cell.setData(messageBean: messageData)
                cell.selectionStyle = .none
                return cell
                
            } else if (!messageData.isReceiveMesg) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.MESG_SENDER_TABLE_CELL, for: indexPath) as! MesgSenderTableViewCell
                
                cell.setData(messageBean: messageData)
                cell.selectionStyle = .none
                return cell
                
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.MESG_RECEIVER_TABLE_CELL, for: indexPath) as! MesgReceiverTableViewCell
            
            if indexPath.row == 0 {
                 messageData.message = mainLan
                 cell.setData(messageBean: messageData)
            }else{
                cell.setData(messageBean: messageData)
            }
            
            
            cell.selectionStyle = .none
            
            return cell
        }
        
    }

    extension FreeChatViewController:UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          //  tableView.deselectRow(at: indexPath, animated: true)
            if #available(iOS 13.0, *) {
                let messageData = self.messageBeanList[indexPath.row]
                guard let message = messageData.message else { return  }
                if (messageData.isPhoto){
                   // let fileUrl = URL(string: messageData.message!)
                    let vc = storyboard?.instantiateViewController(withIdentifier: "FreechatImageDetailViewController") as? FreechatImageDetailViewController
                    vc?.urlString = message
                    
                    vc?.modalPresentationStyle = .overFullScreen
                    self.present(vc!, animated: true, completion: nil)
                }
               
            } else {
                // Fallback on earlier versions
               
            }
           
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            let messageData = self.messageBeanList[indexPath.row]
            if (messageData.isPhoto){
                return CGFloat(370.0)
            } else if messageData.isButton {
                return CGFloat(50.0)
                
            }   else {
                return UITableView.automaticDimension
            }
        }
    }

    extension FreeChatViewController : MoreMessageDelegate {
        func onClickMoreMesg(messageId: Int) {
            super.free_chat_socket_url.write(string: "mobile_old_msgid:\(messageId)room:\(self.senderName)")
        }
    }
