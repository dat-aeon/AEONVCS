//
//  RegistrationViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import DatePickerDialog

class RegistrationViewController: BaseUIViewController {
    
    @IBOutlet weak var svMemberRegister: UIScrollView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tfName: UITextField?
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var tfDob: UITextField?
    @IBOutlet weak var lblNrcNo: UILabel!
    @IBOutlet weak var vDivision: UIView!
    @IBOutlet weak var lblDivision: UILabel!
    @IBOutlet weak var vTownship: UIView!
    @IBOutlet weak var lblTownship: UILabel!
    @IBOutlet weak var vNrcType: UIView!
    @IBOutlet weak var lblNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField?
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var tfPhoneNo: UITextField?
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField?
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var tfConPassword: UITextField?
    
    @IBOutlet weak var imgDatepicker: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    private var confirmPhoneView: UIView!
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedTownshipList = [String]()
    var hotlineNo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//    self.btnRegister.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickRegister)))
//
        //self.confirmPhoneView.isHidden = true
        
        self.tfName?.becomeFirstResponder()
        self.tfNrcNo?.keyboardType = UIKeyboardType.numberPad
        self.tfPhoneNo?.keyboardType = UIKeyboardType.phonePad
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
//                Utils.showAlert(viewcontroller: self, title: "Loading Error", message: error)
//                weak var pvc = self.presentingViewController
//                self.dismiss(animated: true, completion: {
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ServiceUnavailableViewController") as! UINavigationController
                    self.present(navigationVC, animated: true, completion: nil)
                    
