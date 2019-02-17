//
//  SecQuestConfirmViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuestConfirmViewController: UIViewController {

    @IBOutlet weak var secQuesTableView: UITableView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    
    var secQuesList = [SecQuesListBean]()
    var numOfQuestion = 0
    var numOfAnsChar = 0
    var userSecQuesConfirmBean = UserSecQuesConfirmBean()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSecurityQuestionLIst()
        
        RegisterViewModel.init().loadNrcData(success: { (result) in
            RegisterViewModel.init().getNrcData(success: { (townshipList) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                self.allTownShipList = townshipList
                self.selectedTownshipList = townshipList[0]
                self.selectedDivision = self.divisionList[0]
                self.selectedTownship = self.allTownShipList[0][0]
                self.selectedNrcType = self.nrcTypeList[0]
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: "Loading Error", message: error)
            }
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Loading Failed", message: error)
        }
        
        self.secQuesTableView.register(UINib(nibName: "SecQuesRegisterTableViewCell", bundle: nil), forCellReuseIdentifier: "SecQuesRegisterTableViewCell")
        self.secQuesTableView.register(UINib(nibName: "SecQuesConfirmTableViewCell", bundle: nil), forCellReuseIdentifier: "SecQuesConfirmTableViewCell")
        
        //open thid comment in real
        self.secQuesTableView.dataSource = self
        self.secQuesTableView.delegate = self
        
    }
    
    private func loadSecurityQuestionLIst(){
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesRegisterViewModel.init().getSecQuesList(siteActivationKey: "12345678", success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.numOfQuestion = result.numOfQuestion
            self.numOfAnsChar = result.numOfAnsCount
            self.secQEng = result.questionList[0]
            self.secQMy = result.questionList[1]
            self.secQuesList = result.secQuesList
            switch Locale.currentLocale {
            case .EN:
                self.questionList = self.secQEng
            case .MY:
                self.questionList = self.secQMy
            }
            self.secQuesTableView.reloadData()
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
        }
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
}

extension SecQuestConfirmViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.numOfQuestion
        }else if section == 1{
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesRegisterTableViewCell", for: indexPath) as! SecQuesRegisterTableViewCell
            cell.selectionStyle = .none
            cell.setData(data: self.questionList,answerCount:self.numOfAnsChar)
            cell.cellClickDelegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesConfirmTableViewCell", for: indexPath) as! SecQuesConfirmTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
        
    }
    
    
}

extension SecQuestConfirmViewController:SecQuesRegisterCellClickDelegate{
    func onClickSecQuesList(quesList: [String],cell:SecQuesRegisterTableViewCell) {
        let action = UIAlertController.actionSheetWithItems(items: quesList, action: { (value)  in
            cell.lblSecQuestion.text = value
             print(value)
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(action, animated: true, completion: nil)

    }
}

extension SecQuestConfirmViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(150.0)
       
        }
        return CGFloat(250.0)
    }
}

extension SecQuestConfirmViewController:SecQuesConfirmDelegate{
    
    func onClickDivision() {
        let row: Int = secQuesTableView.numberOfRows(inSection: 1)
        let indexPath = IndexPath(row:row-1, section: 1)
        let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
        
        let action = UIAlertController.actionSheetWithItems(items: divisionList, currentSelection: selectedDivision, action: { (value)  in
            self.selectedDivision = value
            
            self.selectedTownshipList = self.allTownShipList[Int(self.selectedDivision)!-1]
            self.selectedTownship = self.allTownShipList[Int(self.selectedDivision)!-1][0]
            
            let defaultData: LoginResponse = UserDefaults.standard.object(forKey: Constants.LOGIN_RESPONSE) as! LoginResponse
            conCell.tfPhoneNo.text = defaultData.phoneNo
            conCell.lblDivision.text = self.selectedDivision
            conCell.lblTownship.text = self.selectedTownship
            print(defaultData.phoneNo)
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    func onClickTownship() {
        let row: Int = secQuesTableView.numberOfRows(inSection: 1)
        let indexPath = IndexPath(row:row-1, section: 1)
        let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
        
        let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, currentSelection: selectedTownship, action: { (value)  in
            conCell.lblTownship.text = value
            self.selectedTownship = value
            print(value)
            
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    func onClickNrcType() {
        let row: Int = secQuesTableView.numberOfRows(inSection: 1)
        let indexPath = IndexPath(row:row-1, section: 1)
        let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
        
        let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, currentSelection: selectedNrcType, action: { (value)  in
            conCell.lblNrcType.text = value
            self.selectedNrcType = value
            print(value)
            
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    
    func onClickConfirm() {
        
        var qaList = [UserQABean]()
        var phoneNo:String = ""
        var nrcData: String = ""
        var i = 0
        var isError: Bool = false
        while i < secQuesTableView.numberOfRows(inSection: 0){
            let indexPath = IndexPath(row: i, section: 0)
            let sqCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesRegisterTableViewCell
            if sqCell.tfsecAnswer.text?.isEmpty ?? true {
                sqCell.tfsecAnswer.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
                sqCell.tfsecAnswer.attributedPlaceholder = NSAttributedString(string: "Please input answer",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                isError = true
                print("sec cell error)\(i)")
                
            } else {
                let ans = sqCell.tfsecAnswer.text!
                let que = sqCell.lblSecQuestion.text!
                if let selectedIndex = questionList.firstIndex(of: "\(sqCell.lblSecQuestion.text!)"){
                    let selectedQuestionId = secQuesList[selectedIndex].secQuestionId
                    qaList.append(UserQABean(secQuesId: selectedQuestionId,question: que,answer: ans))
                }
                
            }
             i += 1
        }
        
        let row: Int = secQuesTableView.numberOfRows(inSection: 1)
            let indexPath = IndexPath(row:row-1, section: 1)
            let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
            
            if conCell.tfPhoneNo.text?.isEmpty ?? true {
                conCell.tfPhoneNo.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
                conCell.tfPhoneNo.attributedPlaceholder = NSAttributedString(string: "Please input phone no.",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                isError = true
                print("confirm cell phone error)")
                
            } else {
                phoneNo = conCell.tfPhoneNo.text!
            }
            
            if conCell.tfNrcNo.text?.isEmpty ?? true {
                conCell.tfNrcNo.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
                conCell.tfNrcNo.attributedPlaceholder = NSAttributedString(string: "Please input NRC No.",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
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
        
        SecQuesConfirmViewModel.init().makeConfirm(userConfirmBean: userSecQuesConfirmBean, success: { (result) in
            
            print(result)
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! UINavigationController
            let vc = navigationVC.children.first as! ResetPasswordViewController
            vc.customerId = result.customerId
            vc.userTypeId = result.userTypeId
            self.present(navigationVC, animated: true, completion: nil)
            
        }) { (error) in
             Utils.showAlert(viewcontroller: self, title: "Confirm Error", message: error)
        }
    }
    
    
}
