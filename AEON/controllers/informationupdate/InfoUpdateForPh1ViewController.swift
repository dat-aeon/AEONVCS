//
//  InfoUpdateForPh1ViewController.swift
//  AEONVCS
//
//  Created by mac on 4/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class InfoUpdateForPh1ViewController: BaseUIViewController {
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    
    @IBOutlet weak var tvSecurityQuestionUpdate: UITableView!
    
    var userQAList:[UserQAList] = []
    var answerCount: Int = 0
    var customerId:Int = 0
    var tokenInfo: TokenData?
    var updateCells:[SecurityQuestionTableViewCell]!
    
    var isDidLoad = false
    var isFirstAppear : Bool?
    var isViewAppear = false
    
    override func viewDidLoad() {
//        print("Start SecurityQuestionUpdateViewController :::::::::::::::")
        super.viewDidLoad()
        
        self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
               self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        self.userQAList = []
        self.isDidLoad = true
        self.isFirstAppear = true
        self.isViewAppear = false
        
        self.reloadSecQuesUpdateList()
        
        self.tvSecurityQuestionUpdate.register(UINib(nibName: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL)
        
        self.tvSecurityQuestionUpdate.register(UINib(nibName: CommonNames.SECURITY_QUESTION_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SECURITY_QUESTION_TABLE_CELL)
        
        self.tvSecurityQuestionUpdate.register(UINib(nibName: CommonNames.SECURITY_QUESTION_UPDATE_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SECURITY_QUESTION_UPDATE_TABLE_CELL)
        
        self.tvSecurityQuestionUpdate.dataSource = self
        self.tvSecurityQuestionUpdate.delegate = self
        self.tvSecurityQuestionUpdate.tableFooterView = UIView()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isDidLoad {
            self.isDidLoad = false
        } else {
            let messageMenu = UserDefaults.standard.integer(forKey: Constants.MESSAGING_MENU)
            
            if messageMenu == 3 {
                self.isViewAppear = true
                self.reloadSecQuesUpdateList()
            }
        }
    }
    
    func reloadSecQuesUpdateList() {
        
        self.customerId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        UpdateInfoViewModel.init().loadUserQAList(customerId: "\(customerId)", token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!,success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.userQAList = (result.data?.secQAUpdateInfoResDtoList)!
            self.answerCount = result.data?.numOfAnsChar ?? 0
            self.updateCells = [SecurityQuestionTableViewCell](repeating: SecurityQuestionTableViewCell(), count: self.userQAList.count)
            self.tvSecurityQuestionUpdate.reloadData()
            
            //print("User QA list \(self.userQAList.count)")
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }
        
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.tvSecurityQuestionUpdate.reloadData()
        
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            tvSecurityQuestionUpdate.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            tvSecurityQuestionUpdate.contentInset = UIEdgeInsets.zero
            
        }
        tvSecurityQuestionUpdate.scrollIndicatorInsets = tvSecurityQuestionUpdate.contentInset
        
    }
    
}
extension InfoUpdateForPh1ViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 2 {
            return 1
        }
        return self.userQAList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, for: indexPath) as! SecQuesRegHeaderTableViewCell
            cell.selectionStyle = .none
            cell.lblHeader.text = "infoupdate.tag1.title".localized
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SECURITY_QUESTION_TABLE_CELL, for: indexPath) as! SecurityQuestionTableViewCell
            cell.selectionStyle = .none
            
            if self.isViewAppear {
                cell.tfAnswer.text = Constants.BLANK
                cell.lbMessage.text = Constants.BLANK
                cell.answerMesgLocale = Constants.BLANK
                cell.tfAnswer.isSecureTextEntry = true
                cell.imgVisibleIcon.image = UIImage(named: "visible-icon")
                
            }
            cell.setData(data: self.userQAList[indexPath.row] , err_message: cell.answerMesgLocale ?? Constants.BLANK , answerCount: self.answerCount)
            
            cell.lbQuesNo.text = "Q\(indexPath.row + 1):"
            cell.lbAnsNo.text = "Ans\(indexPath.row + 1):"
            
            if(self.isFirstAppear! || self.isViewAppear) {
                cell.tfAnswer.text = self.userQAList[indexPath.row].answer!
                cell.tfAnswer.isSecureTextEntry = true
                
            }
            updateCells[indexPath.row] = cell
            cell.tfAnswer.delegate = self
            
            if indexPath.row + 1 == userQAList.count {
                self.isFirstAppear = false
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SECURITY_QUESTION_UPDATE_TABLE_CELL, for: indexPath) as! SecurityQuestionUpdateTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.tfPassword.setMaxLength(maxLength: 16)
        cell.btnUpdate.setTitle("infoupate.update.button".localized, for: UIButton.State.normal)
        if self.isViewAppear {
            cell.tfPassword.text = Constants.BLANK
            cell.lbMessage.text = Constants.BLANK
            cell.tfPassword.isSecureTextEntry = true
            cell.ivPasswordVisible.image = UIImage(named: "visible-icon")
            
        } else {
            cell.lbMessage.text = cell.messageLocale?.localized
        }
        self.isViewAppear = false
        return cell
    }
    
    func replaceAnswerWithStar(answer :String) -> String{
        let str = answer
        if str.count > 1{
            let first = String(str.first!)
            let replaceStr = String(repeating: ("*" as Character), count: str.count-1)

            let newString = first + replaceStr
            return newString
            
        } else {
            return str
        }
        
    }
}

