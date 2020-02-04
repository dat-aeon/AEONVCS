//
//  RegistrationViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import DatePickerDialog
import SearchTextField

class RegistrationViewController: BaseUIViewController {
    
    @IBOutlet weak var svMemberRegister: UIScrollView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tfName: UITextField?
    @IBOutlet weak var lbNameErrorMessage: UILabel!
    
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lbAgeNotification: UILabel!
    @IBOutlet weak var tfDob: UITextField?
    @IBOutlet weak var lbDobErrorMessage: UILabel!
    
    @IBOutlet weak var lblNrcNo: UILabel!
    @IBOutlet weak var vDivision: UIView!
    @IBOutlet weak var lblDivision: UILabel!
    //@IBOutlet weak var vTownship: UIView!
    //@IBOutlet weak var lblTownship: UILabel!
    @IBOutlet weak var vNrcType: UIView!
    @IBOutlet weak var lblNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField?
    @IBOutlet weak var lbNrcNoErrorMessage: UILabel!
    
    @IBOutlet weak var tfTownshipAutoText: SearchTextField!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var tfPhoneNo: UITextField?
    @IBOutlet weak var lbPhoneNoErrorMessage: UILabel!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField?
    @IBOutlet weak var lbPasswordErrorMessage: UILabel!
    
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var tfConPassword: UITextField?
    @IBOutlet weak var lbConPassErrorMessage: UILabel!
    
    @IBOutlet weak var lbPasswordWarning: UILabel!
    
    @IBOutlet weak var imgDatepicker: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    private var confirmPhoneView: UIView!
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedTownshipList = [String]()
    var hotlineNo: String = ""
    
    // Error message Language control
    var nameMesgLocale: String?
    var dobMesgLocale: String?
    var nrcMesgLocale: String?
    var phoneMesgLocale : String?
    var passMesgLocale : String?
    var conPassMesgLocale: String?
    
    var checkMemberResponse : CheckMemberResponse?
    
    var isMemberAnnouncePopupShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//    self.btnRegister.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickRegister)))
//
        self.tfNrcNo?.setMaxLength(maxLength: 6)
        tfPhoneNo?.setMaxLength(maxLength: 11)
        tfPassword?.setMaxLength(maxLength: 16)
        tfConPassword?.setMaxLength(maxLength: 16)
        
        
        lbNameErrorMessage.text = Constants.BLANK
        lbDobErrorMessage.text = Constants.BLANK
        lbNrcNoErrorMessage.text = Constants.BLANK
        lbPhoneNoErrorMessage.text = Constants.BLANK
        lbPasswordErrorMessage.text = Constants.BLANK
        lbConPassErrorMessage.text = Constants.BLANK
        
        DispatchQueue.main.async {
            self.tfName?.becomeFirstResponder()
        }
//        self.tfName?.keyboardType = UIKeyboardType.namePhonePad
        self.tfName?.autocapitalizationType = .allCharacters
        self.tfNrcNo?.keyboardType = UIKeyboardType.numberPad
        self.tfPhoneNo?.keyboardType = UIKeyboardType.numberPad
        
        //autocomplete
        self.tfTownshipAutoText.theme.cellHeight = 40
        self.tfTownshipAutoText.maxResultsListHeight = 300
        self.tfTownshipAutoText.startVisible = true
        self.tfTownshipAutoText.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfTownshipAutoText.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfTownshipAutoText.theme.bgColor = UIColor.groupTableViewBackground
        self.tfTownshipAutoText.theme.separatorColor = UIColor.lightGray
        self.svMemberRegister.delegate = self
        