               // })
            }
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            Utils.showAlert(viewcontroller: self, title: "Loading Failed", message: error)
//            weak var pvc = self.presentingViewController
//            self.dismiss(animated: true, completion: {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ServiceUnavailableViewController") as! UINavigationController
                self.present(navigationVC, animated: true, completion: nil)
                
           // })
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        HotlineViewModel.init().getHotlineData(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.hotlineNo = result.hotLinePhone
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            Utils.showAlert(viewcontroller: self, title: "Loading Error", message: Messages.SERVER_ERROR)
//            weak var pvc = self.presentingViewController
//            self.dismiss(animated: true, completion: {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ServiceUnavailableViewController") as! UINavigationController
                self.present(navigationVC, animated: true, completion: nil)
                
           // })
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
        self.tfDob?.placeholder = "register.dob.holder".localized
        self.lblNrcNo.text = "register.nrc.label".localized
        self.lblPhoneNo.text = "register.phoneno.label".localized
        self.lblPassword.text = "register.password.label".localized
        self.lblConfirmPassword.text = "register.conpassword.label".localized
        self.btnRegister.setTitle("register.save.button".localized, for: UIControl.State.normal)
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
        self.tfDob?.placeholder = "register.dob.holder".localized
        self.lblNrcNo.text = "register.nrc.label".localized
        self.lblPhoneNo.text = "register.phoneno.label".localized
        self.lblPassword.text = "register.password.label".localized
        self.lblConfirmPassword.text = "register.conpassword.label".localized
        self.btnRegister.setTitle("register.save.button".localized, for: UIControl.State.normal)
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

    @IBAction func onClickSave(_ sender: Any) {
        
        var isError = false
        
         if self.tfName?.text?.isEmpty ?? true{
            self.tfName?.showError(message: Messages.NAME_EMPTY_ERROR)
            isError = true
        }
        
        if self.tfDob?.text?.isEmpty ?? true{
            self.tfDob?.showError(message: Messages.DOB_EMPTY_ERROR)
            isError = true
        }
        
        if self.tfNrcNo?.text?.isEmpty ?? true{
            self.tfNrcNo?.showError(message: Messages.NRC_EMPTY_ERROR)
            isError = true
            
        } else if self.tfNrcNo?.text?.count ?? 0 < 6 {
            self.tfNrcNo?.text = ""
            self.tfNrcNo?.showError(message: Messages.NRC_LENGTH_ERROR)
            isError = true
        }
        
        if self.tfPhoneNo?.text?.isEmpty ?? true{
            self.tfPhoneNo?.showError(message: Messages.PHONE_REG_EMPTY_ERROR)
            isError = true
        }
        
        if self.tfPassword?.text?.isEmpty ?? true{
            self.tfPassword?.showError(message: Messages.PASSWORD_EMPTY_ERROR)
            isError = true
            
        } else if self.tfPassword?.text?.count ?? 0 < 6{
            self.tfPassword?.text = ""
            self.tfPassword?.showError(message: Messages.PASSWORD_LENGTH_ERROR)
            return
        }
        
        if self.tfConPassword?.text?.isEmpty ?? true{
            self.tfConPassword?.showError(message: Messages.CON_PASSWORD_EMPTY_ERROR)
            isError = true
            
        }else if self.tfPassword?.text != self.tfConPassword?.text{
            self.tfConPassword?.text = ""
            self.tfConPassword?.showError(message: Messages.PASSWORD_NOT_MATCH_ERROR)
            return
        }
        
        if isError {
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
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().checkMember(registerBean: registerBean, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if (result.message?.isEmpty)! {
                //failure(result.message ?? "Cannot Register")
                Utils.showAlert(viewcontroller: self, title: "Register Error", message: result.statusMessage!)
                
            } else {
                if result.message == Constants.PHONE_DUPLICATE {
                    //failure(result.message ?? "PH_DUPLICATE")
                    Utils.showAlert(viewcontroller: self, title: "Register Failed", message: Messages.PHONE_DUPLICATE_ERROR)
                    
                } else if result.message == Constants.NRC_DUPLICATE {
                    //failure(result.message ?? "PH_DUPLICATE")
                    Utils.showAlert(viewcontroller: self, title: "Register Failed", message: Messages.NRC_DUPLICATE_ERROR)
                    
                } else if result.message == Constants.NRC_PH_DUPLICATE {
                    //failure(result.message ?? "PH_DUPLICATE")
                    Utils.showAlert(viewcontroller: self, title: "Register Failed", message: Messages.REGISTER_DUPLICATE_ERROR)
                    
                } else{
                    if result.message == Constants.MEMBER{
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
                        
                        let alertController = UIAlertController(title: "Title", message: "For Membership process, OTP code will be sent to your registered phone no (\(result.memberDataBean!.phoneNo ?? "09")) .Click “OK” if your phone number has no changes.Click “Call Now” if your phone number has changes.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                            self.goToSecQuesRegisterView(result: result,registerRequestData:registerBean)
                        }))
                        alertController.addAction(UIAlertAction(title: "Call Now", style: UIAlertAction.Style.default, handler: { action in
                            self.hotlineNo.makeCall()
                        }))
                        self.present(alertController, animated: true, completion: nil)
                        
                    }else if result.message == Constants.NON_MEMBER {
                        // save in user default
                        UserDefaults.standard.set(result.message, forKey: Constants.CUSTOMER_TYPE)
                        self.goToSecQuesRegisterView(result: result,registerRequestData:registerBean)
                    }
                }
            }
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            Utils.showAlert(viewcontroller: self, title: "Register Error", message: error)
//
//            weak var pvc = self.presentingViewController
//            self.dismiss(animated: true, completion: {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ServiceUnavailableViewController") as! UINavigationController
                self.present(navigationVC, animated: true, completion: nil)
                
           // })
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
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lblDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count >= Int(value)!{
                self.selectedTownshipList = self.allTownShipList[Int(value)! - 1]
                self.lblTownship.text = self.selectedTownshipList[0]
                }
                print(value)
                print("\(self.selectedTownshipList)")
            })
            action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lblDivision
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
        } else {
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lblDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count >= Int(value)!{
                    self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
                    self.lblTownship.text = self.selectedTownshipList[0]
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
        }
    }
    
    func openTownshipSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, action: { (value)  in
                self.lblTownship.text = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lblTownship
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
        } else {
            let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, action: { (value)  in
                self.lblTownship.text = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
        }
    }
    
    func openNrcTypeSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
            self.lblNrcType.text = value
            print(value)
        
            })
            action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lblNrcType
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
        } else {
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
                self.lblNrcType.text = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
        }
    }
    
}