extension InfoUpdateForPh1ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(70.0)
            
        } else if indexPath.section == 1{
            return CGFloat(150.0)
        }
        return CGFloat(150.0)
    }
}

extension InfoUpdateForPh1ViewController:SecurityQuestionUpdateDelegate{
    func onClickUpdateButton(cell: SecurityQuestionUpdateTableViewCell) {
        
        var isError = false
        
        var answerList = [String]()
        var qaList = [UpdateUserQABean]()
        //for i in 0..<tvSecurityQuestionUpdate.numberOfRows(inSection: 0){
        for i in 0..<updateCells.count {
            //                let indexPath = IndexPath(row: i, section: 0)
            //                let cell = tvSecurityQuestionUpdate.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
            let qcell = updateCells[i]
            if (qcell.tfAnswer.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true) {
                qcell.tfAnswer.text = Constants.BLANK
                qcell.lbMessage.text = Messages.ANSWER_EMPTY_ERROR.localized
                qcell.answerMesgLocale = Messages.ANSWER_EMPTY_ERROR
                isError = true
                
            } else if !Utils.isAnswerValidate(name: qcell.tfAnswer.text!){
                qcell.lbMessage.text = Messages.ANSWER_FORMAT_ERROR.localized
                qcell.answerMesgLocale = Messages.ANSWER_FORMAT_ERROR
                isError = true
                
            } else if (self.userQAList[i].answer != qcell.tfAnswer.text!) && (qcell.tfAnswer.text?.count)! > self.answerCount{
                switch Locale.currentLocale {
                case .EN:
                    qcell.lbMessage.text = Messages.ANSWER_LENGTH_ERROR.localized + "\(self.answerCount)" + "."
                    qcell.answerMesgLocale = Messages.ANSWER_LENGTH_ERROR
                case .MY:
                    qcell.lbMessage.text = Messages.ANSWER_LENGTH_ERROR.localized + "\(self.answerCount)" + Messages.ANSWER_LENGTH_ERROR_MM.localized
                    qcell.answerMesgLocale = Messages.ANSWER_LENGTH_ERROR
                }
                isError = true
                
            } else {
                //print("\(self.userQAList.count) + \(updateCells.count)")
                qcell.lbMessage.text = Constants.BLANK
                qcell.answerMesgLocale = Constants.BLANK
                let answer = qcell.tfAnswer.text
                let cusQuesId = self.userQAList[i].custSecQuesId!
                let quesId = self.userQAList[i].secQuesId!
                answerList.append(answer!)
                qaList.append(UpdateUserQABean(custSecQuesId :"\(cusQuesId)", answer: answer!, secQuesId: "\(quesId)"))
            }
        }
        
        if (cell.tfPassword.text?.isEmpty)!{
            cell.lbMessage.text = Messages.PASSWORD_EMPTY_ERROR.localized
            cell.messageLocale = Messages.PASSWORD_EMPTY_ERROR
            isError = true
        } else {
            cell.lbMessage.text = Constants.BLANK
            cell.messageLocale = Constants.BLANK
        }
        
        if isError {
            return
        }

        let updUserBean = UpdateUserBean(customerId: "\( self.customerId)", password: cell.tfPassword.text!, securityQAUpdateInfo: qaList)
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        UpdateInfoViewModel.init().updateUserQAList(updateUserQABean: updUserBean, token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if result == Constants.STATUS_200 {
                cell.tfPassword.text = Constants.BLANK
                Utils.showAlert(viewcontroller: self, title: "Update Success", message: Messages.UPDATE_INFO_SUCCESS.localized)
                
            } else {
                cell.tfPassword.text = Constants.BLANK
                Utils.showAlert(viewcontroller: self, title: "Update Failed", message: Messages.INCORRECT_PASSWORD_ERROR.localized)
            }
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            //Utils.showAlert(viewcontroller: self, title: "Failed", message: error)
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }
        
    }
}
