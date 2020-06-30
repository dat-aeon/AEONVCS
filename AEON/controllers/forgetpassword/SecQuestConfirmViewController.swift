//
//  SecQuestConfirmViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecQuestConfirmViewController: BaseUIViewController {
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    
    @IBOutlet weak var secQuesTableView: UITableView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var secQuesList = [SecQuesListBean]()
    var numOfQuestion = 0
    var numOfAnsChar = 0
    var userSecQuesConfirmBean = UserSecQuesConfirmBean()
    var tokenInfo: TokenData?
    
    var registerCells: [SecQuesRegisterTableViewCell]!
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedNrcType = "(N)"
    var selectedDivision = "1"
    var selectedTownshipList = [String]()
    var selectedTownship = "0"
    
    var secQMy = [String]()
    var secQEng = [String]()
    var questionList = [String]()
    
    var phoneNoLabel:String = ""
    var selectedQues = [Int]()
    
    var phoneNo:String?
    var nrcNo:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
        
        loadSecurityQuestionLIst()
        
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        
        RegisterViewModel.init().loadNrcData(success: { (townshipList) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.allTownShipList = townshipList
            self.selectedTownshipList = townshipList[0]
            self.selectedDivision = self.divisionList[0]
            self.selectedTownship = self.allTownShipList[0][0]
            self.selectedNrcType = self.nrcTypeList[0]
            self.secQuesTableView.reloadData()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.JSON_FAILURE {
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            }
        }
        
        self.secQuesTableView.register(UINib(nibName: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL)
        self.secQuesTableView.register(UINib(nibName: CommonNames.SEC_QUEST_REGISTER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_REGISTER_TABLE_CELL)
        self.secQuesTableView.register(UINib(nibName: CommonNames.SEC_QUEST_CONFIRM_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_CONFIRM_TABLE_CELL)
        
        //open thid comment in real
        self.secQuesTableView.dataSource = self
        self.secQuesTableView.delegate = self
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
            self.questionList = self.secQEng
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
            self.questionList = self.secQMy
        }
        
    }
    
    private func loadSecurityQuestionLIst(){
        
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesRegisterViewModel.init().getSecQuesList(siteActivationKey: Constants.site_activation_key, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.numOfQuestion = result.numOfQuestion
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
            self.secQuesTableView.reloadData()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: Constants.CONFIRM_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            } 
        }
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
        self.secQuesTableView.reloadData()
    }
    
    @objc func onTapBack() {
       print("click")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onTapMMLocale() {
       print("click")
        super.NewupdateLocale(flag: 1)
        updateViews()
        secQuesTableView.reloadData()
    }
    @objc func onTapEngLocale() {
       print("click")
        super.NewupdateLocale(flag: 2)
        updateViews()
        secQuesTableView.reloadData()
    }
    
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
            self.questionList = self.secQEng
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
            self.questionList = self.secQMy
        }
        
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            secQuesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            secQuesTableView.contentInset = UIEdgeInsets.zero
            
        }
        
        secQuesTableView.scrollIndicatorInsets = secQuesTableView.contentInset
        
    }
    
}

extension SecQuestConfirmViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.numOfQuestion
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
            if cell.lblSecQuestion.text?.isEmpty ?? true {
                cell.lblSecQuestion.text = self.questionList[0]
                self.selectedQues.append(0)
                
            } else {
                cell.lblSecQuestion.text = self.questionList[self.selectedQues[indexPath.row]]
            }
            cell.lblQuesNo.text = "Q\(indexPath.row+1):"
            cell.lblAnsNo.text = "Ans\(indexPath.row+1):"
            
            cell.cellClickDelegate = self
            self.registerCells[indexPath.row] = cell
            if indexPath.row == 0 {
                DispatchQueue.main.async {
                    cell.tfsecAnswer.becomeFirstResponder()
                }
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_CONFIRM_TABLE_CELL, for: indexPath) as! SecQuesConfirmTableViewCell
        
        cell.selectionStyle = .none
        cell.lblPhoneNo.text = "register.phoneno.label".localized
        cell.tfPhoneNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        cell.lblNrcNo.text = "register.nrc.label".localized
        cell.btnConfirm.setTitle("secquestconfirm.confrim.button".localized, for: UIControl.State.normal)
        cell.lblDivision.text = self.selectedDivision
        cell.lblTownship.text = self.selectedTownship
        cell.lblNrcType.text = self.selectedNrcType
        cell.tfNrcNo.setMaxLength(maxLength: 6)
        cell.delegate = self
        return cell
        
    }
}

