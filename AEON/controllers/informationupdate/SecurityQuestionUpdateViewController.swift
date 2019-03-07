//
//  SecurityQuestionUpdateViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecurityQuestionUpdateViewController: BaseUIViewController {

    @IBOutlet weak var tvSecurityQuestionUpdate: UITableView!
    var userQAList:[UserQAList] = []
    var customerId:Int = 0
    
    override func viewDidLoad() {
        print("Start SecurityQuestionUpdateViewController :::::::::::::::")
        super.viewDidLoad()
        self.tvSecurityQuestionUpdate.register(UINib(nibName: "SecurityQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "SecurityQuestionTableViewCell")
        
        self.tvSecurityQuestionUpdate.register(UINib(nibName: "SecurityQuestionUpdateTableViewCell", bundle: nil), forCellReuseIdentifier: "SecurityQuestionUpdateTableViewCell")
        
        self.tvSecurityQuestionUpdate.dataSource = self
        self.tvSecurityQuestionUpdate.delegate = self
        
        self.customerId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        UpdateInfoViewModel.init().loadUserQAList(customerId: "\(customerId)" ,success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.userQAList = result
            self.tvSecurityQuestionUpdate.reloadData()
            
            print("User QA list \(self.userQAList.count)")
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Info Update Loading Failed", message: error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("Appear SecurityQuestionUpdateViewController :::::::::::::::")
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        UpdateInfoViewModel.init().loadUserQAList(customerId: "\(customerId)" ,success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.userQAList = result
            self.tvSecurityQuestionUpdate.reloadData()
            
            print("User QA list \(self.userQAList.count)")
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Info Update Loading Failed", message: error)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecurityQuestionTableViewCell", for: indexPath) as! SecurityQuestionTableViewCell
            cell.selectionStyle = .none
            cell.setData(data: self.userQAList[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecurityQuestionUpdateTableViewCell", for: indexPath) as! SecurityQuestionUpdateTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
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
        return CGFloat(150.0)
    }
}

extension SecurityQuestionUpdateViewController:SecurityQuestionUpdateDelegate{
    func onClickUpdateButton(cell: SecurityQuestionUpdateTableViewCell) {
        if (cell.tfPassword.text?.isEmpty)!{
            cell.tfPassword.showError(message: "Password is empty")
        }else{
            var answerList = [String]()
            var qaList = [UpdateUserQABean]()
            for i in 0..<tvSecurityQuestionUpdate.numberOfRows(inSection: 0){
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tvSecurityQuestionUpdate.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
                if !(cell.tfAnswer.text?.isEmpty)! {
                    let answer = cell.tfAnswer.text
                    let cusQuesId = self.userQAList[i].custSecQuesId
                    let quesId = self.userQAList[i].secQuestionId
                    answerList.append(answer!)
                    qaList.append(UpdateUserQABean(custSecQuesId :"\(cusQuesId)", answer: answer!, secQuesId: "\(quesId)"))
                }else{
                    cell.tfAnswer.showError(message: "Answer is empty")
                    return
                }
            }
            let updUserBean = UpdateUserBean(customerId: "\( self.customerId)", password: cell.tfPassword.text!, securityQAUpdateInfo: qaList)
            
            
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            UpdateInfoViewModel.init().updateUserQAList(updateUserQABean :updUserBean ,success: { (result) in
                
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: "Updated Status", message: result.updateStatus)
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: "Failed", message: error)
            }
        }
    }
    
    
}
