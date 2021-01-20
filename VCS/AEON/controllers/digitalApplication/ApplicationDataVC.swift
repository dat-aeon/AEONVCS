//
//  ApplicationDataVC.swift
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


class ApplicationDataVC: BaseUIViewController {
    
     var delegate: applyLoanDelegate?
    @IBOutlet weak var nextBtnPress: UIButton!
    @IBOutlet weak var applicationDataTitle: UILabel!
    @IBOutlet weak var svApplicationData: UIScrollView!
    @IBOutlet weak var engFlagBtn: UIImageView!
    @IBOutlet weak var mmFlagBtn: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tfName: UITextField!
//    @IBOutlet weak var lblMsgName: UILabel!
    @IBOutlet weak var townshipWarningHeight: NSLayoutConstraint!
    
    @IBOutlet weak var backView: UIImageView!
    
    @IBOutlet weak var educationTitleLabel: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var tfDob: UITextField!
//    @IBOutlet weak var lblMsgDob: UILabel!
//    @IBOutlet weak var lblMsgOneDob: UILabel!
    
//    @IBOutlet weak var tfTownshipAutoText: SearchTextField!
    @IBOutlet weak var educationLabel: UILabel!
    
    @IBOutlet weak var lblNrcNo: UILabel!
//    @IBOutlet weak var vDivision: UIView!
//    @IBOutlet weak var lblDivision: UILabel!
    
//    @IBOutlet weak var vNrcType: UIView!
//    @IBOutlet weak var lblNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField?
//    @IBOutlet weak var lbNrcNoErrorMessage: UILabel!
    
    @IBOutlet weak var lblFatherName: UILabel!
    @IBOutlet weak var tfFatherName: UITextField!
    @IBOutlet weak var lblFatherWarning: UILabel!
    
    @IBOutlet weak var roomNoWarningLabel: UILabel!
    @IBOutlet weak var streetWarningLabel: UILabel!
    @IBOutlet weak var floorNoWarningLabel: UILabel!
    @IBOutlet weak var quarterWarningLabel: UILabel!
    
    @IBOutlet weak var streetWarningHeight: NSLayoutConstraint!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var tfNationality: UITextField!
    @IBOutlet weak var lblNationalityWarning: UILabel!
    
   
    @IBOutlet weak var lblCurrentAddress: UILabel!
//    @IBOutlet weak var tfCurrentAddress: UITextField!
    @IBOutlet weak var lblCurrentAddressWarning: UILabel!
    
    @IBOutlet weak var lblPermenentAddress: UILabel!
//    @IBOutlet weak var tfPermenentAddress: UITextField!
    @IBOutlet weak var lblPermenentAddressWarning: UILabel!
    
    @IBOutlet weak var lblTypeResidence: UILabel!
    @IBOutlet weak var tfTypeResidence: UITextField!
    @IBOutlet weak var lblTypeResidenceWarning: UILabel!
    @IBOutlet weak var btnTypeResidence: UIButton! {
        didSet {
            self.btnTypeResidence.layer.cornerRadius = 5
            self.btnTypeResidence.clipsToBounds = true
            self.btnTypeResidence.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
            self.btnTypeResidence.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var perQuarterHeight: NSLayoutConstraint!
    @IBOutlet weak var perStreetHeight: NSLayoutConstraint!
    @IBOutlet weak var perRoomHeight: NSLayoutConstraint!
    @IBOutlet weak var perFloorHeight: NSLayoutConstraint!
    @IBOutlet weak var perBldNoHeight: NSLayoutConstraint!
    @IBOutlet weak var perWarningQuarter: UILabel!
    @IBOutlet weak var perWarningStreet: UILabel!
    @IBOutlet weak var perWarningFloorNo: UILabel!
    @IBOutlet weak var perWarningBldNo: UILabel!
    
    @IBOutlet weak var perWarningRoomNo: UILabel!
    @IBOutlet weak var lblLivingWithText: UILabel!
    @IBOutlet weak var lblLivingWith: UILabel!
//    @IBOutlet weak var tfLivingWith: UITextField!
    @IBOutlet weak var lblLivingWithWarning: UILabel!
    @IBOutlet weak var educationWith: UIView! {
        didSet {
                   self.educationWith.clipsToBounds = true
                   self.educationWith.layer.cornerRadius = 5
                   self.educationWith.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
                   self.educationWith.layer.borderWidth = 1.0
               }
    }
    @IBOutlet weak var viewLivingWith: UIView! {
        didSet {
            self.viewLivingWith.clipsToBounds = true
            self.viewLivingWith.layer.cornerRadius = 5
            self.viewLivingWith.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
            self.viewLivingWith.layer.borderWidth = 1.0
        }
    }
    
    @IBOutlet weak var lblYearStay: UILabel!
//    @IBOutlet weak var tfYearStay: UITextField!
    @IBOutlet weak var lblYearStayWarning: UILabel!
    
    @IBOutlet weak var lblPhNo: UILabel!
    @IBOutlet weak var tfPhNo: UITextField!
//    @IBOutlet weak var tfPhNoWarning: UILabel!
    
    @IBOutlet weak var lblResidentPhNo: UILabel!
    @IBOutlet weak var tfResidentPhNo: UITextField!
    @IBOutlet weak var tfResidentPhNoWarning: UILabel!
    
    @IBOutlet weak var lblOtherPhNo: UILabel!
    @IBOutlet weak var tfOtherPhNo: UITextField!
    @IBOutlet weak var lblOtherPhNoWarning: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var lblEmailWarning: UILabel!
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var lblMale: UILabel!
    @IBOutlet weak var lblFemale: UILabel!
    
    @IBOutlet weak var imgSingle: UIImageView!
    @IBOutlet weak var imgMarried: UIImageView!
    @IBOutlet weak var lblMarried: UILabel!
    @IBOutlet weak var lblSingle: UILabel!
    
    @IBOutlet weak var imgOtherNationality: UIImageView!
    @IBOutlet weak var imgMyanNationality: UIImageView!
    @IBOutlet weak var lblMyan: UILabel!
    @IBOutlet weak var lblOtherNationality: UILabel!
    
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblMarital: UILabel!
    
    @IBOutlet weak var tfYears: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMonths: SkyFloatingLabelTextField!
    @IBOutlet weak var tflivingWith: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lblBldNo: UILabel!
    
    @IBOutlet weak var tfCurrentBldNo: UITextField!
    @IBOutlet weak var currentBldNoWarning: UILabel!
    @IBOutlet weak var BldNoHeight: NSLayoutConstraint!
    @IBOutlet weak var roomNoWarningHeight: NSLayoutConstraint!
    @IBOutlet weak var floorNoWarningHeight: NSLayoutConstraint!
   
    @IBOutlet weak var quarterWarningHeight: NSLayoutConstraint!
    @IBOutlet weak var lblCurrentRoomNo: UILabel!
    @IBOutlet weak var tfCurrentRoomNo: UITextField!
    @IBOutlet weak var lblCurrentFloor: UILabel!
    @IBOutlet weak var tfCurrentFloor: UITextField!
    @IBOutlet weak var lblCurrentStreet: UILabel!
    @IBOutlet weak var tfCurrentStreet: UITextField!
    @IBOutlet weak var lblCurrentQrt: UILabel!
    @IBOutlet weak var tfCurrentQrt: UITextField!
    @IBOutlet weak var lblCurrentTsp: UILabel!
    @IBOutlet weak var tfCurrentTsp: SearchTextField!
    @IBOutlet weak var btnCurrentCity: UIButton!
    @IBOutlet weak var lblCurrentCity: UILabel!
    @IBOutlet weak var tfCurrentCity: UITextField!
    
    @IBOutlet weak var lblPermenentBldNo: UILabel!
    @IBOutlet weak var tfPermenentBldNo: UITextField!
    @IBOutlet weak var lblPermenentRoomNo: UILabel!
    @IBOutlet weak var tfPermenentRoomNo: UITextField!
    
    @IBOutlet weak var lblPermenentFloorNo: UILabel!
    @IBOutlet weak var tfPermenentFloor: UITextField!
    
    @IBOutlet weak var lblPermenentStreet: UILabel!
    @IBOutlet weak var tfPermenentStreet: UITextField!
    
    @IBOutlet weak var lblPermenentQrt: UILabel!
    @IBOutlet weak var tfPermenentQrt: UITextField!
    @IBOutlet weak var lblPermenentTsp: UILabel!
    
    @IBOutlet weak var tfPermenentTsp: SearchTextField!
    
    @IBOutlet weak var btnPermanetCity: UIButton!
    @IBOutlet weak var lblPermenentCity: UILabel!
    @IBOutlet weak var tfPermenentCity: UITextField!
    
    // City Township
    var allCurrTownNameList = [String]()
    var allPerTownNameList = [String]()
    var cityNameList = [String]()
    var cityTownshipModel = CityTownShipModel()
    var selectedCurrCityID : Int?
    var selectedCurrTownshipID: Int?
    var selectedPerCityID : Int?
    var selectedPerTownshipID: Int?
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedTownshipList = [String]()
    
    var yearList :[Int]!
    var monthList :[Int]!
    var numberPicker : UIPickerView!
    
    // Error message Language control
    var nameMesgLocale: String?
    var dobMesgLocale: String?
    var nrcMesgLocale: String?
    var phoneMesgLocale : String?
    var fatherNameMesgLocale: String?
    var currentAddressMesgLocale: String?
    var permenentAddressMesgLocale: String?
    var residentPhoneMesgLocale: String?
    var otherPhoneMesgLocale: String?
    var emailMesgLocale: String?
    var nationalityMesgLocale: String?
    var typeResidenceMesgLocale: String?
    var yearStayMesgLocale: String?
    var isMyanmarNationality = true
    var isMaleSelected = true
    var isMaritalSingle = true
    var selectedTypeResidence = 1
    var selectedLivingWith = 1
    var selectedEducationWith = 1
    var dobString = ""
    var sessionInfo:SessionDataBean?
    var educationText = ""
    var educationId = 1
     //var logoutTimer: Timer?
    var tokenInfo: TokenData?
     let myPickerController = UIImagePickerController()
    
    var myAppData = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 1 , nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)
    var myLoanData = LoanConfirmationRequest(daLoanTypeId: 1, financeAmount: 0.0, financeTerm: 0, daProductTypeId: 1, productDescription: "", channelType: 2)
    
    var myGuarantorData = GuarantorRequest(daGuarantorInfoId: 0,name: "", dob: "", nrcNo: "", nationality: 1, nationalityOther: "", mobileNo: "", residentTelNo: "", relationship: 1, relationshipOther: "", currentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", gender: 1, maritalStatus: 1, yearOfStayYear: 0, yearOfStayMonth: 0, companyName: "", companyTelNo: "", companyAddress: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, monthlyBasicIncome: 0.0, totalIncome: 0.0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
    
    var myOccupationData = OccupationDataRequest(daApplicantCompanyInfoId: 0, companyName: "", companyAddress: "", companyTelNo: "", contactTimeFrom: "", contactTimeTo: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, companyStatus: 1, companyStatusOther: "", monthlyBasicIncome: 0.0, otherIncome: 0.0, totalIncome: 0.0, salaryDay: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
    
    var myContactData = EmergencyContactRequest(daEmergencyContactInfoId: 0, name: "", relationship: 1, relationshipOther: "", currentAddress: "", mobileNo: "", residentTelNo: "", otherPhoneNo: "", currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0)
    var myAttachments = [AttachmentRequest]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextBtnPress.isUserInteractionEnabled = true
              self.nextBtnPress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextBtn)))
        self.mmFlagBtn.isUserInteractionEnabled = true
                 self.engFlagBtn.isUserInteractionEnabled = true
                     
