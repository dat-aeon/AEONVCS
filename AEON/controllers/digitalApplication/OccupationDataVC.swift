//
//  OccupationDataVC.swift
//  AEONVCS
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SearchTextField
import SkyFloatingLabelTextField
import SwiftyJSON
import SwipeMenuViewController
import SwiftyJSON
import AVFoundation


class OccupationDataVC: BaseUIViewController {
   
    
    @IBOutlet weak var svOccupationData: UIScrollView!
    @IBOutlet weak var lblBldNo: UILabel!
    @IBOutlet weak var tfBldNO: UITextField!
    @IBOutlet weak var lblRoomNo: UILabel!
    @IBOutlet weak var tfRoomNo: UITextField!
    @IBOutlet weak var lblFloor: UILabel!
    @IBOutlet weak var tfFloor: UITextField!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var lblQrt: UILabel!
    @IBOutlet weak var tfQrt: UITextField!
    @IBOutlet weak var lblTsp: UILabel!
    @IBOutlet weak var tfTsp: SearchTextField!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var btnCity: UIButton!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyAddress: UILabel!
    
    @IBOutlet weak var lblSalaryDate: UILabel!
    @IBOutlet weak var lblTotalIncome: UILabel!
    @IBOutlet weak var lblOtherIncome: UILabel!
    @IBOutlet weak var lblMonthlyBasicIncome: UILabel!
    @IBOutlet weak var lblCompanyStatus: UILabel!
    @IBOutlet weak var lblYearService: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblDepartment: UILabel!
    @IBOutlet weak var lblContactTime: UILabel!
    @IBOutlet weak var lblCompanyTelNo: UILabel!
    
    @IBOutlet weak var lblCompanyNameError: UILabel!
    @IBOutlet weak var lblAddressError: UILabel!
    @IBOutlet weak var lblTelNoError: UILabel!
    @IBOutlet weak var lblContactTimeError: UILabel!
    @IBOutlet weak var lblDepartmentError: UILabel!
    @IBOutlet weak var lblPositionError: UILabel!
    @IBOutlet weak var lblYearServiceError: UILabel!
    @IBOutlet weak var lblStatusError: UILabel!
    @IBOutlet weak var lblMonthlyIncomeError: UILabel!
    @IBOutlet weak var lblOtherIncomeError: UILabel!
//    @IBOutlet weak var lblTotalIncomeError: UILabel!
    @IBOutlet weak var lblSalaryDateError: UILabel!
    
