//
//  GuarantorVC.swift
//  AEONVCS
//
//  Created by mac on 10/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SearchTextField

class GuarantorVC: BaseUIViewController {
    
    @IBOutlet weak var svGuarantorData: UIScrollView!
    @IBOutlet weak var lblBldNo: UILabel!
    @IBOutlet weak var tfBldNo: UITextField!
    
    @IBOutlet weak var lblRoomNo: UILabel!
    @IBOutlet weak var tfRoomNo: UITextField!
    
    @IBOutlet weak var lblFloorNo: UILabel!
    @IBOutlet weak var tfFloorNo: UITextField!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var lblQrt: UILabel!
    @IBOutlet weak var tfQrt: UITextField!
    @IBOutlet weak var lblTownship: UILabel!
    @IBOutlet weak var tfTsp: SearchTextField!
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var brnCurrentCity: UIButton!
    
    @IBOutlet weak var lblCompanyBldNo: UILabel!
    @IBOutlet weak var tfCompanyBldNo: UITextField!
    
    @IBOutlet weak var lblCompanyRoomNo: UILabel!
    @IBOutlet weak var tfCompanyRoomNo: UITextField!
    
    @IBOutlet weak var lblCompanyFloorNo: UILabel!
    @IBOutlet weak var tfCompanyFloorNO: UITextField!
    
    @IBOutlet weak var lblCompanyStreet: UILabel!
    @IBOutlet weak var tfCompanyStreet: UITextField!
    
    @IBOutlet weak var tfCompanyQrt: UITextField!
    @IBOutlet weak var lblCompanyQrt: UILabel!
    
    @IBOutlet weak var lblCompanyTsp: UILabel!
    @IBOutlet weak var tfCompanyTsp: SearchTextField!
    
    @IBOutlet weak var lblCompanyCity: UILabel!
    @IBOutlet weak var tfCompanyCity: UITextField!
    @IBOutlet weak var btnCompanyCity: UIButton!
    
    
//    @IBOutlet weak var tvCompanyAddress: UITextView! {
//        didSet {
//            self.tvCompanyAddress.clipsToBounds = true
//            self.tvCompanyAddress.layer.cornerRadius = 5
//            self.tvCompanyAddress.layer.borderWidth = 1.0
//            self.tvCompanyAddress.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
//        }
//    }
    