                     self.mmFlagBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
                     self.engFlagBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
        
        
        
        
        
        logoImageView.layer.cornerRadius = 5
        btnSave.layer.cornerRadius = 10
        nextBtnPress.layer.cornerRadius = 10
        applicationDataTitle.layer.cornerRadius = 5
          NotificationCenter.default.addObserver(self, selector: #selector(alertSuccess), name: NSNotification.Name(rawValue: "applicationSuccessfully"), object: nil)
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAppForm"), object: self, userInfo: ["data": self.myAppData as Any])
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markAppDataLastState"), object: nil)
        self.backView.isUserInteractionEnabled = true
         self.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtn)))
        self.markAppDataLastState()
            // logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
//        self.lblMsgDob.text = Constants.BLANK
//        self.lbNrcNoErrorMessage.text = Constants.BLANK
//        self.lblMsgName.text = Constants.BLANK
        self.lblFatherWarning.text = Constants.BLANK
        self.lblNationalityWarning.text = Constants.BLANK
        self.lblCurrentAddressWarning.text = Constants.BLANK
        self.lblPermenentAddressWarning.text = Constants.BLANK
        self.lblTypeResidenceWarning.text = Constants.BLANK
        self.lblLivingWithWarning.text = Constants.BLANK
        self.lblYearStayWarning.text = Constants.BLANK
//        self.tfPhNoWarning.text = Constants.BLANK
        self.tfResidentPhNoWarning.text = Constants.BLANK
        self.lblOtherPhNoWarning.text = Constants.BLANK
        self.lblEmailWarning.text = Constants.BLANK
    
        
        self.setupDob()
        self.setupTownshipCityData()