        // check network
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().loadNrcData(success: { (townshipList) in
            //RegisterViewModel.init().getNrcData(success: { (townshipList) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.allTownShipList = townshipList
            self.selectedTownshipList = townshipList[0]
            self.lblDivision.text = self.divisionList[0]
            //self.lblTownship.text = self.allTownShipList[0][0]
            self.tfTownshipAutoText.filterStrings(townshipList[0])
            self.lblNrcType.text = self.nrcTypeList[0]
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.JSON_FAILURE {
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
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
        // check network
        if Network.reachability.isReachable == false {
            self.networkConnectionError()
            return
        }

        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        //components.year = -10
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        datePickerView.maximumDate = maxDate

        tfDob?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
        
//        self.vTownship.layer.borderWidth = 1
//        self.vTownship.layer.cornerRadius = 4 as CGFloat
//        self.vTownship.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vDivision.layer.borderWidth = 1
        self.vDivision.layer.cornerRadius = 4 as CGFloat
        self.vDivision.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vNrcType.layer.borderWidth = 1
        self.vNrcType.layer.cornerRadius = 4 as CGFloat
        self.vNrcType.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        vDivision.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickDivisionDropDown)))
//        vTownship.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickTownshipDropDown)))
        vNrcType.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickNrcTypeDropDown)))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            var frame = self.tfNrcNo!.frame
            frame.size.width = 100
            self.tfNrcNo?.frame = frame
        }
        
        
        
        tfName?.delegate = self
        tfDob?.delegate = self
        tfNrcNo?.delegate = self
        tfPhoneNo?.delegate = self
        tfPassword?.delegate = self
        tfConPassword?.delegate = self
        
       
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.lblTitle.text = "register.title.label".localized
        self.lblName.text = "register.name.label".localized
        self.tfName?.placeholder = "register.name.holder".localized
        self.lblDob.text = "register.dob.label".localized
        self.lbAgeNotification.text = "register.dob.restrict.label".localized
        self.tfDob?.placeholder = "register.dob.holder".localized
        self.lblNrcNo.text = "register.nrc.label".localized
        self.lblPhoneNo.text = "register.phoneno.label".localized
        self.lblPassword.text = "register.password.label".localized
        self.lblConfirmPassword.text = "register.conpassword.label".localized
        self.lbPasswordWarning.text = "register.password.warning.label".localized
        self.btnRegister.setTitle("register.save.button".localized, for: UIControl.State.normal)
        
        self.tfNrcNo?.setNeedsLayout()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isMemberAnnouncePopupShowing {
            self.isMemberAnnouncePopupShowing = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "dismissPopupMemberAnnounce"), object: nil, userInfo: nil)
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
        self.lblTitle.text = "register.title.label".localized
        self.lblName.text = "register.name.label".localized
        self.tfName?.placeholder = "register.name.holder".localized
        self.lblDob.text = "register.dob.label".localized
        self.lbAgeNotification.text = "register.dob.restrict.label".localized
        self.tfDob?.placeholder = "register.dob.holder".localized
        self.lblNrcNo.text = "register.nrc.label".localized
        self.lblPhoneNo.text = "register.phoneno.label".localized
        self.lblPassword.text = "register.password.label".localized
        self.lblConfirmPassword.text = "register.conpassword.label".localized
        self.lbPasswordWarning.text = "register.password.warning.label".localized
        self.btnRegister.setTitle("register.save.button".localized, for: UIControl.State.normal)
        
        self.lbNameErrorMessage.text = self.nameMesgLocale?.localized
        self.lbDobErrorMessage.text = self.dobMesgLocale?.localized
        self.lbNrcNoErrorMessage.text = self.nrcMesgLocale?.localized
        self.lbPhoneNoErrorMessage.text = self.phoneMesgLocale?.localized
        self.lbPasswordErrorMessage.text = self.passMesgLocale?.localized
        self.lbConPassErrorMessage.text = self.conPassMesgLocale?.localized
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == self.tfName {
//            textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
//
//            return false
//        }
        
        return true
        
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification {
            svMemberRegister.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
            
        } else {
            svMemberRegister.contentInset = UIEdgeInsets.zero
        }
        svMemberRegister.scrollIndicatorInsets = svMemberRegister.contentInset
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        // example code
        self.tfTownshipAutoText.hideResultsList()
    }
    
    func isErrorExist() -> Bool {
        
        var isError = false
        // not to overwrite error message
        var isNRCError = false
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfName?.text = Constants.BLANK
            self.lbNameErrorMessage.text = Messages.NAME_EMPTY_ERROR.localized
            self.nameMesgLocale = Messages.NAME_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isNameValidate(name: (self.tfName!.text)!){
            
            self.lbNameErrorMessage.text = Messages.NAME_REG_FORMAT_ERROR.localized
            self.nameMesgLocale = Messages.NAME_REG_FORMAT_ERROR
            isError = true
            
        } else {
            self.nameMesgLocale = Constants.BLANK
            self.lbNameErrorMessage.text = Constants.BLANK
        }
        
        // Validate Date of Birth [dd-MM-yyyy]
        if self.tfDob?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfDob?.text = Constants.BLANK
            self.lbDobErrorMessage.text = Messages.DOB_EMPTY_ERROR.localized
            self.dobMesgLocale = Messages.DOB_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isDobValidate(dob: (self.tfDob?.text)!){
            self.lbDobErrorMessage.text = Messages.DOB_FORMAT_ERROR.localized
            self.dobMesgLocale = Messages.DOB_FORMAT_ERROR
            isError = true
            
        } else {
            self.dobMesgLocale = Constants.BLANK
            self.lbDobErrorMessage.text = Constants.BLANK
        }
        
        // Validate NRC Township
        if self.tfTownshipAutoText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbNrcNoErrorMessage.text = Messages.NRC_TOWNSHIP_EMPTY_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_TOWNSHIP_EMPTY_ERROR
            isError = true
            isNRCError = true
            
        } else if !self.selectedTownshipList.contains(self.tfTownshipAutoText.text!){
            self.lbNrcNoErrorMessage.text = Messages.NRC_TOWNSHIP_INVALID_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_TOWNSHIP_INVALID_ERROR
            isError = true
            isNRCError = true
            
        } else {
            self.lbNrcNoErrorMessage.text = Constants.BLANK
            self.nrcMesgLocale = Constants.BLANK
            isNRCError = false
        }
        
        // Validate Nrc No.
        if self.tfNrcNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfNrcNo?.text = Constants.BLANK
            self.lbNrcNoErrorMessage.text = Messages.NRC_NO_EMPTY_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_NO_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isNrcNoValidate(nrcNo: (self.tfNrcNo?.text)!){
            self.lbNrcNoErrorMessage.text = Messages.NRC_LENGTH_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_LENGTH_ERROR
            isError = true
            
        } else {
            if !isNRCError {
                self.lbNrcNoErrorMessage.text = Constants.BLANK
                self.nrcMesgLocale = Constants.BLANK
            }
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfPhoneNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfPhoneNo?.text = Constants.BLANK
            self.lbPhoneNoErrorMessage.text = Messages.PHONE_REG_EMPTY_ERROR.localized
            self.phoneMesgLocale = Messages.PHONE_REG_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isPhoneValidate(phoneNo: (self.tfPhoneNo?.text)!){
            // validate phone no format
            self.lbPhoneNoErrorMessage.text = Messages.PHONE_REG_LENGTH_ERROR.localized
            self.phoneMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
            isError = true
            
        } else {
            self.phoneMesgLocale = Constants.BLANK
            self.lbPhoneNoErrorMessage.text = Constants.BLANK
        }
        
        // Validate Password
        if self.tfPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfPassword?.text = Constants.BLANK
            self.lbPasswordErrorMessage.text = Messages.PASSWORD_EMPTY_ERROR.localized
            self.passMesgLocale = Messages.PASSWORD_EMPTY_ERROR
            isError = true
            
        } else if self.tfPassword?.text?.count ?? 0 < 6 || self.tfPassword?.text?.count ?? 0 > 16 {
            self.tfPassword?.text = Constants.BLANK
            self.lbPasswordErrorMessage.text = Messages.PASSWORD_LENGTH_ERROR.localized
            self.passMesgLocale = Messages.PASSWORD_LENGTH_ERROR
            isError = true
            
        } else {
            self.lbPasswordErrorMessage.text = Constants.BLANK
            self.passMesgLocale = Constants.BLANK
        }
        
        if self.tfConPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfConPassword?.text = Constants.BLANK
            self.lbConPassErrorMessage.text = Messages.CON_PASSWORD_EMPTY_ERROR.localized
            self.conPassMesgLocale = Messages.CON_PASSWORD_EMPTY_ERROR
            isError = true
            
        }else if self.tfPassword?.text != self.tfConPassword?.text{
            self.tfConPassword?.text = Constants.BLANK
            self.lbConPassErrorMessage.text = Messages.PASSWORD_NOT_MATCH_ERROR.localized
            self.conPassMesgLocale = Messages.PASSWORD_NOT_MATCH_ERROR
            isError = true
            
        } else {
            self.lbConPassErrorMessage.text = Constants.BLANK
            self.conPassMesgLocale = Constants.BLANK
        }
        return isError
    }
    
    @IBAction func onClickSave(_ sender: UIButton) {
        
        if isErrorExist() {
            return
        }
        //loadCustomViewIntoController()
        //return
        let divisionCode: String = (self.lblDivision?.text!)!
        let townshipCode: String = (self.tfTownshipAutoText?.text!)!
        let nrcType: String = (self.lblNrcType?.text!)!
        let nrcNo: String = (self.tfNrcNo?.text!)!
        
        let nrc = divisionCode + "/" + townshipCode + nrcType + nrcNo
        
        var registerBean = RegisterRequestBean()
        registerBean.name = (self.tfName?.text!.uppercased())!
        registerBean.dob = super.changeYMDformat(date: (self.tfDob?.text!)!)
        registerBean.nrc = nrc
        registerBean.phoneNo = (self.tfPhoneNo?.text!)!
        registerBean.password = (self.tfPassword?.text!)!
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().checkMember(registerBean: registerBean, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if result.data?.messageCode == Constants.PWD_WEAK {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: Messages.PASSWORD_WEAK_ERROR.localized)
                
            } else if result.data?.messageCode == Constants.INVALID_AGE {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: Messages.INVALID_AGE_ERROR.localized)
                
            } else if result.data?.messageCode == Constants.PHONE_DUPLICATE {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: Messages.PHONE_DUPLICATE_ERROR.localized)
                
            } else if result.data?.messageCode == Constants.NRC_DUPLICATE {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: Messages.NRC_DUPLICATE_ERROR.localized)
                
            } else if result.data?.messageCode == Constants.DUPLICATED_CUSTOMER_INFO {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: Messages.REGISTER_DUPLICATE_ERROR.localized)
                
            } else if result.data?.messageCode == Constants.IMPORT_PH_DUPLICATE {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: Messages.IMPORT_PH_DUPLICATE_ERROR.localized)
                
            } else if result.data?.messageCode == Constants.DUPLICATED_NRC_NO_CORE_SYSTEM {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: Messages.NRC_DUPLICATE_ON_CORE_ERROR.localized)
                
            } else{
                if result.data?.memberStatus == Constants.MEMBER{
                    // save in user default
                    UserDefaults.standard.set(result.data?.memberStatus, forKey: Constants.CUSTOMER_TYPE)
                    self.hotlineNo = (result.data?.hotlinePhone)!
                    self.checkMemberResponse = result
                    self.openAnnouncePopUp(phoneNo: result.data?.memberPhoneNo ?? "09", checkMemberResponse: result, registerBean: registerBean)
                    
//                    let alertController = UIAlertController(title: "Announce", message: "For Membership process, OTP code will be sent to your registered phone no (\(result.data?.memberPhoneNo ?? "09")) .Click “OK” if your phone number has no changes.Click “Call Now” if your phone number has changes.", preferredStyle: .alert)
//                    alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
//                        self.goToSecQuesRegisterView(result: result,registerRequestData:registerBean)
//                    }))
//
//                    alertController.addAction(UIAlertAction(title: "“Call Now” if your phone number has changes.", style: UIAlertAction.Style.default, handler: .none))
//                    alertController.addAction(UIAlertAction(title: Constants.CALL_NOW, style: UIAlertAction.Style.default, handler: { action in
//                        self.hotlineNo.makeCall()
//                    }))
//                    self.present(alertController, animated: true, completion: nil)
//
                }else if result.data?.memberStatus == Constants.NON_MEMBER {
                    // save in user default
                    UserDefaults.standard.set(result.data?.memberStatus, forKey: Constants.CUSTOMER_TYPE)
                    self.goToSecQuesRegisterView(result: result,registerRequestData:registerBean)
                }
                
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
    
    private func goToSecQuesRegisterView(result:CheckMemberResponse,registerRequestData:RegisterRequestBean){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SEC_QUES_REGISTER_VIEW_CONTROLLER) as! UINavigationController
        let vc = navigationVC.children.first as! SecQuesRegisterViewController
        vc.memberResponseData = result
        vc.registerRequestData = registerRequestData
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func didPressButtonFromCustomView(sender:UIButton) {
        // do whatever you want
        // make view disappears again, or remove from its superview
    }

    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func dobDatePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        tfDob?.text = dateFormatter.string(from: sender.date)
        
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        // Apply date format
        //let selectedDate: String = dateFormatter.string(from: sender.date)
        
        //print("Selected value \(selectedDate)")
    }
    @objc func onClickDivisionDropDown(){
        self.tfName?.resignFirstResponder()
        self.tfDob?.resignFirstResponder()
        self.tfNrcNo?.resignFirstResponder()
        self.tfPhoneNo?.resignFirstResponder()
        self.tfPassword?.resignFirstResponder()
        self.tfConPassword?.resignFirstResponder()
        self.tfTownshipAutoText.resignFirstResponder()
        openDivisionSelectionPopUp()
    }
    
    @objc func onClickTownshipDropDown(){
        self.tfName?.resignFirstResponder()
        self.tfDob?.resignFirstResponder()
        self.tfNrcNo?.resignFirstResponder()
        self.tfPhoneNo?.resignFirstResponder()
        self.tfPassword?.resignFirstResponder()
        self.tfConPassword?.resignFirstResponder()
        self.tfTownshipAutoText.resignFirstResponder()
        openTownshipSelectionPopUp()
    }
    
    @objc func onClickNrcTypeDropDown(){
        self.tfName?.resignFirstResponder()
        self.tfDob?.resignFirstResponder()
        self.tfNrcNo?.resignFirstResponder()
        self.tfPhoneNo?.resignFirstResponder()
        self.tfPassword?.resignFirstResponder()
        self.tfConPassword?.resignFirstResponder()
        self.tfTownshipAutoText.resignFirstResponder()
        openNrcTypeSelectionPopUp()
    }
    
    func openDivisionSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lblDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count >= Int(value)!{
                self.selectedTownshipList = self.allTownShipList[Int(value)! - 1]
                //self.lblTownship.text = self.selectedTownshipList[0]
                self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                //print(value)
                //print("\(self.selectedTownshipList)")
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lblDivision
            }
            
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lblDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count >= Int(value)!{
                    self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
                    //self.lblTownship.text = self.selectedTownshipList[0]
                    self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(action, animated: true, completion: nil)
        }
    }
    
    func openTownshipSelectionPopUp() {

        // popup view test
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
    
    func openNrcTypeSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
            self.lblNrcType.text = value
            //print(value)
        
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lblNrcType
            }
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
                self.lblNrcType.text = value
                //print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(action, animated: true, completion: nil)
        }
    }
    
    // show announce alert box
    func openAnnouncePopUp(phoneNo : String , checkMemberResponse : CheckMemberResponse, registerBean : RegisterRequestBean) {
        
        let firstTwo = phoneNo.prefix(2)
        let lastThree = phoneNo.suffix(3)
        
        var xSting = ""
        let maxCount = phoneNo.count - 5
        for _ in 0..<maxCount  {
            xSting += "x"
        }
        
        // popup view test
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MEMBER_ANNOUNCE_POPUP_VIEW_CONTROLLER) as! MemberAnnouncePopupViewController
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        
        self.definesPresentationContext = true
        popupVC.popupDelegate = self
        popupVC.lbMessage.text = "For Membership process, OTP code will be sent to your registered phone no (\(firstTwo)\(xSting)\(lastThree)) .Click “OK” if your phone number has no changes."
        popupVC.lbCallNowNotice.text = "If your phone number has any changes, please contact to AEON."
        popupVC.checkMemberResponse = checkMemberResponse
        popupVC.registerBean = registerBean
        
        self.isMemberAnnouncePopupShowing = true
        self.present(popupVC, animated: true, completion: nil)
        
    }
    
}

extension RegistrationViewController: TownshipSelectDelegate {
    func onClickTownshipCode(townshipCode: String) {
       // self.lblTownship.text = townshipCode
    }
}

extension RegistrationViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tfTownshipAutoText.hideResultsList()
    }
}

extension RegistrationViewController : AnnouncePopupButtonDelegate {
    func onClickOkBtn(checkMemberReponse: CheckMemberResponse, registerBean: RegisterRequestBean) {
        self.goToSecQuesRegisterView(result: checkMemberResponse!,registerRequestData:registerBean)

    }
    
    func onClickCallNow() {
        self.hotlineNo.makeCall()
    }
    
    
}