    @IBOutlet weak var tfAM: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPM: SkyFloatingLabelTextField!
    @IBOutlet weak var tfYear: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMonth: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnCompanyStatus: UIButton! {
        didSet {
            self.btnCompanyStatus.clipsToBounds = true
            self.btnCompanyStatus.layer.cornerRadius = 5
            self.btnCompanyStatus.layer.borderWidth = 1.0
            self.btnCompanyStatus.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    @IBOutlet weak var tfSalaryDate: UITextField!
    
    @IBOutlet weak var tfCompanyName: UITextField!
    @IBOutlet weak var tfCompanyTelNo: UITextField!
    @IBOutlet weak var tfDepartment: UITextField!
    @IBOutlet weak var tfPosition: UITextField!
    @IBOutlet weak var tfCompanyStatusAutoText: SearchTextField!
    @IBOutlet weak var tfCompanyStatus: UITextField!
    
    @IBOutlet weak var tfMonthlyBasicIncome: UITextField!
    @IBOutlet weak var tfOtherIncome: UITextField!
    @IBOutlet weak var tfTotalIncome: UITextField!
    @IBOutlet weak var lbTotalIncomeTxt: UILabel!
    
    @IBOutlet weak var backView: UIImageView!
    
//    var companyStatusList = ["Public Company","Factory", "Police","Private Company","SME Owner","Goverment Office", "Taxi Owner", "Specialist", "SME officer", "Military", "NGO", "Other"]
//
    //Warning Outlet and Height
    @IBOutlet weak var buldingNoWarning: UILabel!
    @IBOutlet weak var buldingNowarningHeight: NSLayoutConstraint!
    @IBOutlet weak var RoomNoWarning: UILabel!
    @IBOutlet weak var roomNoWarningHeight: NSLayoutConstraint!
    @IBOutlet weak var floorNoWarning: UILabel!
    @IBOutlet weak var floorNoHeight: NSLayoutConstraint!
    @IBOutlet weak var streetWarning: UILabel!
    @IBOutlet weak var streetWarningHeight: NSLayoutConstraint!
    @IBOutlet weak var quarterWarning: UILabel!
    @IBOutlet weak var quarterWarningHeight: NSLayoutConstraint!
    
    
    var daysArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    
    var yearList :[Int]!
    var monthList :[Int]!
    var numberPicker : UIPickerView!
    
    // City Township
    var allTownNameList = [String]()
    var cityNameList = [String]()
    var cityTownshipModel = CityTownShipModel()
    var selectedCityID : Int?
    var selectedTownshipID: Int?
    
    var companyNameMesgLocale: String?
    var companyAddressMesgLocale: String?
    var companyTelNoMesgLocale: String?
    var contactTimeMesgLocale: String?
    var departmentMesgLocale: String?
    var positionMesgLocale: String?
    var yearServiceMesgLocale: String?
    var companyStatusMesgLocale: String?
    var monthlyBasicIncomeMesgLocale: String?
    var otherIncomeMesgLocale: String?
    var totalIncomeMesgLocale: String?
    var salaryDateMesgLocale: String?
    
    var selectedStatusIndex = 1
    var logoutTimer: Timer?
    var tokenInfo: TokenData?
     var delegate: applyLoanDelegate?
    var myAppData = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 1 , nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)
    var myLoanData = LoanConfirmationRequest(daLoanTypeId: 1, financeAmount: 0.0, financeTerm: 0, daProductTypeId: 1, productDescription: "", channelType: 2)
    
    var myGuarantorData = GuarantorRequest(daGuarantorInfoId: 0,name: "", dob: "", nrcNo: "", nationality: 1, nationalityOther: "", mobileNo: "", residentTelNo: "", relationship: 1, relationshipOther: "", currentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", gender: 1, maritalStatus: 1, yearOfStayYear: 0, yearOfStayMonth: 0, companyName: "", companyTelNo: "", companyAddress: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, monthlyBasicIncome: 0.0, totalIncome: 0.0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
    
    var myOccupationData = OccupationDataRequest(daApplicantCompanyInfoId: 0, companyName: "", companyAddress: "", companyTelNo: "", contactTimeFrom: "", contactTimeTo: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, companyStatus: 1, companyStatusOther: "", monthlyBasicIncome: 0.0, otherIncome: 0.0, totalIncome: 0.0, salaryDay: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
    
    var myContactData = EmergencyContactRequest(daEmergencyContactInfoId: 0, name: "", relationship: 1, relationshipOther: "", currentAddress: "", mobileNo: "", residentTelNo: "", otherPhoneNo: "", currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0)
    var myAttachments = [AttachmentRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       NotificationCenter.default.addObserver(self, selector: #selector(alertSuccess), name: NSNotification.Name(rawValue: "applicationSuccessfully"), object: nil)
        self.backView.isUserInteractionEnabled = true
         self.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtn)))
       // logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        self.lblCompanyNameError.text = Constants.BLANK
//        self.lblAddressError.text = Constants.BLANK
        self.lblTelNoError.text = Constants.BLANK
        self.lblContactTimeError.text = Constants.BLANK
        self.lblDepartmentError.text = Constants.BLANK
        self.lblPositionError.text = Constants.BLANK
        self.lblYearServiceError.text = Constants.BLANK
        self.lblStatusError.text = Constants.BLANK
        self.lblMonthlyIncomeError.text = Constants.BLANK
        self.lblOtherIncomeError.text = Constants.BLANK
        //self.lblTotalIncomeError.text = Constants.BLANK
        self.lblSalaryDateError.text = Constants.BLANK
        
        
        self.tfAM.font = UIFont.systemFont(ofSize: 15)
        self.tfPM.font = UIFont.systemFont(ofSize: 15)
        self.tfYear.font = UIFont.systemFont(ofSize: 15)
        self.tfMonth.font = UIFont.systemFont(ofSize: 15)
        
        self.tfAM.keyboardType = .numberPad
        self.tfPM.keyboardType = .numberPad
        self.tfYear.keyboardType = .numberPad
        self.tfMonth.keyboardType = .numberPad
        
        
       self.tfCompanyStatus.isHidden = true
        //autocomplete
        self.tfCompanyStatusAutoText.theme.cellHeight = 40
        self.tfCompanyStatusAutoText.maxResultsListHeight = 300
        self.tfCompanyStatusAutoText.startVisible = true
        self.tfCompanyStatusAutoText.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfCompanyStatusAutoText.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfCompanyStatusAutoText.theme.bgColor = UIColor.groupTableViewBackground
        self.tfCompanyStatusAutoText.theme.separatorColor = UIColor.lightGray
        //let v = CommonDataCConstants.some
        self.tfCompanyStatusAutoText.filterStrings(Constants.companyStatusList)
        self.tfCompanyStatusAutoText.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.selectedStatusIndex = itemPosition + 1
            self.tfCompanyStatusAutoText.text = item.title
            self.tfCompanyStatusAutoText.backgroundColor = UIColor.white
            if item.title == "Other" {
                self.tfCompanyStatus.isHidden = false
            } else {
                self.tfCompanyStatus.isHidden = true
                self.tfCompanyStatus.text = Constants.BLANK
            }
        }
        
        tfCompanyName.setMaxLength(maxLength: 60)
        tfCompanyTelNo.setMaxLength(maxLength: 11)
        tfDepartment.setMaxLength(maxLength: 60)
        tfPosition.setMaxLength(maxLength: 60)
        tfAM?.setMaxLength(maxLength: 2)
        tfPM?.setMaxLength(maxLength: 2)
        tfYear?.setMaxLength(maxLength: 2)
        tfMonth?.setMaxLength(maxLength: 2)
        tfCompanyStatus.setMaxLength(maxLength: 50)
        tfMonthlyBasicIncome.setMaxLength(maxLength: 12)
        tfOtherIncome.setMaxLength(maxLength: 12)
        tfTotalIncome.setMaxLength(maxLength: 12)
        tfBldNO.setMaxLength(maxLength: 20)
        tfRoomNo.setMaxLength(maxLength: 20)
        tfFloor.setMaxLength(maxLength: 20)
        tfQrt.setMaxLength(maxLength: 100)
        tfStreet.setMaxLength(maxLength: 100)
        tfTsp.setMaxLength(maxLength: 100)
        
        tfCompanyName.autocapitalizationType = .allCharacters
        tfCompanyStatus.autocapitalizationType = .allCharacters
        tfDepartment.autocapitalizationType = .allCharacters
        tfPosition.autocapitalizationType = .allCharacters
        tfBldNO.autocapitalizationType = .allCharacters
        tfRoomNo.autocapitalizationType = .allCharacters
        tfFloor.autocapitalizationType = .allCharacters
        tfQrt.autocapitalizationType = .allCharacters
        tfStreet.autocapitalizationType = .allCharacters
        
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
        
        
        self.updateViews()
        self.setupTownshipCityData()
        self.setupAMTimepicker()
        self.setupPMTimepicker()
        
        self.tfMonthlyBasicIncome.addTarget(self, action: #selector(basicIncomeDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.tfOtherIncome.addTarget(self, action: #selector(otherIncomeDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(markOccupationDataLastState), name: NSNotification.Name(rawValue: "markOccupationDataLastState"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showOccupationForm(notification:)), name: NSNotification.Name(rawValue: "showOccupationForm"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorLabelOccupation), name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
        
        // mendatory fields background setting
        self.tfCompanyName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfStreet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfBldNO.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfRoomNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfQrt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfFloor.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.tfTsp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyTelNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfAM.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfPM.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfDepartment.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfPosition.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfYear.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMonth.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyStatusAutoText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyStatus.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMonthlyBasicIncome.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
       
               
                NotificationCenter.default.addObserver(self, selector: #selector(doSetAppData(notification:)), name: NSNotification.Name(rawValue: "SetAppData"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSetOccupationData(notification:)), name: NSNotification.Name(rawValue: "SetOccupationData"), object: nil)
               
             
            
                NotificationCenter.default.addObserver(self, selector: #selector(doRegisterDA), name: NSNotification.Name(rawValue: "doRegistration"), object: nil)
               
//               NotificationCenter.default.addObserver(self, selector: #selector(doSaveDA), name: NSNotification.Name(rawValue: "saveDA"), object: nil)
//         NotificationCenter.default.addObserver(self, selector: #selector(showPreview), name: NSNotification.Name(rawValue: "showPreview"), object: nil)
        self.doLoadSaveDAData()
        
    }
    
     @objc func doRegisterDA() {
        //        self.logoutTimer?.invalidate()
                let appError = UserDefaults.standard.integer(forKey: Constants.APP_DATA_ERROR_COUNT)
                let occupationError = UserDefaults.standard.integer(forKey: Constants.OCCUPATION_DATA_ERROR_COUNT)
                let contactError = UserDefaults.standard.integer(forKey: Constants.EMERGENCY_CONTACT_ERROR_COUNT)
                 let guarantorError = UserDefaults.standard.integer(forKey: Constants.GUARANTOR_ERROR_COUNT)
                 let loanError = UserDefaults.standard.integer(forKey: Constants.LOAN_CONFIRMATION_ERROR_COUNT)
                
                if appError == 0 && occupationError == 0 && contactError == 0 && guarantorError == 0 && loanError == 0 {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let popupVC = storyboard.instantiateViewController(withIdentifier: CommonNames.CHECK_PASSWORD_POPUP_VC) as! CheckPasswordPopupVC
                    popupVC.modalPresentationStyle = .overCurrentContext
                    popupVC.modalTransitionStyle = .crossDissolve
                    popupVC.preferredContentSize = CGSize(width: 400, height: 300)
                    popupVC.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
                    //popupVC.ivMainView.alpha = 0.5
                    let pVC = popupVC.popoverPresentationController
                    pVC?.permittedArrowDirections = .any
                    
                    //pVC?.sourceView = sender
                    pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
                    
                    self.definesPresentationContext = true
                    popupVC.delegate = self
                    popupVC.titleString = "Enter Password"
                    self.present(popupVC, animated: true, completion: nil)
                    
                  // self.doRegisterDAApi()
                } else {
                    var errorString = ""
                    if appError > 0 {
                        errorString += "In Application Data, total warning : \(appError) \n"
                    }
                    
                    if occupationError > 0 {
                        errorString += "In Occupation Data, total warning : \(occupationError) \n"
                    }
                    
                    if contactError > 0 {
                        errorString += "In Emergency Contact, total warning : \(contactError) \n"
                    }
                    
                    if guarantorError > 0 {
                        errorString += "In Guarantor, total warning : \(guarantorError) \n"
                    }
                    
                    if loanError > 0 {
                        errorString += "In Loan Confirmation, total warning : \(loanError) \n"
                    }
                    
                    let alertController = UIAlertController(title: "Please fill all the mendantory fields!", message: errorString, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                        if appError > 0 {
                            //go to application data
    //                        self.changeTextIndicator(selectedIndex: 0)
    //                        self.progressBarWithoutLastState.currentIndex = 0
    //                        self.viewSwipeMenu.jump(to: 0, animated: true)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                        } else if occupationError > 0 {
                            //go to application data
    //                        self.changeTextIndicator(selectedIndex: 1)
    //                        self.progressBarWithoutLastState.currentIndex = 1
    //                        self.viewSwipeMenu.jump(to: 1, animated: true)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                        } else if contactError > 0 {
                            //go to application data
    //                        self.changeTextIndicator(selectedIndex: 2)
    //                        self.progressBarWithoutLastState.currentIndex = 2
    //                        self.viewSwipeMenu.jump(to: 2, animated: true)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                        } else if guarantorError > 0 {
                            //go to application data
    //                        self.changeTextIndicator(selectedIndex: 3)
    //                        self.progressBarWithoutLastState.currentIndex = 3
    //                        self.viewSwipeMenu.jump(to: 3, animated: true)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                        } else if loanError > 0 {
                            //go to application data
        //                    self.changeTextIndicator(selectedIndex: )
        //                    self.progressBarWithoutLastState.currentIndex = 1
        //                    self.viewSwipeMenu.jump(to: 1, animated: true)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                        }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
             self.doLoadSaveDAData()
                
            }
    @objc func alertSuccess() {
        streetWarningHeight.constant = 0
        buldingNowarningHeight.constant = 0
        roomNoWarningHeight.constant = 0
        floorNoHeight.constant = 0
        quarterWarningHeight.constant = 0
        self.lblCompanyNameError.text = Constants.BLANK
        self.lblDepartmentError.text = Constants.BLANK
        self.lblPositionError.text = Constants.BLANK
        self.lblTelNoError.text = Constants.BLANK
          self.lblYearServiceError.text = Constants.BLANK
          self.lblStatusError.text = Constants.BLANK
          self.lblMonthlyIncomeError.text = Constants.BLANK
          self.lblOtherIncomeError.text = Constants.BLANK
          self.lblSalaryDateError.text = Constants.BLANK
           let alertController = UIAlertController(title: "Your application is successfully saved!", message: "", preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                 
           }))
           self.present(alertController, animated: true, completion: nil)
       }
    @objc func doSetAppData(notification: Notification) {
               print("doSetAppData")
               if let dict = notification.userInfo as? Dictionary<String, Any> {
                   print("doSetAppData \(dict)")
                   if let sVar = dict["appData"] as? ApplicationDataRequest {
                       print("doSetAppData \(sVar.name)")
                       self.myAppData = sVar
                       print("doSetAppData myappdata.name \(self.myAppData.name)")
                   }
               }
           }
    @objc func doSetOccupationData(notification: Notification) {
               print("doSetOccupationData")
               if let dict = notification.userInfo as? Dictionary<String, Any> {
                   print("doSetOccupationData \(dict)")
                   if let sVar = dict["appData"] as? OccupationDataRequest {
                       print("doSetOccupationData \(sVar.companyName)")
                       self.myOccupationData = sVar
                       print("doSetOccupationData myappdata.name \(self.myOccupationData.companyName)")
                   }
               }
           }
       
       
        func doLoadSaveDAData() {
            let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
            tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
            
             let customerId = UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID)
            
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            DAViewModel.init().doLoadSaveDataDigitalApplication(tokenInfo: tokenInfo!, cusID: customerId!, success: { (responseObjDA) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                print("LOAD DATA SUCCESS")
                self.myContactData = responseObjDA.emergencyContactInfoDto!
                print("\(self.myContactData.name)")
                self.myGuarantorData = responseObjDA.guarantorInfoDto!
                self.myOccupationData = responseObjDA.applicantCompanyInfoDto!
                
//                let appdata = ApplicationDataRequest(daApplicationInfoId: responseObjDA.daApplicationInfoId ?? 0, daApplicationTypeId: responseObjDA.daApplicationTypeId ?? 1, name: responseObjDA.name ?? "", dob: responseObjDA.dob ?? "", nrcNo: responseObjDA.nrcNo ?? "", fatherName: responseObjDA.fatherName ?? "",highestEducationTypeId: responseObjDA.highestEducationTypeId ?? 1, nationality: responseObjDA.nationality ?? 1, nationalityOther: responseObjDA.nationalityOther ?? "", gender: responseObjDA.gender!, maritalStatus: responseObjDA.maritalStatus ?? 1, currentAddress: responseObjDA.currentAddress ?? "", permanentAddress: responseObjDA.permanentAddress ?? "", typeOfResidence: responseObjDA.typeOfResidence ?? 1, typeOfResidenceOther: responseObjDA.typeOfResidenceOther ?? "", livingWith: responseObjDA.livingWith ?? 1, livingWithOther: responseObjDA.livingWithOther ?? "", yearOfStayYear: responseObjDA.yearOfStayYear ?? 0, yearOfStayMonth: responseObjDA.yearOfStayMonth ?? 0, mobileNo: responseObjDA.mobileNo ?? "", residentTelNo: responseObjDA.residentTelNo ?? "", otherPhoneNo: responseObjDA.otherPhoneNo ?? "", email: responseObjDA.email ?? "", customerId: responseObjDA.customerId ?? 0, status: responseObjDA.status ?? 0, currentAddressFloor: responseObjDA.currentAddressFloor ?? "", currentAddressBuildingNo: responseObjDA.currentAddressBuildingNo ?? "", currentAddressRoomNo: responseObjDA.currentAddressRoomNo ?? "", currentAddressStreet: responseObjDA.currentAddressStreet ?? "", currentAddressQtr: responseObjDA.currentAddressQtr ?? "", currentAddressTownship: responseObjDA.currentAddressTownship ?? 0, currentAddressCity: responseObjDA.currentAddressCity ?? 0,permanentAddressCity: responseObjDA.permanentAddressCity ?? 0, permanentAddressFloor: responseObjDA.permanentAddressFloor ?? "", permanentAddressBuildingNo: responseObjDA.permanentAddressBuildingNo ?? "", permanentAddressRoomNo: responseObjDA.permanentAddressRoomNo ?? "", permanentAddressStreet: responseObjDA.permanentAddressStreet ?? "", permanentAddressQtr: responseObjDA.permanentAddressQtr ?? "", permanentAddressTownship: responseObjDA.permanentAddressTownship ?? 0)
                var responseObjOccupation = responseObjDA.applicantCompanyInfoDto
                var appdata = OccupationDataRequest(daApplicantCompanyInfoId: responseObjDA.daApplicationInfoId ?? 0, companyName: responseObjOccupation?.companyName ?? "", companyAddress: responseObjOccupation?.companyAddress ?? "", companyTelNo: responseObjOccupation?.companyTelNo ?? "", contactTimeFrom: responseObjOccupation?.contactTimeFrom ?? "", contactTimeTo: responseObjOccupation?.contactTimeTo ?? "", department: responseObjOccupation?.department ?? "", position: responseObjOccupation?.position ?? "", yearOfServiceYear: responseObjOccupation?.yearOfServiceYear ?? 0, yearOfServiceMonth: responseObjOccupation?.yearOfServiceMonth ?? 0, companyStatus: responseObjOccupation?.companyStatus ?? 0, companyStatusOther: responseObjOccupation?.companyStatusOther ?? "", monthlyBasicIncome: responseObjOccupation?.monthlyBasicIncome ?? 0.0, otherIncome: responseObjOccupation?.otherIncome ?? 0.0, totalIncome: responseObjOccupation?.totalIncome ?? 0.0, salaryDay: responseObjOccupation?.salaryDay ?? 0, companyAddressBuildingNo: responseObjOccupation?.companyAddressBuildingNo ?? "", companyAddressRoomNo: responseObjOccupation?.companyAddressRoomNo ?? "", companyAddressFloor: responseObjOccupation?.companyAddressFloor ?? "", companyAddressStreet: responseObjOccupation?.companyAddressStreet ?? "", companyAddressQtr: responseObjOccupation?.companyAddressQtr ?? "", companyAddressTownship: responseObjOccupation?.companyAddressTownship ?? 0, companyAddressCity: responseObjOccupation?.companyAddressCity ?? 0)
                
                
                DispatchQueue.main.async {
                    self.myOccupationData = appdata
                }
                self.fillThisForm(data: self.myOccupationData)
    //            DispatchQueue.main.async {
    //                self.delegate?.showApplicationForm()
    //            }
                
                let loanData = LoanConfirmationRequest(daLoanTypeId: responseObjDA.daLoanTypeId ?? 1, financeAmount: responseObjDA.financeAmount ?? 0.0, financeTerm: responseObjDA.financeTerm ?? 0, daProductTypeId: responseObjDA.daProductTypeId ?? 1, productDescription: responseObjDA.productDescription ?? "", channelType: responseObjDA.channelType ?? 2)
                self.myLoanData = loanData
                
                applicationFormID = self.myAppData.daApplicationInfoId
                occupationFormID = self.myOccupationData.daApplicantCompanyInfoId
                emergencyFormID = self.myContactData.daEmergencyContactInfoId
                guarantorFormID = self.myGuarantorData.daGuarantorInfoId
                applicationStatus = self.myAppData.status
                
                
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
                if error == Constants.SERVER_FAILURE {
                     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                    self.present(navigationVC, animated: true, completion: nil)
                    
                } else if error == Constants.EXPIRE_TOKEN {
                    Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "Application Form " + Messages.EXPIRE_TOKEN_ERROR.localized)
                    
                } else if error == "Empty" {
                    //nothing data
                    let appdata = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 1, nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)
                    
                    self.myAppData = appdata
                    myAppFormData = self.myAppData
    //                DispatchQueue.main.async {
    //                    self.delegate?.showApplicationForm()
    //                }
                } else {
                    Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "News " + error)
                }
            }
        }
    //    @objc func runTimedCode() {
    //                   multiLoginGet()
    //               // print("kms\(logoutTimer)")
    //               }
    //       func multiLoginGet(){
    //                  let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
    //               var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
    //              MultiLoginModel.init().makeMultiLogin(customerId: customerId
    //                      , loginDeviceId: deviceID, success: { (results) in
    //                      print("kaungmyat san multi >>>  \(results)")
    //
    //                      if results.data.logoutFlag == true {
    //                          print("success stage logout")
    //                          // create the alert
    //                                 let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)
    //
    //                                 // add an action (button)
    //                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
    //                              self.logoutTimer?.invalidate()
    //                              let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
    //                              navigationVC.modalPresentationStyle = .overFullScreen
    //                              self.present(navigationVC, animated: true, completion:nil)
    //
    //                          }))
    //
    //                                 // show the alert
    //                                 self.present(alert, animated: true, completion: nil)
    //
    //
    //                      }
    //                  }) { (error) in
    //                      print(error)
    //                  }
    //              }
        
        @objc func showErrorLabelApplication() {
           _ = self.isErrorExist()
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            if textField.text == "" {
                textField.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
            } else {
                textField.backgroundColor = UIColor.white
            }
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
                  //    print("kaungmyat san multi >>>  \(results)")
                      
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

   @objc func backBtn() {
          self.dismiss(animated: true, completion: nil)
      }
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        if textField.text == "" {
//            textField.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
//        } else {
//            textField.backgroundColor = UIColor.white
//        }
//    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification {
            svOccupationData.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
            
        } else {
            svOccupationData.contentInset = UIEdgeInsets.zero
        }
        svOccupationData.scrollIndicatorInsets = svOccupationData.contentInset
    }

    @objc func basicIncomeDidChange(_ textField: UITextField) {
        print("textfield did change")
        
        let basicString = "\(textField.text ?? "0")"
        let basicInt = Int(basicString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        let otherString = "\(self.tfOtherIncome.text ?? "0")"
        let otherInt = Int(otherString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        let total = basicInt + otherInt
        self.lbTotalIncomeTxt.text = Int(total).thousandsFormat
        self.tfMonthlyBasicIncome.text = basicInt.thousandsFormat
        
    }
    
    @objc func otherIncomeDidChange(_ textField: UITextField) {
        print("textfield did change")
        
        let basicString = "\(self.tfMonthlyBasicIncome.text ?? "0")"
        let basicInt = Int(basicString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        let otherString = "\(textField.text ?? "0")"
        let otherInt = Int(otherString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        let total = basicInt + otherInt
        self.lbTotalIncomeTxt.text = Int(total).thousandsFormat
        self.tfOtherIncome.text = otherInt.thousandsFormat
    }
    
    @IBAction func onClickCityBtn(_ sender: UIButton) {
        self.tfAM?.resignFirstResponder()
        self.tfPM.resignFirstResponder()
        openCitySelectionPopUp()
    }
    
    func openCitySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                
                if self.allTownNameList.count >= 0 {
                    self.tfTsp.filterStrings(self.allTownNameList)
                    self.tfTsp.text = Constants.BLANK
                    self.tfTsp.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.tfCity
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                
                if self.allTownNameList.count >= 0 {
                    self.tfTsp.filterStrings(self.allTownNameList)
                    self.tfTsp.text = Constants.BLANK
                    self.tfTsp.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
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
            self.tfTsp.backgroundColor = UIColor.white
            self.selectedTownshipID = self.cityTownshipModel.townNameIdDic![item.title]
            print("\(item.title)", "\(self.selectedTownshipID ?? 0)")
        }
        
        //load city township data
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        DAViewModel.init().getCityTownshipList(success: { (model) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.cityTownshipModel = model
            for cityName in model.cityNameIdDic!.keys {
                self.cityNameList.append(cityName)
            }
            // Company Address
            self.selectedCityID = model.cityNameIdDic![self.cityNameList[0]]
            self.btnCity.setTitle("", for: UIControl.State.normal)
            self.allTownNameList = model.cityIdTownListDic![self.selectedCityID!]!
            self.tfTsp.filterStrings(self.allTownNameList)
            
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
      
    func setupAMTimepicker() {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        self.tfAM?.inputView = datePickerView
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let min = timeFormatter.date(from: "00:00")
        let max = timeFormatter.date(from: "11:59")
        datePickerView.minimumDate = min
        datePickerView.maximumDate = max

        datePickerView.addTarget(self, action: #selector(timePickerFromValueChangedAM), for: UIControl.Event.valueChanged)
        
        self.tfAM?.delegate = self
    }
    
    func setupPMTimepicker() {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        self.tfPM?.inputView = datePickerView
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let min = timeFormatter.date(from: "12:00")
        let max = timeFormatter.date(from: "23:59")
        datePickerView.minimumDate = min
        datePickerView.maximumDate = max

        datePickerView.addTarget(self, action: #selector(timePickerFromValueChangedPM), for: UIControl.Event.valueChanged)
        
        self.tfPM?.delegate = self
    }
    
    @objc func timePickerFromValueChangedAM(sender:UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeStyle = .short
        self.tfAM.text = String(timeFormatter.string(from: sender.date).split(separator: " ")[0])
        //self.view.endEditing(true)
    }
    @objc func timePickerFromValueChangedPM(sender:UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeStyle = .short
        self.tfPM.text = String(timeFormatter.string(from: sender.date).split(separator: " ")[0])
        //self.view.endEditing(true)
    }
    
    @objc func showErrorLabelOccupation() {
        _ = self.isErrorExist()
    }
    
    @objc func showOccupationForm(notification: Notification) {
        if let dict = notification.userInfo as? Dictionary<String, Any> {
            print("showOccupationForm \(dict)")
            if let sVar = dict["data"] as? OccupationDataRequest {
                self.fillThisForm(data: sVar)
            }
        }
    }
    
    func fillThisForm(data: OccupationDataRequest) {
        self.tfCompanyName.text = data.companyName
        self.textFieldDidChange(self.tfCompanyName)
        
//        self.tvCompanuAddress.text = data.companyAddress
        self.tfCompanyTelNo.text = data.companyTelNo
        self.textFieldDidChange(self.tfCompanyTelNo)
        
        self.tfDepartment.text = data.department
        self.textFieldDidChange(self.tfDepartment)
        
        self.tfPosition.text = data.position
        self.textFieldDidChange(self.tfPosition)
        
        if data.yearOfServiceYear == 0 {
            self.tfYear.text = "0"
        } else {
            self.tfYear.text = "\(data.yearOfServiceYear)"
        }
        self.textFieldDidChange(self.tfYear)
        
        if data.yearOfServiceMonth == 0 {
            self.tfMonth.text = "0"
        } else {
            self.tfMonth.text = "\(data.yearOfServiceMonth)"
        }
        self.textFieldDidChange(self.tfMonth)
        
        self.selectedStatusIndex = data.companyStatus
        //self.btnCompanyStatus.setTitle("\(self.companyStatusList[self.selectedStatusIndex - 1])", for: .normal)
        let status = self.lblStatusError.text ?? Constants.BLANK
        if status == Constants.BLANK {
            self.tfCompanyStatusAutoText.text = Constants.companyStatusList[self.selectedStatusIndex - 1]
        }
        self.textFieldDidChange(self.tfCompanyStatusAutoText)
        
        self.tfCompanyStatus.text = data.companyStatusOther
        self.textFieldDidChange(self.tfCompanyStatus)
        
        if self.selectedStatusIndex == Constants.companyStatusList.count {
            self.tfCompanyStatus.isHidden = false
        } else {
            self.tfCompanyStatus.isHidden = true
        }
        
        if data.monthlyBasicIncome == 0.0 {
            self.tfMonthlyBasicIncome.text = ""
        } else {
            let val = Int(Double(data.monthlyBasicIncome))
            self.tfMonthlyBasicIncome.text = "\(val.thousandsFormat)"
        }
        self.textFieldDidChange(self.tfMonthlyBasicIncome)
        
        if data.otherIncome == 0.0 {
            self.tfOtherIncome.text = ""
        } else {
            let val = Int(Double(data.otherIncome))
            self.tfOtherIncome.text = "\(val.thousandsFormat)"
        }
        if data.totalIncome == 0.0 {
            //self.tfTotalIncome.text = ""
            self.lbTotalIncomeTxt.text = ""
        } else {
            let val = Int(Double(data.totalIncome))
            self.lbTotalIncomeTxt.text = "\(val.thousandsFormat)"
        }
        
        let dobtemp = data.salaryDay
        
        //        if dobtemp != nil {
        self.tfSalaryDate.text  = "\(dobtemp)"
        //        }
        //        else {
        //            self.tfSalaryDate.text  = data.salaryDay
        //        }
        
        self.tfAM.text = data.contactTimeFrom
        self.textFieldDidChange(self.tfAM)
        
        self.tfPM.text = data.contactTimeTo
        self.textFieldDidChange(self.tfPM)
        
        self.tfBldNO.text = data.companyAddressBuildingNo
        self.tfRoomNo.text = data.companyAddressRoomNo
        self.tfFloor.text = data.companyAddressFloor
        self.tfStreet.text = data.companyAddressStreet
        self.textFieldDidChange(self.tfStreet)
        
        self.tfQrt.text = data.companyAddressQtr
        
        if data.companyAddressCity != 0 {
            for cityName in self.cityTownshipModel.cityNameIdDic!.keys{
                let id = self.cityTownshipModel.cityNameIdDic![cityName]
                if id == data.companyAddressCity {
                    self.btnCity.setTitle(cityName, for: UIControl.State.normal)
                    self.selectedCityID = id
                    break
                }
            }
        }
        
        if data.companyAddressTownship != 0{
            for townName in self.cityTownshipModel.townNameIdDic!.keys{
                let id = self.cityTownshipModel.townNameIdDic![townName]
                if id == data.companyAddressTownship {
                    self.tfTsp.text = townName
                    self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                    self.tfTsp.filterStrings(self.allTownNameList)
                    self.selectedTownshipID = id
                    break
                }
            }
        }
        self.textFieldDidChange(self.tfTsp)
        
    }
    
    @objc func markOccupationDataLastState() {
        
        self.markOccupationErrorCount()
        self.tfTsp.hideResultsList()
        self.tfCompanyStatusAutoText.hideResultsList()
        
        var yearService = 0
        if self.tfYear.text != "" {
            if let intString = Int(self.tfYear.text!) {
                yearService = intString
            }
        }
        
        var monthService = 0
        if self.tfMonth.text != "" {
            if let intString = Int(self.tfMonth.text!) {
                monthService = intString
            }
        }
        
        var monthlyIncome = 0.0
        if self.tfMonthlyBasicIncome.text != ""{
            if let intString = Double(self.tfMonthlyBasicIncome.text!.replacingOccurrences(of: ",", with: "")) {
                monthlyIncome = intString
            }
        }
        
        var otherIncome = 0.0
        if self.tfOtherIncome.text != "" {
            if let intString = Double(self.tfOtherIncome.text!.replacingOccurrences(of: ",", with: "")) {
                otherIncome = intString
            }
        }
        
        var totalIncome = 0.0
        if self.lbTotalIncomeTxt.text != "" {
            if let intString = Double(self.lbTotalIncomeTxt.text!.replacingOccurrences(of: ",", with: "")) {
                totalIncome = intString
            }
        }
        
        if self.tfCompanyName == nil {
            return
        }
        
        if self.tfStreet == nil {
            return
        }
        
        if self.tfCompanyTelNo == nil {
            return
        }
        
        //
        if self.tfPosition == nil {
            return
        }
        //
        //        if self.tfAM == nil {
        //            return
        //        }
        //
        //        if self.tfPM == nil {
        //            return
        //        }
        
        if self.tfDepartment == nil {
            return
        }
        
        if self.tfCompanyStatus == nil {
            return
        }
        
        if self.tfSalaryDate == nil {
            return
        }
        
        let appData = OccupationDataRequest(daApplicantCompanyInfoId: occupationFormID,companyName: self.tfCompanyName.text?.uppercased() ?? "", companyAddress: "", companyTelNo: self.tfCompanyTelNo.text ?? "", contactTimeFrom: self.tfAM.text ?? "", contactTimeTo: self.tfPM.text ?? "", department: self.tfDepartment.text?.uppercased() ?? "", position: self.tfPosition.text?.uppercased() ?? "", yearOfServiceYear: yearService, yearOfServiceMonth: monthService, companyStatus: self.selectedStatusIndex, companyStatusOther: self.tfCompanyStatus.text?.uppercased() ?? "", monthlyBasicIncome: monthlyIncome, otherIncome: otherIncome, totalIncome: totalIncome, salaryDay: Int(self.tfSalaryDate.text ?? "0") ?? 0, companyAddressBuildingNo: "\(self.tfBldNO.text?.uppercased() ?? "")", companyAddressRoomNo: "\(self.tfRoomNo.text?.uppercased() ?? "")", companyAddressFloor: "\(self.tfFloor.text?.uppercased() ?? "")", companyAddressStreet: "\(self.tfStreet.text?.uppercased() ?? "")", companyAddressQtr: "\(self.tfQrt.text?.uppercased() ?? "")", companyAddressTownship: self.selectedTownshipID ?? 0, companyAddressCity: self.selectedCityID ?? 0)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetOccupationData"), object: self, userInfo: ["appData": appData])
        self.view.endEditing(true)
    }
    
    @objc override func updateViews() {
        super.updateViews()
        
        self.lblCompanyName.text = "occupation_company_name".localized
        self.lblCompanyAddress.text = "occupation_company_address".localized
        self.lblCompanyTelNo.text = "occupation_company_telno".localized
        self.lblContactTime.text = "occupation_company_contact_time".localized
        self.lblDepartment.text = "occupation_company_department".localized
        self.lblPosition.text = "occupation_company_position".localized
        self.lblYearService.text = "occupation_company_year_service".localized
        self.lblCompanyStatus.text = "occupation_company_status".localized
        self.lblMonthlyBasicIncome.text = "occupation_monthly_income".localized
        self.lblOtherIncome.text = "occupation_other_income".localized
        self.lblTotalIncome.text = "occupation_total_income".localized
        self.lblSalaryDate.text = "occupation_salary_date".localized
        
        self.lblBldNo.text = "da.buildno".localized
        self.lblFloor.text = "da.floor".localized
        self.lblRoomNo.text = "da.roomno".localized
        self.lblStreet.text = "da.street".localized
        self.lblQrt.text = "da.quarter".localized
        self.lblTsp.text = "da.township".localized
        self.lblCity.text = "da.city".localized
        
        self.lblCompanyNameError.text = self.companyNameMesgLocale?.localized
        self.lblAddressError.text = self.companyAddressMesgLocale?.localized
        self.lblTelNoError.text = self.companyTelNoMesgLocale?.localized
        self.lblContactTimeError.text = self.contactTimeMesgLocale?.localized
        self.lblDepartmentError.text = self.departmentMesgLocale?.localized
        self.lblPositionError.text = self.positionMesgLocale?.localized
        self.lblYearServiceError.text = self.yearServiceMesgLocale?.localized
        self.lblStatusError.text = self.companyStatusMesgLocale?.localized
        self.lblMonthlyIncomeError.text = self.monthlyBasicIncomeMesgLocale?.localized
        self.lblOtherIncomeError.text = self.otherIncomeMesgLocale?.localized
        //self.lblTotalIncomeError.text = self.totalIncomeMesgLocale?.localized
        self.lblSalaryDateError.text = self.salaryDateMesgLocale?.localized
        
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
        
        tfSalaryDate?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
        
    }
    
    
    @objc func dobDatePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tfSalaryDate?.text = dateFormatter.string(from: sender.date)
        
    }
    
    func openCompanyStatusPopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: Constants.companyStatusList, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.btnCompanyStatus.setTitle(value, for: .normal)
                self.selectedStatusIndex = Constants.companyStatusList.firstIndex(of: value)! + 1
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: Constants.companyStatusList, action: { (value)  in
                //                let selectedType = self.typeResidence[-1]
                self.btnCompanyStatus.setTitle(value, for: .normal)
                self.selectedStatusIndex = Constants.companyStatusList.firstIndex(of: value)! + 1
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openSalaryDayPopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: daysArray, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.tfSalaryDate.text = value
                
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: daysArray, action: { (value)  in
                //                let selectedType = self.typeResidence[-1]
                self.tfSalaryDate.text = value
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func doSelectSalaryDay(_ sender: Any) {
        self.openSalaryDayPopup()
    }
    
    
    @IBAction func doSelectCompanyStatus(_ sender: Any) {
        self.openCompanyStatusPopup()
    }
    
    @IBAction func doSaveData(_ sender: Any) {
        
        self.markOccupationDataLastState()
        let appError = UserDefaults.standard.integer(forKey: Constants.OCCUPATION_DATA_ERROR_COUNT)
                var errorString = ""
                
                if appError > 0 {
                    errorString += "In Application Data, total warning : \(appError) \n"
                     let alertController = UIAlertController(title: "Please fill all the mendantory fields!", message: errorString, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { (action) in
                        if appError > 0 {
                                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                                            }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveDA"), object: nil)
       
        
    }
    func doRegisterDAApi() {
           // self.logoutTimer?.invalidate()
             CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                 let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
                self.tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
                       DAViewModel.init().doRegisterDigitalApplication(tokenInfo: self.tokenInfo!, appData: self.myAppData, companyData: self.myOccupationData, emergencyContact: self.myContactData, attachmentlist: self.myAttachments, loanData: self.myLoanData, guarantorData: self.myGuarantorData,  success: { (success) in
                           CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
    //                       self.logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
                           if success {
                               let alertController = UIAlertController(title: Constants.DA_UPLOAD_SUCCESS, message: "Digital Application Registration Success.", preferredStyle: .alert)
                               alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                                   
                                   let storyboard = UIStoryboard(name: "DA", bundle: nil)
                                   let appListNav = storyboard.instantiateViewController(withIdentifier: CommonNames.INQUIRY_LOAN_NAV) as! UINavigationController
                                   let appList = appListNav.children.first as! ApplicationListVC
                                   appList.isRegisterSuccess = true
                                   appListNav.modalPresentationStyle = .overFullScreen

                                   let applyVC = self.presentingViewController
                                   self.dismiss(animated: true, completion: {
                                       applyVC?.present(appListNav, animated: true, completion: nil)
                                       
                                   })
                                   CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                                   
                               }))
                               self.present(alertController, animated: true, completion: nil)
                           }
                           
                       }) { (error) in
                           
    //                       CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                           
                           if error == Constants.SERVER_FAILURE {
                               let storyboard = UIStoryboard(name: "Main", bundle: nil)
                               let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                               self.present(navigationVC, animated: true, completion: nil)
                               
                           } else if error == Constants.EXPIRE_TOKEN {
                               Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "Digital Application " + Messages.EXPIRE_TOKEN_ERROR.localized)
                               
                           } else if error == Constants.APPLICATION_LIMIT{
                               Utils.showAlert(viewcontroller: self, title: Constants.DA_UPLOAD_FAILED, message: "" + Constants.APPLICATION_LIMIT.localized)
                               
                           } else if error == Constants.INVALID_TOTAL_FINANCE_AMOUNT{
                               Utils.showAlert(viewcontroller: self, title: Constants.DA_UPLOAD_FAILED, message: "" + Constants.INVALID_TOTAL_FINANCE_AMOUNT.localized)
                               
                           } else if error == Constants.INVALID_FINANCE_AMOUNT{
                               Utils.showAlert(viewcontroller: self, title: Constants.DA_UPLOAD_FAILED, message: "" + Constants.INVALID_FINANCE_AMOUNT.localized)
                               
                           } else if error == Constants.INVALID_REQUEST_PARAMETER{
                               Utils.showAlert(viewcontroller: self, title: Constants.DA_UPLOAD_FAILED, message: "" + Constants.INVALID_REQUEST_PARAMETER.localized)
                               
                           } else {
                               Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "" + error)
                           }
                           
                           
                       }
            
           
        }
    func doPasswordVerification(strPassword: String, popup: UIViewController) {
           
           let cusID = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
           
           let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
           tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
           
           let verifyUserInfoRequest = CheckPasswordRequest(
               customerId: cusID, password: "\(strPassword)"
               )
           
           CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
           CheckPasswordViewModel.init().checkPasswordvm(verifyUserRequest: verifyUserInfoRequest, token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
               
               CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
               
               if result.status == Constants.STATUS_200{
                   //success(result)
                  
                   DispatchQueue.main.async {
                        self.doRegisterDAApi()
                      
                   }
                    popup.dismiss(animated: false, completion: nil)
               } else {
                   Utils.showAlert(viewcontroller: self, title: Constants.CHECK_PASSWORD_FAILED_TITIE, message: "")
                  
               }
               
           }) { (error) in
               popup.dismiss(animated: false, completion: nil)
               CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
               if error == Constants.SERVER_FAILURE {
                   let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                   navigationVC.modalPresentationStyle = .overFullScreen
                   self.present(navigationVC, animated: true, completion: nil)
               } else if error == Constants.EXPIRE_TOKEN {
                   Utils.showExpireAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: Messages.EXPIRE_TOKEN_ERROR.localized)
                   
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
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfCompanyName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfCompanyName?.text = Constants.BLANK
            self.lblCompanyNameError.text = Messages.COMPANY_NAME_EMPTY_ERROR.localized
            self.companyNameMesgLocale = Messages.COMPANY_NAME_EMPTY_ERROR
            isError = true
        }
//       else if !Utils.isNameValidate(name: (self.tfCompanyName!.text)!){
//
//            self.lblCompanyNameError.text = Messages.NAME_REG_FORMAT_ERROR.localized
//            self.companyNameMesgLocale = Messages.NAME_REG_FORMAT_ERROR
//            isError = true
//
//        }
        else {
            self.companyNameMesgLocale = Constants.BLANK
            self.lblCompanyName.text = Constants.BLANK
        }
        
        // Company address
        if self.tfStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.streetWarningHeight.constant = 16
            self.tfStreet?.text = Constants.BLANK
            self.streetWarning.text = Messages.OCCUPATION_STREET_ERROR.localized
            self.companyAddressMesgLocale = Messages.OCCUPATION_STREET_ERROR
            isError = true
            
        } else {
            self.streetWarningHeight.constant = 0
            self.companyAddressMesgLocale = Constants.BLANK
            self.streetWarning.text = Constants.BLANK
        }
        if self.tfBldNO?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                   self.buldingNowarningHeight.constant = 16
                   self.tfBldNO?.text = Constants.BLANK
                   self.buldingNoWarning.text = Messages.OCCUPATION_BULDING_ERROR.localized
                   self.companyAddressMesgLocale = Messages.OCCUPATION_BULDING_ERROR
                   isError = true
                   
               } else {
                   self.buldingNowarningHeight.constant = 0
                   self.companyAddressMesgLocale = Constants.BLANK
                   self.buldingNoWarning.text = Constants.BLANK
               }
        if self.tfFloor?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                          self.floorNoHeight.constant = 16
                          self.tfFloor?.text = Constants.BLANK
                          self.floorNoWarning.text = Messages.OCCUPATION_FLOOR_NO_ERROR.localized
                          self.companyAddressMesgLocale = Messages.OCCUPATION_FLOOR_NO_ERROR
                          isError = true
                          
                      } else {
                          self.floorNoHeight.constant = 0
                          self.companyAddressMesgLocale = Constants.BLANK
                          self.floorNoWarning.text = Constants.BLANK
                      }
        if self.tfRoomNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                                 self.roomNoWarningHeight.constant = 16
                                 self.tfRoomNo?.text = Constants.BLANK
                                 self.RoomNoWarning.text = Messages.OCCUPATION_ROOM_NO_ERROR.localized
                                 self.companyAddressMesgLocale = Messages.OCCUPATION_ROOM_NO_ERROR
                                 isError = true
                                 
                             } else {
                                 self.roomNoWarningHeight.constant = 0
                                 self.companyAddressMesgLocale = Constants.BLANK
                                 self.RoomNoWarning.text = Constants.BLANK
                             }
        if self.tfQrt?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.quarterWarningHeight.constant = 16
            //self.tfQrt?.text = Constants.BLANK
            self.quarterWarning.text = Messages.OCCUPATION_QUARTER_ERROR.localized
            self.companyAddressMesgLocale = Messages.OCCUPATION_QUARTER_ERROR
            isError = true
            
        } else {
            self.quarterWarningHeight.constant = 0
            self.companyAddressMesgLocale = Constants.BLANK
           // self.tfQrt.text = Constants.BLANK
        }
        
        if self.tfTsp?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfTsp?.text = Constants.BLANK
            self.lblAddressError.text = Messages.COMPANY_ADDRESS_EMPTY_ERROR.localized
            self.companyAddressMesgLocale = Messages.COMPANY_ADDRESS_EMPTY_ERROR
            isError = true
            
        } else if !self.allTownNameList.contains((self.tfTsp?.text)!) {
            self.tfTsp?.text = Constants.BLANK
            self.lblAddressError.text = Messages.ADDRESS_INVALID_ERROR.localized
            self.companyAddressMesgLocale = Messages.ADDRESS_INVALID_ERROR
            isError = true
                   
        } else {
            self.lblAddressError.text = Constants.BLANK
            self.companyAddressMesgLocale = Constants.BLANK
        }
        
        // Department
        if self.tfDepartment?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfDepartment?.text = Constants.BLANK
            self.lblDepartmentError.text = Messages.DEPARTMENT_EMPTY_ERROR.localized
            self.departmentMesgLocale = Messages.DEPARTMENT_EMPTY_ERROR
            isError = true
            
        } else {
            self.departmentMesgLocale = Constants.BLANK
            self.lblDepartmentError.text = Constants.BLANK
        }
        
        //Position
        if self.tfPosition?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfPosition?.text = Constants.BLANK
            self.lblPositionError.text = Messages.POSITION_EMPTY_ERROR.localized
            self.positionMesgLocale = Messages.POSITION_EMPTY_ERROR
            isError = true
            
        } else {
            self.positionMesgLocale = Constants.BLANK
            self.lblPositionError.text = Constants.BLANK
        }
        
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfCompanyTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfCompanyTelNo?.text = Constants.BLANK
            self.lblTelNoError.text = Messages.TEL_NO_EMPTY_ERROR.localized
            self.companyTelNoMesgLocale = Messages.TEL_NO_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isNumberValidate(phoneNo: (self.tfCompanyTelNo?.text)!){
            // validate phone no format
            self.lblTelNoError.text = Messages.PHONE_COMPANY_LENGTH_ERROR.localized
            self.companyTelNoMesgLocale = Messages.PHONE_COMPANY_LENGTH_ERROR
            isError = true
            
        } else {
            self.companyTelNoMesgLocale = Constants.BLANK
            self.lblTelNoError.text = Constants.BLANK
        }
        
        //YEAR of Stay
        if self.tfYear?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfYear?.text = Constants.BLANK
            self.lblYearServiceError.text = Messages.YEAR_SERVICE_EMPTY_ERROR.localized
            self.yearServiceMesgLocale = Messages.YEAR_SERVICE_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblYearServiceError.text = Constants.BLANK
            self.yearServiceMesgLocale = Constants.BLANK
        }
        