//        self.setupNRCData()
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
        
        self.tfYears.delegate = self
        self.tfYears.inputView = numberPicker
        self.tfYears.text = "\(yearList[0])"
        
        self.tfMonths.delegate = self
        self.tfMonths.inputView = numberPicker
        self.tfMonths.text = "\(monthList[0])"
        
        self.tfYears.font = UIFont.systemFont(ofSize: 15)
        self.tfMonths.font = UIFont.systemFont(ofSize: 15)
        tfYears?.setMaxLength(maxLength: 2)
        tfMonths?.setMaxLength(maxLength: 2)
        
        self.tfYears.keyboardType = .numberPad
        self.tfMonths.keyboardType = .numberPad
        
        self.viewLivingWith.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickLivingWith)))
        self.educationWith.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickEducationWith)))
        NotificationCenter.default.addObserver(self, selector: #selector(changeLocaleForAppData), name: NSNotification.Name(rawValue: "changeLocaleForApplicationData"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(markAppDataLastState), name: NSNotification.Name(rawValue: "markAppDataLastState"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorLabelApplication), name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
        
        tfName.setMaxLength(maxLength: 50)
        tfFatherName.setMaxLength(maxLength: 50)
        tfNationality.setMaxLength(maxLength: 50)
        tflivingWith.setMaxLength(maxLength: 256)
        
//        tfPermenentAddress.setMaxLength(maxLength: 100)
//        tfCurrentAddress.setMaxLength(maxLength: 100)
        tfCurrentBldNo.setMaxLength(maxLength: 20)
        tfCurrentFloor.setMaxLength(maxLength: 20)
        tfCurrentRoomNo.setMaxLength(maxLength: 20)
        tfCurrentStreet.setMaxLength(maxLength: 100)
        tfCurrentQrt.setMaxLength(maxLength: 100)
        tfCurrentTsp.setMaxLength(maxLength: 100)
        tfCurrentCity.setMaxLength(maxLength: 100)
        
        tfPermenentBldNo.setMaxLength(maxLength: 20)
        tfPermenentFloor.setMaxLength(maxLength: 20)
        tfPermenentRoomNo.setMaxLength(maxLength: 20)
        tfPermenentStreet.setMaxLength(maxLength: 100)
        tfPermenentQrt.setMaxLength(maxLength: 100)
        tfPermenentTsp.setMaxLength(maxLength: 100)
        tfPermenentCity.setMaxLength(maxLength: 100)
        tfTypeResidence.setMaxLength(maxLength: 256)
        tfResidentPhNo.setMaxLength(maxLength: 11)
        tfOtherPhNo.setMaxLength(maxLength: 11)
        tfEmail.setMaxLength(maxLength: 50)
        tfPhNo.setMaxLength(maxLength: 11)
        
        tfName.autocapitalizationType = .allCharacters
        tfFatherName.autocapitalizationType = .allCharacters
        tfNationality.autocapitalizationType = .allCharacters
        tflivingWith.autocapitalizationType = .allCharacters
        tfCurrentBldNo.autocapitalizationType = .allCharacters
        tfCurrentFloor.autocapitalizationType = .allCharacters
        tfCurrentRoomNo.autocapitalizationType = .allCharacters
        tfCurrentStreet.autocapitalizationType = .allCharacters
        tfCurrentQrt.autocapitalizationType = .allCharacters
        tfTypeResidence.autocapitalizationType = .allCharacters
        tfPermenentBldNo.autocapitalizationType = .allCharacters
        tfPermenentFloor.autocapitalizationType = .allCharacters
        tfPermenentRoomNo.autocapitalizationType = .allCharacters
        tfPermenentStreet.autocapitalizationType = .allCharacters
        tfPermenentQrt.autocapitalizationType = .allCharacters
        
        self.updateViews()
        
        // mendatory fields background setting
        self.tfCurrentBldNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentRoomNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentFloor.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentQrt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentCity.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentTsp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfFatherName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfNationality.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentStreet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentTsp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfTypeResidence.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfYears.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMonths.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
         self.tfPermenentBldNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         self.tfPermenentStreet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         self.tfPermenentQrt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         self.tfPermenentCity.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         self.tfPermenentFloor.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         self.tfPermenentRoomNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
              
               
                NotificationCenter.default.addObserver(self, selector: #selector(doSetAppData(notification:)), name: NSNotification.Name(rawValue: "SetAppData"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSetOccupationData(notification:)), name: NSNotification.Name(rawValue: "SetOccupationData"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSetEmergencyContactData(notification:)), name: NSNotification.Name(rawValue: "SetEmergencyContactData"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSetGuarantorData(notification:)), name: NSNotification.Name(rawValue: "SetGuarantorData"), object: nil)
//
//               NotificationCenter.default.addObserver(self, selector: #selector(doSetLoanConfirmationData(notification:)), name: NSNotification.Name(rawValue: "SetLoanConfirmationData"), object: nil)
               
                NotificationCenter.default.addObserver(self, selector: #selector(doRegisterDA), name: NSNotification.Name(rawValue: "doRegistration"), object: nil)
               
//               NotificationCenter.default.addObserver(self, selector: #selector(doSaveDA), name: NSNotification.Name(rawValue: "saveDA"), object: nil)
//         NotificationCenter.default.addObserver(self, selector: #selector(showPreview), name: NSNotification.Name(rawValue: "showPreview"), object: nil)
        self.doLoadSaveDAData()
    }
    @objc func alertSuccess() {
        BldNoHeight.constant = 0
        roomNoWarningHeight.constant = 0
        floorNoWarningHeight.constant = 0
        streetWarningHeight.constant = 0
        quarterWarningHeight.constant = 0
        
        perStreetHeight.constant = 0
        perQuarterHeight.constant = 0
        perFloorHeight.constant = 0
        perBldNoHeight.constant = 0
        perRoomHeight.constant = 0
        self.tfResidentPhNoWarning.text = Constants.BLANK
        self.lblOtherPhNoWarning.text = Constants.BLANK
        self.lblEmailWarning.text = Constants.BLANK
         CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
           let alertController = UIAlertController(title: "Your application is successfully saved!", message: "", preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                 
           }))
           self.present(alertController, animated: true, completion: nil)
        
       }
    @objc func nextBtn() {
                               let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "OccupationDataVC") as! OccupationDataVC
        navigationVC.modalPresentationStyle = .overFullScreen
                               self.present(navigationVC, animated: true, completion: nil)
       }
    @objc func onTapMMLocale() {
        print("click")
        super.NewupdateLocale(flag: 1)
        updateViews()
    }
    @objc func onTapEngLocale() {
        print("click")
        super.NewupdateLocale(flag: 2)
        updateViews()
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
        
        @objc func doSetGuarantorData(notification: Notification) {
            print("doSetGuarantorData")
            if let dict = notification.userInfo as? Dictionary<String, Any> {
                print("doSetGuarantorData \(dict)")
                if let sVar = dict["appData"] as? GuarantorRequest {
                    print("doSetGuarantorData \(sVar.name)")
                    self.myGuarantorData = sVar
                    print("doSetGuarantorData myappdata.name \(self.myGuarantorData.name)")
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
            
            let appdata = ApplicationDataRequest(daApplicationInfoId: responseObjDA.daApplicationInfoId ?? 0, daApplicationTypeId: responseObjDA.daApplicationTypeId ?? 1, name: responseObjDA.name ?? "", dob: responseObjDA.dob ?? "", nrcNo: responseObjDA.nrcNo ?? "", fatherName: responseObjDA.fatherName ?? "",highestEducationTypeId: responseObjDA.highestEducationTypeId ?? 1, nationality: responseObjDA.nationality ?? 1, nationalityOther: responseObjDA.nationalityOther ?? "", gender: responseObjDA.gender!, maritalStatus: responseObjDA.maritalStatus ?? 1, currentAddress: responseObjDA.currentAddress ?? "", permanentAddress: responseObjDA.permanentAddress ?? "", typeOfResidence: responseObjDA.typeOfResidence ?? 1, typeOfResidenceOther: responseObjDA.typeOfResidenceOther ?? "", livingWith: responseObjDA.livingWith ?? 1, livingWithOther: responseObjDA.livingWithOther ?? "", yearOfStayYear: responseObjDA.yearOfStayYear ?? 0, yearOfStayMonth: responseObjDA.yearOfStayMonth ?? 0, mobileNo: responseObjDA.mobileNo ?? "", residentTelNo: responseObjDA.residentTelNo ?? "", otherPhoneNo: responseObjDA.otherPhoneNo ?? "", email: responseObjDA.email ?? "", customerId: responseObjDA.customerId ?? 0, status: responseObjDA.status ?? 0, currentAddressFloor: responseObjDA.currentAddressFloor ?? "", currentAddressBuildingNo: responseObjDA.currentAddressBuildingNo ?? "", currentAddressRoomNo: responseObjDA.currentAddressRoomNo ?? "", currentAddressStreet: responseObjDA.currentAddressStreet ?? "", currentAddressQtr: responseObjDA.currentAddressQtr ?? "", currentAddressTownship: responseObjDA.currentAddressTownship ?? 0, currentAddressCity: responseObjDA.currentAddressCity ?? 0,permanentAddressCity: responseObjDA.permanentAddressCity ?? 0, permanentAddressFloor: responseObjDA.permanentAddressFloor ?? "", permanentAddressBuildingNo: responseObjDA.permanentAddressBuildingNo ?? "", permanentAddressRoomNo: responseObjDA.permanentAddressRoomNo ?? "", permanentAddressStreet: responseObjDA.permanentAddressStreet ?? "", permanentAddressQtr: responseObjDA.permanentAddressQtr ?? "", permanentAddressTownship: responseObjDA.permanentAddressTownship ?? 0)

            
            self.myAppData = appdata
            myAppFormData = self.myAppData
            self.fillThisForm(data: myAppFormData)
            DispatchQueue.main.async {
                self.delegate?.showApplicationForm()
            }
            
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
                DispatchQueue.main.async {
                    self.delegate?.showApplicationForm()
                }
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
    
    @objc func markAppDataLastState() {
        //Calculate Error Count
        self.markErrorCount()
        self.tfCurrentTsp.hideResultsList()
        self.tfPermenentTsp.hideResultsList()
        //Mark Last State
        guard let customerId = UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) else { return  }
        
//        let divisionCode: String = (self.lblDivision?.text!)!
//        let townshipCode: String = (self.tfTownshipAutoText?.text!)!
//        let nrcType: String = (self.lblNrcType?.text!)!
        let nrc: String = (self.tfNrcNo?.text!)!
        
//        let nrc = divisionCode + "/" + townshipCode + nrcType + nrcNo
        
        //Nationality
        var selectedNationality = 1
        
        if !isMyanmarNationality {
            selectedNationality = 2
        }
        
        var selectedGender = 1
        
        if !isMaleSelected {
            selectedGender = 2
        }
        
        var selectedMarital = 1
        
        if !isMaritalSingle {
            selectedMarital = 2
        }
        
        var yearStay = 0
        if self.tfYears.text != "" {
            if let intString = Int(self.tfYears.text!) {
                yearStay = intString
            }
        }
        
        var monthStay = 0
        if self.tfYears.text != "" {
            if let intString = Int(self.tfMonths.text!) {
                monthStay = intString
            }
        }
       
        self.dobString = self.tfDob.text!
        myAppFormData.permanentAddressCity = self.selectedPerCityID ?? 0
        let appData = ApplicationDataRequest(daApplicationInfoId: applicationFormID, daApplicationTypeId: 1, name: self.tfName.text ?? "", dob: self.tfDob.text!, nrcNo: nrc, fatherName: self.tfFatherName.text?.uppercased() ?? "", highestEducationTypeId: educationId, nationality: selectedNationality, nationalityOther: self.tfNationality.text?.uppercased() ?? "", gender: selectedGender, maritalStatus: selectedMarital, currentAddress: "", permanentAddress: "", typeOfResidence: self.selectedTypeResidence, typeOfResidenceOther: self.tfTypeResidence.text?.uppercased() ?? "", livingWith: self.selectedLivingWith, livingWithOther: self.tflivingWith.text?.uppercased() ?? "", yearOfStayYear: yearStay, yearOfStayMonth: monthStay, mobileNo: self.tfPhNo.text ?? "", residentTelNo: self.tfResidentPhNo.text ?? "", otherPhoneNo: self.tfOtherPhNo.text ?? "", email: self.tfEmail.text ?? "", customerId: Int(customerId)!, status: 0, currentAddressFloor: "\(self.tfCurrentFloor.text?.uppercased() ?? "")", currentAddressBuildingNo: "\(self.tfCurrentBldNo.text?.uppercased() ?? "")", currentAddressRoomNo: "\(self.tfCurrentRoomNo.text?.uppercased() ?? "")", currentAddressStreet: "\(self.tfCurrentStreet.text?.uppercased() ?? "")", currentAddressQtr: "\(self.tfCurrentQrt.text?.uppercased() ?? "")", currentAddressTownship: self.selectedCurrTownshipID ?? 0, currentAddressCity: self.selectedCurrCityID ?? 0, permanentAddressCity: self.selectedPerCityID ?? 0, permanentAddressFloor:  "\(self.tfPermenentFloor.text?.uppercased() ?? "")", permanentAddressBuildingNo: "\(self.tfPermenentBldNo.text?.uppercased() ?? "")", permanentAddressRoomNo: "\(self.tfPermenentRoomNo.text?.uppercased() ?? "")", permanentAddressStreet: "\(self.tfPermenentStreet.text?.uppercased() ?? "")", permanentAddressQtr: "\(self.tfPermenentQrt.text?.uppercased() ?? "")", permanentAddressTownship: self.selectedPerTownshipID ?? 0)
    
//        let appData = ApplicationDataRequest(daApplicationInfoId: applicationFormID, daApplicationTypeId: 1, name: self.tfName.text ?? "", dob: self.tfDob.text!, nrcNo: nrc, fatherName: self.tfFatherName.text?.uppercased() ?? "",highestEducationTypeId: educationId, nationality: selectedNationality, nationalityOther: self.tfNationality.text?.uppercased() ?? "", gender: selectedGender, maritalStatus: selectedMarital, currentAddress: "", permanentAddress: "", typeOfResidence: self.selectedTypeResidence, typeOfResidenceOther: self.tfTypeResidence.text?.uppercased() ?? "", livingWith: self.selectedLivingWith, livingWithOther: self.tflivingWith.text?.uppercased() ?? "", yearOfStayYear: yearStay, yearOfStayMonth: monthStay, mobileNo: self.tfPhNo.text ?? "", residentTelNo: self.tfResidentPhNo.text ?? "", otherPhoneNo: self.tfOtherPhNo.text ?? "", email: self.tfEmail.text ?? "", customerId: Int(customerId)!, status: 0, currentAddressFloor: "\(self.tfCurrentFloor.text?.uppercased() ?? "")", currentAddressBuildingNo: "\(self.tfCurrentBldNo.text?.uppercased() ?? "")", currentAddressRoomNo: "\(self.tfCurrentRoomNo.text?.uppercased() ?? "")", currentAddressStreet: "\(self.tfCurrentStreet.text?.uppercased() ?? "")", currentAddressQtr: "\(self.tfCurrentQrt.text?.uppercased() ?? "")", currentAddressTownship: self.selectedCurrTownshipID ?? 0, currentAddressCity: self.selectedCurrCityID ?? 0, permanentAddressFloor: "\(self.tfPermenentFloor.text?.uppercased() ?? "")", permanentAddressBuildingNo: "\(self.tfPermenentBldNo.text?.uppercased() ?? "")", permanentAddressRoomNo: "\(self.tfPermenentRoomNo.text?.uppercased() ?? "")", permanentAddressStreet: "\(self.tfPermenentStreet.text?.uppercased() ?? "")", permanentAddressQtr: "\(self.tfPermenentQrt.text?.uppercased() ?? "")", permanentAddressTownship: self.selectedPerTownshipID ?? 0)
        myAppFormData.permanentAddressCity = appData.permanentAddressCity
        
         myAppFormData = appData
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetAppData"), object: self, userInfo: ["appData": appData])
        self.fillThisForm(data: myAppFormData)
        NotificationCenter.default.addObserver(self, selector: #selector(showAppForm(notification:)), name: NSNotification.Name(rawValue: "showAppForm"), object: nil)
        self.view.endEditing(true)
    }
    
    @objc func myTargetFunction(textField: UITextField) {
        print("myTargetFunction")
        
    }
    @objc func backBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func showAppForm(notification: Notification) {
        if let dict = notification.userInfo as? Dictionary<String, Any> {
        print("showemergencyform \(dict)")
            if (dict["data"] as? ApplicationDataRequest) != nil {
            self.fillThisForm(data: myAppFormData)
            }
        }
    }
    
    
    func fillThisForm(data: ApplicationDataRequest) {
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())

        //let dobtemp = "\(sessionInfo?.dateOfBirth ?? "")".strstr(needle: "T", beforeNeedle: true)
        //.strstr(needle: ")", beforeNeedle: false) //6 number string
        //        self.lblDivision.text = nrcStr.strstr(needle: "/", beforeNeedle: true)
        //        let afterBackSlash = nrcStr.strstr(needle: "/")
        //        self.tfTownshipAutoText.text = afterBackSlash?.strstr(needle: "(", beforeNeedle: true)
        //        self.lblNrcType.text = "(\(nrcStr.slice(from: "(", to: ")") ?? ""))"
        //        self.tfNrcNo?.text = data.nrcNo
        
        let datas = data.highestEducationTypeId
        if datas == 1 {
             self.educationLabel.text = "High School"
        }else if datas == 2 {
            self.educationLabel.text = "University"
        }else if datas == 3 {
            self.educationLabel.text = "Graduated"
        }
        
        self.tfName.text = "\(sessionInfo?.name ?? "")"//data.name
        self.tfDob.text  = Utils.changeYMDDateformat(date: (sessionInfo?.dateOfBirth)!)
        let nrcStr = "\(sessionInfo?.nrcNo ?? "")"//data.nrcNo
        self.tfNrcNo?.text = nrcStr
        
        self.tfFatherName.text = data.fatherName
        self.textFieldDidChange(self.tfFatherName)
        
        self.tfNationality.text = data.nationalityOther
        self.textFieldDidChange(self.tfNationality)
        
        if data.nationality == 1 {
            self.doSelectMyanmarNationality(UIButton())
        } else {
            self.doSelectOtherNationality(UIButton())
        }
        if data.gender == 1 {
            self.doSelectmale(UIButton())
        } else {
            self.doSelectFemale(UIButton())
        }
        if data.maritalStatus == 1 {
            self.doSelectSingle(UIButton())
        } else {
            self.doSelectMarried(UIButton())
        }
        
//        self.tfCurrentAddress.text = data.currentAddress
//        self.tfPermenentAddress.text = data.permanentAddress
        self.selectedTypeResidence = data.typeOfResidence
        self.btnTypeResidence.setTitle("\(Constants.typeResidenceList[self.selectedTypeResidence - 1])", for: .normal)
        self.tfTypeResidence.text = data.typeOfResidenceOther
        self.textFieldDidChange(self.tfTypeResidence)
        
        if self.selectedTypeResidence == Constants.typeResidenceList.count {
            self.tfTypeResidence.isHidden = false
        } else {
            self.tfTypeResidence.isHidden = true
        }
        
        self.tflivingWith.text = data.livingWithOther
        self.selectedLivingWith = data.livingWith
        self.lblLivingWithText.text = Constants.livingWithList[self.selectedLivingWith - 1]
        
        if data.yearOfStayYear == 0 {
            self.tfYears.text = "0"
        } else {
           self.tfYears.text = "\(data.yearOfStayYear)"
        }
        self.textFieldDidChange(self.tfYears)
        
        if data.yearOfStayMonth == 0 {
            self.tfMonths.text = "0"
        } else {
            self.tfMonths.text = "\(data.yearOfStayMonth)"
        }
        self.textFieldDidChange(self.tfMonths)
        
        self.tfPhNo.text = "\(sessionInfo?.phoneNo ?? "")"//data.mobileNo
        self.tfResidentPhNo.text = data.residentTelNo
        self.tfOtherPhNo.text = data.otherPhoneNo
        self.tfEmail.text = data.email
        
        self.tfCurrentBldNo.text = "\(data.currentAddressBuildingNo)"
        self.tfCurrentFloor.text = "\(data.currentAddressFloor)"
        self.tfCurrentRoomNo.text = "\(data.currentAddressRoomNo)"
        self.tfCurrentStreet.text = "\(data.currentAddressStreet)"
        self.textFieldDidChange(self.tfCurrentStreet)
        
        self.tfCurrentQrt.text = "\(data.currentAddressQtr)"
        
        if data.currentAddressCity != 0 {
            for cityName in self.cityTownshipModel.cityNameIdDic!.keys{
                let id = self.cityTownshipModel.cityNameIdDic![cityName]
                if id == data.currentAddressCity {
                    self.btnCurrentCity.setTitle(cityName, for: UIControl.State.normal)
                    self.selectedCurrCityID = id
                    break
                }
            }
        }
        
        if data.currentAddressTownship != 0 {
            for townName in self.cityTownshipModel.townNameIdDic!.keys{
                let id = self.cityTownshipModel.townNameIdDic![townName]
                if id == data.currentAddressTownship {
                    self.tfCurrentTsp.text = townName
                    self.allCurrTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCurrCityID!]!
                    self.tfCurrentTsp.filterStrings(self.allCurrTownNameList)
                    self.selectedCurrTownshipID = id
                    break
                }
            }
        }
        self.textFieldDidChange(self.tfCurrentTsp)
        
        self.tfPermenentBldNo.text = "\(data.permanentAddressBuildingNo)"
        self.tfPermenentFloor.text = "\(data.permanentAddressFloor)"
        self.tfPermenentRoomNo.text = "\(data.permanentAddressRoomNo)"
        self.tfPermenentStreet.text = "\(data.permanentAddressStreet)"
        self.tfPermenentQrt.text = "\(data.permanentAddressQtr)"
        
        if data.permanentAddressCity != 0{
            for cityName in self.cityTownshipModel.cityNameIdDic!.keys{
                let id = self.cityTownshipModel.cityNameIdDic![cityName]
                if id == data.permanentAddressCity {
                    self.btnPermanetCity.setTitle(cityName, for: UIControl.State.normal)
                    self.selectedPerCityID = id
                    break
                }
            }
        }
        
        if data.permanentAddressTownship != 0 {
            for townName in self.cityTownshipModel.townNameIdDic!.keys{
                let id = self.cityTownshipModel.townNameIdDic![townName]
                if id == data.permanentAddressTownship {
                    self.tfPermenentTsp.text = townName
                    self.allPerTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedPerCityID!]!
                    self.tfPermenentTsp.filterStrings(self.allPerTownNameList)
                    self.selectedPerTownshipID = id
                    break
                }
            }
        }
        
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification {
            svApplicationData.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
            
        } else {
            svApplicationData.contentInset = UIEdgeInsets.zero
        }
        svApplicationData.scrollIndicatorInsets = svApplicationData.contentInset
    }

    @objc func changeLocaleForAppData() {
        print("change local for App data")
        self.updateViews()
        self.updateLocale()
    }
    
    
    @objc override func updateViews() {
        super.updateViews()
        
        self.lblName.text = "application_data.title".localized
        self.lblDob.text = "application_data.dob.label".localized
        self.tfDob?.placeholder = "verify.dob.holder".localized
//        self.lblMsgOneDob.text = "register.dob.restrict.label".localized
        self.lblNrcNo.text = "application_data.nrc.label".localized
        
        self.lblFatherName.text = "application_data.fathername".localized
        self.educationTitleLabel.text = "application_data.education".localized
        self.btnSave.setTitle("application_data.save.button".localized, for: UIControl.State.normal)
       // self.btnNext.setTitle("application_data.next.button".localized, for: UIControl.State.normal)
        
        self.lblNationality.text = "application_data.nationality".localized
        self.lblGender.text = "application_data.gender".localized
        self.lblMarital.text = "application_data.marital".localized
        self.lblCurrentAddress.text = "application_data.currentaddress".localized
        self.lblPermenentAddress.text = "application_data.permenentaddress".localized
        self.lblTypeResidence.text = "application_data.typeresidence".localized
        self.lblLivingWith.text = "application_data.livingwith".localized
        self.lblYearStay.text =  "application_data.yearstay".localized
        self.lblPhNo.text =  "application_data.phno".localized
        self.lblResidentPhNo.text =  "application_data.residentphno".localized
        self.lblOtherPhNo.text =  "application_data.otherphno".localized
        self.lblEmail.text =  "application_data.email".localized
        
        self.lblMyan.text = "application_data.myan".localized
        self.lblOtherNationality.text = "application_data.othernationality".localized
        self.lblMale.text = "application_data.male".localized
        self.lblFemale.text = "application_data.female".localized
        self.lblSingle.text = "application_data.single".localized
        self.lblMarried.text = "application_data.married".localized
        
        self.lblBldNo.text = "da.buildno".localized
        self.lblCurrentFloor.text = "da.floor".localized
        self.lblCurrentRoomNo.text = "da.roomno".localized
        self.lblCurrentStreet.text = "da.street".localized
        self.lblCurrentQrt.text = "da.quarter".localized
        self.lblCurrentTsp.text = "da.township".localized
        self.lblCurrentCity.text = "da.city".localized
        
        self.lblPermenentBldNo.text = "da.buildno".localized
        self.lblPermenentFloorNo.text = "da.floor".localized
        self.lblPermenentRoomNo.text = "da.roomno".localized
        self.lblPermenentStreet.text = "da.permanent.street".localized
        self.lblPermenentQrt.text = "da.quarter".localized
        self.lblPermenentTsp.text = "da.permanent.township".localized
        self.lblPermenentCity.text = "da.permanent.city".localized
        
        
        self.tfYears.placeholder = "application_data.year.placeholder".localized
        self.tfMonths.placeholder = "application_data.month.placeholder".localized
        
//        self.lblMsgName.text = self.nameMesgLocale?.localized
//        self.lblMsgDob.text = self.dobMesgLocale?.localized
//        self.lbNrcNoErrorMessage.text = self.nrcMesgLocale?.localized
       
        self.lblFatherWarning.text = self.fatherNameMesgLocale?.localized
        self.lblNationalityWarning.text = self.nationalityMesgLocale?.localized
        self.lblCurrentAddressWarning.text = self.currentAddressMesgLocale?.localized
        self.lblPermenentAddressWarning.text = self.permenentAddressMesgLocale?.localized
        self.lblTypeResidenceWarning.text = self.typeResidenceMesgLocale?.localized
        self.lblYearStayWarning.text = self.yearStayMesgLocale?.localized
//        self.tfPhNoWarning.text = self.phoneMesgLocale?.localized
        self.tfResidentPhNoWarning.text = self.residentPhoneMesgLocale?.localized
        self.lblOtherPhNoWarning.text = self.otherPhoneMesgLocale?.localized
        self.lblEmailWarning.text = self.emailMesgLocale?.localized
        
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
        
    }
    
    @IBAction func onClickCityBtn(_ sender: UIButton) {
        self.tfDob?.resignFirstResponder()
        openCurrCitySelectionPopUp()
    }
    
    @IBAction func onClickPerCityBtn(_ sender: UIButton) {
        self.tfDob?.resignFirstResponder()
        openPerCitySelectionPopUp()
    }
    
    func openCurrCitySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCurrentCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCurrCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allCurrTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCurrCityID!]!
                
                if self.allCurrTownNameList.count >= 0 {
                    self.tfCurrentTsp.filterStrings(self.allCurrTownNameList)
                    self.tfCurrentTsp.text = Constants.BLANK
                    self.tfCurrentTsp.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.tfCurrentCity
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCurrentCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCurrCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allCurrTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCurrCityID!]!
                
                if self.allCurrTownNameList.count >= 0 {
                    self.tfCurrentTsp.filterStrings(self.allCurrTownNameList)
                    self.tfCurrentTsp.text = Constants.BLANK
                    self.tfCurrentTsp.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openPerCitySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnPermanetCity.setTitle(value, for: UIControl.State.normal)
                self.selectedPerCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allPerTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedPerCityID!]!
                
                if self.allPerTownNameList.count >= 0 {
                    self.tfPermenentTsp.filterStrings(self.allPerTownNameList)
                    self.tfPermenentTsp.text = Constants.BLANK
                    self.tfPermenentTsp.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.tfCurrentCity
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnPermanetCity.setTitle(value, for: UIControl.State.normal)
                self.selectedPerCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allPerTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedPerCityID!]!
                
                if self.allPerTownNameList.count >= 0 {
                    self.tfPermenentTsp.filterStrings(self.allPerTownNameList)
                    self.tfPermenentTsp.text = Constants.BLANK
                    self.tfPermenentTsp.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
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
        self.tfCurrentTsp.theme.cellHeight = 40
        self.tfCurrentTsp.maxResultsListHeight = 300
        self.tfCurrentTsp.startVisible = true
        self.tfCurrentTsp.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfCurrentTsp.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfCurrentTsp.theme.bgColor = UIColor.groupTableViewBackground
        self.tfCurrentTsp.theme.separatorColor = UIColor.lightGray
        self.tfCurrentTsp.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfCurrentTsp.text = item.title
            self.tfCurrentTsp.backgroundColor = UIColor.white
            self.selectedCurrTownshipID = self.cityTownshipModel.townNameIdDic![item.title]
            print("\(item.title)", "\(self.selectedCurrTownshipID ?? 0)")
        }
        
        self.tfPermenentTsp.theme.cellHeight = 40
        self.tfPermenentTsp.maxResultsListHeight = 300
        self.tfPermenentTsp.startVisible = true
        self.tfPermenentTsp.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfPermenentTsp.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfPermenentTsp.theme.bgColor = UIColor.groupTableViewBackground
        self.tfPermenentTsp.theme.separatorColor = UIColor.lightGray
        self.tfPermenentTsp.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfPermenentTsp.text = item.title
            self.tfPermenentTsp.backgroundColor = UIColor.white
            self.selectedPerTownshipID = self.cityTownshipModel.townNameIdDic![item.title]
            print("\(item.title)", "\(self.selectedPerTownshipID ?? 0)")
        }
        
        //load city township data
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        DAViewModel.init().getCityTownshipList(success: { (model) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.cityTownshipModel = model
            for cityName in model.cityNameIdDic!.keys {
                self.cityNameList.append(cityName)
            }
            
            // Current Address
            self.btnCurrentCity.setTitle("", for: UIControl.State.normal)
            self.selectedCurrCityID = model.cityNameIdDic![self.cityNameList[0]]
            self.allCurrTownNameList = model.cityIdTownListDic![self.selectedCurrCityID!]!
            self.tfCurrentTsp.filterStrings(self.allCurrTownNameList)
            
            
            // Permanent Address
          
            self.btnPermanetCity.setTitle("", for: UIControl.State.normal)
            self.selectedPerCityID = model.cityNameIdDic![self.cityNameList[0]]
            self.allPerTownNameList = model.cityIdTownListDic![self.selectedPerCityID!]!
            self.tfPermenentTsp.filterStrings(self.allPerTownNameList)
            
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
        
    /*
    func setupNRCData() {
        
        //autocomplete
        self.tfTownshipAutoText.theme.cellHeight = 40
        self.tfTownshipAutoText.maxResultsListHeight = 300
        self.tfTownshipAutoText.startVisible = true
        self.tfTownshipAutoText.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfTownshipAutoText.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfTownshipAutoText.theme.bgColor = UIColor.groupTableViewBackground
        self.tfTownshipAutoText.theme.separatorColor = UIColor.lightGray
        
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
    }
    
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
    */
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
    
    @objc func onClickLivingWith() {
        self.openLivingWithPopup()
    }
    @objc func onClickEducationWith() {
        self.openEducationWithPopup()
    }
    func openEducationWithPopup() {
           if UIDevice.current.userInterfaceIdiom == .pad {
               let action = UIAlertController.actionSheetWithItems(items: Constants.educationWithList, action: { (value)  in
                   //                let selectedType = self.typeResidence[Int(value)!-1]
                   self.educationLabel.text = value
                   self.selectedEducationWith = Constants.educationWithList.firstIndex(of: value)! + 1
                   print(value)
               })
               action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
               if let popoverPresentationController = action.popoverPresentationController {
                   popoverPresentationController.sourceView = self.view
               }
               //Present the controller
               self.present(action, animated: true, completion: nil)
               
           } else {
               
               let action = UIAlertController.actionSheetWithItems(items: Constants.educationWithList, action: { (value)  in
                   //                let selectedType = self.typeResidence[-1]
                
                    self.educationText = value
                   self.educationLabel.text = value
               
                   self.selectedEducationWith = Constants.educationWithList.firstIndex(of: value)! + 1
                   print(value)
                if value == "High School"{
                                   self.educationId = 1
                               }
                               if value == "University"{
                                   self.educationId = 2
                                
                               }
                               if value == "Graduated"{
                                   self.educationId = 3
                               }
                
                
               })
               action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
               //Present the controller
               self.present(action, animated: true, completion: nil)
               
           }
       }


    @IBAction func doSelectmale(_ sender: Any) {
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
        
        self.isMaritalSingle = true
    }
    
    @IBAction func doSelectMarried(_ sender: Any) {
        self.imgMarried.image = UIImage(named: "circle_selected")
        self.imgSingle.image = UIImage(named: "circle")
        
        self.isMaritalSingle = false
    }
    
    @IBAction func doSelectTypeResidence(_ sender: Any) {
        self.openTypeOfResidencePopup()
    }
    
    @IBAction func doSelectMyanmarNationality(_ sender: Any) {
        self.imgMyanNationality.image = UIImage(named: "circle_selected")
        self.imgOtherNationality.image = UIImage(named: "circle")
        
        self.isMyanmarNationality = true
        self.tfNationality.isHidden = true
    }
    
    @IBAction func doSelectOtherNationality(_ sender: Any) {
        self.imgMyanNationality.image = UIImage(named: "circle")
        self.imgOtherNationality.image = UIImage(named: "circle_selected")
        self.isMyanmarNationality = false
        self.tfNationality.isHidden = false
    }
    
    func isErrorExist() -> Bool {
        
        var isError = false
        // not to overwrite error message
        //var isNRCError = false
        
//        // Validate Name [a-zA-Z0-9 ]
//        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            self.tfName?.text = Constants.BLANK
//            self.lblMsgName.text = Messages.NAME_EMPTY_ERROR.localized
//            self.nameMesgLocale = Messages.NAME_EMPTY_ERROR
//            isError = true
//
//        } else if !Utils.isNameValidate(name: (self.tfName!.text)!){
//
//            self.lblMsgName.text = Messages.NAME_REG_FORMAT_ERROR.localized
//            self.nameMesgLocale = Messages.NAME_REG_FORMAT_ERROR
//            isError = true
//
//        } else {
//            self.nameMesgLocale = Constants.BLANK
//            self.lblMsgName.text = Constants.BLANK
//        }
        
        // Validate Name [a-zA-Z0-9 ]
        
        if self.tfFatherName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfFatherName?.text = Constants.BLANK
            self.lblFatherWarning.text = Messages.NAME_EMPTY_ERROR.localized
            self.fatherNameMesgLocale = Messages.NAME_EMPTY_ERROR
            isError = true
            
        }
//        else if !Utils.isNameValidate(name: (self.tfFatherName!.text)!){
//
//            self.lblFatherWarning.text = Messages.NAME_REG_FORMAT_ERROR.localized
//            self.fatherNameMesgLocale = Messages.NAME_REG_FORMAT_ERROR
//            isError = true
//
//        }
        else {
            self.fatherNameMesgLocale = Constants.BLANK
            self.lblFatherWarning.text = Constants.BLANK
        }
        if self.tfCurrentRoomNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            roomNoWarningHeight.constant = 16
            self.tfCurrentRoomNo?.text = Constants.BLANK
            self.roomNoWarningLabel.text = Messages.ROOM_NO_ERROR.localized
            isError = true
        }else{
            roomNoWarningHeight.constant = 0
        }
        if self.tfCurrentBldNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            BldNoHeight.constant = 16
            self.tfCurrentBldNo.text = Constants.BLANK
            self.currentBldNoWarning.text = Messages.BUILD_NO_ERROR.localized
           isError = true
        }else{
           BldNoHeight.constant = 0
//              self.tfCurrentBldNo.text = Constants.BLANK
//                self.currentBldNoWarning.text = Constants.BLANK
        }
        if self.tfCurrentRoomNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                    roomNoWarningHeight.constant = 16
                    self.tfCurrentRoomNo.text = Constants.BLANK
                    self.roomNoWarningLabel.text = Messages.ROOM_NO_ERROR.localized
                   isError = true
                }else{
                   roomNoWarningHeight.constant = 0
        //              self.tfCurrentBldNo.text = Constants.BLANK
        //                self.currentBldNoWarning.text = Constants.BLANK
                }
        if self.tfCurrentFloor.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                           floorNoWarningHeight.constant = 16
                           self.tfCurrentFloor.text = Constants.BLANK
                           self.floorNoWarningLabel.text = Messages.FLOOR_NO_ERROR.localized
                          isError = true
                       }else{
                          floorNoWarningHeight.constant = 0
               //              self.tfCurrentBldNo.text = Constants.BLANK
               //                self.currentBldNoWarning.text = Constants.BLANK
                       }
        if self.tfCurrentQrt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                                  quarterWarningHeight.constant = 16
                                  self.quarterWarningLabel.text = Constants.BLANK
                                  self.quarterWarningLabel.text = Messages.FLOOR_NO_ERROR.localized
                                 isError = true
                              }else{
                                 quarterWarningHeight.constant = 0
                      //              self.tfCurrentBldNo.text = Constants.BLANK
                      //                self.currentBldNoWarning.text = Constants.BLANK
                              }
        // Current address
        if self.tfCurrentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.streetWarningHeight.constant = 16
            self.tfCurrentStreet?.text = Constants.BLANK
            self.streetWarningLabel.text = Messages.STREET_ERROR.localized