    @IBOutlet weak var vDivision: UIView! {
        didSet {
            self.vDivision.clipsToBounds = true
            self.vDivision.layer.cornerRadius = 5
            self.vDivision.layer.borderWidth = 1.0
            self.vDivision.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    @IBOutlet weak var vNrcType: UIView! {
        didSet {
            self.vNrcType.clipsToBounds = true
            self.vNrcType.layer.cornerRadius = 5
            self.vNrcType.layer.borderWidth = 1.0
            self.vNrcType.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    @IBOutlet weak var btnRelationshipWith: UIButton! {
        didSet {
            self.btnRelationshipWith.clipsToBounds = true
            self.btnRelationshipWith.layer.cornerRadius = 5
            self.btnRelationshipWith.layer.borderWidth = 1.0
            self.btnRelationshipWith.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    @IBOutlet weak var btnTypeResidence: UIButton! {
        didSet {
            self.btnTypeResidence.clipsToBounds = true
            self.btnTypeResidence.layer.cornerRadius = 5
            self.btnTypeResidence.layer.borderWidth = 1.0
            self.btnTypeResidence.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    @IBOutlet weak var vLivingwith: UIView! {
        didSet {
            self.vLivingwith.clipsToBounds = true
            self.vLivingwith.layer.cornerRadius = 5
            self.vLivingwith.layer.borderWidth = 1.0
            self.vLivingwith.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    @IBOutlet weak var lbldobwarningtop: UILabel!
    
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblDobError: UILabel!
    @IBOutlet weak var lblNrcError: UILabel!
    
    @IBOutlet weak var lblNationalityError: UILabel!
    @IBOutlet weak var lblMobileNoError: UILabel!
    @IBOutlet weak var lblResidentTelNoError: UILabel!
    
    @IBOutlet weak var lblRelationshipWithError: UILabel!
    @IBOutlet weak var lblCurrentAddressError: UILabel!
    @IBOutlet weak var lblTypeResidenceError: UILabel!
    
    @IBOutlet weak var lblLivingWithError: UILabel!
    @IBOutlet weak var lblYearStayError: UILabel!
    @IBOutlet weak var lblCompanyNameError: UILabel!
    
    @IBOutlet weak var lblCompanyTelNoError: UILabel!
    @IBOutlet weak var lblCompanyAddressError: UILabel!
    @IBOutlet weak var lblDepartmentError: UILabel!
    
    @IBOutlet weak var lblPositionError: UILabel!
    @IBOutlet weak var lblYearServiceError: UILabel!
    @IBOutlet weak var lblMonthlyBasicError: UILabel!
    //@IBOutlet weak var lblTotalIncomeError: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblNrc: UILabel!
    
//    @IBOutlet weak var tfLivingWith: SkyFloatingLabelTextField!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    @IBOutlet weak var lblResidentTelNo: UILabel!
    
    @IBOutlet weak var lblRelationshipWith: UILabel!
    @IBOutlet weak var lblCurrentAddress: UILabel!
    @IBOutlet weak var lblTypeResidence: UILabel!
    
    @IBOutlet weak var lblLivingWithText: UILabel!
    @IBOutlet weak var lblLivingWith: UILabel!
    @IBOutlet weak var lblYearStay: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    
    @IBOutlet weak var lblCompanyTelNo: UILabel!
    @IBOutlet weak var lblCompanyAddress: UILabel!
    @IBOutlet weak var lblDepartment: UILabel!
    
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblYearService: UILabel!
    @IBOutlet weak var lblMonthlyBasic: UILabel!
    @IBOutlet weak var lblTotalIncome: UILabel!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfDob: UITextField!
    @IBOutlet weak var tfNationality: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMobileNo: UITextField!
    @IBOutlet weak var tfResidentTelNo: UITextField!
    @IBOutlet weak var tfRsWithApplicant: SkyFloatingLabelTextField!
    @IBOutlet weak var tfTypeResidence: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMonth: SkyFloatingLabelTextField!
    @IBOutlet weak var tfYear: SkyFloatingLabelTextField!
    @IBOutlet weak var tfCompanyName: UITextField!
    @IBOutlet weak var tfCompanyTelNo: UITextField!
    @IBOutlet weak var tfDepartment: UITextField!
    @IBOutlet weak var tfPosition: UITextField!
    @IBOutlet weak var tfYearService: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMonthService: SkyFloatingLabelTextField!
    @IBOutlet weak var tfTotalIncome: UITextField!
    @IBOutlet weak var tfMonthlyIncome: UITextField!
    @IBOutlet weak var lbTotalIncomeText: UILabel!
    
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblMaritalStatus: UILabel!
    
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var imgFemale: UIImageView!
    
    @IBOutlet weak var imgSingle: UIImageView!
    @IBOutlet weak var imgMarried: UIImageView!
    
    @IBOutlet weak var tfTownshipAutoText: SearchTextField!
    
    @IBOutlet weak var lblDivision: UILabel!
    
    @IBOutlet weak var lblNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField!
    
    @IBOutlet weak var imgMyanmarNationality: UIImageView!
    @IBOutlet weak var imgOtherNationality: UIImageView!
    
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedTownshipList = [String]()
    var isMyanmarNationality = true
    
    var yearList :[Int]!
    var monthList :[Int]!
    var numberPicker : UIPickerView!
    
    var nameErrorMesgLocale: String?
    var dobErrorMesgLocale: String?
    var nrcErrorMesgLocale: String?
    var nationalityErrorMesgLocale: String?
    var mobileNoErrorMesgLocale: String?
    var residentTelNoErrorMesgLocale: String?
    var rsWithApplicantErrorMesgLocale: String?
    var currentAddressErrorMesgLocale: String?
    var typeOfResidenceErrorMesgLocale: String?
    var livingWithErrorMesgLocale: String?
    var yearStayErrorMesgLocale: String?
    var companyNameErrorMesgLocale: String?
    var companyTelNoErrorMesgLocale: String?
    var companyAddressErrorMesgLocale: String?
    var departmentErrorMesgLocale: String?
    var positionErrorMesgLocale: String?
    var yearOfServiceErrorMesgLocale: String?
    var monthlyIncomeErrorMesgLocale: String?
    var totalIncomeErrorMesgLocale: String?
    
    var isMaleSelected = true
    var selectedRsIndex = 1
    var selectedTypeResidence = 1
    var selectedLivingWith = 1
    
    var isSingleSelected = true
    var dobString = ""
    
    // City Township
    var allCurrTownNameList = [String]()
    var allComTownNameList = [String]()
    var cityNameList = [String]()
    var cityTownshipModel = CityTownShipModel()
    var selectedCurrCityID : Int?
    var selectedCurrTownshipID: Int?
    var selectedComCityID : Int?
    var selectedComTownshipID: Int?
    var logoutTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
//logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        self.lblNameError.text = Constants.BLANK
        self.lblDobError.text = Constants.BLANK
        self.lblNrcError.text = Constants.BLANK
        self.lblNationalityError.text = Constants.BLANK
        self.lblMobileNoError.text = Constants.BLANK
        self.lblResidentTelNoError.text = Constants.BLANK
        self.lblRelationshipWithError.text = Constants.BLANK
        self.lblCurrentAddressError.text = Constants.BLANK
        self.lblTypeResidenceError.text = Constants.BLANK
        self.lblLivingWithError.text = Constants.BLANK
        self.lblYearStayError.text = Constants.BLANK
        self.lblCompanyNameError.text = Constants.BLANK
        self.lblCompanyTelNoError.text = Constants.BLANK
        self.lblCompanyAddressError.text = Constants.BLANK
        self.lblDepartmentError.text = Constants.BLANK
        self.lblPositionError.text = Constants.BLANK
        self.lblYearServiceError.text = Constants.BLANK
        self.lblMonthlyBasicError.text = Constants.BLANK
        //self.lblTotalIncomeError.text = Constants.BLANK
        
        self.setupNRCData()
        self.setupDob()
        self.setupTownshipCityData()
        
        // Year of Serice
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

        yearList = [Int]()
        for y in 0...99 {
            yearList.append(y)
        }
        
        monthList = [Int]()
        for m in 0...11 {
            monthList.append(m)
        }
        self.numberPicker = UIPickerView()
        self.numberPicker.dataSource = self
        self.numberPicker.delegate = self
        
        self.tfYear.delegate = self
        self.tfYear.inputView = numberPicker
        self.tfYear.text = "\(yearList[0])"
        
        self.tfMonth.delegate = self
        self.tfMonth.inputView = numberPicker
        self.tfMonth.text = "\(monthList[0])"
        
        self.tfYearService.delegate = self
        self.tfYearService.inputView = numberPicker
        self.tfYearService.text = "\(yearList[0])"
        
        self.tfMonthService.delegate = self
        self.tfMonthService.inputView = numberPicker
        self.tfMonthService.text = "\(monthList[0])"
        
        self.tfYear.font = UIFont.systemFont(ofSize: 15)
        self.tfMonth.font = UIFont.systemFont(ofSize: 15)
        tfYear?.setMaxLength(maxLength: 2)
        tfMonth?.setMaxLength(maxLength: 2)
        self.tfYear.keyboardType = .numberPad
        self.tfMonth.keyboardType = .numberPad
        
        self.tfYearService.font = UIFont.systemFont(ofSize: 15)
        self.tfMonthService.font = UIFont.systemFont(ofSize: 15)
        tfYearService?.setMaxLength(maxLength: 2)
        tfMonthService?.setMaxLength(maxLength: 2)
        self.tfYearService.keyboardType = .numberPad
        self.tfMonthService.keyboardType = .numberPad
        
        self.vLivingwith.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickLivingWith)))
        
        self.updateViews()
        
         NotificationCenter.default.addObserver(self, selector: #selector(markGuarantorDatatLastState), name: NSNotification.Name(rawValue: "markGuarantorDataLastState"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(showGuarantorForm(notification:)), name: NSNotification.Name(rawValue: "showGuarantorForm"), object: nil)
        
        tfName.autocapitalizationType = .allCharacters
        tfNationality.autocapitalizationType = .allCharacters
        tfRsWithApplicant.autocapitalizationType = .allCharacters
        tfTypeResidence.autocapitalizationType = .allCharacters
        tfCompanyName.autocapitalizationType = .allCharacters
        tfDepartment.autocapitalizationType = .allCharacters
        tfPosition.autocapitalizationType = .allCharacters
        tfBldNo.autocapitalizationType = .allCharacters
        tfRoomNo.autocapitalizationType = .allCharacters
        tfFloorNo.autocapitalizationType = .allCharacters
        tfStreet.autocapitalizationType = .allCharacters
        tfQrt.autocapitalizationType = .allCharacters
        tfCompanyBldNo.autocapitalizationType = .allCharacters
        tfCompanyFloorNO.autocapitalizationType = .allCharacters
        tfCompanyRoomNo.autocapitalizationType = .allCharacters
        tfCompanyStreet.autocapitalizationType = .allCharacters
        tfCompanyQrt.autocapitalizationType = .allCharacters
        
        tfName.setMaxLength(maxLength: 50)
        tfNrcNo?.setMaxLength(maxLength: 6)
        tfNationality.setMaxLength(maxLength: 50)
        tfMobileNo.setMaxLength(maxLength: 14)
        tfResidentTelNo.setMaxLength(maxLength: 11)
        tfRsWithApplicant.setMaxLength(maxLength: 50)
        tfTypeResidence.setMaxLength(maxLength: 256)
//        tfLivingWith.setMaxLength(maxLength: 256)
        tfCompanyName.setMaxLength(maxLength: 60)
        tfCompanyTelNo.setMaxLength(maxLength: 11)
        tfDepartment.setMaxLength(maxLength: 60)
         tfPosition.setMaxLength(maxLength: 60)
        tfMonthlyIncome.setMaxLength(maxLength: 12)
        tfTotalIncome.setMaxLength(maxLength: 12)
        
        tfBldNo.setMaxLength(maxLength: 20)
        tfRoomNo.setMaxLength(maxLength: 20)
        tfFloorNo.setMaxLength(maxLength: 20)
        tfStreet.setMaxLength(maxLength: 100)
        tfQrt.setMaxLength(maxLength: 100)
        tfTsp.setMaxLength(maxLength: 100)
        
        tfCompanyBldNo.setMaxLength(maxLength: 20)
        tfCompanyRoomNo.setMaxLength(maxLength: 20)
        tfCompanyFloorNO.setMaxLength(maxLength: 20)
        tfCompanyQrt.setMaxLength(maxLength: 100)
        tfCompanyTsp.setMaxLength(maxLength: 100)
//        tvCurrentAddress.delegate = self
//        tvCompanyAddress.delegate = self
        self.tfMonthlyIncome.addTarget(self, action: #selector(monthlyIncomeDidChange(_:)), for: UIControl.Event.editingChanged)
        
        // mandatory fields backgroun setting
        self.tfName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfDob.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfTownshipAutoText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfNrcNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfNationality.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMobileNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfRsWithApplicant.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfTsp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfStreet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfTypeResidence.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfYear.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMonth.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyTelNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyStreet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyTsp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfDepartment.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfPosition.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfYearService.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMonthService.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    @objc func runTimedCode() {
                   multiLoginGet()
               // print("kms\(logoutTimer)")
               }
       func multiLoginGet(){
                  let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
               var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
              MultiLoginModel.init().makeMultiLogin(customerId: customerId
                      , loginDeviceId: deviceID, success: { (results) in
                      print("kaungmyat san multi >>>  \(results)")
                      
                      if results.data.logoutFlag == true {
                          print("success stage logout")
                          // create the alert
                                 let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)

                                 // add an action (button)
                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                              self.logoutTimer?.invalidate()
                              let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                              navigationVC.modalPresentationStyle = .overFullScreen
                              self.present(navigationVC, animated: true, completion:nil)
                              
                          }))

                                 // show the alert
                                 self.present(alert, animated: true, completion: nil)
                          
                          
                      }
                  }) { (error) in
                      print(error)
                  }
              }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            textField.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
        } else {
            textField.backgroundColor = UIColor.white
        }
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification {
            svGuarantorData.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
            
        } else {
            svGuarantorData.contentInset = UIEdgeInsets.zero
        }
        svGuarantorData.scrollIndicatorInsets = svGuarantorData.contentInset
    }

    @objc func monthlyIncomeDidChange(_ textField: UITextField) {
        print("textfield did change")
        if textField.text == "" {
            textField.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
        } else {
            textField.backgroundColor = UIColor.white
        }
        let basicString = "\(textField.text ?? "0")"
        let basicInt = Int(basicString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        textField.text = basicInt.thousandsFormat
        self.lbTotalIncomeText.text = basicInt.thousandsFormat
        
    }
    
    @objc func showGuarantorForm(notification: Notification) {
           if let dict = notification.userInfo as? Dictionary<String, Any> {
           print("showemergencyform \(dict)")
           if let sVar = dict["data"] as? GuarantorRequest {
               self.fillThisForm(data: sVar)
               }
           }
       }
       
    func fillThisForm(data: GuarantorRequest) {
        self.tfName.text = data.name
        self.textFieldDidChange(self.tfName)
        
        if data.nrcNo == "" {
            self.lblDivision.text = self.divisionList[0]
            self.lblNrcType.text = self.nrcTypeList[0]
            self.tfTownshipAutoText.text = ""
            self.tfNrcNo?.text = ""
        } else {
            let nrcStr = data.nrcNo
            self.tfNrcNo?.text = nrcStr.strstr(needle: ")", beforeNeedle: false) //6 number string
            self.lblDivision.text = nrcStr.strstr(needle: "/", beforeNeedle: true)
            let afterBackSlash = nrcStr.strstr(needle: "/")
            self.tfTownshipAutoText.text = afterBackSlash?.strstr(needle: "(", beforeNeedle: true)
            self.lblNrcType.text = "(\(nrcStr.slice(from: "(", to: ")") ?? ""))"
        }
        self.selectedTownshipList = self.allTownShipList[Int(self.lblDivision.text!)!-1]
        self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
        
        self.textFieldDidChange(self.tfTownshipAutoText)
        self.textFieldDidChange(self.tfNrcNo)
        
        if data.dob.count > 10 {
            self.tfDob.text = Utils.changeYMDDateformat(date: data.dob)
        } else {
            self.tfDob.text = data.dob
        }
        self.textFieldDidChange(self.tfDob)
        
        //           self.tvCurrentAddress.text = data.currentAddress
        self.tfMobileNo.text = data.mobileNo
        self.textFieldDidChange(self.tfMobileNo)
        
        self.tfResidentTelNo.text = data.residentTelNo
        
        if data.nationality == 1 {
            self.doSelectMyanmarNationality(UIButton())
        } else {
            self.doSelectOtherNationality(UIButton())
            self.tfNationality.text = data.nationalityOther
        }
        self.textFieldDidChange(self.tfNationality)
        
        self.tfCompanyTelNo.text = data.companyTelNo
        self.textFieldDidChange(self.tfCompanyTelNo)
        
        self.tfDepartment.text = data.department
        self.textFieldDidChange(self.tfDepartment)
        
        self.tfPosition.text = data.position
        self.textFieldDidChange(self.tfPosition)
        
        if data.relationship != 0 {
            self.selectedRsIndex = data.relationship
        } else {
            self.selectedRsIndex = data.relationship
        }
        self.btnRelationshipWith.setTitle("\(Constants.rsWithList[self.selectedRsIndex - 1])", for: .normal)
        if Constants.rsWithList.count == self.selectedRsIndex {
            self.tfRsWithApplicant.isHidden = false
        } else {
            self.tfRsWithApplicant.isHidden = true
        }
        self.tfRsWithApplicant.text = data.relationshipOther
        self.textFieldDidChange(self.tfRsWithApplicant)
        
        //        self.tvCompanyAddress.text = data.companyAddress
        self.selectedTypeResidence = data.typeOfResidence
        self.btnTypeResidence.setTitle("\(Constants.typeResidenceList[self.selectedTypeResidence - 1])", for: .normal)
        if Constants.typeResidenceList.count == self.selectedTypeResidence {
            self.tfTypeResidence.isHidden = false
        } else {
            self.tfTypeResidence.isHidden = true
        }
        self.tfTypeResidence.text = data.typeOfResidenceOther
        self.textFieldDidChange(self.tfTypeResidence)
        
        self.selectedLivingWith = data.livingWith
        if self.selectedLivingWith != 0 {
            self.lblLivingWithText.text = "\(Constants.livingWithList[self.selectedLivingWith - 1])"
        } else {
            self.lblLivingWithText.text = "\(Constants.livingWithList[self.selectedLivingWith])"
        }
        //        self.tfLivingWith.text = data.livingWithOther
        
        if data.gender == 1 {
            self.doSelectMale(UIButton())
            
        } else {
            self.doSelectFemale(UIButton())
        }
        
        if data.maritalStatus == 1 {
            self.doSelectSingle(UIButton())
        } else {
            self.doSelectMarried(UIButton())
        }
        
        if data.yearOfStayYear == 0 {
            self.tfYear.text = "0"
        } else {
            self.tfYear.text = "\(data.yearOfStayYear)"
        }
        self.textFieldDidChange(self.tfYear)
        
        if data.yearOfStayMonth == 0 {
            self.tfMonth.text = "0"
        } else {
            self.tfMonth.text = "\(data.yearOfStayMonth)"
        }
        self.textFieldDidChange(self.tfMonth)
        
        self.tfCompanyName.text = data.companyName
        self.textFieldDidChange(self.tfCompanyName)
        
        //        self.tvCompanyAddress.text = data.companyAddress
         
        if data.yearOfServiceYear == 0 {
            self.tfYearService.text = "0"
        } else {
            self.tfYearService.text = "\(data.yearOfServiceYear)"
        }
        self.textFieldDidChange(self.tfYearService)
        
        if data.yearOfServiceMonth == 0 {
            self.tfMonthService.text = "0"
        } else {
            self.tfMonthService.text = "\(data.yearOfServiceMonth)"
        }
        self.textFieldDidChange(self.tfMonthService)
        
        if data.monthlyBasicIncome == 0.0 {
            self.tfMonthlyIncome.text = "0"
        } else {
            //self.tfMonthlyIncome.text = "\(data.monthlyBasicIncome)"
            let val = Int(Double(data.monthlyBasicIncome))
            self.tfMonthlyIncome.text = "\(val.thousandsFormat)"
        }
        self.textFieldDidChange(self.tfMonthlyIncome)
        
        if data.totalIncome == 0.0 {
            self.lbTotalIncomeText.text = "0"
        } else {
            //self.tfTotalIncome.text = "\(data.totalIncome)"
            let val = Int(Double(data.totalIncome))
            self.lbTotalIncomeText.text = "\(val.thousandsFormat)"
        }
        
        self.tfBldNo.text = data.currentAddressBuildingNo
        self.tfRoomNo.text = data.currentAddressRoomNo
        self.tfFloorNo.text = data.currentAddressFloor
        self.tfStreet.text = data.currentAddressStreet
        self.textFieldDidChange(self.tfStreet)
        
        self.tfQrt.text = data.currentAddressQtr
        
        if data.currentAddressCity != 0 {
            for cityName in self.cityTownshipModel.cityNameIdDic!.keys{
                let id = self.cityTownshipModel.cityNameIdDic![cityName]
                if id == data.currentAddressCity {
                    self.brnCurrentCity.setTitle(cityName, for: UIControl.State.normal)
                    self.selectedCurrCityID = id
                    break
                }
            }
        }
        
        if data.currentAddressTownship != 0{
            for townName in self.cityTownshipModel.townNameIdDic!.keys{
                let id = self.cityTownshipModel.townNameIdDic![townName]
                if id == data.currentAddressTownship {
                    self.tfTsp.text = townName
                    self.selectedCurrTownshipID = id
                    print(self.allCurrTownNameList)
                    self.allCurrTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCurrCityID!]!
                    self.tfTsp.filterStrings(self.allCurrTownNameList)
                    break
                }
            }
        }
        self.textFieldDidChange(self.tfTsp)
        
        self.tfCompanyBldNo.text = data.companyAddressBuildingNo
        self.tfCompanyRoomNo.text = data.companyAddressRoomNo
        self.tfCompanyFloorNO.text = data.companyAddressFloor
        self.tfCompanyStreet.text = data.companyAddressStreet
        self.textFieldDidChange(self.tfCompanyStreet)
        
        self.tfCompanyQrt.text = data.companyAddressQtr
        
        if data.companyAddressCity != 0 {
            for cityName in self.cityTownshipModel.cityNameIdDic!.keys{
                let id = self.cityTownshipModel.cityNameIdDic![cityName]
                if id == data.companyAddressCity {
                    self.btnCompanyCity.setTitle(cityName, for: UIControl.State.normal)
                    self.selectedComCityID = id
                    break
                }
            }
        }
        
        if data.companyAddressTownship != 0{
            for townName in self.cityTownshipModel.townNameIdDic!.keys{
                let id = self.cityTownshipModel.townNameIdDic![townName]
                if id == data.companyAddressTownship {
                    self.tfCompanyTsp.text = townName
                    self.selectedComTownshipID = id
                    self.allComTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedComCityID!]!
                    self.tfCompanyTsp.filterStrings(self.allComTownNameList)
                    break
                }
            }
        }
        self.textFieldDidChange(self.tfCompanyTsp)
        
    }
    
    @objc func markGuarantorDatatLastState() {
        
        self.markGuarantorErrorCount()
        self.tfTownshipAutoText.hideResultsList()
        self.tfTsp.hideResultsList()
        self.tfCompanyTsp.hideResultsList()
        
        let divisionCode: String = self.lblDivision?.text ?? ""
        let townshipCode: String = self.tfTownshipAutoText?.text ?? ""
        let nrcType: String = self.lblNrcType?.text ?? ""
        let nrcNo: String = self.tfNrcNo?.text ?? ""
        
        let nrc = divisionCode + "/" + townshipCode + nrcType + nrcNo
        
        var selectedNationality = 1
        if !isMyanmarNationality {
            selectedNationality = 2
        }
        
        var selectedGender = 1
        if !isMaleSelected {
            selectedGender = 2
        }
        
        var selectedMaritalStatus = 1
        if !isSingleSelected {
            selectedMaritalStatus = 2
        }
        
        var yearStay = 0
        if self.tfYear.text != "" {
            if let intString = Int(self.tfYear.text!) {
                yearStay = intString
            }
        }
        
        var monthStay = 0
        if self.tfMonth.text != "" {
            if let intString = Int(self.tfMonth.text!) {
                monthStay = intString
            }
        }
        
        var yearService = 0
        if self.tfYearService.text != "" {
            if let intString = Int(self.tfYearService.text!) {
                yearService = intString
            }
        }
        
        var monthService = 0
        if self.tfMonthService.text != "" {
            if let intString = Int(self.tfMonthService.text!) {
                monthService = intString
            }
        }
        
        var monthlyIncome = 0.0
        if self.tfMonthlyIncome.text != "" {
            if let intString = Double(self.tfMonthlyIncome.text!.replacingOccurrences(of: ",", with: "")) {
                monthlyIncome = intString
            }
        }
        
        var totalIncome = 0.0
        if self.lbTotalIncomeText.text != "" {
            if let intString = Double(self.lbTotalIncomeText.text!.replacingOccurrences(of: ",", with: "")) {
                totalIncome = intString
            }
        }
        
        self.dobString = self.tfDob.text!
        
        let appData = GuarantorRequest(daGuarantorInfoId: guarantorFormID, name: self.tfName.text ?? "", dob: self.dobString, nrcNo: nrc, nationality: selectedNationality, nationalityOther: self.tfNationality.text ?? "", mobileNo: self.tfMobileNo.text ?? "", residentTelNo: self.tfResidentTelNo.text ?? "", relationship: self.selectedRsIndex, relationshipOther: self.tfRsWithApplicant.text ?? "", currentAddress: "", typeOfResidence: self.selectedTypeResidence, typeOfResidenceOther: self.tfTypeResidence.text ?? "", livingWith: self.selectedLivingWith, livingWithOther: "", gender: selectedGender, maritalStatus: selectedMaritalStatus, yearOfStayYear: yearStay, yearOfStayMonth: monthStay, companyName: self.tfCompanyName.text ?? "", companyTelNo: self.tfCompanyTelNo.text ?? "", companyAddress: "", department: self.tfDepartment.text ?? "", position: self.tfPosition.text ?? "", yearOfServiceYear: yearService, yearOfServiceMonth: monthService, monthlyBasicIncome: monthlyIncome, totalIncome: totalIncome, currentAddressFloor: self.tfFloorNo.text ?? "", currentAddressBuildingNo: self.tfBldNo.text ?? "", currentAddressRoomNo: self.tfRoomNo.text ?? "", currentAddressStreet: self.tfStreet.text ?? "", currentAddressQtr: self.tfQrt.text ?? "", currentAddressTownship: self.selectedCurrTownshipID ?? 0, currentAddressCity: self.selectedCurrCityID!, companyAddressBuildingNo: self.tfCompanyBldNo.text ?? "", companyAddressRoomNo: self.tfCompanyRoomNo.text ?? "", companyAddressFloor: self.tfCompanyFloorNO.text ?? "", companyAddressStreet: self.tfCompanyStreet.text ?? "", companyAddressQtr: self.tfCompanyQrt.text ?? "", companyAddressTownship: self.selectedComTownshipID ?? 0, companyAddressCity: self.selectedComCityID!)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetGuarantorData"), object: self, userInfo: ["appData": appData])
        
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorLabelGuarantor), name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
        self.view.endEditing(true)
    }
    
    @objc func showErrorLabelGuarantor() {
       _ = self.isErrorExist()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        
        self.lblName.text = "emergencycontact_name".localized
        self.lblDob.text = "register.dob.label".localized
        self.lblNrc.text = "register.nrc.label".localized
        self.lblNationality.text = "application_data.nationality".localized
        self.lblMobileNo.text = "emergencycontact_mobileno".localized
        self.lblResidentTelNo.text = "emergencycontact_residenttelno".localized
        self.lblRelationshipWith.text = "emergencycontact_rsapplicant".localized
        self.lblCurrentAddress.text = "emergencycontact_currentaddress".localized
        self.lblTypeResidence.text = "application_data.typeresidence".localized
        self.lblLivingWith.text = "application_data.livingwith".localized
        self.lblGender.text = "application_data.gender".localized
        self.lblMaritalStatus.text = "application_data.marital".localized
        self.lblYearStay.text = "application_data.yearstay".localized
        self.lblCompanyName.text = "occupation_company_name".localized
        self.lblCompanyTelNo.text = "occupation_company_telno".localized
        self.lblCompanyAddress.text = "occupation_company_address".localized
        self.lblDepartment.text = "occupation_company_department".localized
        self.lblPosition.text = "occupation_company_position".localized
        self.lblYearService.text = "occupation_company_year_service".localized
        self.lblMonthlyBasic.text = "occupation_monthly_income".localized
        self.lblTotalIncome.text = "occupation_total_income".localized
        self.lbldobwarningtop.text = "register.dob.restrict.label".localized
        
        self.lblBldNo.text = "da.buildno".localized
        self.lblFloorNo.text = "da.floor".localized
        self.lblRoomNo.text = "da.roomno".localized
        self.lblStreet.text = "da.street".localized
        self.lblQrt.text = "da.quarter".localized
        self.lblTownship.text = "da.township".localized
        self.lblCity.text = "da.city".localized
        
        self.lblCompanyBldNo.text = "da.buildno".localized
        self.lblCompanyFloorNo.text = "da.floor".localized
        self.lblCompanyRoomNo.text = "da.roomno".localized
        self.lblCompanyStreet.text = "da.street".localized
        self.lblCompanyQrt.text = "da.quarter".localized
        self.lblCompanyTsp.text = "da.township".localized
        self.lblCompanyCity.text = "da.city".localized
        
        self.lblNameError.text = nameErrorMesgLocale?.localized
        self.lblDobError.text = dobErrorMesgLocale?.localized
        self.lblNrcError.text = nrcErrorMesgLocale?.localized
        self.lblNationalityError.text = nationalityErrorMesgLocale?.localized
        self.lblMobileNoError.text = mobileNoErrorMesgLocale?.localized
        self.lblResidentTelNoError.text = residentTelNoErrorMesgLocale?.localized
        self.lblRelationshipWithError.text = rsWithApplicantErrorMesgLocale?.localized
        self.lblCurrentAddressError.text = currentAddressErrorMesgLocale?.localized
        self.lblTypeResidenceError.text = typeOfResidenceErrorMesgLocale?.localized
        self.lblLivingWithError.text = livingWithErrorMesgLocale?.localized
        self.lblYearStayError.text = yearStayErrorMesgLocale?.localized
        self.lblCompanyNameError.text = companyNameErrorMesgLocale?.localized
        self.lblCompanyTelNoError.text = companyTelNoErrorMesgLocale?.localized
        self.lblCompanyAddressError.text = companyAddressErrorMesgLocale?.localized
        self.lblDepartmentError.text = departmentErrorMesgLocale?.localized
        self.lblPositionError.text = positionErrorMesgLocale?.localized
        self.lblYearServiceError.text = yearOfServiceErrorMesgLocale?.localized
        self.lblMonthlyBasicError.text = monthlyIncomeErrorMesgLocale?.localized
        //self.lblTotalIncomeError.text = totalIncomeErrorMesgLocale?.localized
        
        
    }
    
    @IBAction func doSelectMale(_ sender: Any) {
        self.imgMale.image = UIImage(named: "circle_selected")
        self.imgFemale.image = UIImage(named: "circle")
        
        self.isMaleSelected = true
    }
    
    @IBAction func doSelectFemale(_ sender: Any) {
        self.imgMale.image = UIImage(named: "circle")
        self.imgFemale.image = UIImage(named: "circle_selected")
        
        self.isMaleSelected = false
    }
    
    @IBAction func doSelectSingle(_ sender: Any) {
        self.imgSingle.image = UIImage(named: "circle_selected")
        self.imgMarried.image = UIImage(named: "circle")
        
        self.isSingleSelected = true
    }
    
    @IBAction func doSelectMarried(_ sender: Any) {
        self.imgMarried.image = UIImage(named: "circle_selected")
        self.imgSingle.image = UIImage(named: "circle")
        
        self.isSingleSelected = false
    }
    
    @IBAction func doSelectTypeOfResidence(_ sender: Any) {
        self.openTypeOfResidencePopup()
    }
    
    @IBAction func doSelectMyanmarNationality(_ sender: Any) {
        self.imgMyanmarNationality.image = UIImage(named: "circle_selected")
        self.imgOtherNationality.image = UIImage(named: "circle")
        
        self.isMyanmarNationality = true
        self.tfNationality.isHidden = true
    }
    
    @IBAction func doSelectOtherNationality(_ sender: Any) {
        self.imgMyanmarNationality.image = UIImage(named: "circle")
        self.imgOtherNationality.image = UIImage(named: "circle_selected")
        self.isMyanmarNationality = false
        self.tfNationality.isHidden = false
    }
    
    @IBAction func doTappedOnRsWithApplicant(_ sender: Any) {
        self.openRSWithPopup()
    }
    
    func setupDob() {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        //components.year = -10
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        datePickerView.maximumDate = maxDate
        
        self.tfDob?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
        
        self.tfDob?.delegate = self
    }
    
    @objc func dobDatePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.tfDob?.text = dateFormatter.string(from: sender.date)
        self.dobString = dateFormatter.string(from: sender.date)
        self.tfDob.backgroundColor = UIColor.white
        
    }
    
