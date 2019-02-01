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
    
    var secQuesList = [SecurityQuestion]()
    var secQuesConfirmList = [SecurityQuestionConfirm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secQuesList = SecQuesDataModel().getSecQuesList()
        secQuesConfirmList = SecQuesDataModel().getSecQuestConfirmation()

        self.secQuesTableView.register(UINib(nibName: "SecurityQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "SecurityQuestionTableViewCell")
        self.secQuesTableView.register(UINib(nibName: "SecuQuesConfirmTableViewCell", bundle: nil), forCellReuseIdentifier: "SecuQuesConfirmTableViewCell")
        
        //open thid comment in real
//        self.secQuesTableView.dataSource = self
//        self.secQuesTableView.delegate = self
        
        
        
    }
    
    //remove this override function in real
    override func viewWillAppear(_ animated: Bool) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
}

extension SecQuestConfirmViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecurityQuestionTableViewCell", for: indexPath) as! SecurityQuestionTableViewCell
            cell.selectionStyle = .none
            cell.setData(data: secQuesList[indexPath.row])
            return cell
        
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesConfirmTableViewCell", for: indexPath) as! SecQuesConfirmTableViewCell
        cell.selectionStyle = .none
        cell.setData(data: secQuesConfirmList[indexPath.row])
        
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SecQuestConfirmViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(self.view.frame.height/2)
       
        } else if indexPath.section == 1{
            return CGFloat(300)
        }
        return 150
    }
}

extension SecQuestConfirmViewController:SecQuesConfirmDelegate{
    func onClickConfirm(phoneNo: String, nrcDiv: String, nrcTownship: String, nrcType: String, nrcNo: String) {
        var qaList = [String]()
        var i = 0
        while i < secQuesTableView.numberOfRows(inSection: 0){
            let indexPath = IndexPath(row: i, section: 0)
            let sqCell = secQuesTableView.cellForRow(at: indexPath) as! SecurityQuestionTableViewCell
            guard let answer = sqCell.tfAnswer else {
                
                return
            }
            let ans = sqCell.tfAnswer.text ?? ""
            
            qaList.append(ans)
            i+=1
        }
        
        print("Phone No \(phoneNo)")
    }
    
    
}
