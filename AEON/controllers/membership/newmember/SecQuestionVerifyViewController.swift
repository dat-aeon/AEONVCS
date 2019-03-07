//
//  SecQuestionResetPasswordViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuestionVerifyViewController: BaseUIViewController {
    @IBOutlet weak var tvSecQuesVerifyView: UITableView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var verifyData  = VerifyUserInfoBean()
    var userQAList:[UserQAList] = []
    var customerId:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Start SecQuestionVerifyViewController :::::::::::::::")
        self.tvSecQuesVerifyView.register(UINib(nibName: "SecurityQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "SecurityQuestionTableViewCell")
        
        self.tvSecQuesVerifyView.register(UINib(nibName: "SecQuesVerifyBtnTableViewCell", bundle: nil), forCellReuseIdentifier: "SecQuesVerifyBtnTableViewCell")
        
        self.tvSecQuesVerifyView.dataSource = self
        self.tvSecQuesVerifyView.delegate = self
        
        self.customerId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        UpdateInfoViewModel.init().loadUserQAList(customerId: "\(customerId)" ,success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.userQAList = result
            self.tvSecQuesVerifyView.reloadData()
            
            print("User QA list for Verify \(self.userQAList.count)")
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Security Question Verify Failed", message: error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Appear SecQuestionVerifyViewController :::::::::::::::")
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        UpdateInfoViewModel.init().loadUserQAList(customerId: "\(customerId)" ,success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.userQAList = result
            self.tvSecQuesVerifyView.reloadData()
            
            print("User QA list for Verify \(self.userQAList.count)")
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Security Question Verify Failed", message: error)
        }

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
        self.tvSecQuesVerifyView.reloadData()
    }
    
    @IBAction func onClickCloseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            tvSecQuesVerifyView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            tvSecQuesVerifyView.contentInset = UIEdgeInsets.zero
            
        }
        
        tvSecQuesVerifyView.scrollIndicatorInsets = tvSecQuesVerifyView.contentInset
        
    }

}

extension SecQuestionVerifyViewController:UITableViewDataSource{
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
            switch Locale.currentLocale {
            case .EN:
                cell.lbQuestion.text = self.userQAList[indexPath.row].questionEN
            case .MY:
                cell.lbQuestion.text = self.userQAList[indexPath.row].questionMM
            }
            cell.tfAnswer.text = Constants.BLANK
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesVerifyBtnTableViewCell", for: indexPath) as! SecQuesVerifyBtnTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

extension SecQuestionVerifyViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(150.0)
        }
        return CGFloat(100.0)
    }
}

extension SecQuestionVerifyViewController:SecurityQuestionVerifyDelegate{
    func onClickVerifyConfirmBtn (cell: SecQuesVerifyBtnTableViewCell) {
        var qaList = [UserQABean]()
        var i = 0
        while i < tvSecQuesVerifyView.numberOfRows(inSection: 0){
            let indexPath = IndexPath(row: i, section: 0)
            let cell = tvSecQuesVerifyView.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
            if !(cell.tfAnswer.text?.isEmpty)! {
                let answer = cell.tfAnswer.text
                let que = cell.lbQuestion.text!
                let selectedQuestionId = userQAList[i].secQuestionId
                qaList.append(UserQABean(secQuesId: selectedQuestionId,question: que,answer: answer!))
            }else{
                cell.tfAnswer.showError(message: "Answer is empty")
                return
            }
            i+=1
        }
        var userSecQuesVerifyBean = UserSecQuesVerifyBean()
        userSecQuesVerifyBean.customerId = "\(self.customerId)"
        userSecQuesVerifyBean.quesAnsBean = qaList
                
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesVerifyViewModel.init().makeVerify(userConfirmBean: userSecQuesVerifyBean, success: {(result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
//            Utils.showAlert(viewcontroller: self, title: "Check Result", message: "\(result.statusMessage) - \(self.verifyData.customerNo)", action: {self.openCamera(imagePickerControllerDelegate: self)})
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoUploadViewController") as! UINavigationController
            let vc = navigationVC.children.first as! PhotoUploadViewController
            vc.verifyData = self.verifyData
            self.present(navigationVC, animated: true, completion: nil)
            
        }) {(error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Failed", message: error)
        }
        
//        UpdateInfoViewModel.init().updateUserQAList(success: { (result) in
//            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            Utils.showAlert(viewcontroller: self, title: "Updated Status", message: result.updateStatus)
//
//        }) { (error) in
//            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            Utils.showAlert(viewcontroller: self, title: "Failed", message: error)
//        }
    }
}