//            self.currentAddressMesgLocale = Messages.STREET_ERROR
            isError = true
            
        } else {
            self.streetWarningHeight.constant = 0
            //self.currentAddressMesgLocale = Constants.BLANK
            //self.lblCurrentAddressWarning.text = Constants.BLANK
        }
        if self.tfCurrentQrt?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                  self.quarterWarningHeight.constant = 16

            self.tfCurrentQrt.text = Constants.BLANK
            self.quarterWarningLabel.text = Messages.QUARTER_ERROR.localized
                 // self.currentAddressMesgLocale = Messages.ADDRESS_EMPTY_ERROR
                  isError = true

              } else {
                  self.quarterWarningHeight.constant = 0
//                  self.currentAddressMesgLocale = Constants.BLANK
//                  self.lblCurrentAddressWarning.text = Constants.BLANK
              }
        
        if self.tfCurrentTsp?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            //self.townshipWarningHeight.constant = 16
            self.tfCurrentTsp?.text = Constants.BLANK
            self.lblCurrentAddressWarning.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.currentAddressMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true
            
        } else if !self.allCurrTownNameList.contains((self.tfCurrentTsp?.text)!) {
            self.tfCurrentTsp?.text = Constants.BLANK
            self.lblCurrentAddressWarning.text = Messages.ADDRESS_INVALID_ERROR.localized
            self.currentAddressMesgLocale = Messages.ADDRESS_INVALID_ERROR
            isError = true
            
        } else {
           // self.townshipWarningHeight.constant = 16
            self.currentAddressMesgLocale = Constants.BLANK
            self.lblCurrentAddressWarning.text = Constants.BLANK
        }
        
         //Permenent address