    func setupNRCData() {
        
        //autocomplete
        self.tfTownshipAutoText.theme.cellHeight = 40
        self.tfTownshipAutoText.maxResultsListHeight = 300
        self.tfTownshipAutoText.startVisible = true
        self.tfTownshipAutoText.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfTownshipAutoText.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfTownshipAutoText.theme.bgColor = UIColor.groupTableViewBackground
        self.tfTownshipAutoText.theme.separatorColor = UIColor.lightGray
        self.tfTownshipAutoText.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfTownshipAutoText.text = item.title
            self.tfTownshipAutoText.backgroundColor = UIColor.white
            print("\(item.title)")
        }
        
        tfNrcNo?.delegate = self
        tfNrcNo?.setMaxLength(maxLength: 6)
        
        self.vDivision.layer.borderWidth = 1
        self.vDivision.layer.cornerRadius = 4 as CGFloat
        self.vDivision.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vNrcType.layer.borderWidth = 1
        self.vNrcType.layer.cornerRadius = 4 as CGFloat
        self.vNrcType.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        vDivision.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickDivisionDropDown)))
        //vTownship.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickTownshipDropDown)))
        vNrcType.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickNrcTypeDropDown)))
        
        
        //load nrc data
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().loadNrcData(success: { (townshipList) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.allTownShipList = townshipList
            self.selectedTownshipList = townshipList[0]
            self.lblDivision.text = self.divisionList[0]
            //self.lblTownship.text = self.allTownShipList[0][0]
            self.lblNrcType.text = self.nrcTypeList[0]
            self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.JSON_FAILURE {
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    //                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.CUSTOMER_TYPE_VIEW_CONTROLLER) as! UINavigationController
                    //                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            }
        }
    }//end of setupnrcdata
    
    @objc func onClickDivisionDropDown(){
        self.tfDob?.resignFirstResponder()
        
        self.tfNrcNo?.resignFirstResponder()
        openDivisionSelectionPopUp()
    }
    
    @objc func onClickTownshipDropDown(){
        self.tfDob?.resignFirstResponder()
        
        self.tfNrcNo?.resignFirstResponder()
        openTownshipSelectionPopUp()
    }
    
    @objc func onClickNrcTypeDropDown(){
        self.tfDob?.resignFirstResponder()
        
        self.tfNrcNo?.resignFirstResponder()
        openNrcTypeSelectionPopUp()
    }
    
    func openDivisionSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lblDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count>=Int(value)!{
                    self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
                    //self.lblTownship.text = self.selectedTownshipList[0]
                    self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                    self.tfTownshipAutoText.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lblDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count>=Int(value)!{
                    self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
                    //self.lblTownship.text = self.selectedTownshipList[0]
                    self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                    self.tfTownshipAutoText.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openTownshipSelectionPopUp() {
        
        
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
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
        } else {
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
                self.lblNrcType.text = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    @objc func onClickLivingWith() {
        self.openLivingWithPopup()
    }

    
    func openRSWithPopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: Constants.rsWithList, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.btnRelationshipWith.setTitle(value, for: .normal)
                self.selectedRsIndex = Constants.rsWithList.firstIndex(of: value)! + 1
                print(value)
                if self.selectedRsIndex == Constants.rsWithList.count {
                    self.tfRsWithApplicant.isHidden = false
                } else {
                    self.tfRsWithApplicant.isHidden = true
                }
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: Constants.rsWithList, action: { (value)  in
                //                let selectedType = self.typeResidence[-1]
                 self.btnRelationshipWith.setTitle(value, for: .normal)
                self.selectedRsIndex = Constants.rsWithList.firstIndex(of: value)! + 1
                print(value)
                if self.selectedRsIndex == Constants.rsWithList.count {
                    self.tfRsWithApplicant.isHidden = false
                } else {
                    self.tfRsWithApplicant.isHidden = true
                }
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openLivingWithPopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: Constants.livingWithList, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.lblLivingWithText.text = value
                self.selectedLivingWith = Constants.livingWithList.firstIndex(of: value)! + 1
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: Constants.livingWithList, action: { (value)  in
                //                let selectedType = self.typeResidence[-1]
                self.lblLivingWithText.text = value
                self.selectedLivingWith = Constants.livingWithList.firstIndex(of: value)! + 1
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openTypeOfResidencePopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: Constants.typeResidenceList, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.btnTypeResidence.setTitle(value, for: .normal)
                self.selectedTypeResidence = Constants.typeResidenceList.firstIndex(of: value)! + 1
                print(value)
                if self.selectedTypeResidence == Constants.typeResidenceList.count {
                    self.tfTypeResidence.isHidden = false
                } else {
                    self.tfTypeResidence.isHidden = true
                }
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: Constants.typeResidenceList, action: { (value)  in
                //                let selectedType = self.typeResidence[-1]
                self.btnTypeResidence.setTitle(value, for: .normal)
                 self.selectedTypeResidence = Constants.typeResidenceList.firstIndex(of: value)! + 1
                print(value)
                if self.selectedTypeResidence == Constants.typeResidenceList.count {
                    self.tfTypeResidence.isHidden = false
                } else {
                    self.tfTypeResidence.isHidden = true
                }
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func onClickCurrCityBtn(_ sender: UIButton) {
        openCurrCitySelectionPopUp()
    }
    
    @IBAction func onClickComCityBtn(_ sender: UIButton) {
        openComCitySelectionPopUp()
    }
    
    func openCurrCitySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.brnCurrentCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCurrCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allCurrTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCurrCityID!]!
                
                if self.allCurrTownNameList.count >= 0 {
                    self.tfTsp.filterStrings(self.allCurrTownNameList)
                    self.tfTsp.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.brnCurrentCity
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.brnCurrentCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCurrCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allCurrTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCurrCityID!]!
                
                if self.allCurrTownNameList.count >= 0 {
                    self.tfTsp.filterStrings(self.allCurrTownNameList)
                    self.tfTsp.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openComCitySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCompanyCity.setTitle(value, for: UIControl.State.normal)
                self.selectedComCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allComTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedComCityID!]!
                
                if self.allComTownNameList.count >= 0 {
                    self.tfCompanyTsp.filterStrings(self.allComTownNameList)
                    self.tfCompanyTsp.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.brnCurrentCity
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCompanyCity.setTitle(value, for: UIControl.State.normal)
                self.selectedComCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allComTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedComCityID!]!
                
                if self.allComTownNameList.count >= 0 {
                    self.tfCompanyTsp.filterStrings(self.allComTownNameList)
                    self.tfCompanyTsp.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func setupTownshipCityData() {
        
        //autocomplete
        self.tfTsp.theme.cellHeight = 40
        self.tfTsp.maxResultsListHeight = 300
        self.tfTsp.startVisible = true
        self.tfTsp.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfTsp.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfTsp.theme.bgColor = UIColor.groupTableViewBackground
        self.tfTsp.theme.separatorColor = UIColor.lightGray
        self.tfTsp.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfTsp.text = item.title
            self.selectedCurrTownshipID = self.cityTownshipModel.townNameIdDic![item.title]
            self.tfTsp.backgroundColor = UIColor.white
            //print("\(item.title)", "\(self.selectedCurrTownshipID ?? 0)")
        }
        
        self.tfCompanyTsp.theme.cellHeight = 40
        self.tfCompanyTsp.maxResultsListHeight = 300
        self.tfCompanyTsp.startVisible = true
        self.tfCompanyTsp.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfCompanyTsp.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfCompanyTsp.theme.bgColor = UIColor.groupTableViewBackground
        self.tfCompanyTsp.theme.separatorColor = UIColor.lightGray
        self.tfCompanyTsp.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.selectedComTownshipID = self.cityTownshipModel.townNameIdDic![item.title]
            self.tfCompanyTsp.text = item.title
            self.tfCompanyTsp.backgroundColor = UIColor.white
            //print("\(item.title)", "\(self.selectedComTownshipID ?? 0)")
        }
        
        //load city township data
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        DAViewModel.init().getCityTownshipList(success: { (model) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.cityTownshipModel = model
            for cityName in model.cityNameIdDic!.keys {
                self.cityNameList.append(cityName)
            }
            // current Address
            self.selectedCurrCityID = model.cityNameIdDic![self.cityNameList[0]]
            self.brnCurrentCity.setTitle(self.cityNameList[0], for: UIControl.State.normal)
            self.allCurrTownNameList = model.cityIdTownListDic![self.selectedCurrCityID!]!
            self.tfTsp.filterStrings(self.allCurrTownNameList)
            
            // company address
            self.selectedComCityID = model.cityNameIdDic![self.cityNameList[0]]
            self.btnCompanyCity.setTitle(self.cityNameList[0], for: UIControl.State.normal)
            self.allComTownNameList = model.cityIdTownListDic![self.selectedComCityID!]!
            self.tfCompanyTsp.filterStrings(self.allComTownNameList)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.JSON_FAILURE {
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    //                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.CUSTOMER_TYPE_VIEW_CONTROLLER) as! UINavigationController
                    //                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            }
        }
    }
    func isErrorExist() -> Bool {
        
        var isError = false
        // not to overwrite error message
        var isNRCError = false
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfName?.text = Constants.BLANK
            self.lblNameError.text = Messages.NAME_EMPTY_ERROR.localized
            self.nameErrorMesgLocale = Messages.NAME_EMPTY_ERROR
            isError = true
            
        }
//        else if !Utils.isNameValidate(name: (self.tfName!.text)!){
//
//            self.lblNameError.text = Messages.NAME_REG_FORMAT_ERROR.localized
//            self.nameErrorMesgLocale = Messages.NAME_REG_FORMAT_ERROR
//            isError = true
//
//        }
        else {
            self.nameErrorMesgLocale = Constants.BLANK
            self.lblNameError.text = Constants.BLANK
        }
        
        // Current address
        if self.tfStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfStreet?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.currentAddressErrorMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true

        } else {
            self.currentAddressErrorMesgLocale = Constants.BLANK
            self.lblCurrentAddressError.text = Constants.BLANK
        }
        
        if self.tfTsp?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfTsp?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.currentAddressErrorMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true
            
        } else if !self.allCurrTownNameList.contains((self.tfTsp?.text)!) {
            self.tfTsp?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_INVALID_ERROR.localized
            self.currentAddressErrorMesgLocale = Messages.ADDRESS_INVALID_ERROR
            isError = true
                   
        } else {
            self.currentAddressErrorMesgLocale = Constants.BLANK
            self.lblCurrentAddressError.text = Constants.BLANK
        }
        
        // Permanent address
        if self.tfCompanyStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfCompanyStreet?.text = Constants.BLANK
            self.lblCompanyAddressError.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.companyAddressErrorMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true

        } else {
            self.companyAddressErrorMesgLocale = Constants.BLANK
            self.lblCompanyAddressError.text = Constants.BLANK
        }
        
        if self.tfCompanyTsp?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfCompanyTsp?.text = Constants.BLANK
            self.lblCompanyAddressError.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.companyAddressErrorMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true
            
        } else if !self.allComTownNameList.contains((self.tfCompanyTsp?.text)!) {
            self.tfCompanyTsp?.text = Constants.BLANK
            self.lblCompanyAddressError.text = Messages.ADDRESS_INVALID_ERROR.localized
            self.companyAddressErrorMesgLocale = Messages.ADDRESS_INVALID_ERROR
            isError = true
                   
        } else {
            self.companyAddressErrorMesgLocale = Constants.BLANK
            self.lblCompanyAddressError.text = Constants.BLANK
        }
        
        // Validate Date of Birth [dd-MM-yyyy]
        if self.tfDob?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfDob?.text = Constants.BLANK
            self.lblDobError.text = Messages.DOB_EMPTY_ERROR.localized
            self.dobErrorMesgLocale = Messages.DOB_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isDobValidateDA(dob: (self.tfDob?.text)!){
            self.lblDobError.text = Messages.DOB_FORMAT_ERROR.localized
            self.dobErrorMesgLocale = Messages.DOB_FORMAT_ERROR
            isError = true
            
        } else {
            self.dobErrorMesgLocale = Constants.BLANK
            self.lblDobError.text = Constants.BLANK
        }
        
        // Validate NRC Township
        if self.tfTownshipAutoText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lblNrcError.text = Messages.NRC_TOWNSHIP_EMPTY_ERROR.localized
            self.nrcErrorMesgLocale = Messages.NRC_TOWNSHIP_EMPTY_ERROR
            isError = true
            isNRCError = true
            
        } else if !self.selectedTownshipList.contains(self.tfTownshipAutoText.text!){
            print("town list \(self.selectedTownshipList)")
            print("town \(self.tfTownshipAutoText.text!)")
            self.lblNrcError.text = Messages.NRC_TOWNSHIP_INVALID_ERROR.localized
            self.nrcErrorMesgLocale = Messages.NRC_TOWNSHIP_INVALID_ERROR
            isError = true
            isNRCError = true
            
        } else {
            self.lblNrcError.text = Constants.BLANK
            self.nrcErrorMesgLocale = Constants.BLANK
            isNRCError = false
        }
        
        // Validate Nrc No.
        if self.tfNrcNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfNrcNo?.text = Constants.BLANK
            self.lblNrcError.text = Messages.NRC_NO_EMPTY_ERROR.localized
            self.nrcErrorMesgLocale = Messages.NRC_NO_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isNrcNoValidate(nrcNo: (self.tfNrcNo?.text)!){
            self.lblNrcError.text = Messages.NRC_LENGTH_ERROR.localized
            self.nrcErrorMesgLocale = Messages.NRC_LENGTH_ERROR
            isError = true
            
        } else {
            if !isNRCError {
                self.lblNrcError.text = Constants.BLANK
                self.nrcErrorMesgLocale = Constants.BLANK
            }
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfMobileNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfMobileNo?.text = Constants.BLANK
            self.lblMobileNoError.text = Messages.PHONE_REG_EMPTY_ERROR.localized
            self.mobileNoErrorMesgLocale = Messages.PHONE_REG_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isPhoneValidate(phoneNo: (self.tfMobileNo?.text)!){
            // validate phone no format
            self.lblMobileNoError.text = Messages.PHONE_REG_LENGTH_ERROR.localized
            self.mobileNoErrorMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
            isError = true
            
        } else {
            self.mobileNoErrorMesgLocale = Constants.BLANK
            self.lblMobileNoError.text = Constants.BLANK
        }
        
        //Validate Resident Phone No. [09[0-9]{7,9}]
//        if self.tfResidentTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
//            self.tfResidentTelNo?.text = Constants.BLANK
//            self.lblResidentTelNoError.text = Messages.PHONE_RESIDENT_EMPTY_ERROR.localized
//            self.residentTelNoErrorMesgLocale = Messages.PHONE_RESIDENT_EMPTY_ERROR
//            isError = true
//
//        } else
        if self.tfResidentTelNo.text?.count ?? 0 > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfResidentTelNo?.text)!){
                // validate phone no format
                self.lblResidentTelNoError.text = Messages.PHONE_REG_LENGTH_ERROR.localized
                self.residentTelNoErrorMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
                isError = true
                
            } else {
                self.residentTelNoErrorMesgLocale = Constants.BLANK
                self.lblResidentTelNoError.text = Constants.BLANK
            }
        } else {
            self.residentTelNoErrorMesgLocale = Constants.BLANK
            self.lblResidentTelNoError.text = Constants.BLANK
        }
        if !self.isMyanmarNationality {
            if self.tfNationality?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
                self.tfNationality?.text = Constants.BLANK
                self.lblNationalityError.text = Messages.NATIONALITY_EMPTY_ERROR.localized
                self.nationalityErrorMesgLocale = Messages.NATIONALITY_EMPTY_ERROR
                isError = true
                
            } else {
                self.lblNationalityError.text = Constants.BLANK
                self.nationalityErrorMesgLocale = Constants.BLANK
            }
        }
        
        if self.btnTypeResidence.titleLabel?.text == "Hostel/Other" {
            if self.tfTypeResidence?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
                self.tfTypeResidence?.text = Constants.BLANK
                self.lblTypeResidenceError.text = Messages.TYPE_RESIDENCE_EMPTY_ERROR.localized
                self.typeOfResidenceErrorMesgLocale = Messages.TYPE_RESIDENCE_EMPTY_ERROR
                isError = true
                
            } else {
                self.lblTypeResidenceError.text = Constants.BLANK
                self.typeOfResidenceErrorMesgLocale = Constants.BLANK
            }
        }
        
        //YEAR of Stay
        var isStayError = false
        if self.tfYear?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfYear?.text = Constants.BLANK
            self.lblYearStayError.text = Messages.YEAR_STAY_EMPTY_ERROR.localized
            self.yearStayErrorMesgLocale = Messages.YEAR_STAY_EMPTY_ERROR
            isError = true
            isStayError = true
            
        } else {
            self.lblYearStayError.text = Constants.BLANK
            self.yearStayErrorMesgLocale = Constants.BLANK
        }
        
        if self.tfMonth?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfMonth?.text = Constants.BLANK
            self.lblYearStayError.text = Messages.YEAR_STAY_EMPTY_ERROR.localized
            self.yearStayErrorMesgLocale = Messages.YEAR_STAY_EMPTY_ERROR
            isError = true
            isStayError = true
            
        } else {
            self.lblYearStayError.text = Constants.BLANK
            self.yearStayErrorMesgLocale = Constants.BLANK
        }
        if !isStayError {
            if self.tfYear?.text == "0" && self.tfMonth.text == "0"{
                self.tfYear?.text = Constants.BLANK
                self.lblYearStayError.text = Messages.YEAR_STAY_EMPTY_ERROR.localized
                self.yearStayErrorMesgLocale = Messages.YEAR_STAY_EMPTY_ERROR
                isError = true
                
            }
        }
        
        //YEAR of Service
        var isServiceError = false
        if self.tfYearService?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfYearService?.text = Constants.BLANK
            self.lblYearServiceError.text = Messages.YEAR_SERVICE_EMPTY_ERROR.localized
            self.yearOfServiceErrorMesgLocale = Messages.YEAR_SERVICE_EMPTY_ERROR
            isError = true
            isServiceError = true
            
        } else {
            self.lblYearServiceError.text = Constants.BLANK
            self.yearOfServiceErrorMesgLocale = Constants.BLANK
        }
        
        if self.tfMonthService?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfMonthService?.text = Constants.BLANK
            self.lblYearServiceError.text = Messages.YEAR_SERVICE_EMPTY_ERROR.localized
            self.yearOfServiceErrorMesgLocale = Messages.YEAR_SERVICE_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblYearServiceError.text = Constants.BLANK
            self.yearOfServiceErrorMesgLocale = Constants.BLANK
        }
        
        if !isServiceError {
            if self.tfYearService?.text == "0" && self.tfMonthService?.text == "0"{
                self.tfYearService?.text = Constants.BLANK
                self.lblYearServiceError.text = Messages.YEAR_SERVICE_EMPTY_ERROR.localized
                self.yearOfServiceErrorMesgLocale = Messages.YEAR_SERVICE_EMPTY_ERROR
                isError = true
            }
        }
        // COMPANY Name [a-zA-Z0-9 ]
        if self.tfCompanyName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfCompanyName?.text = Constants.BLANK
            self.lblCompanyNameError.text = Messages.COMPANY_NAME_EMPTY_ERROR.localized
            self.companyNameErrorMesgLocale = Messages.COMPANY_NAME_EMPTY_ERROR
            isError = true
            
        } else {
            self.companyNameErrorMesgLocale = Constants.BLANK
            self.lblCompanyNameError.text = Constants.BLANK
        }
        
        //Company Phone No. [09[0-9]{7,9}]
        if self.tfCompanyTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfCompanyTelNo?.text = Constants.BLANK
            self.lblCompanyTelNoError.text = Messages.COMPANY_PHONE_EMPTY_ERROR.localized
            self.companyTelNoErrorMesgLocale = Messages.COMPANY_PHONE_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isNumberValidate(phoneNo: (self.tfMobileNo?.text)!){
            // validate phone no format
            self.lblCompanyTelNoError.text = Messages.PHONE_REG_LENGTH_ERROR.localized
            self.companyTelNoErrorMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
            isError = true
            
        } else {
            self.companyTelNoErrorMesgLocale = Constants.BLANK
            self.lblCompanyTelNoError.text = Constants.BLANK
        }
        
        if self.tfDepartment?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfDepartment?.text = Constants.BLANK
            self.lblDepartmentError.text = Messages.DEPARTMENT_EMPTY_ERROR.localized
            self.departmentErrorMesgLocale = Messages.DEPARTMENT_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblDepartmentError.text = Constants.BLANK
            self.departmentErrorMesgLocale = Constants.BLANK
        }
        
        if self.tfPosition?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfPosition?.text = Constants.BLANK
            self.lblPositionError.text = Messages.DEPARTMENT_EMPTY_ERROR.localized
            self.positionErrorMesgLocale = Messages.DEPARTMENT_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblPositionError.text = Constants.BLANK
            self.positionErrorMesgLocale = Constants.BLANK
        }
        
        if self.tfMonthlyIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true || self.tfMonthlyIncome.text! == "0"{
            self.tfMonthlyIncome?.text = Constants.BLANK
            self.lblMonthlyBasicError.text = Messages.MONTHLY_INCOME_EMPTY_ERROR.localized
            self.monthlyIncomeErrorMesgLocale = Messages.MONTHLY_INCOME_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblMonthlyBasicError.text = Constants.BLANK
            self.monthlyIncomeErrorMesgLocale = Constants.BLANK
        }
