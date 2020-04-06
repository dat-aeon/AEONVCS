//
//  SecQuesRegisterViewController.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecQuesRegisterViewController: BaseUIViewController {
    
    
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarPhNo: UILabel!
    
    @IBOutlet weak var tvSecQuesRegView: UITableView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var numOfQuestion: Int = 0
    var numOfAnsCount: Int = 0
    var secQMy = [String]()
    var secQEng = [String]()
    var questionList = [String]()
    var secQuesList = [SecQuesListBean]()
    var qaList = [SecQABean]()
    var selectedQues = [Int]()
    var answersList = [String]()
    
    var memberResponseData:CheckMemberResponse?
    var registerRequestData:RegisterRequestBean?
    
    var registerCells = [SecQuesRegisterTableViewCell]()
    
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
            self.networkConnectionError()
            return
        }
        
        loadSecurityQuestionLIst()
        
        self.tvSecQuesRegView.register(UINib(nibName: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL)
        self.tvSecQuesRegView.register(UINib(nibName: CommonNames.SEC_QUEST_REGISTER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_REGISTER_TABLE_CELL)
        self.tvSecQuesRegView.register(UINib(nibName: CommonNames.SEC_QUEST_SAVE_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SEC_QUEST_SAVE_TABLE_CELL)
        
        //open thid comment in real
        self.tvSecQuesRegView.dataSource = self
        self.tvSecQuesRegView.delegate = self
        self.tvSecQuesRegView.tableFooterView = UIView()
        
         self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
        self.tvSecQuesRegView.reloadData()
    }
    
    @objc func onTapBack() {
       print("click")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onTapMMLocale() {
       print("click")
        super.NewupdateLocale(flag: 1)
        updateViews()
        tvSecQuesRegView.reloadData()
    }
    @objc func onTapEngLocale() {
       print("click")
        super.NewupdateLocale(flag: 2)
        updateViews()
        tvSecQuesRegView.reloadData()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
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
        //self.dismiss(animated: true, completion: nil)
    }
    
    private func loadSecurityQuestionLIst(){
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        SecQuesRegisterViewModel.init().getSecQuesList(siteActivationKey: Constants.site_activation_key, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.numOfQuestion = result.numOfQuestion
            self.numOfAnsCount = result.numOfAnsCount
            self.secQEng = result.questionList[1]
            self.secQMy = result.questionList[0]
            self.secQuesList = result.secQuesList
            switch Locale.currentLocale {
            case .EN:
                self.bbLocaleFlag.image = UIImage(named: "mm_flag")
                self.questionList = self.secQEng
            case .MY:
                self.bbLocaleFlag.image = UIImage(named: "en_flag")
                self.questionList = self.secQMy
            }
            self.registerCells = [SecQuesRegisterTableViewCell](repeating: SecQuesRegisterTableViewCell(), count: self.numOfQuestion)
            
            self.selectedQues = [Int](repeating: Int(), count: self.numOfQuestion)
            self.answersList = [String](repeating: String(), count: self.numOfQuestion)
            self.tvSecQuesRegView.reloadData()
            
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: Constants.LOADING_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.REGISTER_VIEW_CONTROLLER) as! RegistrationViewController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        }
    }
    
}

extension SecQuesRegisterViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.numOfQuestion
        }
        return 1

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_REG_HEADER_TABLE_CELL, for: indexPath) as! SecQuesRegHeaderTableViewCell
            cell.selectionStyle = .none
            cell.lblHeader.text = "secquest.title".localized
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_REGISTER_TABLE_CELL, for: indexPath) as! SecQuesRegisterTableViewCell
            cell.selectionStyle = .none
            cell.setData( data: self.questionList,answerCount:self.numOfAnsCount, row: indexPath.row)
            // for register only
            cell.tfsecAnswer.setMaxLength(maxLength: self.numOfAnsCount)
            
            if cell.lblSecQuestion.text == Constants.BLANK {
                 cell.lblSecQuestion.text = self.questionList[0]
                 self.selectedQues[indexPath.row] = 0
                //print("Cell data Blank:", self.selectedQues.count)
                
            } else {
                //print("Cell data:", self.selectedQues.count)
                //print("Cell data:", cell.lblSecQuestion.text!)
                cell.lblSecQuestion.text = self.questionList[self.selectedQues[indexPath.row]]
            }
            
            cell.lblQuesNo.text = "Q\(indexPath.row+1):"
            cell.lblAnsNo.text = "Ans\(indexPath.row+1):"
            cell.cellClickDelegate = self
            cell.lbMessage.text = cell.answerMesgLocale?.localized
            
            registerCells[indexPath.row] = cell