//        if self.tfPermenentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            self.tfPermenentStreet?.text = Constants.BLANK
//            self.lblPermenentAddressWarning.text = Messages.PERMEMNENT_ADDRESS_EMPTY_ERROR.localized
//            self.permenentAddressMesgLocale = Messages.PERMEMNENT_ADDRESS_EMPTY_ERROR
//            isError = true
//
//        } else
        
        
         if self.tfPermenentBldNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                    perBldNoHeight.constant = 16
                    self.tfPermenentBldNo.text = Constants.BLANK
                    self.perWarningBldNo.text = Messages.BUILD_NO_ERROR.localized
                   isError = true
                }else{
                   perBldNoHeight.constant = 0
                self.perWarningBldNo.text = Constants.BLANK
                }
        if self.tfPermenentFloor.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            perFloorHeight.constant = 16
            self.tfPermenentFloor.text = Constants.BLANK
            self.perWarningFloorNo.text = Messages.FLOOR_NO_ERROR.localized
           isError = true
        }else{
           perFloorHeight.constant = 0
        self.perWarningFloorNo.text = Constants.BLANK
        }
        if self.tfPermenentRoomNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            perRoomHeight.constant = 16
            self.tfPermenentRoomNo.text = Constants.BLANK
            self.perWarningRoomNo.text = Messages.ROOM_NO_ERROR.localized
           isError = true
        }else{
           perRoomHeight.constant = 0
        self.perWarningRoomNo.text = Constants.BLANK
        }
        if self.tfPermenentQrt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                   perQuarterHeight.constant = 16
                   self.tfPermenentQrt.text = Constants.BLANK
                   self.perWarningQuarter.text = Messages.QUARTER_ERROR.localized
                  isError = true
               }else{
                  perQuarterHeight.constant = 0
               self.perWarningQuarter.text = Constants.BLANK
               }
        if self.tfPermenentStreet.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            perStreetHeight.constant = 16
            self.tfPermenentStreet.text = Constants.BLANK
            self.perWarningStreet.text = Messages.STREET_ERROR.localized
           isError = true
        }else{
           perStreetHeight.constant = 0
        self.perWarningStreet.text = Constants.BLANK
        }
        
