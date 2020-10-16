//
//  SecurityQuestionUpdateViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecurityQuestionUpdateViewController: BaseUIViewController {

    @IBOutlet weak var tvSecurityQuestionUpdate: UITableView!
    
    var userQAList:[UserQAList] = []
    var customerId:Int = 0
    var tokenInfo : TokenData?
    var updateCells:[SecurityQuestionTableViewCell]!
     var logoutTimer: Timer?
    override func viewDidLoad() {
//        print("Start SecurityQuestionUpdateViewController :::::::::::::::")
        super.viewDidLoad()
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
      //  logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.tvSecurityQuestionUpdate.register(UINib(nibName: CommonNames.SECURITY_QUESTION_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SECURITY_QUESTION_TABLE_CELL)
        
        self.tvSecurityQuestionUpdate.register(UINib(nibName: CommonNames.SECURITY_QUESTION_UPDATE_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SECURITY_QUESTION_UPDATE_TABLE_CELL)
        
        self.tvSecurityQuestionUpdate.dataSource = self
        self.tvSecurityQuestionUpdate.delegate = self
        
        self.customerId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        UpdateInfoViewModel.init().loadUserQAList(customerId: "\(customerId)", token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!,success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.userQAList = (result.data?.secQAUpdateInfoResDtoList)!
            self.updateCells = [SecurityQuestionTableViewCell](repeating: SecurityQuestionTableViewCell(), count: self.userQAList.count)
            self.tvSecurityQuestionUpdate.reloadData()
            
//            print("User QA list \(self.userQAList.count)")
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func runTimedCode() {
                   multiLoginGet()
               // print("kms\(logoutTimer)")
               }
       func multiLoginGet(){
                  let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
               var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
              MultiLoginModel.init().makeMultiLogin(customerId: customerId
                      , loginDeviceId: deviceID, success: { (results) in
                     // print("kaungmyat san multi >>>  \(results)")
                      
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
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
extension SecurityQuestionUpdateViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return self.userQAList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SECURITY_QUESTION_TABLE_CELL, for: indexPath) as! SecurityQuestionTableViewCell
            cell.selectionStyle = .none
            //cell.setData(data: self.userQAList[indexPath.row])
            cell.lbQuesNo.text = "Q\(indexPath.row + 1):"
            cell.lbAnsNo.text = "Ans\(indexPath.row + 1):"
            if(cell.tfAnswer.text?.isEmpty ?? false) {
                cell.tfAnswer.text = self.userQAList[indexPath.row].answer
            }
            updateCells[indexPath.row] = cell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SECURITY_QUESTION_UPDATE_TABLE_CELL, for: indexPath) as! SecurityQuestionUpdateTableViewCell
       
        cell.selectionStyle = .none
        cell.delegate = self
        cell.tfPassword.setMaxLength(maxLength: 6)
        cell.btnUpdate.setTitle("infoupate.update.button".localized, for: UIButton.State.normal)
        cell.passwordTitle.text = "securityquestion.password.holder".localized
        return cell
    }
    
    
}

extension SecurityQuestionUpdateViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(150.0)
        }
        return CGFloat(180.0)
    }
}

extension SecurityQuestionUpdateViewController:SecurityQuestionUpdateDelegate{
    func onClickUpdateButton(cell: SecurityQuestionUpdateTableViewCell) {
        if (cell.tfPassword.text?.isEmpty)!{
            cell.lbMessage.text = Messages.PASSWORD_EMPTY_ERROR.localized
            //cell.tfPassword.showError(message: Messages.PASSWORD_EMPTY_ERROR)
        
        } else{
            cell.lbMessage.text = Constants.BLANK
            
            var answerList = [String]()
            var qaList = [UpdateUserQABean]()
            //for i in 0..<tvSecurityQuestionUpdate.numberOfRows(inSection: 0){
            for i in 0..<updateCells.count {
//                let indexPath = IndexPath(row: i, section: 0)
//                let cell = tvSecurityQuestionUpdate.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
                let qcell = updateCells[i]
                if !(qcell.tfAnswer.text?.isEmpty)! {
                    print("\(self.userQAList.count) + \(updateCells.count)")
                    let answer = qcell.tfAnswer.text
                    let cusQuesId = self.userQAList[i].custSecQuesId!
                    let quesId = self.userQAList[i].secQuesId!
                    answerList.append(answer!)
                    qaList.append(UpdateUserQABean(custSecQuesId :"\(cusQuesId)", answer: answer!, secQuesId: "\(quesId)"))
                }else{
                    qcell.tfAnswer.showError(message: Messages.ANSWER_EMPTY_ERROR.localized)
                    return
                }
            }
            //let updUserBean = UpdateUserBean(customerId: "\( self.customerId)", password: cell.tfPassword.text!, securityQAUpdateInfo: qaList)
            
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            //CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
//            UpdateInfoViewModel.init().updateUserQAList(updateUserQABean :updUserBean ,success: { (result) in
//
//                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//                if result.updateStatus == Constants.UPDATE_OK {
//                    Utils.showAlert(viewcontroller: self, title: "Update Success", message: Messages.UPDATE_INFO_SUCCESS)
//                    cell.tfPassword.text = Constants.BLANK
//                } else {
//                Utils.showAlert(viewcontroller: self, title: "Update Failed", message: Messages.INCORRECT_PASSWORD_ERROR)
//                }
//            }) { (error) in
//                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//                //Utils.showAlert(viewcontroller: self, title: "Failed", message: error)
//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
//                self.present(navigationVC, animated: true, completion: nil)
//            }
        }
    }
}