//            print("register cell",indexPath.row, cell.rowIndex)
//            if indexPath.row == 0 {
//                DispatchQueue.main.async {
//                    cell.tfsecAnswer.becomeFirstResponder()
//                }
//            }
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SEC_QUEST_SAVE_TABLE_CELL, for: indexPath) as! SecQuesSaveTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.ivSaveBtn.setTitle("secquest.save.button".localized, for: UIButton.State.normal)
        return cell
    }

}

extension SecQuesRegisterViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(70.0)
            
        } else if indexPath.section == 1{
            return CGFloat(170.0)
            
        }
        return CGFloat(100.0)
    }

}

extension SecQuesRegisterViewController:SecQuesRegisterCellClickDelegate{
    func onClickSecQuesList(quesList: [String],cell:SecQuesRegisterTableViewCell, row: Int) {
        

        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: quesList, action: { (value)  in
                cell.lblSecQuestion.text = value
                if let selectedIndex = quesList.firstIndex(of: value){
                    self.selectedQues[row] = selectedIndex
//                    print("select index = \(row),\(selectedIndex)")
                }
//                print(value)
                // focus on answer textfield
                DispatchQueue.main.async {
                    cell.tfsecAnswer.becomeFirstResponder()
                }
                
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
//                    print("select index = \(row),\(selectedIndex)")
                }
//                print(value)
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

extension SecQuesRegisterViewController:SecurityQuestionSaveDelegate{
    func onClickSaveButton() {
        
        var secIdList:[Int] = []
        var secQuestionAndAnswer:[SecQABean] = []
        var selectedQuestionId: Int = 0
        
        print("register cells", registerCells.count)
        var isError = false
        for i in 0..<registerCells.count {
//            print("register cells", registerCells[i].rowIndex)
            //            let indexPath = IndexPath(row: i, section: 0)
            //            let cell = self.tvSecQuesRegView.cellForRow(at: indexPath) as! SecQuesRegisterTableViewCell
            let cell = registerCells[i]
//            print("ques:\(i), \(cell.lblSecQuestion.text ?? "0")")
//            print("answer:\(cell.tfsecAnswer.text ?? "0")")
            
            //Validate Answer
            if cell.tfsecAnswer.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                cell.tfsecAnswer.text = Constants.BLANK
                cell.lbMessage.text = Messages.ANSWER_EMPTY_ERROR.localized
                cell.answerMesgLocale = Messages.ANSWER_EMPTY_ERROR
                isError = true
                
            } else if !Utils.isAnswerValidate(name: cell.tfsecAnswer.text!) {
                cell.lbMessage.text = Messages.ANSWER_FORMAT_ERROR.localized
                cell.answerMesgLocale = Messages.ANSWER_FORMAT_ERROR
                isError = true
                
            }else{
                cell.lbMessage.text = Constants.BLANK
                cell.answerMesgLocale = Constants.BLANK
            }
            if let selectedIndex = questionList.firstIndex(of: "\(cell.lblSecQuestion.text!)"){
                selectedQuestionId = secQuesList[selectedIndex].secQuestionId!
                let secQABean = SecQABean(questionId: selectedQuestionId, answer: cell.tfsecAnswer.text!)
                secQuestionAndAnswer.append(secQABean)
            }
            if i != 0 {
                if secIdList.contains(selectedQuestionId) {
                    if cell.lbMessage.text?.isEmpty ?? true {
                        cell.lbMessage.text = Messages.QUESTION_SAME_ERROR.localized
                        cell.answerMesgLocale = Messages.QUESTION_SAME_ERROR
                        isError = true
                    }
                    
                } else {
//                    cell.lbMessage.text = Constants.BLANK
//                    cell.answerMesgLocale = Constants.BLANK
                }
            }
            secIdList.append(selectedQuestionId)
//            print("ID LIST:::\(secIdList)")
        }
        
        if isError {
            return
        }
        
        self.qaList = secQuestionAndAnswer
        let memberValue:String = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE) ?? ""
        
        if memberValue == Constants.MEMBER {
            //openCamera(imagePickerControllerDelegate: self)
            
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.REGISTER_PHOTO_UPLOAD_VIEW_CONTROLLER) as! UINavigationController
//            let vc = navigationVC.children.first as! RegisterPhotoUploadViewController
            let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.REGISTER_PHOTO_UPLOAD_VIEW_CONTROLLER) as! RegisterPhotoUploadViewController
            vc.registerRequestData = self.registerRequestData
            vc.memberResponseData = self.memberResponseData!
            vc.qaList = self.qaList
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)

            
            //testing