//
//        if self.tfTotalIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
//            self.tfTotalIncome?.text = Constants.BLANK
//            self.lblTotalIncomeError.text = Messages.TOTAL_INCOME_EMPTY_ERROR.localized
//            self.totalIncomeErrorMesgLocale = Messages.TOTAL_INCOME_EMPTY_ERROR
//            isError = true
//
//        } else {
//            self.lblTotalIncomeError.text = Constants.BLANK
//            self.totalIncomeErrorMesgLocale = Constants.BLANK
//        }
        
        return isError
    } //End of isErrorExit
    
    func markGuarantorErrorCount() {
        
        var errorcount = 0
       
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        }
//        else if !Utils.isNameValidate(name: (self.tfName!.text)!){
//            errorcount += 1
//        }
        
        // Current address
        if self.tfStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if self.tfTsp?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if !self.allCurrTownNameList.contains((self.tfTsp?.text)!) {
            errorcount += 1
        }
        
        // Permanent address
        if self.tfCompanyStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if self.tfCompanyTsp?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if !self.allComTownNameList.contains((self.tfCompanyTsp?.text)!) {
            errorcount += 1
        }
        
        
        // Validate Date of Birth [dd-MM-yyyy]
        if self.tfDob?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else if !Utils.isDobValidateDA(dob: (self.tfDob?.text)!){
            errorcount += 1
            
        }
        
        // Validate NRC Township
        if self.tfTownshipAutoText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else if !self.selectedTownshipList.contains(self.tfTownshipAutoText.text!){
            errorcount += 1
            
        }
        
        // Validate Nrc No.
        if self.tfNrcNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
           errorcount += 1
            
        } else if !Utils.isNrcNoValidate(nrcNo: (self.tfNrcNo?.text)!){
            errorcount += 1
            
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfMobileNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else if !Utils.isPhoneValidate(phoneNo: (self.tfMobileNo?.text)!){
            // validate phone no format
            errorcount += 1
            
        }
        
        //Validate Resident Phone No. [09[0-9]{7,9}]
//        if self.tfResidentTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
//           errorcount += 1
//
//        } else
        if !(self.tfResidentTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false){
            if !Utils.isNumberValidate(phoneNo: (self.tfResidentTelNo?.text)!){
                // validate phone no format
                errorcount += 1
                
            }
        }
        
        if !self.isMyanmarNationality {
            if self.tfNationality?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
                errorcount += 1
                
            }
        }
        
        if self.btnTypeResidence.titleLabel?.text == "Hostel/Other" {
            if self.tfTypeResidence?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
                errorcount += 1
                
            }
        }
        
        //YEAR of Stay
        if self.tfYear?.text == "0" && self.tfMonth?.text == "0"{
            errorcount += 1
            
        }
        
        //YEAR of Service
        if self.tfYearService?.text == "0" && self.tfMonthService.text == "0"{
            errorcount += 1
            
        }
        // COMPANY Name [a-zA-Z0-9 ]
        if self.tfCompanyName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        }
        
        //Company Phone No. [09[0-9]{7,9}]
        if self.tfCompanyTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else if !Utils.isNumberValidate(phoneNo: (self.tfMobileNo?.text)!){
            // validate phone no format
            errorcount += 1
            
        }
        
        if self.tfDepartment?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        }
        
        if self.tfPosition?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
           errorcount += 1
            
        }
        
        if self.tfMonthlyIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
           errorcount += 1
            
        }
        
