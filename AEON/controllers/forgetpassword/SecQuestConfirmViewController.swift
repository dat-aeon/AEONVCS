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
    
    var secQuesList = [SecurityQuestion]()
    var numOfQuestion = 0
    var userQuestionList = UserSecQuesBeanList()
    var userSecQuesConfirmBean = UserSecQuesConfirmBean()
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var allTownShipList = [ ["1aa","sadfsdf","sdf"],
                            ["2aa","sadfsdf","sdf"],
                            ["3aa","sadfsdf","sdf"],
                            ["4aa","sadfsdf","sdf"],
                            ["5aa","sadfsdf","sdf"],
                            ["6aa","sadfsdf","sdf"],
                            ["7aa","sadfsdf","sdf"],
                            ["8aa","sadfsdf","sdf"],
                            ["9aa","sadfsdf","sdf"],
                            ["10aa","sadfsdf","sdf"],
                            ["11aa","sadfsdf","sdf"],
                            ["12aa","sadfsdf","sdf"],
                            ["13aa","sadfsdf","sdf"],
                            ["14aa","sadfsdf","sdf"],]
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedNrcType = "(N)"
    var selectedDivision = "1"
    var selectedTownshipList = [String]()
    var selectedTownship = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SecQuesConfirmViewModel.init().getSelectedQuesList(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
            
            self.numOfQuestion = result.numOfQuestion
            self.userQuestionList = result.userSecQuesBeanList
            
            
            
        }) { (error) in
            // Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
        }
        
        
        self.secQuesTableView.register(UINib(nibName: "SecurityQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "SecurityQuestionTableViewCell")
        self.secQuesTableView.register(UINib(nibName: "SecQuesConfirmTableViewCell", bundle: nil), forCellReuseIdentifier: "SecQuesConfirmTableViewCell")
        
        //open thid comment in real
        self.secQuesTableView.dataSource = self
        self.secQuesTableView.delegate = self
        
        
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecurityQuestionTableViewCell", for: indexPath) as! SecurityQuestionTableViewCell
            cell.selectionStyle = .none
            cell.lbQuesNo.text = String(indexPath.row)
            switch Locale.currentLocale {
            case .EN:
                cell.lbQuestion.text = self.userQuestionList.questionList[indexPath.row].questionEN
            case .MY:
                cell.lbQuestion.text = self.userQuestionList.questionList[indexPath.row].questionMM
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesConfirmTableViewCell", for: indexPath) as! SecQuesConfirmTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
        
    }
    
    
}

extension SecQuestConfirmViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(self.view.frame.height/2)
       
        } else if indexPath.section == 1{
            return CGFloat(300.0)
        }
        return CGFloat(150.0)
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
            
            conCell.lblDivision.text = self.selectedDivision
            conCell.lblTownship.text = self.selectedTownship
            print(value)
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
            let sqCell = secQuesTableView.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
            if sqCell.tfAnswer == nil {
                sqCell.tfAnswer.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
                sqCell.tfAnswer.attributedPlaceholder = NSAttributedString(string: "Please input answer",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                isError = true
            } else {
                let ans = sqCell.tfAnswer.text!
                let que = self.userQuestionList.questionList[indexPath.row].questionEN
                let queId = self.userQuestionList.questionList[indexPath.row].secQuesId
                qaList.append(UserQABean(secQuesId: queId,question: que,answer: ans))
                i+=1
            }
        }
        
        let row: Int = secQuesTableView.numberOfRows(inSection: 1)
            let indexPath = IndexPath(row:row-1, section: 1)
            let conCell = secQuesTableView.cellForRow(at: indexPath) as! SecQuesConfirmTableViewCell
            
            if conCell.tfPhoneNo.text == nil {
                conCell.tfPhoneNo.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
                conCell.tfPhoneNo.attributedPlaceholder = NSAttributedString(string: "Please input phone no.",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                isError = true
            } else {
                phoneNo = conCell.tfPhoneNo.text!
            }
            
            if conCell.tfNrcNo.text == nil {
                conCell.tfPhoneNo.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
                conCell.tfPhoneNo.attributedPlaceholder = NSAttributedString(string: "Please input phone no.",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                isError = true
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
            
            self.numOfQuestion = result.numOfQuestion
            self.userQuestionList = result.userSecQuesBeanList
            
            
            
        }) { (error) in
            // Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
        }
    }
    
    
}
