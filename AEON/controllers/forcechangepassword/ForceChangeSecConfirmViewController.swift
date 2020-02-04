//
//  ForceChangeSecConfirmViewController.swift
//  AEONVCS
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit

class ForceChangeSecConfirmViewController: BaseUIViewController {
    
    @IBOutlet weak var bbClose: UIBarButtonItem!
    @IBOutlet weak var bbFlag: UIBarButtonItem!
    
    @IBOutlet weak var tvSecQuesView: UITableView!
    
    var secQuesList = [SecQuesListBean]()
    var numOfQuestion = 0
    var numOfAnsChar = 0
    var userSecQuesConfirmBean = UserSecQuesConfirmBean()
    var secQMy = [String]()
    var secQEng = [String]()
    var questionList = [String]()
    var registerCells: [SecQuesRegisterTableViewCell]!
    var phoneNoLabel:String = ""
    var selectedQues = [Int]()
    
    var phoneNo:String?
    var nrcNo:String?
    var hotlinePhone:String?
    var custQuesCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSecurityQuestionLIst()
        
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        
        self.tvSecQuesView.register(UINib(nibName: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL)
        self.tvSecQuesView.register(UINib(nibName: CommonNames.SEC_QUEST_REGISTER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_REGISTER_TABLE_CELL)
        self.tvSecQuesView.register(UINib(nibName: CommonNames.FORGET_CONFIRM_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.FORGET_CONFIRM_TABLE_CELL)
        
        //open thid comment in real
        self.tvSecQuesView.dataSource = self
        self.tvSecQuesView.delegate = self
        self.tvSecQuesView.tableFooterView = UIView()
        
        switch Locale.currentLocale {
        case .EN:
            bbFlag.image = UIImage(named: "mm_flag")
            self.questionList = self.secQEng
        case .MY:
            bbFlag.image = UIImage(named: "en_flag")
            self.questionList = self.secQMy
        }
        
    }
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
        self.tvSecQuesView.reloadData()
    }
    @IBAction func onClickBackBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadSecurityQuestionLIst(){
        
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesRegisterViewModel.init().getSecQuesList(siteActivationKey: Constants.site_activation_key, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.numOfQuestion = self.custQuesCount!
            self.numOfAnsChar = result.numOfAnsCount
            self.secQEng = result.questionList[1]
            self.secQMy = result.questionList[0]
            self.secQuesList = result.secQuesList
            switch Locale.currentLocale {
            case .EN:
                self.questionList = self.secQEng
            case .MY:
                self.questionList = self.secQMy
            }
            self.registerCells = [SecQuesRegisterTableViewCell](repeating: SecQuesRegisterTableViewCell(), count: self.numOfQuestion)
        
            self.tvSecQuesView.reloadData()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: Constants.CONFIRM_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.LOGIN_VIEW_CONTROLLER) as! UINavigationController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }

    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbFlag.image = UIImage(named: "mm_flag")
            self.questionList = self.secQEng
        case .MY:
            bbFlag.image = UIImage(named: "en_flag")
            self.questionList = self.secQMy
        }
        
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            tvSecQuesView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            tvSecQuesView.contentInset = UIEdgeInsets.zero
            
        }
        
        tvSecQuesView.scrollIndicatorInsets = tvSecQuesView.contentInset
        
    }
    
}

extension ForceChangeSecConfirmViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.numOfQuestion
            //return self.custQuesCount!
            
        }else if section == 2{
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, for: indexPath) as! SecQuesRegHeaderTableViewCell
            cell.selectionStyle = .none
            cell.lblHeader.text = "secquestconfirm.title".localized
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_REGISTER_TABLE_CELL, for: indexPath) as! SecQuesRegisterTableViewCell
            cell.selectionStyle = .none
            cell.setData(data: self.questionList,answerCount:self.numOfAnsChar, row: indexPath.row)
            if  cell.lblSecQuestion.text == Constants.BLANK {
                cell.lblSecQuestion.text = self.questionList[0]
                self.selectedQues.append(0)
                
            } else {
                cell.lblSecQuestion.text = self.questionList[self.selectedQues[indexPath.row]]
            }
            cell.lblQuesNo.text = "Q\(indexPath.row+1):"
            cell.lblAnsNo.text = "Ans\(indexPath.row+1):"
            
            cell.cellClickDelegate = self
            cell.lbMessage.text = cell.answerMesgLocale?.localized
            self.registerCells[indexPath.row] = cell
            if indexPath.row == 0 {
                DispatchQueue.main.async {
                    cell.tfsecAnswer.becomeFirstResponder()
                }
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.FORGET_CONFIRM_TABLE_CELL, for: indexPath) as! ForgetConfirmTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.btnConfirm.setTitle("secquestconfirm.confrim.button".localized, for: UIControl.State.normal)
        cell.btnCallNow.setTitle("verify.callnow.button".localized, for: UIControl.State.normal)
        return cell
        
    }
}