//        if !(self.tfPermenentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false) {
//            if !self.allPerTownNameList.contains((self.tfPermenentTsp?.text)!) {
//                self.tfPermenentTsp?.text = Constants.BLANK
//                self.perWarningStreet.text = Messages.ADDRESS_INVALID_ERROR.localized
//                self.permenentAddressMesgLocale = Messages.ADDRESS_INVALID_ERROR
//                isError = true
//
//            } else {
//                self.permenentAddressMesgLocale = Constants.BLANK
//                self.perWarningStreet.text = Constants.BLANK
//            }
//        } else {
//            self.permenentAddressMesgLocale = Constants.BLANK
//            self.perWarningStreet.text = Constants.BLANK
//        }
        
        
        
//        if self.tfPermenentTsp?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            self.tfPermenentTsp?.text = Constants.BLANK
//            self.lblPermenentAddressWarning.text = Messages.PERMEMNENT_ADDRESS_EMPTY_ERROR.localized
//            self.permenentAddressMesgLocale = Messages.PERMEMNENT_ADDRESS_EMPTY_ERROR
//            isError = true
//            
//        } else {
//            self.permenentAddressMesgLocale = Constants.BLANK
//            self.lblPermenentAddressWarning.text = Constants.BLANK
//        }
        
        if !(self.tfResidentPhNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false){
            
            if !Utils.isNumberValidate(phoneNo: (self.tfResidentPhNo?.text)!){
                // validate phone no format
                self.tfResidentPhNoWarning.text = Messages.PHONE_REG_LENGTH_ERROR.localized
                self.residentPhoneMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
                isError = true
            } else {
                self.residentPhoneMesgLocale = Constants.BLANK
                self.tfResidentPhNoWarning.text = Constants.BLANK
            }
            
        } else {
          
        }
        if self.tfResidentPhNo.text == Constants.BLANK {
             self.tfResidentPhNoWarning.text = Messages.PHONE_REG_EMPTY_ERROR.localized
        }

        
        //        //Other Phone No.
        if !(self.tfOtherPhNo?.text?.isEmpty ?? false){
            
            if !Utils.isNumberValidate(phoneNo: (self.tfOtherPhNo?.text)!){
                // validate phone no format
                self.lblOtherPhNoWarning.text = Messages.PHONE_REG_LENGTH_ERROR.localized
                self.otherPhoneMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
                isError = true
                
            } else {
                self.otherPhoneMesgLocale = Constants.BLANK
                self.lblOtherPhNoWarning.text = Constants.BLANK
            }
        }else {
            self.otherPhoneMesgLocale = Constants.BLANK
            self.lblOtherPhNoWarning.text = Constants.BLANK
        }
        
        if self.tfOtherPhNo.text == Constants.BLANK {
                    self.lblOtherPhNoWarning.text = Messages.PHONE_REG_EMPTY_ERROR.localized
               }
        
        // Validate Email
        if !(self.tfEmail?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false){
//            self.tfEmail?.text = Constants.BLANK
//            self.lblEmailWarning.text = Messages.EMAIL_EMPTY_ERROR.localized
//            self.emailMesgLocale = Messages.EMAIL_EMPTY_ERROR
//            isError = true
//
//        } else
            if !Utils.isValidEmail(emailStr: (self.tfEmail?.text)!){
                self.lblEmailWarning.text = Messages.EMAIL_INVALID.localized
                self.emailMesgLocale = Messages.EMAIL_INVALID
                isError = true
                
            }else {
                self.lblEmailWarning.text = Constants.BLANK
                self.emailMesgLocale = Constants.BLANK
            }
            
        } else {
            self.lblEmailWarning.text = Constants.BLANK
            self.emailMesgLocale = Constants.BLANK
        }
        if self.tfEmail.text == Constants.BLANK {
            self.lblEmailWarning.text = Messages.EMAIL_EMPTY_ERROR.localized
        }
        
        if !self.isMyanmarNationality {
            if self.tfNationality?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
                self.tfNationality?.text = Constants.BLANK
                self.lblNationalityWarning.text = Messages.NATIONALITY_EMPTY_ERROR.localized
                self.nationalityMesgLocale = Messages.NATIONALITY_EMPTY_ERROR
                isError = true
                
            } else {
                self.lblNationalityWarning.text = Constants.BLANK
                self.nationalityMesgLocale = Constants.BLANK
            }
        }
        
        if self.btnTypeResidence.titleLabel?.text == "Other" {
            if self.tfTypeResidence?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
                self.tfTypeResidence?.text = Constants.BLANK
                self.lblTypeResidenceWarning.text = Messages.TYPE_RESIDENCE_EMPTY_ERROR.localized
                self.typeResidenceMesgLocale = Messages.TYPE_RESIDENCE_EMPTY_ERROR
                isError = true
                
            } else {
                self.lblTypeResidenceWarning.text = Constants.BLANK
                self.typeResidenceMesgLocale = Constants.BLANK
            }
        }
        
        //YEAR of Stay
        if self.tfYears?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfYears?.text = Constants.BLANK
            self.lblYearStayWarning.text = Messages.YEAR_STAY_EMPTY_ERROR.localized
            self.yearStayMesgLocale = Messages.YEAR_STAY_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblYearStayWarning.text = Constants.BLANK
            self.yearStayMesgLocale = Constants.BLANK
        }
        
        if self.tfMonths?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfMonths?.text = Constants.BLANK
            self.lblYearStayWarning.text = Messages.YEAR_STAY_EMPTY_ERROR.localized
            self.yearStayMesgLocale = Messages.YEAR_STAY_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblYearStayWarning.text = Constants.BLANK
            self.yearStayMesgLocale = Constants.BLANK
        }
        
        return isError
    } //End of isErrorExit
    
    func markErrorCount() {
        
        var errorCount = 0
    
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            
            errorCount += 1
            
        }