        if self.tfMonth?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfMonth?.text = Constants.BLANK
            self.lblYearServiceError.text = Messages.YEAR_SERVICE_EMPTY_ERROR.localized
            self.yearServiceMesgLocale = Messages.YEAR_SERVICE_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblYearServiceError.text = Constants.BLANK
            self.yearServiceMesgLocale = Constants.BLANK
        }
        
        //Contact Time
        //        if self.tfAM?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        //            self.tfAM?.text = Constants.BLANK
        //            self.lblContactTimeError.text = Messages.CONTACT_TIME_EMPTY_ERROR.localized
        //            self.contactTimeMesgLocale = Messages.CONTACT_TIME_EMPTY_ERROR
        //            isError = true
        //
        //        } else {
        //            self.lblContactTimeError.text = Constants.BLANK
        //            self.contactTimeMesgLocale = Constants.BLANK
        //        }
        
        //        if self.tfPM?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        //            self.tfPM?.text = Constants.BLANK
        //            self.lblContactTimeError.text = Messages.CONTACT_TIME_EMPTY_ERROR.localized
        //            self.contactTimeMesgLocale = Messages.CONTACT_TIME_EMPTY_ERROR
        //            isError = true
        //
        //        } else {
        //            self.lblContactTimeError.text = Constants.BLANK
        //            self.contactTimeMesgLocale = Constants.BLANK
        //        }
        
        if self.tfCompanyStatusAutoText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lblStatusError.text = Messages.COMPANY_STATUS_EMPTY_ERROR.localized
            self.companyStatusMesgLocale = Messages.COMPANY_STATUS_EMPTY_ERROR
            isError = true
            
        } else if !Constants.companyStatusList.contains(self.tfCompanyStatusAutoText.text!){
            self.lblStatusError.text = Messages.COMPANY_STATUS_INVALID_ERROR.localized
            self.companyStatusMesgLocale = Messages.COMPANY_STATUS_INVALID_ERROR
            isError = true
            
        } else if self.tfCompanyStatusAutoText.text == "Other" {
            if self.tfCompanyStatus?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                self.tfCompanyStatus?.text = Constants.BLANK
                self.lblStatusError.text = Messages.COMPANY_STATUS_EMPTY_ERROR.localized
                self.companyStatusMesgLocale = Messages.COMPANY_STATUS_EMPTY_ERROR
                isError = true
                
            } else {
                self.lblStatusError.text = Constants.BLANK
                self.companyStatusMesgLocale = Constants.BLANK
            }
        } else {
            self.lblStatusError.text = Constants.BLANK
            self.companyStatusMesgLocale = Constants.BLANK
        }
        
        // MONTHLY BASIC INCOME
        if self.tfMonthlyBasicIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true && (self.tfMonthlyBasicIncome!.text)! == "0" {
            self.tfMonthlyBasicIncome?.text = Constants.BLANK
            self.lblMonthlyIncomeError.text = Messages.MONTHLY_INCOME_EMPTY_ERROR.localized
            self.monthlyBasicIncomeMesgLocale = Messages.MONTHLY_INCOME_EMPTY_ERROR
            isError = true
            
        } else {
            self.monthlyBasicIncomeMesgLocale = Constants.BLANK
            self.lblMonthlyIncomeError.text = Constants.BLANK
        }
        
        // OTHER INCOME
