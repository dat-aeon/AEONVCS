//
//  EmergencyContactVC.swift
//  AEONVCS
//
//  Created by mac on 10/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SearchTextField
import SkyFloatingLabelTextField
import SwiftyJSON
import SwipeMenuViewController
import SwiftyJSON
import AVFoundation

class EmergencyContactVC: BaseUIViewController {
    
    
    @IBOutlet weak var svEmergencyData: UIScrollView!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnParent: UIButton! {
        didSet {
            self.btnParent.clipsToBounds = true
            self.btnParent.layer.cornerRadius = 5
            self.btnParent.layer.borderWidth = 1.0
            self.btnParent.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
//    @IBOutlet weak var tvCurrentAddress: UITextView! {
//        didSet {
//            self.tvCurrentAddress.clipsToBounds = true
//            self.tvCurrentAddress.layer.cornerRadius = 5
//            self.tvCurrentAddress.layer.borderWidth = 1.0
//            self.tvCurrentAddress.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
//        }
//    }
    
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblRelationshipError: UILabel!
    @IBOutlet weak var lblCurrentAddress: UILabel!
    @IBOutlet weak var lblCurrentAddressError: UILabel!
    @IBOutlet weak var lblBuildNo: UILabel!
    @IBOutlet weak var tfCurrentBldNo: UITextField!
    @IBOutlet weak var lblCurrentRoomNo: UILabel!
    @IBOutlet weak var tfCurrentRoomNo: UITextField!
    @IBOutlet weak var lblCurrentFloor: UILabel!
    @IBOutlet weak var tfCurrentFloor: UITextField!
    @IBOutlet weak var lblCurrentStreet: UILabel!
    @IBOutlet weak var tfCurrentStreet: UITextField!
    @IBOutlet weak var lblCurrentQrt: UILabel!
    @IBOutlet weak var tfCurrentQrt: UITextField!
    @IBOutlet weak var lblCurrentTsp: UILabel!
    @IBOutlet weak var tfTownshipAutoText: SearchTextField!
    @IBOutlet weak var lblCurrentCity: UILabel!
    @IBOutlet weak var btnCurrentCity: UIButton!
    @IBOutlet weak var tfCityAutoText: UITextField!
    
    @IBOutlet weak var lblMobilenoError: UILabel!
    @IBOutlet weak var lblResidentTelNoError: UILabel!
    @IBOutlet weak var lblOtherTelNoError: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRsWithApplicant: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    @IBOutlet weak var lblResidentTelNo: UILabel!
    @IBOutlet weak var lblOtherTelNo: UILabel!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfRsWithApplicant: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMobileNo: UITextField!
    @IBOutlet weak var tfResidentTelNo: UITextField!
    @IBOutlet weak var tfOtherTelNo: UITextField!
    
    @IBOutlet weak var backBtn: UIImageView!
    
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    var nameMesgLocale: String?
    var rsWithApplicantMesgLocale: String?
    var addressMesgLocale: String?
    var mobileNoMesgLocale: String?
    var residentTelNoMesgLocale: String?
    var otherTelNoMesgLocale: String?
    //var rsWith = ["Parent", "Sponse", "Relative", "Friend", "Other"]
    
    var selectedRSWith = 1
    
    // City Township
    var allTownNameList = [String]()
    var cityNameList = [String]()
    var cityTownshipModel = CityTownShipModel()
    var selectedCityID : Int?
    var selectedTownshipID: Int?
    var logoutTimer: Timer?
    
     var tokenInfo: TokenData?
    
    var myAppData = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 1 , nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)
    var myLoanData = LoanConfirmationRequest(daLoanTypeId: 1, financeAmount: 0.0, financeTerm: 0, daProductTypeId: 1, productDescription: "", channelType: 2)
    
    var myGuarantorData = GuarantorRequest(daGuarantorInfoId: 0,name: "", dob: "", nrcNo: "", nationality: 1, nationalityOther: "", mobileNo: "", residentTelNo: "", relationship: 1, relationshipOther: "", currentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", gender: 1, maritalStatus: 1, yearOfStayYear: 0, yearOfStayMonth: 0, companyName: "", companyTelNo: "", companyAddress: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, monthlyBasicIncome: 0.0, totalIncome: 0.0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
    
    var myOccupationData = OccupationDataRequest(daApplicantCompanyInfoId: 0, companyName: "", companyAddress: "", companyTelNo: "", contactTimeFrom: "", contactTimeTo: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, companyStatus: 1, companyStatusOther: "", monthlyBasicIncome: 0.0, otherIncome: 0.0, totalIncome: 0.0, salaryDay: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
    
    var myContactData = EmergencyContactRequest(daEmergencyContactInfoId: 0, name: "", relationship: 1, relationshipOther: "", currentAddress: "", mobileNo: "", residentTelNo: "", otherPhoneNo: "", currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0)
    var myAttachments = [AttachmentRequest]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
                   self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
 //logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        backBtn.isUserInteractionEnabled = true
         self.backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backView)))
        self.lblNameError.text = Constants.BLANK
        self.lblRelationshipError.text = Constants.BLANK
        self.lblCurrentAddressError.text = Constants.BLANK
         self.lblMobilenoError.text = Constants.BLANK
        self.lblResidentTelNoError.text = Constants.BLANK
        self.lblOtherTelNoError.text = Constants.BLANK
        
