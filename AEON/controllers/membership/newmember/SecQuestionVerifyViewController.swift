//
//  SecQuestionResetPasswordViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecQuestionVerifyViewController: BaseUIViewController {
    @IBOutlet weak var tvSecQuesVerifyView: UITableView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var bbBack: UIBarButtonItem!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    
    var verifyData  = VerifyUserInfoBean()
    var userQAList:[UserQAList] = []
    var customerId:Int = 0
    var verifyCell:[SecQuesVerifyQATableViewCell]!
    var tokenInfo: TokenData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        // check network
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        self.title = "membership.title".localized
        
//        print("Start SecQuestionVerifyViewController :::::::::::::::")
        self.tvSecQuesVerifyView.register(UINib(nibName: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL)
        
        self.tvSecQuesVerifyView.register(UINib(nibName: CommonNames.SEC_QUES_VERIFY_QA_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUES_VERIFY_QA_TABLE_CELL)
        
        self.tvSecQuesVerifyView.register(UINib(nibName: CommonNames.SEC_QUEST_VERIFY_BTN_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_VERIFY_BTN_TABLE_CELL)
        
        self.tvSecQuesVerifyView.dataSource = self
        self.tvSecQuesVerifyView.delegate = self
        self.tvSecQuesVerifyView.tableFooterView = UIView()
        
        self.customerId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        UpdateInfoViewModel.init().loadUserQAList(customerId: "\(customerId)", token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)! ,success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.userQAList = (result.data?.secQAUpdateInfoResDtoList)!
            self.tvSecQuesVerifyView.reloadData()
            self.verifyCell = [SecQuesVerifyQATableViewCell](repeating: SecQuesVerifyQATableViewCell(), count: self.userQAList.count)
            
//            print("User QA list for Verify \(self.userQAList.count)")
        }) { (error) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            
            } else {
                let alertController = UIAlertController(title: Constants.LOADING_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
//                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.VERIFY_MEMBER_VIEW_CONTROLLER) as! UINavigationController
                     let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.VERIFY_MEMBER_VIEW_CONTROLLER) as! UIViewController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
         self.tvSecQuesVerifyView.reloadData()
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
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.title = "membership.title".localized
       
    }
    
    @IBAction func onClickBackBtn(_ sender: UIBarButtonItem) {
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
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 2 {
            return 1
        }
        return self.userQAList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, for: indexPath) as! SecQuesRegHeaderTableViewCell
            cell.lblHeader.text = "secquestconfirm.title".localized
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUES_VERIFY_QA_TABLE_CELL, for: indexPath) as! SecQuesVerifyQATableViewCell
            cell.selectionStyle = .none
            cell.setData(data: self.userQAList[indexPath.row], err_message: Constants.BLANK, answerCount: 0)
            switch Locale.currentLocale {
            case .EN:
                cell.lbQuestion.text = self.userQAList[indexPath.row].questionEN
            case .MY:
                cell.lbQuestion.text = self.userQAList[indexPath.row].questionMM
            }
            
            //cell.tfAnswer.text = Constants.BLANK
//            if indexPath.row == 0 {
//                cell.tfAnswer.becomeFirstResponder()
//            }
            cell.lbQuesNo.text = "Q\(indexPath.row+1):"
            cell.lbAnsNo.text = "Ans\(indexPath.row+1):"
            cell.lbMessage.text = cell.answerMesgLocale?.localized
            self.verifyCell[indexPath.row] = cell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_VERIFY_BTN_TABLE_CELL, for: indexPath) as! SecQuesVerifyBtnTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.btnVerifyConfirm.setTitle("verify.secque.confirm.button".localized, for: UIControl.State.normal)

        return cell
    }
}

extension SecQuestionVerifyViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(70.0)
        } else if indexPath.section == 1{
            return CGFloat(150.0)
        }
        return CGFloat(100.0)
    }
}

extension SecQuestionVerifyViewController:SecurityQuestionVerifyDelegate{
    func onClickVerifyConfirmBtn (cell: SecQuesVerifyBtnTableViewCell) {
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        var qaList = [UserQABean]()
        var isError = false
        
        //var i = 0
        //while i < tvSecQuesVerifyView.numberOfRows(inSection: 0){
        for i in 0..<self.verifyCell.count{
            //let indexPath = IndexPath(row: i, section: 0)
            //let cell = tvSecQuesVerifyView.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
            let cell = self.verifyCell[i]
            if (cell.tfAnswer.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
                //cell.tfAnswer.showError(message: Messages.ANSWER_EMPTY_ERROR)
                cell.tfAnswer.text = Constants.BLANK
                cell.lbMessage.text = Messages.ANSWER_EMPTY_ERROR.localized
                cell.answerMesgLocale = Messages.ANSWER_EMPTY_ERROR
                isError = true
                
            } else{
                cell.lbMessage.text = Constants.BLANK
                cell.answerMesgLocale = Constants.BLANK
                let answer = cell.tfAnswer.text
                let que = cell.lbQuestion.text!
                let selectedQuestionId = userQAList[i].secQuesId!
                qaList.append(UserQABean(secQuesId: selectedQuestionId,question: que,answer: answer!))
            }
            //i+=1
        }
        if isError {
            return
        }
        var userSecQuesVerifyBean = UserSecQuesVerifyBean()
        userSecQuesVerifyBean.customerId = "\(self.customerId)"
        userSecQuesVerifyBean.quesAnsBean = qaList
        
        let phoneNo = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesVerifyViewModel.init().makeVerify(userConfirmBean: userSecQuesVerifyBean, phoneNo: phoneNo!, token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: {(result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if result.status == Constants.STATUS_200 {

//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_UPLOAD_VIEW_CONTROLLER) as! UINavigationController
//                let vc = navigationVC.children.first as! PhotoUploadViewController
                let vc = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.PHOTO_UPLOAD_VIEW_CONTROLLER) as! PhotoUploadViewController
                
                vc.verifyData = self.verifyData
                vc.isPhotoUpdate = false
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: Messages.VERIFY_INVALID_ANSWER.localized)
            }
            
        }) {(error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: error)
            }
            
        }
        
    }
}
