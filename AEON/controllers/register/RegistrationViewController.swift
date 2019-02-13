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
    
//    var datePicker: UIDatePicker {
//        get {
//            let datePicker = UIDatePicker()
//            datePicker.date = Date()
//            datePicker.datePickerMode = .date
//          datePicker.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
//            datePicker.backgroundColor = UIColor.white
//            return datePicker
//        }
//    }
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14"]
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
//    self.btnRegister.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickRegister)))
//
        //self.confirmPhoneView.isHidden = true
        tfDob?.delegate = self
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        tfDob?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
//        let datePicker: UIDatePicker = UIDatePicker()
//
//        // Posiiton date picket within a view
//        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
//
//        // Set some of UIDatePicker properties
//        datePicker.timeZone = NSTimeZone.local
//        datePicker.backgroundColor = UIColor.white
//        datePicker.datePickerMode = .date
//
//        // Add an event to call onDidChangeDate function when value is changed.
//        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
       
        // Add DataPicker to the view
        //self.view.addSubview(datePicker)
        
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
        
        selectedTownshipList = allTownShipList[Int(selectedDivision)!-1]
        selectedTownship = allTownShipList[Int(selectedDivision)!-1][0]
        selectedNrcType = nrcTypeList[0]
        
        self.lblDivision.text = self.selectedDivision
        self.lblTownship.text = self.selectedTownship
        self.lblNrcType.text = self.selectedNrcType

    }
    
    @IBAction func onClickSave(_ sender: Any) {
        
        var isError = false
        
         if self.tfName?.text?.isEmpty ?? true{
            self.tfName?.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
            self.tfName?.attributedPlaceholder = NSAttributedString(string: "Please input name",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            isError = true
        }
        
        if self.tfDob?.text?.isEmpty ?? true{
            self.tfDob?.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
            self.tfDob?.attributedPlaceholder = NSAttributedString(string: "Please input your birthday",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            isError = true
        }
        
        if self.tfNrcNo?.text?.isEmpty ?? true{
            self.tfNrcNo?.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
            self.tfNrcNo?.attributedPlaceholder = NSAttributedString(string: "Please input NRC No.",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            isError = true
        }
        
        if self.tfPhoneNo?.text?.isEmpty ?? true{
            self.tfPhoneNo?.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
            self.tfPhoneNo?.attributedPlaceholder = NSAttributedString(string: "Please input phone no.",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            isError = true
        }
        
        if self.tfPassword?.text?.isEmpty ?? true{
            self.tfPassword?.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
            self.tfPassword?.attributedPlaceholder = NSAttributedString(string: "Please input password",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            isError = true
        }
        
        if self.tfConPassword?.text?.isEmpty ?? true{
            self.tfConPassword?.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
            self.tfConPassword?.attributedPlaceholder = NSAttributedString(string: "Please input confirm password",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            isError = true
        }
        
//        if isError {
//            return
//        }
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
        registerBean.password = (self.tfPassword?.text!)!
        
        let alertController = UIAlertController(title: "Title", message: "For Membership process, OTP code will be sent to your registered phone no (09xxxxxx258) .Click “OK” if your phone number has no changes.Click “Call Now” if your phone number has changes.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            //run your function here
            self.goToSecQuesRegisterView()
        }))
        alertController.addAction(UIAlertAction(title: "Call Now", style: UIAlertAction.Style.default, handler: { action in
            //run your function here
            self.goToSecQuesRegisterView()
        }))
        
        return
        self.present(alertController, animated: true, completion: nil)
        
        
        RegisterViewModel.init().checkMember(registerBean: registerBean, success: { (result) in

            if result.message == "MEMBER" {
                
                // save in user default
                UserDefaults.standard.set(result.message, forKey: Constants.CUSTOMER_TYPE)
                UserDefaults.standard.set(result.memberDataBean!.importCustomerInfoId, forKey: Constants.IMPORT_CUSTOMER_INFO_ID)
                UserDefaults.standard.set(result.memberDataBean!.customerNo, forKey: Constants.IMPORT_CUSTOMER_NO)
                UserDefaults.standard.set(result.memberDataBean!.name, forKey: Constants.IMPORT_CUSTOMER_NAME)
                UserDefaults.standard.set(result.memberDataBean!.gender, forKey: Constants.IMPORT_GENDER)
                UserDefaults.standard.set(result.memberDataBean!.phoneNo, forKey: Constants.IMPORT_PHONE_NO)
                UserDefaults.standard.set(result.memberDataBean!.nrcNo, forKey: Constants.IMPORT_NRC_NO)
                UserDefaults.standard.set(result.memberDataBean!.dateOfBirth, forKey: Constants.IMPORT_DOB)
                UserDefaults.standard.set(result.memberDataBean!.salary, forKey: Constants.IMPORT_SALARY)
                UserDefaults.standard.set(result.memberDataBean!.age, forKey: Constants.IMPORT_AGE)
                UserDefaults.standard.set(result.memberDataBean!.companyName, forKey: Constants.IMPORT_COMPANY_NAME)
                UserDefaults.standard.set(result.memberDataBean!.townshipAddress, forKey: Constants.IMPORT_ADDRESS)
                UserDefaults.standard.set(result.memberDataBean!.status, forKey: Constants.IMPORT_STATUS)
                UserDefaults.standard.set(result.memberDataBean!.custAgreementListResDaoList, forKey: Constants.IMPORT_CUSTOMER_NO)
                // show pop up
                let alertController = UIAlertController(title: "Title", message: "For Membership process, OTP code will be sent to your registered phone no (09xxxxxx258) .Click “OK” if your phone number has no changes.Click “Call Now” if your phone number has changes.", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
//                let cancelAction = UIAlertAction(title: "Call Now", style: UIAlertAction.Style.cancel)
//                alertController.addAction(okAction)
//                alertController.addAction(cancelAction)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    //run your function here
                    self.goToSecQuesRegisterView()
                }))
                alertController.addAction(UIAlertAction(title: "Call Now", style: UIAlertAction.Style.default, handler: { action in
                    //run your function here
                    self.goToSecQuesRegisterView()
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
                
            } else {
            // save in user default
            UserDefaults.standard.set(result.message, forKey: Constants.CUSTOMER_TYPE)
            }
        }) { (error) in
            // Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
        }
        goToSecQuesRegisterView()
        
        //let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuestConfirmViewController") as! UINavigationController
        //self.present(navigationVC, animated: true, completion: nil)
    }
    
    private func goToSecQuesRegisterView(){
        
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuesRegisterViewController") as! UINavigationController
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
    @objc func didTapView() {
        self.view.endEditing(true)
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
        let action = UIAlertController.actionSheetWithItems(items: divisionList, currentSelection: selectedDivision, action: { (value)  in
            self.selectedDivision = value
            
            self.selectedTownshipList = self.allTownShipList[Int(self.selectedDivision)!-1]
            self.selectedTownship = self.allTownShipList[Int(self.selectedDivision)!-1][0]
            
            self.lblDivision.text = self.selectedDivision
            self.lblTownship.text = self.selectedTownship
            print(value)
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    func openTownshipSelectionPopUp() {
        let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, currentSelection: selectedTownship, action: { (value)  in
            self.lblTownship.text = value
            self.selectedTownship = value
            print(value)
            
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    func openNrcTypeSelectionPopUp() {
        let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, currentSelection: selectedNrcType, action: { (value)  in
            self.lblNrcType.text = value
            self.selectedNrcType = value
            print(value)
            
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
}
extension UIAlertController {
    static func actionSheetWithItems<A : Equatable>(items : [(title : String, value : A)], currentSelection : A? = nil, action : @escaping (A) -> Void) -> UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for (var title, value) in items {
            if let selection = currentSelection, value == selection {
                // Note that checkmark and space have a neutral text flow direction so this is correct for RTL
                title = "✔︎ " + title
            }
            controller.addAction(
                UIAlertAction(title: title, style: .default) {_ in
                    action(value)
                }
            )
        }
        return controller
    }
    static func actionSheetWithItems(items : [(String)], currentSelection : String? = nil, action : @escaping (String) -> Void) -> UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for ( title) in items {
            controller.addAction(
                UIAlertAction(title: title, style: .default) {_ in
                    action(title)
                }
            )
        }
        return controller
    }
}