//        if self.tfOtherIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            self.tfOtherIncome?.text = Constants.BLANK
//            self.lblOtherIncomeError.text = Messages.MONTHLY_INCOME_EMPTY_ERROR.localized
//            self.otherIncomeMesgLocale = Messages.MONTHLY_INCOME_EMPTY_ERROR
//            isError = true
//            
//        } else {
//            self.otherIncomeMesgLocale = Constants.BLANK
//            self.lblOtherIncomeError.text = Constants.BLANK
//        }
        
        // TOTAL INCOME
//        if self.tfTotalIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            self.tfTotalIncome?.text = Constants.BLANK
//            self.lblTotalIncomeError.text = Messages.TOTAL_INCOME_EMPTY_ERROR.localized
//            self.totalIncomeMesgLocale = Messages.TOTAL_INCOME_EMPTY_ERROR
//            isError = true
//
//        } else {
//            self.totalIncomeMesgLocale = Constants.BLANK
//            self.lblTotalIncomeError.text = Constants.BLANK
//        }
        
        // Validate Date of Birth [dd-MM-yyyy]
        if self.tfSalaryDate?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfSalaryDate?.text = Constants.BLANK
            self.lblSalaryDateError.text = Messages.DOB_EMPTY_ERROR.localized
            self.salaryDateMesgLocale = Messages.DOB_EMPTY_ERROR
            isError = true
            
        } else {
            self.salaryDateMesgLocale = Constants.BLANK
            self.lblSalaryDateError.text = Constants.BLANK
        }
        
        
        return isError
    } //End of isErrorExit
    
    func markOccupationErrorCount() {
        
        var errorcount = 0
        // not to overwrite error message
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfCompanyName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            
            errorcount += 1
            
        }
