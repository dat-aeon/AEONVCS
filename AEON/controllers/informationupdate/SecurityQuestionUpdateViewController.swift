//
//  SecurityQuestionUpdateViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecurityQuestionUpdateViewController: UIViewController {

    @IBOutlet weak var tvSecurityQuestionUpdate: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvSecurityQuestionUpdate.register(UINib(nibName: "SecurityQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "SecurityQuestionTableViewCell")
        
        self.tvSecurityQuestionUpdate.register(UINib(nibName: "SecurityQuestionUpdateTableViewCell", bundle: nil), forCellReuseIdentifier: "SecurityQuestionUpdateTableViewCell")
        
        self.tvSecurityQuestionUpdate.dataSource = self
        self.tvSecurityQuestionUpdate.delegate = self
        

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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecurityQuestionTableViewCell", for: indexPath) as! SecurityQuestionTableViewCell
            cell.selectionStyle = .none
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
        return CGFloat(120.0)
    }
}

extension SecurityQuestionUpdateViewController:SecurityQuestionUpdateDelegate{
    func onClickUpdateButton(password: String?) {
        if (password?.isEmpty)!{
            Utils.showAlert(viewcontroller: self, title: "Empty Value", message: "Password is empty")
        }else{
            var answerList = [String]()
            for i in 0..<tvSecurityQuestionUpdate.numberOfRows(inSection: 0){
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tvSecurityQuestionUpdate.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
                if !(cell.tfAnswer.text?.isEmpty)! {
                    let answer = cell.tfAnswer.text
                    answerList.append(answer!)
                }
            }
            if answerList.count != tvSecurityQuestionUpdate.numberOfRows(inSection: 0){
                Utils.showAlert(viewcontroller: self, title: "Empty Value", message: "Answer is empty")
            }else{
                Utils.showAlert(viewcontroller: self, title: "Success", message: "Successfully Updated")
            }
        }
    }
    
    
}