//        else if !Utils.isNameValidate(name: (self.tfName!.text)!){
//
//           errorCount += 1
//
//        }
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfFatherName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
           
            errorCount += 1
            
        }
//        else if !Utils.isNameValidate(name: (self.tfFatherName!.text)!){
//        
//           errorCount += 1
//            
//        }
        
        if self.tfCurrentBldNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorCount += 1
        
        }else{
          
        }
        if self.tfCurrentRoomNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorCount += 1
            
        }
        if self.tfCurrentFloor.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorCount += 1
            
        }
        
        if self.tfCurrentQrt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorCount += 1
            
        }
        // Current address
        if self.tfCurrentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorCount += 1
            
        } else if self.tfCurrentTsp.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorCount += 1
            
        } else if !self.allCurrTownNameList.contains((self.tfCurrentTsp?.text)!) {
            errorCount += 1
            
        }
        
        // Permenent address
        if !(self.tfPermenentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false) {
            if !self.allPerTownNameList.contains((self.tfPermenentTsp?.text)!) {
                errorCount += 1
            }
        }
        if self.tfPermenentBldNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                   errorCount += 1
                   
               }
        if self.tfPermenentRoomNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                          errorCount += 1
                          
                      }
        if self.tfPermenentFloor.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                          errorCount += 1
                          
                      }
        if self.tfPermenentStreet.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                          errorCount += 1
                          
                      }
        if self.tfPermenentQrt.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                          errorCount += 1
                          
                      }
        // Validate Date of Birth [dd-MM-yyyy]
        if self.tfDob?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            
           errorCount += 1
            
        } else if !Utils.isDobValidateDA(dob: (self.tfDob?.text)!){
            
           errorCount += 1
            
        }
        
