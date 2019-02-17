//
//  SecQuesRegisterViewController.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesRegisterViewController: BaseUIViewController {

    @IBOutlet weak var tvSecQuesRegView: UITableView!
    
    var numOfQuestion: Int = 0
    var numOfAnsCount: Int = 0
    var secQMy = [String]()
    var secQEng = [String]()
    var questionList = [String]()
    var secQuesList = [SecQuesListBean]()
    var qaList = [SecQABean]()
    
    var memberResponseData:CheckMemberResponse?
    var registerRequestData:RegisterRequestBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSecurityQuestionLIst()

        self.tvSecQuesRegView.register(UINib(nibName: "SecQuesRegisterTableViewCell", bundle: nil), forCellReuseIdentifier: "SecQuesRegisterTableViewCell")
        self.tvSecQuesRegView.register(UINib(nibName: "SecQuesSaveTableViewCell", bundle: nil), forCellReuseIdentifier: "SecQuesSaveTableViewCell")
        
        //open thid comment in real
        self.tvSecQuesRegView.dataSource = self
        self.tvSecQuesRegView.delegate = self
       
    }
 
    @objc override func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            tvSecQuesRegView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            tvSecQuesRegView.contentInset = UIEdgeInsets.zero
        }
        tvSecQuesRegView.scrollIndicatorInsets = tvSecQuesRegView.contentInset
        
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadSecurityQuestionLIst(){
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesRegisterViewModel.init().getSecQuesList(siteActivationKey: "12345678", success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.numOfQuestion = result.numOfQuestion
            self.numOfAnsCount = result.numOfAnsCount
            self.secQEng = result.questionList[0]
            self.secQMy = result.questionList[1]
            self.secQuesList = result.secQuesList
            switch Locale.currentLocale {
            case .EN:
                self.questionList = self.secQEng
            case .MY:
                self.questionList = self.secQMy
            }
            self.tvSecQuesRegView.reloadData()
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
        }
    }
}

extension SecQuesRegisterViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.numOfQuestion
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesRegisterTableViewCell", for: indexPath) as! SecQuesRegisterTableViewCell
            cell.selectionStyle = .none
            cell.setData(data: self.questionList,answerCount:self.numOfAnsCount)
            cell.cellClickDelegate = self
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecQuesSaveTableViewCell", for: indexPath) as! SecQuesSaveTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
}




extension SecQuesRegisterViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(160.0)
            
        }
        return CGFloat(100.0)
    }
}

extension SecQuesRegisterViewController:SecQuesRegisterCellClickDelegate{
    func onClickSecQuesList(quesList: [String],cell:SecQuesRegisterTableViewCell) {
        let action = UIAlertController.actionSheetWithItems(items: quesList, action: { (value)  in
            cell.lblSecQuestion.text = value
            print(value)
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(action, animated: true, completion: nil)
        
    }
}

extension SecQuesRegisterViewController:SecurityQuestionSaveDelegate{
    func onClickSaveButton() {
        var secQuestionAndAnswer:[SecQABean] = []
        for i in 0..<tvSecQuesRegView.numberOfRows(inSection: 0){
            let indexPath = IndexPath(row: i, section: 0)
            let cell = tvSecQuesRegView.cellForRow(at: indexPath) as! SecQuesRegisterTableViewCell
            if !(cell.tfsecAnswer.text?.isEmpty)!{
                if let selectedIndex = questionList.firstIndex(of: "\(cell.lblSecQuestion.text!)"){
                    let selectedQuestionId = secQuesList[selectedIndex].secQuestionId
                    let secQABean = SecQABean(questionId: selectedQuestionId, answer: cell.tfsecAnswer.text!)
                    secQuestionAndAnswer.append(secQABean)
                }
            }else{
                cell.tfsecAnswer.showError(message: "Enter Answer")
                return
            }
        }
        self.qaList = secQuestionAndAnswer
        let memberValue:String = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE) ?? ""
        
        if memberValue == Constants.MEMBER {
            openCamera(imagePickerControllerDelegate: self)
        } else {
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            RegisterViewModel.init().makeRegisterNewMember(registerRequestData:registerRequestData!,memberResponseData: memberResponseData!, qaList:secQuestionAndAnswer , success: { (newRegisterResponse) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
                let vc = navigationVC.children.first as! HomeViewController
                let registerResponse = RegisterResponse(
                    customerId: "\(newRegisterResponse.customerId!)",
                    customerNo: newRegisterResponse.customerNo ?? "",
                    phoneNo: newRegisterResponse.phoneNo!,
                    customerTypeId: "\(newRegisterResponse.customerTypeId!)",
                    userTypeId: "\(newRegisterResponse.userTypeId!)",
                    name: newRegisterResponse.name!,
                    dateOfBirth: newRegisterResponse.dateOfBirth!,
                    nrcNo: newRegisterResponse.nrcNo!,
                    status: newRegisterResponse.status!,
                    photoPath: newRegisterResponse.photoPath ?? "")
                vc.registerResponse = registerResponse
                
                self.present(navigationVC, animated: true, completion: nil)
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: "Register Failed", message: error)
            }
        }
    }
    
}

extension SecQuesRegisterViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
//            self.ivPreview.image = pickedImage
            //nextvc.data = previousData
            //nextvc.image = pickedImage
            //present(nextvc)
             print("image is not null")
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberInfoPreviewViewController") as! UINavigationController
            let vc = navigationVC.children.first as! MemberInfoPreviewViewController
            vc.registerRequestData = self.registerRequestData
            vc.profileImage = pickedImage ?? UIImage(named: "Image")!
            vc.memberResponseData = self.memberResponseData!
            vc.qaList = self.qaList
            self.present(navigationVC, animated: true, completion: nil)
            
            //            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberInfoPreviewViewController") as! UINavigationController
            //            let vc = navigationVC.children.first as! MemberInfoPreviewViewController
            //            vc.registerRequestData = self.registerRequestData
            //            vc.profileImage = UIImage(named: "Image")!
            //            vc.memberResponseData = self.memberResponseData!
            //            vc.qaList = secQuestionAndAnswer
            //            self.present(navigationVC, animated: true, completion: nil)
        } else {
            print("image is null")
        }
        
    }
    
}