//        else if !Utils.isNameValidate(name: (self.tfCompanyName!.text)!){
//            
//            errorcount += 1
//            
//        }
        
        // Company address
        
        if self.tfBldNO.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        errorcount += 1
        }
        if self.tfRoomNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        errorcount += 1
        }
        if self.tfFloor.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        errorcount += 1
        }
        if self.tfQrt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        errorcount += 1
        }
        
        if self.tfStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if self.tfTsp.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if !self.allTownNameList.contains((self.tfTsp?.text)!) {
            errorcount += 1
        }
        // Department
        if self.tfDepartment?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
        }
        
        //Position
        if self.tfPosition?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfCompanyTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else if !Utils.isNumberValidate(phoneNo: (self.tfCompanyTelNo?.text)!){
            // validate phone no format
            errorcount += 1
            
        }
        
        //YEAR of Stay
        if self.tfYear?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        }
        
        if self.tfMonth?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        }
        
        //Contact Time
        //        if self.tfAM?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        //             errorcount += 1
        //
        //        }
        //
        //        if self.tfPM?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        //             errorcount += 1
        //
        //        }
        let comstatus = self.tfCompanyStatusAutoText.text ?? ""
        if comstatus.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorcount += 1
            
        } else if !Constants.companyStatusList.contains(comstatus){
            errorcount += 1
            
        } else if comstatus == "Other" {
            if self.tfCompanyStatus?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                errorcount += 1
                
            }
        }
        
        // MONTHLY BASIC INCOME
        if self.tfMonthlyBasicIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true  || (self.tfMonthlyBasicIncome.text)! == "0"{
            errorcount += 1
            
        }
        