//        // Validate NRC Township
//        if self.tfTownshipAutoText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
//
//            errorCount += 1
//
//        } else if !self.selectedTownshipList.contains(self.tfTownshipAutoText.text!){
//
//            errorCount += 1
//
//        }
        
//        // Validate Nrc No.
//        if self.tfNrcNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
//
//            errorCount += 1
//
//        } else if !Utils.isNrcNoValidate(nrcNo: (self.tfNrcNo?.text)!){
//
//            errorCount += 1
//
//        }
        
//        //Validate Phone No. [09[0-9]{7,9}]
//        if self.tfPhNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
//
//            errorCount += 1
//
//        } else if !Utils.isPhoneValidate(phoneNo: (self.tfPhNo?.text)!){
//
//            errorCount += 1
//
//        }
    
        
        //Validate Resident Phone No. [09[0-9]{7,9}]
        if !(self.tfResidentPhNo?.text?.isEmpty ?? false) {

            if !Utils.isNumberValidate(phoneNo: (self.tfResidentPhNo?.text)!){
                // validate phone no format
                errorCount += 1

            }
        }
        if self.tfResidentPhNo.text == "" {
             errorCount += 1
        }
//        if self.tfResidentPhNo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//                                 errorCount += 1
//
//                             }
        //        //Other Phone No.
        if !(self.tfOtherPhNo?.text?.isEmpty ?? false) {
            
            if !Utils.isNumberValidate(phoneNo: (self.tfOtherPhNo?.text)!){
                // validate phone no format
                errorCount += 1
            }
        }
        if self.tfOtherPhNo.text == Constants.BLANK {
             errorCount += 1
        }
        // Validate Email
        if !(self.tfEmail?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false){
            if !Utils.isValidEmail(emailStr: (self.tfEmail?.text)!){
                errorCount += 1
            }
        }
        if self.tfEmail.text == Constants.BLANK {
             errorCount += 1
        }
        
        if !self.isMyanmarNationality {
            if self.tfNationality?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
               errorCount += 1
                
            }
        }
        
        if self.btnTypeResidence.titleLabel?.text == "Other" {
            if self.tfTypeResidence?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
                errorCount += 1
                
            }
        }
        
        //YEAR of Stay
        if self.tfYears?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
           errorCount += 1
            
        }
        
        if self.tfMonths?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorCount += 1
            
        }
        
        UserDefaults.standard.set(errorCount, forKey: Constants.APP_DATA_ERROR_COUNT)
    } //End of markErrorCount
    
    @IBAction func doSaveData(_ sender: Any) {
         CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        self.markAppDataLastState()
       let appError = UserDefaults.standard.integer(forKey: Constants.APP_DATA_ERROR_COUNT)
        var errorString = ""
//        if appError == 0 {
//            self.BldNoHeight.constant = 0
//        }
        
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
        
//         NSNotification.Name(rawValue: "saveDA")
//        if isErrorExist() {
//            print("Please fill all the mendantory fields!!!!")
//            return
//        }
        
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
   
    
    @IBAction func tappedOnNext(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnNext"), object: nil , userInfo: ["index" : 1])
    }
    
    
    
}

extension ApplicationDataVC: TownshipSelectDelegate {
    func onClickTownshipCode(townshipCode: String) {
        //self.lblTownship.text = townshipCode
    }
}

extension ApplicationDataVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tfCurrentTsp.hideResultsList()
        self.tfPermenentTsp.hideResultsList()
    }
}

extension ApplicationDataVC: applyLoanDelegate {
    func showApplicationForm() {
        self.fillThisForm(data: myAppFormData)
    }
}

extension ApplicationDataVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 100
    }
}

extension ApplicationDataVC:  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.numberPicker?.reloadAllComponents()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if tfYears.isFirstResponder {
            return yearList.count
        } else if tfMonths.isFirstResponder {
            return monthList.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if tfYears.isFirstResponder {
            return "\(yearList[row])"
        } else if tfMonths.isFirstResponder {
            return "\(monthList[row])"
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if tfYears.isFirstResponder {
            tfYears.text = "\(yearList[row])"
            
        } else if tfMonths.isFirstResponder {
            tfMonths.text = "\(monthList[row])"
            
        }
        
        self.view.endEditing(true)
    }
    
}

extension ApplicationDataVC: CheckPasswordPopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController) {
         if password.text!.count > 0 {
            self.doPasswordVerification(strPassword: "\(password.text ?? "")", popup: popUpView)
        }
    }
}
