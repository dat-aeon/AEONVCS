//
//  ChatBotTableViewCell.swift
//  AEONVCS
//
//  Created by Ant on 16/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit
import Alamofire

protocol QuestionAndAnswerIdDelegate {
    func questionAndAnswerId(id: Int,question: String,answer: String)
}
protocol QuestionDelegate {
    func questionData(question: String)
}
class ChatBotTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    var delegate: QuestionAndAnswerIdDelegate?
    var questionDelegate: QuestionDelegate?
    @IBOutlet weak var chatCollectionView: UICollectionView!
    @IBOutlet weak var readmoreLabel: UILabel!
    @IBOutlet weak var viewsBorder: UIView!
    
    @IBOutlet weak var readmoreView: UIView!
    var chatBot = [ChatBotInfo]()
    var chatBotmm = [ChatBotInfo]()
    var chatBotList: [ChatBotInfo] = []
    var chatBotId = 0
    var chatBotMM = [ChatBotMMInfo]()
    var chatBotMMList: [ChatBotMMInfo] = []
    let mmFlag = "my_MM"
    let engFlag = "en"
    var language = Locale.currentLocale
    @objc func readmores(){
        print("readmor")
        let collectionBounds = self.chatCollectionView.bounds
                let contentOffset = CGFloat(floor(self.chatCollectionView.contentOffset.x + collectionBounds.size.width))
                self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    func moveCollectionToFrame(contentOffset : CGFloat) {

            let frame: CGRect = CGRect(x : contentOffset ,y : self.chatCollectionView.contentOffset.y ,width : self.chatCollectionView.frame.width,height : self.chatCollectionView.frame.height)
            self.chatCollectionView.scrollRectToVisible(frame, animated: true)
        }
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.readmoreView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(readmores)))
        let yourColor : UIColor = UIColor( red: 0.7, green: 0.3, blue:0.1, alpha: 1.0 )
        viewsBorder.layer.masksToBounds = true
        viewsBorder.layer.borderColor = yourColor.cgColor
        viewsBorder.layer.borderWidth = 1.0
       // CustomLoadingView.shared().showActivityIndicator(uiView: self.contentView)
        NotificationCenter.default.addObserver(self, selector: #selector(callmm), name: NSNotification.Name("callMM"), object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(calleng), name: NSNotification.Name("callENG"), object:nil)
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        self.chatCollectionView.register(UINib(nibName: CommonNames.MESG_COLLECTIONCELL_CHAT_BOT, bundle: nil), forCellWithReuseIdentifier: CommonNames.MESG_COLLECTIONCELL_CHAT_BOT)
       
       
        if mmFlag == language.rawValue{
            DispatchQueue.main.async {
                self.getchatBotMM()
            }
           
        }else if engFlag == language.rawValue{
            DispatchQueue.main.async {
                self.getchatBotEng()
            }
        }
     
      
    }
    @objc func callmm(){
       getchatBotMM()
    }
    @objc func calleng(){
       getchatBotEng()
    }
    func getchatBotMM(){
      
        GetChatBotMMViewModel.init().getChatBotSync(type: 1, success: { (result) in
         
                var questionId:Int = 0
                self.chatBot = result
                self.chatBotList = result
                
                for i in self.chatBotList {
                     questionId = i.chatBotQuestionAndAnswerId
                }
                self.chatCollectionView.reloadData()
               
            
           

        }) { (error) in
            print(error.localized)
        }
       
    }
    func getchatBotEng(){
      
        GetChatBotViewModel.init().getChatBotSync(type: 1, success: { (result) in
                
          
            self.chatBot = result
            self.chatBotList = result
            print(self.chatBotList)
            self.chatCollectionView.reloadData()
           
            
        }) { (error) in
            print(error.localized)
        }
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatBotList.count
       // return 10
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = chatBotList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatBotCollectionViewCell", for: indexPath) as! chatBotCollectionViewCell
       let editButton = cell.questionBtnLabel
        //let editButton = UIButton(frame: CGRect(x: 23, y: 55, width: 80, height: 35))
        
        
//        
//        editButton.translatesAutoresizingMaskIntoConstraints = false
//           let horizontalConstraint = editButton.centerXAnchor.constraint(equalTo: editButton.centerXAnchor)
//           let verticalConstraint = editButton.centerYAnchor.constraint(equalTo: editButton.centerYAnchor)
//           let widthConstraint = editButton.widthAnchor.constraint(equalToConstant: 100)
//           let heightConstraint = editButton.heightAnchor.constraint(equalToConstant: 100)
//           NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        //editButton.setTitle("\(indexPath.row)", for: .normal)
        editButton?.imageView?.contentMode = .scaleAspectFit
        editButton?.setTitle("message.ask".localized, for: UIControl.State.normal)
        editButton?.backgroundColor = UIColor.white
        editButton?.addTarget(self, action: #selector(editbutton(sender:)), for: UIControl.Event.touchUpInside)
     //   cell.addSubview(editButton ?? <#default value#>)
        editButton?.tag = indexPath.row
        cell.setData(chatBotInfor: data)
        readmoreLabel.text = "chatbot.readmore.label".localized
        
        return cell
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 5
        layout?.minimumInteritemSpacing = 5
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
        if UIDevice.current.userInterfaceIdiom == .pad {
            let size = CGSize(width:(collectionView.bounds.width-5)/1.8, height: 220)
            layout?.itemSize = size
            return size
        }else{
            let size = CGSize(width:(collectionView.bounds.width-5)/1.8, height: 155)
            layout?.itemSize = size
            return size
        }
       
        
    }
    let customerId = UserDefaults.standard.integer(forKey: Constants.FREECUS_INFO_ID)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let questions = chatBotList[indexPath.row].question
        
        questionDelegate?.questionData(question: questions)
//        print(indexPath.row)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatBotCollectionViewCell", for: indexPath) as! chatBotCollectionViewCell
//        cell.questionBtnLabel.tag = indexPath.row
//         chatBotId = chatBotList[indexPath.row].chatBotQuestionAndAnswerId
//        delegate?.questionAndAnswerId(id: chatBotId, question: chatBotList[indexPath.row].question, answer: chatBotList[indexPath.row].answer)
//
//        SendChatQuestionModel.init().sendChatQuestion(customerId: customerId, chatBotQuestionAndAnswerId: chatBotId, question: chatBotList[indexPath.row].question, answer: chatBotList[indexPath.row].answer) { (result) in
//            print(result)
//            //self.tvMessagingView.reloadData()
//        } failure: { (error) in
//            print(error)
//        }
//
        
        
        
    }
    var button = 0
    var ans = ""
    var que = ""
    @objc func editbutton(sender:UIButton){
        let chat = chatBotList
        button = sender.tag
        let newId = chat[button].chatBotQuestionAndAnswerId
        let ques = chat[button].question
        let answ = chat[button].answer
        
        delegate?.questionAndAnswerId(id: newId, question: ques, answer: answ)
        SendChatQuestionModel.init().sendChatQuestion(customerId: customerId, chatBotQuestionAndAnswerId: newId, question: ques, answer: answ) { (result) in
            //print(result)
            //self.tvMessagingView.reloadData()
        } failure: { (error) in
            //print(error)
        }
    }
    
}