extension ForceChangeSecConfirmViewController:SecQuesRegisterCellClickDelegate{
    func onClickSecQuesList(quesList: [String],cell:SecQuesRegisterTableViewCell, row: Int) {
        
//        // focus on answer textfield
//        DispatchQueue.main.async {
//            cell.tfsecAnswer.becomeFirstResponder()
//        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: quesList, action: { (value)  in
                cell.lblSecQuestion.text = value
                if let selectedIndex = quesList.firstIndex(of: value){
                    self.selectedQues[row] = selectedIndex
                    //print("select index = \(selectedIndex)")
                }
                // focus on answer textfield
                DispatchQueue.main.async {
                    cell.tfsecAnswer.becomeFirstResponder()
                }
                print(value)
            })
            //Present the controller
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = cell.lblSecQuestion
            }
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: quesList, action: { (value)  in
                cell.lblSecQuestion.text = value
                if let selectedIndex = quesList.firstIndex(of: value){
                    self.selectedQues[row] = selectedIndex
                    //print("select index = \(selectedIndex)")
                }
                // focus on answer textfield
                DispatchQueue.main.async {
                    cell.tfsecAnswer.becomeFirstResponder()
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            self.present(action, animated: true, completion: nil)
        }
    }
}

extension ForceChangeSecConfirmViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(70.0)
            
        } else if indexPath.section == 1{
            return CGFloat(160.0)
            
        }
        return CGFloat(60.0)
    }
}

extension ForceChangeSecConfirmViewController : ForgetConfirmDelegate {
    
    func onClickCallNow() {
        self.hotlinePhone!.makeCall()
    }
    
    func onClickConfirm(cell: ForgetConfirmTableViewCell) {
       
        var secIdList:[Int] = []
        var qaList = [UserQABean]()
        var selectedQuestionId : Int = 0
        
        //var i = 0
        var isError: Bool = false
        //while i < secQuesTableView.numberOfRows(inSection: 0){
        print("cell count :::\(registerCells.count)")
        for i in 0..<registerCells.count {
            //let indexPath = IndexPath(row: i, section: 0)
            //let sqCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesRegisterTableViewCell
            let sqCell = registerCells[i]
            if sqCell.tfsecAnswer.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                sqCell.tfsecAnswer.text = Constants.BLANK
                sqCell.lbMessage.text = Messages.ANSWER_EMPTY_ERROR.localized
                sqCell.answerMesgLocale = Messages.ANSWER_EMPTY_ERROR
                isError = true
                
            } else {
                sqCell.lbMessage.text = Constants.BLANK
                sqCell.answerMesgLocale = Constants.BLANK
            }
            let ans = sqCell.tfsecAnswer.text!
            let que = sqCell.lblSecQuestion.text!
            if let selectedIndex = questionList.firstIndex(of: "\(sqCell.lblSecQuestion.text!)"){
                selectedQuestionId = secQuesList[selectedIndex].secQuestionId!
                qaList.append(UserQABean(secQuesId: selectedQuestionId,question: que,answer: ans))
            }
            
            if i != 0 {
                if secIdList.contains(selectedQuestionId) {
                    if sqCell.lbMessage.text?.isEmpty ?? true {
                        sqCell.lbMessage.text = Messages.QUESTION_SAME_ERROR.localized
                        sqCell.answerMesgLocale = Messages.QUESTION_SAME_ERROR
                        isError = true
                    }
                }
//                else {
//                    sqCell.lbMessage.text = Constants.BLANK
//                    sqCell.answerMesgLocale = Constants.BLANK
//                }
            }
            secIdList.append(selectedQuestionId)
            
        }
        
        if isError {
            return
        }
        
        //print("Phone No \(String(describing: self.phoneNo))")
        //print("NRC \(String(describing: self.nrcNo))")
        
        userSecQuesConfirmBean.phoneNo = self.phoneNo!
        userSecQuesConfirmBean.nrcData = self.nrcNo!
        userSecQuesConfirmBean.quesAnsBean = qaList
        
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesConfirmViewModel.init().makeConfirm(userConfirmBean: userSecQuesConfirmBean, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            print(result)
            if result.statusCode == Constants.INVALID_CUSTOMER_ANSWER {
                Utils.showAlert(viewcontroller: self, title: Constants.CONFIRM_ERROR_TITLE, message: Messages.QUES_AND_ANSWER_WRONG_ERROR.localized)
                
            } else if result.statusCode == Constants.NOT_EXIST_CUSTOMER_INFO {
                Utils.showAlert(viewcontroller: self, title: Constants.CONFIRM_ERROR_TITLE, message: Messages.NRC_OR_PHONE_INVALID_ERROR.localized)
                
            } else {
                
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.RESET_PASSWORD_VIEW_CONTROLLER) as! UINavigationController
                let vc = navigationVC.children.first as! ResetPasswordViewController
                vc.customerId = result.customerId
                vc.userTypeId = result.userTypeId
                vc.phoneNo = self.phoneNo!
                vc.isAppLock = false
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            }
        }) { (error) in
            // Service error
            if error == Constants.SERVER_FAILURE {
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.CONFIRM_ERROR_TITLE, message: error)
            }
        }
    }
}