//        if self.tfTotalIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
//            errorcount += 1
//            
//        }
        
        UserDefaults.standard.set(errorcount, forKey: Constants.GUARANTOR_ERROR_COUNT)
        
    } //End of markGuarantorErrorCount
    
    @IBAction func doSaveData(_ sender: Any) {
        
        self.markGuarantorDatatLastState()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveDA"), object: nil)
//        if isErrorExist() {
//            return
//        }
    }
    
    @IBAction func tapOnNextGuarantor(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnNext"), object: nil , userInfo: ["index" : 4])
    }
    
    
}

extension GuarantorVC: TownshipSelectDelegate {
    func onClickTownshipCode(townshipCode: String) {
        //self.lblTownship.text = townshipCode
    }
}

extension GuarantorVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tfTownshipAutoText.hideResultsList()
        self.tfTsp.hideResultsList()
        self.tfCompanyTsp.hideResultsList()
    }
}

extension GuarantorVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 100
    }
}

extension GuarantorVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.numberPicker?.reloadAllComponents()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if tfYear.isFirstResponder {
            return yearList.count
            
        } else if tfMonth.isFirstResponder {
            return monthList.count
            
        } else if tfYearService.isFirstResponder {
            return yearList.count
            
        } else if tfMonthService.isFirstResponder {
            return monthList.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if tfYear.isFirstResponder {
            return "\(yearList[row])"
            
        } else if tfMonth.isFirstResponder {
            return "\(monthList[row])"
            
        } else if tfYearService.isFirstResponder {
            return "\(yearList[row])"
            
        } else if tfMonthService.isFirstResponder {
            return "\(monthList[row])"
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if tfYear.isFirstResponder {
            tfYear.text = "\(yearList[row])"
            
        } else if tfMonth.isFirstResponder {
            tfMonth.text = "\(monthList[row])"
        
        } else if tfYearService.isFirstResponder {
            tfYearService.text = "\(yearList[row])"
            
        } else if tfMonthService.isFirstResponder {
            tfMonthService.text = "\(monthList[row])"
        
        }
        
        self.view.endEditing(true)
    }
    
}