extension SecQuestConfirmViewController:SecQuesRegisterCellClickDelegate{
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
                    print("select index = \(selectedIndex)")
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
                    print("select index = \(selectedIndex)")
                }
                print(value)
                // focus on answer textfield
                DispatchQueue.main.async {
                    cell.tfsecAnswer.becomeFirstResponder()
                }
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            self.present(action, animated: true, completion: nil)
        }
    }
}

extension SecQuestConfirmViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(70.0)
            
        } else if indexPath.section == 1{
            return CGFloat(250.0)
            
        }
        return CGFloat(350.0)
    }
}

extension SecQuestConfirmViewController : SecQuesConfirmDelegate, TownshipSelectDelegate {
    
    func onClickTownshipCode(townshipCode: String) {
        let row: Int = secQuesTableView.numberOfRows(inSection: 2)
        let indexPath = IndexPath(row:row-1, section: 2)
        let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
        
        conCell.lblTownship.text = townshipCode
        self.selectedTownship = townshipCode
        
    }
    
    func onClickDivision() {
        let row: Int = secQuesTableView.numberOfRows(inSection: 2)
        let indexPath = IndexPath(row:row-1, section: 2)
        let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: divisionList, currentSelection: selectedDivision, action: { (value)  in
                self.selectedDivision = value
                
                self.selectedTownshipList = self.allTownShipList[Int(self.selectedDivision)!-1]
                self.selectedTownship = self.allTownShipList[Int(self.selectedDivision)!-1][0]
                
                conCell.lblDivision.text = self.selectedDivision
                conCell.lblTownship.text = self.selectedTownship
                print(conCell.tfPhoneNo.text as Any)
            })
            //Present the controller
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = conCell.lblDivision
            }
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: divisionList, currentSelection: selectedDivision, action: { (value)  in
                self.selectedDivision = value
                
                self.selectedTownshipList = self.allTownShipList[Int(self.selectedDivision)!-1]
                self.selectedTownship = self.allTownShipList[Int(self.selectedDivision)!-1][0]
                
                conCell.lblDivision.text = self.selectedDivision
                conCell.lblTownship.text = self.selectedTownship
                print(conCell.tfPhoneNo.text as Any)
            })
            
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: false, completion: nil)
        }
    }
    
    func onClickTownship() {
        
        //let row: Int = secQuesTableView.numberOfRows(inSection: 2)
        //let indexPath = IndexPath(row:row-1, section: 2)
        //let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
        
//        if UIDevice.current.userInterfaceIdiom == .pad {
//
//            let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, currentSelection: selectedTownship, action: { (value)  in
//                conCell.lblTownship.text = value
//                self.selectedTownship = value
//                print(value)
//
//            })
//            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
//            if let popoverPresentationController = action.popoverPresentationController {
//                popoverPresentationController.sourceView = conCell.lblTownship
//            }
//            self.present(action, animated: true, completion: nil)
//
//        } else {
//
//            let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, currentSelection: selectedTownship, action: { (value)  in
//                conCell.lblTownship.text = value
//                self.selectedTownship = value
//                print(value)
//            })
//
//            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
//            //Present the controller
//
//            DispatchQueue.main.async {
//                self.present(action, animated: false, completion: nil)
//            }
//        }

        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.NRC_POPUP_VIEW_CONTROLLER) as! NRCpopupViewController
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        
        self.definesPresentationContext = true
        popupVC.townshipDelegate = self
        popupVC.townshipList = self.selectedTownshipList
        self.present(popupVC, animated: true, completion: nil)
        
    }
    
    func onClickNrcType() {
        let row: Int = secQuesTableView.numberOfRows(inSection: 2)
        let indexPath = IndexPath(row:row-1, section: 2)
        let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, currentSelection: selectedNrcType, action: { (value)  in
                conCell.lblNrcType.text = value
                self.selectedNrcType = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = conCell.lblNrcType
            }
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, currentSelection: selectedNrcType, action: { (value)  in
                conCell.lblNrcType.text = value
                self.selectedNrcType = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func onClickConfirm() {
        
        var secIdList:[Int] = []
        var qaList = [UserQABean]()
        var selectedQuestionId : Int = 0
        var phoneNo:String = ""
        var nrcData: String = ""
        //var i = 0
        var isError: Bool = false
        //while i < secQuesTableView.numberOfRows(inSection: 0){
        //var i = 0
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

        
        let row: Int = secQuesTableView.numberOfRows(inSection: 2)
        let indexPath = IndexPath(row:row-1, section: 2)
        let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
        
        if conCell.tfPhoneNo.text?.isEmpty ?? true {
            conCell.tfPhoneNo.showError(message: Messages.PHONE_EMPTY_ERROR.localized)
            print("confirm cell phone error)")
            
        } else {
            phoneNo = conCell.tfPhoneNo.text!
        }
        
        if conCell.tfNrcNo.text?.isEmpty ?? true {
            conCell.tfNrcNo.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
            conCell.tfNrcNo.showError(message: Messages.NRC_NO_EMPTY_ERROR.localized)
            isError = true
            print("confirm cell nrc error)")
        } else {
            
            let divisionCode: String = conCell.lblDivision.text!
            let townshipCode: String = conCell.lblTownship.text!
            let nrcType: String = conCell.lblNrcType.text!
            let nrcNo: String = conCell.tfNrcNo!.text!
            
            nrcData = divisionCode + "/" + townshipCode + nrcType + nrcNo
        }
        
        if isError {
            return
        }
        
        print("Phone No \(String(describing: phoneNo))")
        print("NRC \(String(describing: nrcData))")
        
        userSecQuesConfirmBean.phoneNo = phoneNo
        userSecQuesConfirmBean.nrcData = nrcData
        userSecQuesConfirmBean.quesAnsBean = qaList
        
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesConfirmViewModel.init().makeConfirm(userConfirmBean: userSecQuesConfirmBean, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            print(result)
            if result.statusCode == Constants.INVALID_CUSTOMER_ANSWER {
                Utils.showAlert(viewcontroller: self, title: Constants.CONFIRM_ERROR_TITLE, message: Messages.QUES_AND_ANSWER_WRONG_ERROR.localized)
                
            } else if result.statusCode == Constants.NOT_EXIST_CUSTOMER_INFO {
                Utils.showAlert(viewcontroller: self, title: Constants.CONFIRM_ERROR_TITLE, message: Messages.NRC_OR_PHONE_INVALID_ERROR.localized)
                
            } else {
                
//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.RESET_PASSWORD_VIEW_CONTROLLER) as! UINavigationController
//                let vc = navigationVC.children.first as! ResetPasswordViewController
                let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.RESET_PASSWORD_VIEW_CONTROLLER) as! ResetPasswordViewController
                vc.customerId = result.customerId
                vc.userTypeId = result.userTypeId
                vc.phoneNo = phoneNo
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
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

//
//extension SecQuestConfirmViewController: TownshipSelectDelegate {
//    func onClickTownshipCode(townshipCode: String) {
//        //self.lblTownship.text = townshipCode
//    }
//}
