//
//  SecQuesRegisterViewController.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesRegisterViewController: UIViewController {

    @IBOutlet weak var barBackBtn: UIBarButtonItem!
    @IBOutlet weak var tvSecQuesRegView: UITableView!
    
    var numOfQuestion: Int = 0
    var numOfAnsCount: Int = 0
    var secQMy = [String]()
    var secQEng = [String]()
    var questionList = [[String]]()
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        SecQuesRegisterViewModel.init().getSecQuesList(siteActivationKey: "12345678", success: { (result) in
//
//            self.numOfQuestion = result.numOfQuestion
//            self.numOfAnsCount = result.numOfAnsCount
//            self.secQEng = result.questionList[0]
//            self.secQMy = result.questionList[1]
//            self.questionList = result.questionList
//            //switch Locale.currentLocale {
//            //case .EN:
//                //self.secQuesList = self.secQEng
//            //case .MY:
//                //self.secQuesList = self.secQMy
//           // }
//        }) { (error) in
//            // Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
//        }
//
        //secQuesList = SecQuesDataModel().getSecQuesList()
        //secQuesConfirmList = SecQuesConfirmModel().getSecQuestConfirmation()
        
        self.numOfQuestion = 2
        self.questionList = [["1","2"],["3","4"]]
        
        self.tvSecQuesRegView.register(UINib(nibName: "SecQuesRegisterTableViewCell", bundle: nil), forCellReuseIdentifier: "SecQuesRegisterTableViewCell")
        self.tvSecQuesRegView.register(UINib(nibName: "SecQuesSaveTableViewCell", bundle: nil), forCellReuseIdentifier: "SecQuesSaveTableViewCell")
        
        //open thid comment in real
        self.tvSecQuesRegView.dataSource = self
        self.tvSecQuesRegView.delegate = self
        
    }
    
}

extension SecQuesRegisterViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            print("number of cell:::::: \(self.numOfQuestion)")
            return self.numOfQuestion
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            print("Register cell:::::::::::")
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesRegisterTableViewCell", for: indexPath) as! SecQuesRegisterTableViewCell
            cell.selectionStyle = .none
            cell.setData(data: self.questionList)
            //cell.setData(data: secQuesList[indexPath.row])
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesSaveTableViewCell", for: indexPath) as! SecQuesSaveTableViewCell
        cell.selectionStyle = .none
        //cell.setData(data: secQuesConfirmList[indexPath.row])
        
        cell.delegate = self
        return cell
        
    }
    
    func openCamera(imagePickerControllerDelegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = imagePickerControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}

extension SecQuesRegisterViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(self.view.frame.height/4)
            
        }
        return CGFloat(100.0)
    }
}

extension SecQuesRegisterViewController:SecQuesRegisterDelegate{
    func onClickSecQuesList(secQuestion: String?, secAnswer: String?) {
        
    }
    
    func onClickSecQuesList() {
        
    }
}

extension SecQuesRegisterViewController:SecurityQuestionSaveDelegate{
    func onClickSaveButton() {
//        let memberValue:String = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE) ?? ""
//
//        if memberValue == Constants.MEMBER {
//        openCamera(imagePickerControllerDelegate: self)
//        } else {
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
//        }
    }
    
}

extension SecQuesRegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
//            self.ivPreview.image = pickedImage
            //nextvc.data = previousData
            //nextvc.image = pickedImage
            //present(nextvc)
             print("image is not null")
        } else {
            print("image is null")
        }
        
    }
    
}
