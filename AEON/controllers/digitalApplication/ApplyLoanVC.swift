//
//  ApplyLoanVC.swift
//  AEONVCS
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar
import SwipeMenuViewController
import SwiftyJSON
import AVFoundation

protocol applyLoanDelegate {
//    func didSelectfoto(image: UIImage)
    func showApplicationForm()
}

//var myAppFormData = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 0, nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)

var myAppFormData = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 1, nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)

var applicationFormID = 0
var occupationFormID = 0
var emergencyFormID = 0
var guarantorFormID = 0
var applicationStatus = 0

class ApplyLoanVC: BaseUIViewController {
    
    var delegate: applyLoanDelegate?
    var logoutTimer: Timer?
    @IBOutlet weak var viewBgTop: UIView!  {
        didSet {
            
            self.viewBgTop.layer.masksToBounds = false
            self.viewBgTop.layer.shadowRadius = 4
            self.viewBgTop.layer.shadowOpacity = 0.9
            self.viewBgTop.layer.shadowColor = UIColor.gray.cgColor
            self.viewBgTop.layer.shadowOffset = CGSize(width: 0 , height:2)
        }
    }
    
    @IBOutlet weak var vSeperator: UIView!
    
    @IBOutlet weak var viewBgProgressBar: UIView!
    @IBOutlet weak var viewSwipeMenu: SwipeMenuView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    @IBOutlet weak var lblForm1: UILabel!
    @IBOutlet weak var lblForm2: UILabel!
    @IBOutlet weak var lblForm3: UILabel!
    @IBOutlet weak var lblForm5: UILabel!
    @IBOutlet weak var lblForm4: UILabel!
    