//
//            let navigationVC1 = self.storyboard?.instantiateViewController(withIdentifier: "OTPRegisterViewController") as! UINavigationController
//            let vc1 = navigationVC1.children.first as! OTPRegisterViewController
//            vc1.registerRequestData = self.registerRequestData
//            vc1.memberResponseData = self.memberResponseData!
//            vc1.qaList = self.qaList
//            vc1.otpCode = "1111"
//            //vc1.profileImage = self.ivProfile.image
//            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            self.present(navigationVC1, animated: true, completion: nil)
//
            
        } else {
            
            // check network
            if Network.reachability.isReachable == false {
                Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
                return
            }
            
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            RegisterViewModel.init().makeRegisterNewMember(registerRequestData:registerRequestData!,memberResponseData: memberResponseData!, qaList:secQuestionAndAnswer , success: { (newRegisterResponse) in
                
                LoginAuthViewModel.init().accessLoginToken(phoneNo: (self.registerRequestData?.phoneNo)!, password: (self.registerRequestData?.password)!, success: { (result) in
                    
//                    let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
//                    let tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
//
//                    LoginViewModel.init().login(phoneNo: (self.registerRequestData?.phoneNo)!,token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
                    // success
                    var sessionData = SessionDataBean()
                    sessionData.customerId = result.data.customerId
                    sessionData.customerNo = result.data.customerNo
                    sessionData.customerTypeId = result.data.customerTypeId
                    sessionData.dateOfBirth = result.data.dateOfBirth
                    sessionData.memberNo = result.data.memberNo
                    sessionData.name = result.data.name
                    sessionData.nrcNo = result.data.nrcNo
                    sessionData.phoneNo = result.data.phoneNo
                    sessionData.photoPath = result.data.photoPath
                    sessionData.userTypeId = result.data.userTypeId
                    sessionData.hotlineNo = result.data.hotlinePhone
                    sessionData.customerAgreementDtoList = result.data.customerAgreementDtoList
                    sessionData.memberNoValid = result.data.memberNoValid
                    
                    if (result.data.customerNo == nil) {
                        UserDefaults.standard.set(Constants.NON_MEMBER, forKey: Constants.CUSTOMER_TYPE)
                    } else {
                        UserDefaults.standard.set(Constants.MEMBER, forKey: Constants.CUSTOMER_TYPE)
                    }
                    
                    UserDefaults.standard.set(result.data.customerId, forKey: Constants.USER_INFO_CUSTOMER_ID)
                    UserDefaults.standard.set(result.data.phoneNo, forKey: Constants.USER_INFO_PHONE_NO)
                     UserDefaults.standard.set(result.data.name, forKey: Constants.USER_INFO_NAME)
                    UserDefaults.standard.set(super.generateCurrentTimeStamp(), forKey : Constants.LOGIN_TIME)
                    UserDefaults.standard.set(false, forKey: Constants.IS_LOGOUT)
                    UserDefaults.standard.set(nil, forKey: Constants.SESSION_INFO)
                    UserDefaults.standard.set(super.generateCurrentTimeStamp(), forKey: Constants.LAST_USED_TIME)
                    
                    let jsonData = try? JSONEncoder().encode(sessionData)
                    let jsonString = String(data: jsonData!, encoding: .utf8)!
                    UserDefaults.standard.set(jsonString, forKey: Constants.SESSION_INFO)
                    
//                    print("REGISTER CUSTOMER-ID:::::::: \(String(describing: UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)))")
                    
                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    
                    let alert = UIAlertController(title: Constants.LOGIN_SUCCESS_TITLE, message: Messages.BIOMETRIC_REGISTER_INFO.localized, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: { action in
                        
//                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.BIOMETRIC_VIEW_CONTROLLER) as! UINavigationController
//                        let vc = navigationVC.children.first as! BioMetricRegisterViewController
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.BIOMETRIC_VIEW_CONTROLLER) as! BioMetricRegisterViewController
                        vc.isAlreadyLogin = true
                        vc.sessionData = sessionData
                        
                        print("security Q : to Login")
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true, completion: nil)
                        
                    })
                    let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: { action in
                        
//                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_PAGE_VIEW_CONTROLLER) as! UINavigationController
//                        let vc = navigationVC.children.first as! HomePageViewController
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.HOME_NEW_VIEW_CONTROLLER) as! HomeNewViewController
                        vc.sessionDataBean = sessionData
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true, completion: nil)
                        
                    })
                    alert.addAction(okAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }) { (error) in
                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                }
                
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
                if error == Constants.SERVER_FAILURE {
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                    
                } else {
                    Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: error)
                }
            }
        }
    }
    
}

extension SecQuesRegisterViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {

//             print("image is not null")
            
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MEMBER_INFO_PREVIEW_VIEW_CONTROLLER) as! UINavigationController
//            let vc = navigationVC.children.first as! MemberInfoPreviewViewController
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MEMBER_INFO_PREVIEW_VIEW_CONTROLLER) as! MemberInfoPreviewViewController
            
            vc.registerRequestData = self.registerRequestData
            vc.profileImage = pickedImage
            vc.memberResponseData = self.memberResponseData!
            vc.qaList = self.qaList
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            
        } else {
//            print("image is null")
        }
        
    }
    
}