//        // OTHER INCOME
//        if self.tfOtherIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            errorcount += 1
//
//        }
        
//        // TOTAL INCOME
//        if self.tfTotalIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            errorcount += 1
//
//        }
        
        // Validate Date of Birth [dd-MM-yyyy]
        if self.tfSalaryDate?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } 
        
        UserDefaults.standard.set(errorcount, forKey: Constants.OCCUPATION_DATA_ERROR_COUNT)
        
    } //End of markErrorCount
    
    @IBAction func tapOnNextOccu(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnNext"), object: nil , userInfo: ["index" : 2])
    }
    
}

extension OccupationDataVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tfTsp.hideResultsList()
        self.tfCompanyStatusAutoText.hideResultsList()
    }
}
extension OccupationDataVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 100
    }
}

extension OccupationDataVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if tfYear.isFirstResponder {
            return "\(yearList[row])"
        } else if tfMonth.isFirstResponder {
            return "\(monthList[row])"
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if tfYear.isFirstResponder {
            tfYear.text = "\(yearList[row])"
            
        } else if tfMonth.isFirstResponder {
            tfMonth.text = "\(monthList[row])"
            
        }
        
        self.view.endEditing(true)
    }
    
    
}
extension OccupationDataVC: CheckPasswordPopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController) {
         if password.text!.count > 0 {
            self.doPasswordVerification(strPassword: "\(password.text ?? "")", popup: popUpView)
        }
    }
}