    var myAppData = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 1 , nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)
    
    var myLoanData = LoanConfirmationRequest(daLoanTypeId: 1, financeAmount: 0.0, financeTerm: 0, daProductTypeId: 1, productDescription: "", channelType: 2)
    
    var myGuarantorData = GuarantorRequest(daGuarantorInfoId: 0,name: "", dob: "", nrcNo: "", nationality: 1, nationalityOther: "", mobileNo: "", residentTelNo: "", relationship: 1, relationshipOther: "", currentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", gender: 1, maritalStatus: 1, yearOfStayYear: 0, yearOfStayMonth: 0, companyName: "", companyTelNo: "", companyAddress: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, monthlyBasicIncome: 0.0, totalIncome: 0.0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
    
    var myOccupationData = OccupationDataRequest(daApplicantCompanyInfoId: 0, companyName: "", companyAddress: "", companyTelNo: "", contactTimeFrom: "", contactTimeTo: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, companyStatus: 1, companyStatusOther: "", monthlyBasicIncome: 0.0, otherIncome: 0.0, totalIncome: 0.0, salaryDay: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
    
    var myContactData = EmergencyContactRequest(daEmergencyContactInfoId: 0, name: "", relationship: 1, relationshipOther: "", currentAddress: "", mobileNo: "", residentTelNo: "", otherPhoneNo: "", currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0)
    var myAttachments = [AttachmentRequest]()
    
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!
    var backgroundColor = UIColor(red: 218.0 / 255.0, green: 218.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0)
    var progressColor = UIColor(red: 255.0 / 255.0, green: 150.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    var textColorHere = UIColor(red: 255.0 / 255.0, green: 150.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    var minIndex = -1
    
    var vControllers = [UIViewController]()
    
    var tokenInfo: TokenData?
    
    let myPickerController = UIImagePickerController()
    
    var isAttachmentEdit = false
    @IBOutlet weak var heightTopMostView: NSLayoutConstraint!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var backBtnLabel: UIImageView!
    @IBOutlet weak var phoneLabelBtn: UILabel!
    @IBOutlet weak var nameLabelBtn: UILabel!
    @IBOutlet weak var myanmarLabelBtn: UIImageView!
    @IBOutlet weak var engLabelBtn: UIImageView!
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
    @objc func onTapBack() {
        print("click")
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.phoneLabelBtn.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
                                       self.nameLabelBtn.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
                             self.typeLabel.text = "Lv.2 : Login user"
        self.myanmarLabelBtn.isUserInteractionEnabled = true
        self.engLabelBtn.isUserInteractionEnabled = true
         self.backBtnLabel.isUserInteractionEnabled = true
        self.myanmarLabelBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.engLabelBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
         self.backBtnLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        // Do any additional setup after loading the view.
        self.setupProgressBarWithoutLastState()
       
        self.setupSwipeMenuViewControllers()
        self.setupSwipeMenuView()
        
        self.title = "aeonservice.da.form.title".localized
        
        self.updateViews()
        
        self.changeTextIndicator(selectedIndex: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(choosePhotoVia(notification:)), name: NSNotification.Name(rawValue: "ChooseFoto"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(doSetAppData(notification:)), name: NSNotification.Name(rawValue: "SetAppData"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(doSetOccupationData(notification:)), name: NSNotification.Name(rawValue: "SetOccupationData"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(doSetEmergencyContactData(notification:)), name: NSNotification.Name(rawValue: "SetEmergencyContactData"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(doSetGuarantorData(notification:)), name: NSNotification.Name(rawValue: "SetGuarantorData"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(doSetLoanConfirmationData(notification:)), name: NSNotification.Name(rawValue: "SetLoanConfirmationData"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(doRegisterDA), name: NSNotification.Name(rawValue: "doRegistration"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(doSaveDA), name: NSNotification.Name(rawValue: "saveDA"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tapOnNextAppData), name: NSNotification.Name(rawValue: "tapOnNext"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showPreview), name: NSNotification.Name(rawValue: "showPreview"), object: nil)
        
        self.doLoadSaveDAData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//
//    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if isAttachmentEdit {
            self.heightTopMostView.constant = 91
        } else {
            self.heightTopMostView.constant = 0
        }
    }
    @objc func runTimedCode() {
                   multiLoginGet()
               // print("kms\(logoutTimer)")
               }
       func multiLoginGet(){
                  let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
              MultiLoginModel.init().makeMultiLogin(customerId: customerId
                      , loginDeviceId: deviceID, success: { (results) in
                    //  print("kaungmyat san multi >>>  \(results)")
                      
                      if results.data.logoutFlag == true {
                          print("success stage logout")
                          // create the alert
                                 let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)

                                 // add an action (button)
                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                              self.logoutTimer?.invalidate()
//                              let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "mainvc") as! MainNewViewController
//                              navigationVC.modalPresentationStyle = .overFullScreen
//                              self.present(navigationVC, animated: true, completion:nil)
                            self.performSegue(withIdentifier: "mainsegue", sender: nil)
                          }))

                                 // show the alert
                                 self.present(alert, animated: true, completion: nil)
                          
                          
                      }
                  }) { (error) in
                      print(error)
                  }
              }
    
    @objc func showPreview(notitfication: Notification) {
        //prepare data
        
        if let attachmentdict = notitfication.userInfo as? Dictionary<String, Any> {
            
            print("doshowPreview")
            var tempAttachment = [PurchaseAttachmentResponse]()
            if let attachmentarray = attachmentdict["attachment"] as? [AttachmentRequest] {
                
                for attachment in attachmentarray {
                    var purchaseAttachment = PurchaseAttachmentResponse()
                    purchaseAttachment.fileType = attachment.fileType
                    purchaseAttachment.filePath = attachment.photoByte
                    tempAttachment.append(purchaseAttachment)
                }
            }
            
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPreview"), object: self, userInfo: ["attachment": tempArray, "processingfee": Double(self.tfProcessingfee.text ?? "0.0") ?? 0.0, "comSaving": Double(self.tfCompulsory.text ?? "0.0") ?? 0.0, "totalrepay": Double(self.tfTotalRepayment.text ?? "0.0") ?? 0.0, "firstrepay": Double(self.tfFirstRepayment.text ?? "0.0") ?? 0.0, "monthltyrepay": Double(self.tfMonthlyRepayment.text ?? "0.0") ?? 0.0])
            
            let processingfee = attachmentdict["processingfee"] as? Double
            let totalcomp = attachmentdict["comSaving"] as? Double
            let totalrepay = attachmentdict["totalrepay"] as? Double
            let firstpayment = attachmentdict["firstrepay"] as? Double//
            let monthly = attachmentdict["monthltyrepay"] as? Double
            let lastpay = attachmentdict["lastpay"] as? Double
            
            var applicationdetailresponse = ApplicationDetailResponse(daApplicationInfoId: 0, applicationNo: "", appliedDate: "", daApplicationTypeId: 0, status: 0, settlementPendingComment: "", daInterestInfoId: 0, daCompulsoryInfoId: 0, name: self.myAppData.name, dob: self.myAppData.dob, nrcNo: self.myAppData.nrcNo, fatherName: self.myAppData.fatherName,highestEducationTypeId: self.myAppData.highestEducationTypeId, nationality: self.myAppData.nationality, nationalityOther: self.myAppData.nationalityOther, gender: self.myAppData.gender, maritalStatus: self.myAppData.maritalStatus, currentAddress: self.myAppData.currentAddress, permanentAddress: self.myAppData.permanentAddress, typeOfResidence: self.myAppData.typeOfResidence, typeOfResidenceOther: self.myAppData.typeOfResidenceOther, livingWith: self.myAppData.livingWith, livingWithOther: self.myAppData.livingWithOther, yearOfStayYear: self.myAppData.yearOfStayYear, yearOfStayMonth: self.myAppData.yearOfStayMonth, mobileNo: self.myAppData.mobileNo, residentTelNo: self.myAppData.residentTelNo, otherPhoneNo: self.myAppData.otherPhoneNo, email: self.myAppData.email, customerId: self.myAppData.customerId, daLoanTypeId: self.myLoanData.daLoanTypeId, financeAmount: self.myLoanData.financeAmount, financeTerm: self.myLoanData.financeTerm, daProductTypeId: self.myLoanData.daProductTypeId, productDescription: self.myLoanData.productDescription, channelType: self.myLoanData.channelType, applicantCompanyInfoDto: myOccupationData, emergencyContactInfoDto: self.myContactData, guarantorInfoDto: self.myGuarantorData, applicationInfoAttachmentDtoList: tempAttachment, processingFees: processingfee, totalConSaving: totalcomp, totalRepayment: totalrepay, firstPayment: firstpayment, monthlyInstallment: monthly, lastPayment: lastpay)
            
            applicationdetailresponse.currentAddressBuildingNo = self.myAppData.currentAddressBuildingNo
            applicationdetailresponse.currentAddressRoomNo = self.myAppData.currentAddressRoomNo
            applicationdetailresponse.currentAddressFloor = self.myAppData.currentAddressFloor
            applicationdetailresponse.currentAddressStreet = self.myAppData.currentAddressStreet
            applicationdetailresponse.currentAddressQtr = self.myAppData.currentAddressQtr
            applicationdetailresponse.currentAddressTownship = self.myAppData.currentAddressTownship
            applicationdetailresponse.currentAddressCity = self.myAppData.currentAddressCity
            
            applicationdetailresponse.permanentAddressBuildingNo = self.myAppData.permanentAddressBuildingNo
            applicationdetailresponse.permanentAddressRoomNo = self.myAppData.permanentAddressRoomNo
            applicationdetailresponse.permanentAddressFloor = self.myAppData.permanentAddressFloor
            applicationdetailresponse.permanentAddressStreet = self.myAppData.permanentAddressStreet
            applicationdetailresponse.permanentAddressQtr = self.myAppData.permanentAddressQtr
            applicationdetailresponse.permanentAddressTownship = self.myAppData.permanentAddressTownship
            applicationdetailresponse.permanentAddressCity = self.myAppData.permanentAddressCity
            
            let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DETAIL_VC) as! ApplicationDetailVC
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            
             
            popupVC.inquiryAppID =  0
            popupVC.appinfoobj = applicationdetailresponse
            popupVC.isPreviewing = true
            
            let pVC = popupVC.popoverPresentationController
            pVC?.permittedArrowDirections = .any
            
            
            
            self.definesPresentationContext = true
            //popupVC.delegate = self
            self.present(popupVC, animated: true, completion: nil)
            
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
                    self.changeTextIndicator(selectedIndex: 0)
                    self.progressBarWithoutLastState.currentIndex = 0
                    self.viewSwipeMenu.jump(to: 0, animated: true)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                } else if occupationError > 0 {
                    //go to application data
                    self.changeTextIndicator(selectedIndex: 1)
                    self.progressBarWithoutLastState.currentIndex = 1
                    self.viewSwipeMenu.jump(to: 1, animated: true)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                } else if contactError > 0 {
                    //go to application data
                    self.changeTextIndicator(selectedIndex: 2)
                    self.progressBarWithoutLastState.currentIndex = 2
                    self.viewSwipeMenu.jump(to: 2, animated: true)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
                } else if guarantorError > 0 {
                    //go to application data
                    self.changeTextIndicator(selectedIndex: 3)
                    self.progressBarWithoutLastState.currentIndex = 3
                    self.viewSwipeMenu.jump(to: 3, animated: true)
                    
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
    
    @objc func doSetLoanConfirmationData(notification: Notification) {
        print("doSetLoanConfirmationData")
        if let dict = notification.userInfo as? Dictionary<String, Any> {
//            print("doSetLoanConfirmationData \(dict)")
            if let sVar = dict["appData"] as? LoanConfirmationRequest {
                print("doSetLoanConfirmationData \(sVar.financeAmount)")
                self.myLoanData = sVar
                print("doSetLoanConfirmationData myappdata.name \(self.myLoanData.financeAmount)")
            } //attachment
            
            if let sVar = dict["attachment"] as? [AttachmentRequest] {
                print("doSetLoanConfirmationData attachment present")
                self.myAttachments = sVar
                print("doSetLoanConfirmationData attachment present")
            }
        }
    }
    
    @objc func tapOnNextAppData(notification: Notification) {
        print("tapOnNextAppData")
        if let indexdict = notification.userInfo as? Dictionary<String, Any> {
            
            if let sVar = indexdict["index"] as? Int {
                self.viewSwipeMenu.jump(to: sVar, animated: true)
            }
        }
    }
    
    override func updateViews() {
        super.updateViews()
//        switch Locale.currentLocale {
//        case .EN:
//        //    bbLocaleFlag.image = UIImage(named: "mm_flag")
//        case .MY:
//
//          //  bbLocaleFlag.image = UIImage(named: "en_flag")
//        }
     //  self.title = "aeonservice.da.form.title".localized
       
    }
    
    @objc func choosePhotoVia(notification: Notification) {
        print("choose photo noti")
        if let dict = notification.userInfo as? Dictionary<String, Bool> {
            print("choose photo noti \(dict)")
            if let boolvar = dict["isCamera"] as? Bool {
                if boolvar {
                    self.camera()
                } else {
                    self.photoLibrary()
                }
            }
        }
    }
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            self.myPickerController.delegate = self;
             self.myPickerController.sourceType = .camera
            self.present( self.myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
             self.myPickerController.delegate = self;
             self.myPickerController.sourceType = .photoLibrary
            self.present( self.myPickerController, animated: true, completion: nil)
        }
    }

    
    func setupSwipeMenuViewControllers() {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applicationdataVC = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DATA_VC) as! ApplicationDataVC
        let occupationdataVC = storyboard.instantiateViewController(withIdentifier: CommonNames.OCCUPATION_DATA_VC)
        let emergencycontactVC = storyboard.instantiateViewController(withIdentifier: CommonNames.EMERGENCY_CONTACT_VC)
        let guarantorVC = storyboard.instantiateViewController(withIdentifier: CommonNames.GUARANTOR_VC)
        let lConfirmationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.LOAN_CONFIRMATION_VC) as! LoanConfirmationVC
//        self.delegate = lConfirmationVC as applyLoanDelegate
        self.delegate = applicationdataVC as applyLoanDelegate
        self.vControllers.append(applicationdataVC)
        self.vControllers.append(occupationdataVC)
        self.vControllers.append(emergencycontactVC)
        self.vControllers.append(guarantorVC)
        self.vControllers.append(lConfirmationVC)
    }
    
    func setupSwipeMenuView() {
        viewSwipeMenu.dataSource = self
        viewSwipeMenu.delegate = self
        
        var options: SwipeMenuViewOptions = .init()
        options.tabView.additionView.underline.height = 0
        viewSwipeMenu.reloadData(options: options)
    }
    
    func setupProgressBarWithoutLastState() {
        progressBarWithoutLastState = FlexibleSteppedProgressBar()
        progressBarWithoutLastState.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressBarWithoutLastState)
        
        var minusWidth = CGFloat(40.0)
        if UIDevice().screenType == .iPhone6Plus || UIDevice().screenType == .iPhoneXR {
            minusWidth = CGFloat(0.0)
        }
        
        // iOS9+ auto layout code
        let horizontalConstraint = progressBarWithoutLastState.centerXAnchor.constraint(equalTo: self.viewBgProgressBar.centerXAnchor)
        let verticalConstraint = progressBarWithoutLastState.topAnchor.constraint(
            equalTo: self.viewBgProgressBar.topAnchor,
            constant: 10
        )
        let widthConstraint = progressBarWithoutLastState.widthAnchor.constraint(equalToConstant: self.viewBgProgressBar.frame.size.width - minusWidth)
        let heightConstraint = progressBarWithoutLastState.heightAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        // Customise the progress bar here
        progressBarWithoutLastState.numberOfPoints = 5
        progressBarWithoutLastState.lineHeight = 3
        progressBarWithoutLastState.radius = 20
        progressBarWithoutLastState.progressRadius = 25
        progressBarWithoutLastState.progressLineHeight = 3
        progressBarWithoutLastState.delegate = self
        progressBarWithoutLastState.selectedBackgoundColor = progressColor
        progressBarWithoutLastState.selectedOuterCircleStrokeColor = backgroundColor
        progressBarWithoutLastState.currentSelectedCenterColor = progressColor
        progressBarWithoutLastState.stepTextColor = textColorHere
        progressBarWithoutLastState.currentSelectedTextColor = progressColor
        
        progressBarWithoutLastState.currentIndex = 0
//        progressBarWithoutLastState.textDistance = 10
        progressBarWithoutLastState.stepTextFont = UIFont.systemFont(ofSize: 9.0)
        
        
    }

    @IBAction func doGoBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doChangeLanguage(_ sender: Any) {
        self.localeChanged()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeLocaleForApplicationData"), object: nil)
    }
    
    
    func changeTextIndicator(selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            self.lblForm1.textColor = progressColor
            self.lblForm2.textColor = textColorHere
            self.lblForm3.textColor = textColorHere
            self.lblForm4.textColor = textColorHere
            self.lblForm5.textColor = textColorHere
        case 1:
            self.lblForm1.textColor = textColorHere
            self.lblForm2.textColor = progressColor
            self.lblForm3.textColor = textColorHere
            self.lblForm4.textColor = textColorHere
            self.lblForm5.textColor = textColorHere
            
        case 2:
            self.lblForm1.textColor = textColorHere
            self.lblForm2.textColor = textColorHere
            self.lblForm3.textColor = progressColor
            self.lblForm4.textColor = textColorHere
            self.lblForm5.textColor = textColorHere
            
        case 3:
            self.lblForm1.textColor = textColorHere
            self.lblForm2.textColor = textColorHere
            self.lblForm3.textColor = textColorHere
            self.lblForm4.textColor = progressColor
            self.lblForm5.textColor = textColorHere
            
        case 4:
            self.lblForm1.textColor = textColorHere
            self.lblForm2.textColor = textColorHere
            self.lblForm3.textColor = textColorHere
            self.lblForm4.textColor = textColorHere
            self.lblForm5.textColor = progressColor
            
        default:
            self.lblForm1.textColor = UIColor.red
            self.lblForm2.textColor = UIColor.darkGray
            self.lblForm3.textColor = UIColor.darkGray
            self.lblForm4.textColor = UIColor.darkGray
            self.lblForm5.textColor = UIColor.darkGray
        }
    }
    
    func callNotification(image: UIImage) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectFoto"), object: self, userInfo: ["img": image])
//        self.delegate?.didSelectfoto(image: image)
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

extension ApplyLoanVC: FlexibleSteppedProgressBarDelegate {
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     didSelectItemAtIndex index: Int) {
        progressBar.currentIndex = index
        if index > minIndex {
            minIndex = index
            progressBar.completedTillIndex = minIndex
            
        }
        self.viewSwipeMenu.jump(to: index, animated: true)
    }
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     canSelectItemAtIndex index: Int) -> Bool {
        return true
    }
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        
//            if position == FlexibleSteppedProgressBarTextLocation.bottom {
//                switch index {
//
//                case 0: return "Application Data"
//                case 1: return "Occupation Data"
//                case 2: return "Emergency Contact"
//                case 3: return "Guarantor"
//                case 4: return "Loan Confirmation"
//                default: return ""
//
//                }
//
//            }
//            else
//                if position == FlexibleSteppedProgressBarTextLocation.center {
//                switch index {
//
//                case 0: return "1"
//                case 1: return "2"
//                case 2: return "3"
//                case 3: return "4"
//                case 4: return "5"
//                default: return "0"
//
//                }
//            }
        
        return ""
    }
}

