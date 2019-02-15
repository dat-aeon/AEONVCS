//
//  RegistrationViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import DatePickerDialog

class RegistrationViewController: BaseUIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var svMemberRegister: UIScrollView!
    
    @IBOutlet weak var tfName: UITextField?
    @IBOutlet weak var tfDob: UITextField?
    @IBOutlet weak var vDivision: UIView!
    @IBOutlet weak var lblDivision: UILabel!
    @IBOutlet weak var vTownship: UIView!
    @IBOutlet weak var lblTownship: UILabel!
    @IBOutlet weak var vNrcType: UIView!
    @IBOutlet weak var lblNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField?
    @IBOutlet weak var tfPhoneNo: UITextField?
    @IBOutlet weak var tfPassword: UITextField?
    @IBOutlet weak var tfConPassword: UITextField?
    
    @IBOutlet weak var imgDatepicker: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    private var confirmPhoneView: UIView!
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedTownshipList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//    self.btnRegister.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickRegister)))
//
        //self.confirmPhoneView.isHidden = true
        
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().loadNrcData(success: { (result) in
            RegisterViewModel.init().getNrcData(success: { (townshipList) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                self.allTownShipList = townshipList
                self.selectedTownshipList = townshipList[0]
                self.lblDivision.text = self.divisionList[0]
                self.lblTownship.text = self.allTownShipList[0][0]
                self.lblNrcType.text = self.nrcTypeList[0]
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: "Loading Error", message: error)
            }
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Loading Failed", message: error)
        }
        
        tfDob?.delegate = self
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = -10
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        datePickerView.maximumDate = maxDate

        tfDob?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
        
        self.vTownship.layer.borderWidth = 1
        self.vTownship.layer.cornerRadius = 4 as CGFloat
        self.vTownship.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vDivision.layer.borderWidth = 1
        self.vDivision.layer.cornerRadius = 4 as CGFloat
        self.vDivision.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vNrcType.layer.borderWidth = 1
        self.vNrcType.layer.cornerRadius = 4 as CGFloat
        self.vNrcType.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        vDivision.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickDivisionDropDown)))
        vTownship.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickTownshipDropDown)))
        vNrcType.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickNrcTypeDropDown)))
        
        
        tfName?.delegate = self
        tfDob?.delegate = self
        tfNrcNo?.delegate = self
        tfPhoneNo?.delegate = self
        tfPassword?.delegate = self
        tfConPassword?.delegate = self
        
        tfNrcNo?.setMaxLength(maxLength: 6)
        tfPassword?.setMaxLength(maxLength: 6)
        tfConPassword?.setMaxLength(maxLength: 6)
        
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification : Notification) {
        
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

    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        
        var isError = false
        
         if self.tfName?.text?.isEmpty ?? true{
            self.tfName?.showError(message: "Please input name")
            isError = true
        }
        
        if self.tfDob?.text?.isEmpty ?? true{
            self.tfDob?.showError(message: "Please input your birthday")
            isError = true
        }
        
        if self.tfNrcNo?.text?.isEmpty ?? true{
            self.tfNrcNo?.showError(message: "Please input NRC No.")
            isError = true
        }
        
        if self.tfPhoneNo?.text?.isEmpty ?? true{
            self.tfPhoneNo?.showError(message: "Please input phone no.")
            isError = true
        }
        
        if self.tfPassword?.text?.isEmpty ?? true{
            self.tfPassword?.showError(message: "Please input password")
            isError = true
        }
        
        if self.tfConPassword?.text?.isEmpty ?? true{
            self.tfConPassword?.showError(message: "Please input confirm password")
            isError = true
        }
        
        if self.tfPassword?.text?.count ?? 0 > 5{
            self.tfPassword?.showError(message: "Please input confirm password")
            isError = true
        }
        if self.tfConPassword?.text?.count ?? 0 > 5 {
            self.tfConPassword?.showError(message: "Please input confirm password")
            isError = true
        }
        
        if isError {
            return
        }else if self.tfPassword?.text != self.tfConPassword?.text{
            self.tfConPassword?.text = ""
            self.tfConPassword?.showError(message: "Not Match Password")
            return
        }
        //loadCustomViewIntoController()
        //return
        let divisionCode: String = (self.lblDivision?.text!)!
        let townshipCode: String = (self.lblTownship?.text!)!
        let nrcType: String = (self.lblNrcType?.text!)!
        let nrcNo: String = (self.tfNrcNo?.text!)!
        
        let nrc = divisionCode + "/" + townshipCode + nrcType + nrcNo
        
        var registerBean = RegisterRequestBean()
        registerBean.name = (self.tfName?.text!)!
        registerBean.dob = (self.tfDob?.text!)!
        registerBean.nrc = nrc
        registerBean.phoneNo = (self.tfPhoneNo?.text!)!
        registerBean.password = (self.tfPassword?.text!)!
        
        let alertController = UIAlertController(title: "Title", message: "For Membership process, OTP code will be sent to your registered phone no (\(registerBean.phoneNo)) .Click “OK” if your phone number has no changes.Click “Call Now” if your phone number has changes.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            self.checkMemberType(registerRequestData: registerBean)
        }))
        alertController.addAction(UIAlertAction(title: "Call Now", style: UIAlertAction.Style.default, handler: { action in
            let phoneNumber = "0942332939239"
            phoneNumber.makeCall()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func checkMemberType(registerRequestData:RegisterRequestBean){
        RegisterViewModel.init().checkMember(registerBean: registerRequestData, success: { (result) in
                self.goToSecQuesRegisterView(result: result,registerRequestData:registerRequestData)
        }) { (error) in
             Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
        }
    }
    
    private func goToSecQuesRegisterView(result:CheckMemberResponse,registerRequestData:RegisterRequestBean){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuesRegisterViewController") as! UINavigationController
        let vc = navigationVC.children.first as! SecQuesRegisterViewController
        vc.memberResponseData = result
        vc.registerRequestData = registerRequestData
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
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        print("Selected value \(selectedDate)")
    }
    @objc func onClickDivisionDropDown(){
        openDivisionSelectionPopUp()
    }
    
    @objc func onClickTownshipDropDown(){
        openTownshipSelectionPopUp()
    }
    
    @objc func onClickNrcTypeDropDown(){
        openNrcTypeSelectionPopUp()
    }
    
    func openDivisionSelectionPopUp() {
        let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
            self.lblDivision.text = self.divisionList[Int(value)!-1]
            if self.allTownShipList.count>Int(value)!{
            self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
            self.lblTownship.text = self.selectedTownshipList[0]
            }
            print(value)
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    func openTownshipSelectionPopUp() {
        let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, action: { (value)  in
            self.lblTownship.text = value
            print(value)
            
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    func openNrcTypeSelectionPopUp() {
        let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
            self.lblNrcType.text = value
            print(value)
            
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
}