        self.updateViews()
        self.setupTownshipCityData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(markEmergencyContactLastState), name: NSNotification.Name(rawValue: "markEmergencyContactDataLastState"), object: nil)
//
        NotificationCenter.default.addObserver(self, selector: #selector(showEmergencyForm(notification:)), name: NSNotification.Name(rawValue: "showEmergencyForm"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorLabelEmergency), name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
        
        tfName.setMaxLength(maxLength: 50)
        tfRsWithApplicant.setMaxLength(maxLength: 50)
        tfMobileNo.setMaxLength(maxLength: 11)
    
        tfResidentTelNo.setMaxLength(maxLength: 11)
        tfOtherTelNo.setMaxLength(maxLength: 11)
        
        tfCurrentBldNo.setMaxLength(maxLength: 20)
        tfCurrentFloor.setMaxLength(maxLength: 20)
        tfCurrentRoomNo.setMaxLength(maxLength: 20)
        tfCurrentStreet.setMaxLength(maxLength: 100)
        tfCurrentQrt.setMaxLength(maxLength: 100)
        tfTownshipAutoText.setMaxLength(maxLength: 100)
        //tvCurrentAddress.delegate = self
        
        tfName.autocapitalizationType = .allCharacters
        tfRsWithApplicant.autocapitalizationType = .allCharacters
        tfCurrentBldNo.autocapitalizationType = .allCharacters
        tfCurrentRoomNo.autocapitalizationType = .allCharacters
        tfCurrentStreet.autocapitalizationType = .allCharacters
        tfCurrentFloor.autocapitalizationType = .allCharacters
        tfCurrentQrt.autocapitalizationType = .allCharacters
        
        // mendatory fields background setting
        self.tfName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfRsWithApplicant.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentStreet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMobileNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(doSetEmergencyContactData(notification:)), name: NSNotification.Name(rawValue: "SetEmergencyContactData"), object: nil)
                     
                      
                     
                      
                       NotificationCenter.default.addObserver(self, selector: #selector(doRegisterDA), name: NSNotification.Name(rawValue: "doRegistration"), object: nil)
                      
                      NotificationCenter.default.addObserver(self, selector: #selector(doSaveDA), name: NSNotification.Name(rawValue: "saveDA"), object: nil)
                
               self.doLoadSaveDAData()
        
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
                var myEmergencyContact = responseObjDA.emergencyContactInfoDto
//                let appdata = ApplicationDataRequest(daApplicationInfoId: responseObjDA.daApplicationInfoId ?? 0, daApplicationTypeId: responseObjDA.daApplicationTypeId ?? 1, name: responseObjDA.name ?? "", dob: responseObjDA.dob ?? "", nrcNo: responseObjDA.nrcNo ?? "", fatherName: responseObjDA.fatherName ?? "",highestEducationTypeId: responseObjDA.highestEducationTypeId ?? 1, nationality: responseObjDA.nationality ?? 1, nationalityOther: responseObjDA.nationalityOther ?? "", gender: responseObjDA.gender!, maritalStatus: responseObjDA.maritalStatus ?? 1, currentAddress: responseObjDA.currentAddress ?? "", permanentAddress: responseObjDA.permanentAddress ?? "", typeOfResidence: responseObjDA.typeOfResidence ?? 1, typeOfResidenceOther: responseObjDA.typeOfResidenceOther ?? "", livingWith: responseObjDA.livingWith ?? 1, livingWithOther: responseObjDA.livingWithOther ?? "", yearOfStayYear: responseObjDA.yearOfStayYear ?? 0, yearOfStayMonth: responseObjDA.yearOfStayMonth ?? 0, mobileNo: responseObjDA.mobileNo ?? "", residentTelNo: responseObjDA.residentTelNo ?? "", otherPhoneNo: responseObjDA.otherPhoneNo ?? "", email: responseObjDA.email ?? "", customerId: responseObjDA.customerId ?? 0, status: responseObjDA.status ?? 0, currentAddressFloor: responseObjDA.currentAddressFloor ?? "", currentAddressBuildingNo: responseObjDA.currentAddressBuildingNo ?? "", currentAddressRoomNo: responseObjDA.currentAddressRoomNo ?? "", currentAddressStreet: responseObjDA.currentAddressStreet ?? "", currentAddressQtr: responseObjDA.currentAddressQtr ?? "", currentAddressTownship: responseObjDA.currentAddressTownship ?? 0, currentAddressCity: responseObjDA.currentAddressCity ?? 0,permanentAddressCity: responseObjDA.permanentAddressCity ?? 0, permanentAddressFloor: responseObjDA.permanentAddressFloor ?? "", permanentAddressBuildingNo: responseObjDA.permanentAddressBuildingNo ?? "", permanentAddressRoomNo: responseObjDA.permanentAddressRoomNo ?? "", permanentAddressStreet: responseObjDA.permanentAddressStreet ?? "", permanentAddressQtr: responseObjDA.permanentAddressQtr ?? "", permanentAddressTownship: responseObjDA.permanentAddressTownship ?? 0)

//                let appdata = EmergencyContactRequest(daEmergencyContactInfoId: myEmergencyContact?.daEmergencyContactInfoId ?? 0, name: myEmergencyContact?.name "", relationship: myEmergencyContact?.relationship ?? 0, relationshipOther: myEmergencyContact?.relationshipOther ?? "", currentAddress: myEmergencyContact?.currentAddress ?? "", mobileNo: myEmergencyContact?.mobileNo ?? "", residentTelNo: myEmergencyContact?.residentTelNo ?? "", otherPhoneNo: myEmergencyContact?.otherPhoneNo ?? "", currentAddressFloor: myEmergencyContact?.currentAddressFloor ?? "", currentAddressBuildingNo: myEmergencyContact?.currentAddressBuildingNo ?? "", currentAddressRoomNo: myEmergencyContact?.currentAddressRoomNo ?? "", currentAddressStreet: myEmergencyContact?.currentAddressStreet ?? "", currentAddressQtr: myEmergencyContact?.currentAddressQtr ?? "", currentAddressTownship: myEmergencyContact.currentAddressTownship ?? 0, currentAddressCity: myEmergencyContact?.currentAddressCity ?? 0)
//                self.myContactData = appdata
               // myAppFormData = self.myAppData
                self.fillThisForm(data: self.myContactData)
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
     @objc func doSaveDA() {
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            
            let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
                   tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
                   
                   DAViewModel.init().doSaveDigitalApplication(tokenInfo: self.tokenInfo!, appData: self.myAppData, companyData: self.myOccupationData, emergencyContact: self.myContactData, loanData: self.myLoanData, guarantorData: self.myGuarantorData,  success: { (responseObjDA) in
                    
                    self.myContactData = responseObjDA.emergencyContactInfoDto!
                    print("\(self.myContactData.name)")
                    self.myGuarantorData = responseObjDA.guarantorInfoDto!
                    self.myOccupationData = responseObjDA.applicantCompanyInfoDto!
                    
                    let appdata = ApplicationDataRequest(daApplicationInfoId: responseObjDA.daApplicationInfoId ?? 0, daApplicationTypeId: responseObjDA.daApplicationTypeId ?? 1, name: responseObjDA.name ?? "", dob: responseObjDA.dob ?? "", nrcNo: responseObjDA.nrcNo ?? "", fatherName: responseObjDA.fatherName ?? "",highestEducationTypeId: responseObjDA.highestEducationTypeId ?? 0, nationality: responseObjDA.nationality ?? 1, nationalityOther: responseObjDA.nationalityOther ?? "", gender: responseObjDA.gender!, maritalStatus: responseObjDA.maritalStatus ?? 1, currentAddress: responseObjDA.currentAddress ?? "", permanentAddress: responseObjDA.permanentAddress ?? "", typeOfResidence: responseObjDA.typeOfResidence ?? 1, typeOfResidenceOther: responseObjDA.typeOfResidenceOther ?? "", livingWith: responseObjDA.livingWith ?? 1, livingWithOther: responseObjDA.livingWithOther ?? "", yearOfStayYear: responseObjDA.yearOfStayYear ?? 0, yearOfStayMonth: responseObjDA.yearOfStayMonth ?? 0, mobileNo: responseObjDA.mobileNo ?? "", residentTelNo: responseObjDA.residentTelNo ?? "", otherPhoneNo: responseObjDA.otherPhoneNo ?? "", email: responseObjDA.email ?? "", customerId: responseObjDA.customerId ?? 0, status: responseObjDA.status ?? 0, currentAddressFloor: responseObjDA.currentAddressFloor ?? "", currentAddressBuildingNo: responseObjDA.currentAddressBuildingNo ?? "", currentAddressRoomNo: responseObjDA.currentAddressRoomNo ?? "", currentAddressStreet: responseObjDA.currentAddressStreet ?? "", currentAddressQtr: responseObjDA.currentAddressQtr ?? "", currentAddressTownship: responseObjDA.currentAddressTownship ?? 0, currentAddressCity: responseObjDA.currentAddressCity ?? 0,permanentAddressCity: responseObjDA.permanentAddressCity ?? 0, permanentAddressFloor: responseObjDA.permanentAddressFloor ?? "", permanentAddressBuildingNo: responseObjDA.permanentAddressBuildingNo ?? "", permanentAddressRoomNo: responseObjDA.permanentAddressRoomNo ?? "", permanentAddressStreet: responseObjDA.permanentAddressStreet ?? "", permanentAddressQtr: responseObjDA.permanentAddressQtr ?? "", permanentAddressTownship: responseObjDA.permanentAddressTownship ?? 0)


                    self.myAppData = appdata
                    myAppFormData = self.myAppData
                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    
    //                DispatchQueue.main.async {
    //                    self.delegate?.showApplicationForm()
    //                }
    //
                    let loanData = LoanConfirmationRequest(daLoanTypeId: responseObjDA.daLoanTypeId ?? 1, financeAmount: responseObjDA.financeAmount ?? 0.0, financeTerm: responseObjDA.financeTerm ?? 0, daProductTypeId: responseObjDA.daProductTypeId ?? 1, productDescription: responseObjDA.productDescription ?? "", channelType: responseObjDA.channelType ?? 2)
                    self.myLoanData = loanData
                    
                    applicationFormID = self.myAppData.daApplicationInfoId
                    occupationFormID = self.myOccupationData.daApplicantCompanyInfoId
                    emergencyFormID = self.myContactData.daEmergencyContactInfoId
                    guarantorFormID = self.myGuarantorData.daGuarantorInfoId
                    applicationStatus = self.myAppData.status
                    
                       
                        let alertController = UIAlertController(title: "Your application is successfully saved!", message: "", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                              
                        }))
                        self.present(alertController, animated: true, completion: nil)
                       
                       
                   }) { (error) in
                       
                       CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                                  
                           if error == Constants.SERVER_FAILURE {
                               let storyboard = UIStoryboard(name: "Main", bundle: nil)
                               let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                               self.present(navigationVC, animated: true, completion: nil)
                                      
                               } else if error == Constants.EXPIRE_TOKEN {
                                   Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON " + Messages.EXPIRE_TOKEN_ERROR.localized)
                                      
                                  } else if error == Constants.APPLICATION_LIMIT {
                                      Utils.showAlert(viewcontroller: self, title: Constants.APPLICATION_LIMIT_TITLE, message: "" + error)
                                  } else {
                                      Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "" + error)
                                  }
                       
                       
                   }
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
    @objc func doSetEmergencyContactData(notification: Notification) {
              print("doSetEmergencyContactData")
              if let dict = notification.userInfo as? Dictionary<String, Any> {
                  print("doSetEmergencyContactData \(dict)")
                  if let sVar = dict["appData"] as? EmergencyContactRequest {
                      print("doSetEmergencyContactData \(sVar.name)")
                      self.myContactData = sVar
                      print("doSetEmergencyContactData myappdata.name \(self.myContactData.name)")
                  }
              }
          }
    @objc func backView() {
              self.dismiss(animated: true, completion: nil)
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
                     // print("kaungmyat san multi >>>  \(results)")
                      
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
            svEmergencyData.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
            
        } else {
            svEmergencyData.contentInset = UIEdgeInsets.zero
        }
        svEmergencyData.scrollIndicatorInsets = svEmergencyData.contentInset
    }

    @objc func showErrorLabelEmergency() {
       _ = self.isErrorExist()
    }
    
    @objc func showEmergencyForm(notification: Notification) {
        if let dict = notification.userInfo as? Dictionary<String, Any> {
        print("showemergencyform \(dict)")
        if let sVar = dict["data"] as? EmergencyContactRequest {
            self.fillThisForm(data: sVar)
            }
        }
    }
    
    @IBAction func onClickCityBtn(_ sender: UIButton) {
        openCitySelectionPopUp()
    }
    
    func openCitySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCurrentCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                
                if self.allTownNameList.count >= 0 {
                    self.tfTownshipAutoText.filterStrings(self.allTownNameList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.tfCityAutoText
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCurrentCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                
                if self.allTownNameList.count >= 0 {
                    self.tfTownshipAutoText.filterStrings(self.allTownNameList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    @objc func onTapMMLocale() {
               
               super.NewupdateLocale(flag: 1)
               updateViews()
            
             
           }
           @objc func onTapEngLocale() {
              
               super.NewupdateLocale(flag: 2)
               updateViews()
         
               
           }
    func setupTownshipCityData() {
        
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
            self.btnCurrentCity.setTitle("", for: UIControl.State.normal)
            self.allTownNameList = model.cityIdTownListDic![self.selectedCityID!]!
            self.tfTownshipAutoText.filterStrings(self.allTownNameList)
            
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
     
    func fillThisForm(data: EmergencyContactRequest) {
        self.tfName.text = data.name
        self.textFieldDidChange(self.tfName)
        
        self.selectedRSWith = data.relationship
        self.btnParent.setTitle("\(Constants.rsWithList[self.selectedRSWith - 1])", for: .normal)
        if self.selectedRSWith == Constants.rsWithList.count {
            self.tfRsWithApplicant.isHidden = false
        } else {
            self.tfRsWithApplicant.isHidden = true
        }
        self.tfRsWithApplicant.text = data.relationshipOther
        self.textFieldDidChange(self.tfRsWithApplicant)
        
        //self.tvCurrentAddress.text = data.currentAddress
        self.tfCurrentBldNo.text = data.currentAddressBuildingNo
        self.tfCurrentRoomNo.text = data.currentAddressRoomNo
        self.tfCurrentFloor.text = data.currentAddressFloor
        self.tfCurrentQrt.text = data.currentAddressQtr
        self.tfCurrentStreet.text = data.currentAddressStreet
        self.textFieldDidChange(self.tfCurrentStreet)
        
        if data.currentAddressCity != 0 {
            for cityName in self.cityTownshipModel.cityNameIdDic!.keys{
                let id = self.cityTownshipModel.cityNameIdDic![cityName]
                if id == data.currentAddressCity {
                    self.btnCurrentCity.setTitle(cityName, for: UIControl.State.normal)
                    self.selectedCityID = id
                    break
                }
            }
        }
        
        if data.currentAddressTownship != 0{
            for townName in self.cityTownshipModel.townNameIdDic!.keys{
                let id = self.cityTownshipModel.townNameIdDic![townName]
                if id == data.currentAddressTownship {
                    self.tfTownshipAutoText.text = townName
                    self.selectedTownshipID = id
                    self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                    self.tfTownshipAutoText.filterStrings(self.allTownNameList)
                    break
                }
            }
        }
        self.textFieldDidChange(self.tfTownshipAutoText)
        
        self.tfMobileNo.text = data.mobileNo
        self.textFieldDidChange(self.tfMobileNo)
        
        self.tfResidentTelNo.text = data.residentTelNo
        self.tfOtherTelNo.text = data.otherPhoneNo
        
    }
    
    @objc func markEmergencyContactLastState() {
       
        self.markEmergencyContactErrorCount()
         self.tfTownshipAutoText.hideResultsList()
        
        let appData = EmergencyContactRequest(daEmergencyContactInfoId: emergencyFormID, name: self.tfName.text ?? "", relationship: self.selectedRSWith, relationshipOther: self.tfRsWithApplicant.text ?? "", currentAddress: "", mobileNo: self.tfMobileNo.text ?? "", residentTelNo: self.tfResidentTelNo.text ?? "", otherPhoneNo: self.tfOtherTelNo.text ?? "", currentAddressFloor: self.tfCurrentFloor.text ?? "", currentAddressBuildingNo: self.tfCurrentBldNo.text ?? "", currentAddressRoomNo: self.tfCurrentRoomNo.text ?? "", currentAddressStreet: self.tfCurrentStreet.text ?? "", currentAddressQtr: self.tfCurrentQrt.text ?? "", currentAddressTownship: self.selectedTownshipID ?? 0, currentAddressCity: selectedCityID ?? 0)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetEmergencyContactData"), object: self, userInfo: ["appData": appData])
        self.view.endEditing(true)
    }
    
    @objc override func updateViews() {
        super.updateViews()
        
        self.lblName.text = "emergencycontact_name".localized
        self.lblRsWithApplicant.text = "emergencycontact_rsapplicant".localized
        self.lblCurrentAddress.text = "emergencycontact_currentaddress".localized
        self.lblMobileNo.text = "emergencycontact_mobileno".localized
        self.lblResidentTelNo.text = "emergencycontact_residenttelno".localized
        self.lblOtherTelNo.text = "emergencycontact_othertelno".localized
        
        self.lblBuildNo.text = "da.buildno".localized
        self.lblCurrentFloor.text = "da.floor".localized
        self.lblCurrentRoomNo.text = "da.roomno".localized
        self.lblCurrentStreet.text = "da.street".localized
        self.lblCurrentQrt.text = "da.quarter".localized
        self.lblCurrentTsp.text = "da.township".localized
        self.lblCurrentCity.text = "da.city".localized
        
        self.lblNameError.text = nameMesgLocale?.localized
        self.lblRelationshipError.text = rsWithApplicantMesgLocale?.localized
        self.lblCurrentAddressError.text = addressMesgLocale?.localized
        self.lblMobilenoError.text = mobileNoMesgLocale?.localized
        self.lblResidentTelNoError.text = residentTelNoMesgLocale?.localized
        self.lblOtherTelNoError.text = otherTelNoMesgLocale?.localized
        
    }
    
    @IBAction func doShowRsWithApplicantList(_ sender: Any) {
        self.openRsWithApplicantPopup()
    }
    
    func openRsWithApplicantPopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: Constants.rsWithList, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.btnParent.setTitle(value, for: .normal)
                self.selectedRSWith = Constants.rsWithList.firstIndex(of: value)! + 1
                print(value)
                if self.selectedRSWith == Constants.rsWithList.count {
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
                self.btnParent.setTitle(value, for: .normal)
                self.selectedRSWith = Constants.rsWithList.firstIndex(of: value)! + 1
                print(value)
                if self.selectedRSWith == Constants.rsWithList.count {
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
    
    func isErrorExist() -> Bool {
        
        var isError = false
        // not to overwrite error message
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfName?.text = Constants.BLANK
            self.lblNameError.text = Messages.NAME_EMPTY_ERROR.localized
            self.nameMesgLocale = Messages.NAME_EMPTY_ERROR
            isError = true
            
        }
//        else if !Utils.isNameValidate(name: (self.tfName!.text)!){
//
//            self.lblNameError.text = Messages.NAME_REG_FORMAT_ERROR.localized
//            self.nameMesgLocale = Messages.NAME_REG_FORMAT_ERROR
//            isError = true
//
//        }
        else {
            self.nameMesgLocale = Constants.BLANK
            self.lblNameError.text = Constants.BLANK
        }
        
        if self.btnParent.titleLabel?.text == "Other" {
            if self.tfRsWithApplicant?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                self.tfRsWithApplicant?.text = Constants.BLANK
                self.lblRelationshipError.text = Messages.RSWITHAPPLICANT_EMPTY_ERROR.localized
                self.rsWithApplicantMesgLocale = Messages.RSWITHAPPLICANT_EMPTY_ERROR
                isError = true
                
            } else {
                self.rsWithApplicantMesgLocale = Constants.BLANK
                self.lblRelationshipError.text = Constants.BLANK
            }
        }
        
        // Address
        if self.tfCurrentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfCurrentStreet?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.addressMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true
            
        } else {
            self.addressMesgLocale = Constants.BLANK
            self.lblCurrentAddressError.text = Constants.BLANK
        }
        
        if self.tfTownshipAutoText?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfTownshipAutoText?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.addressMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true
            
        } else if !self.allTownNameList.contains((self.tfTownshipAutoText?.text)!) {
            self.tfTownshipAutoText?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_INVALID_ERROR.localized
            self.addressMesgLocale = Messages.ADDRESS_INVALID_ERROR
            isError = true
                   
        } else {
            self.addressMesgLocale = Constants.BLANK
            self.lblCurrentAddressError.text = Constants.BLANK
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfMobileNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfMobileNo?.text = Constants.BLANK
            self.lblMobilenoError.text = Messages.PHONE_REG_EMPTY_ERROR.localized
            self.mobileNoMesgLocale = Messages.PHONE_REG_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isPhoneValidate(phoneNo: (self.tfMobileNo?.text)!){
            // validate phone no format
            self.lblMobilenoError.text = Messages.PHONE_LENGTH_ERROR.localized
            self.mobileNoMesgLocale = Messages.PHONE_LENGTH_ERROR
            isError = true
            
        } else {
            self.mobileNoMesgLocale = Constants.BLANK
            self.lblMobilenoError.text = Constants.BLANK
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfResidentTelNo.text!.count > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfResidentTelNo?.text)!){
                // validate phone no format
                self.lblResidentTelNoError.text = Messages.PHONE_LENGTH_ERROR.localized
                self.residentTelNoMesgLocale = Messages.PHONE_LENGTH_ERROR
                isError = true
                
            } else {
                self.residentTelNoMesgLocale = Constants.BLANK
                self.lblResidentTelNoError.text = Constants.BLANK
            }
        }  else {
            self.residentTelNoMesgLocale = Constants.BLANK
            self.lblResidentTelNoError.text = Constants.BLANK
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfOtherTelNo.text!.count > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfOtherTelNo?.text)!){
                // validate phone no format
                self.lblOtherTelNoError.text = Messages.PHONE_LENGTH_ERROR.localized
                self.otherTelNoMesgLocale = Messages.PHONE_LENGTH_ERROR
                isError = true
                
            } else {
                self.otherTelNoMesgLocale = Constants.BLANK
                self.lblOtherTelNoError.text = Constants.BLANK
            }
        }  else {
            self.otherTelNoMesgLocale = Constants.BLANK
            self.lblOtherTelNoError.text = Constants.BLANK
        }
        
        return isError
    }
    
    func markEmergencyContactErrorCount() {
        
        var errorcount = 0
        // not to overwrite error message
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        }
//        else if !Utils.isNameValidate(name: (self.tfName!.text)!){
//            
//            errorcount += 1
//            
//        }
        
        if self.btnParent.titleLabel?.text == "Other" {
            if self.tfRsWithApplicant?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                errorcount += 1
                
            }
        }
        
        // Department
        if self.tfCurrentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if self.tfTownshipAutoText?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if !self.allTownNameList.contains((self.tfTownshipAutoText?.text)!) {
            errorcount += 1
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfMobileNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else if !Utils.isPhoneValidate(phoneNo: (self.tfMobileNo?.text)!){
            // validate phone no format
            errorcount += 1
            
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfResidentTelNo.text!.count > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfResidentTelNo?.text)!){
                // validate phone no format
                errorcount += 1
                
            }
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfOtherTelNo.text!.count > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfOtherTelNo?.text)!){
                // validate phone no format
                errorcount += 1
                
            }
        }
        
        UserDefaults.standard.set(errorcount, forKey: Constants.EMERGENCY_CONTACT_ERROR_COUNT)
    }
    
    @IBAction func doSaveData(_ sender: Any) {
        
        self.markEmergencyContactLastState()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveDA"), object: nil)
//        if isErrorExist() {
//            return
//        }
    }
    
    
    @IBAction func tapOnNextEcontact(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnNext"), object: nil , userInfo: ["index" : 3])
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

}

extension EmergencyContactVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tfTownshipAutoText.hideResultsList()
        
    }
}
extension EmergencyContactVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 100
    }
}
extension EmergencyContactVC: CheckPasswordPopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController) {
         if password.text!.count > 0 {
            self.doPasswordVerification(strPassword: "\(password.text ?? "")", popup: popUpView)
        }
    }
}