extension ApplyLoanVC: SwipeMenuViewDelegate {
    
    // MARK - SwipeMenuViewDelegate
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
        if fromIndex == 0 {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markAppDataLastState"), object: nil)
        } else if fromIndex == 1 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markOccupationDataLastState"), object: nil)
        } else if fromIndex == 2 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markEmergencyContactDataLastState"), object: nil)
        } else if fromIndex == 3 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markGuarantorDataLastState"), object: nil)
        } else if fromIndex == 4 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markLoanConfirmationLastState"), object: nil)
        } else {
            if let app = UserDefaults.standard.object(forKey: "appData") as? ApplicationDataRequest {
                print("app : \(app.customerId)")
            }
            
        }
        
        if toIndex == 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAppForm"), object: self, userInfo: ["data": self.myAppData as Any])
        } else if toIndex == 2 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showEmergencyForm"), object: self, userInfo: ["data": self.myContactData as Any])
        } else if toIndex == 1 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showOccupationForm"), object: self, userInfo: ["data": self.myOccupationData as Any])
        } else if toIndex == 3 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showGuarantorForm"), object: self, userInfo: ["data": self.myGuarantorData as Any])
        } else if toIndex == 4 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showLoanForm"), object: self, userInfo: ["data": self.myLoanData as Any])
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
        self.changeTextIndicator(selectedIndex: toIndex)
        self.progressBarWithoutLastState.currentIndex = toIndex
        
       
    }
}

extension ApplyLoanVC: SwipeMenuViewDataSource {
    
    //MARK - SwipeMenuViewDataSource
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return self.vControllers.count
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return ""
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        
        return self.vControllers[index]
    }
}

extension ApplyLoanVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            guard let originImage = info[.originalImage] as? UIImage else {
                self.callNotification(image: UIImage())
                return
            }
            self.callNotification(image: originImage)
            return
        }
         self.callNotification(image: image)
        return
    }
}

extension ApplyLoanVC: CheckPasswordPopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController) {
         if password.text!.count > 0 {
            self.doPasswordVerification(strPassword: "\(password.text ?? "")", popup: popUpView)
        }
    }
}
