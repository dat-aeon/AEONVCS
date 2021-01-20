//
//  CustomerInfoFormViewController.swift
//  AEONVCS
//
//  Created by Ant on 06/08/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//
import UIKit
import FlexibleSteppedProgressBar
import SwipeMenuViewController
import SwiftyJSON
import AVFoundation
import NotificationCenter
import AAViewAnimator
protocol applyLoanDelegate {
//    func didSelectfoto(image: UIImage)
    func showApplicationForm()
}

var myAppFormData = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 1, nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)
var myOccupationFormData = OccupationDataRequest(daApplicantCompanyInfoId: 0, companyName: "", companyAddress: "", companyTelNo: "", contactTimeFrom: "", contactTimeTo: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, companyStatus: 1, companyStatusOther: "", monthlyBasicIncome: 0.0, otherIncome: 0.0, totalIncome: 0.0, salaryDay: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
 var myContactFormData = EmergencyContactRequest(daEmergencyContactInfoId: 0, name: "", relationship: 1, relationshipOther: "", currentAddress: "", mobileNo: "", residentTelNo: "", otherPhoneNo: "", currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0)

var applicationFormID = 0
var occupationFormID = 0
var emergencyFormID = 0
var guarantorFormID = 0
var applicationStatus = 0

class CustomerInfoFormViewController: BaseUIViewController {

    var delegate: applyLoanDelegate?
       var logoutTimer: Timer?
     var sessionInfo:SessionDataBean?
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var nrcNoLbl: UILabel!
    
//    @IBOutlet weak var mmflag: UIImageView!
//    @IBOutlet weak var engflag: UIImageView!
    @IBOutlet weak var myscrollView: UIScrollView!
   // @IBOutlet weak var backView: UIImageView!
   // @IBOutlet weak var applicationDataLabel: UILabel!
    @IBOutlet weak var occupationDataLabel: UILabel!
    @IBOutlet weak var emergencyContactLabel: UILabel!
//    @IBOutlet weak var lblBarPhNo: UILabel!
//    @IBOutlet weak var lblBarName: UILabel!
    
  //  @IBOutlet weak var loanConfirmationLabel: UILabel!
 //   @IBOutlet weak var saveLabel: UIButton!
   // @IBOutlet weak var applicationChangeLabel: UIButton!
   // @IBOutlet weak var occupationChangeLabel: UIButton!
   // @IBOutlet weak var emergencyContactChangeLabel: UIButton!
    @IBOutlet weak var guarantorChangeLabel: UIButton!
    @IBOutlet weak var loanConfirmationChangeLabel: UIButton!
    @IBOutlet weak var occupationPressView: CardView!
 
    @IBOutlet weak var applicationTitleView: UIView!
    @IBOutlet weak var emergencyPressView: CardView!
   // @IBOutlet weak var guarantorPressView: CardView!
    @IBOutlet weak var applicationLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var emergencyLabel: UILabel!
   // @IBOutlet weak var guarantorLabel: UILabel!
  //  @IBOutlet weak var saveView: CardView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateofBirthLabel: UILabel!
    @IBOutlet weak var nrcNoLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var buildingNoLabel: UILabel!
    @IBOutlet weak var roomNoLabel: UILabel!
    @IBOutlet weak var ocCompanyName: UILabel!
    @IBOutlet weak var ocBuildingNo: UILabel!
    @IBOutlet weak var ocRoomNo: UILabel!
    @IBOutlet weak var ocDetailLabel: UILabel!
    @IBOutlet weak var appDetailLabel: UILabel!
    
    @IBOutlet weak var emeNameLabel: UILabel!
    @IBOutlet weak var emePhoneNoLabel: UILabel!
    @IBOutlet weak var emeBuildingNo: UILabel!
    @IBOutlet weak var emeNameResLabel: UILabel!
    @IBOutlet weak var emePhoneNoResLabel: UILabel!
    @IBOutlet weak var emeBuildingResLabel: UILabel!
    @IBOutlet weak var emeDetailLabel: UILabel!
    
//    @IBOutlet weak var guaNameLabel: UILabel!
//    @IBOutlet weak var guaDateofBLabel: UILabel!
//    @IBOutlet weak var guaNrcLabel: UILabel!
//    @IBOutlet weak var guanameResLabel: UILabel!
//    @IBOutlet weak var guaDateOfBResLabel: UILabel!
//    @IBOutlet weak var guaNrcResLabel: UILabel!
//    @IBOutlet weak var guaDetailLabel: UILabel!
    
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
    
  
       @objc func onTapBack() {
           print("click")
           self.dismiss(animated: true, completion: nil)
       }
    @IBOutlet weak var animationview: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
     //   updateViews()
       
//        animationview.aa_animate(duration: 1.0, repeatCount: 1 ,springDamping: .slight, animation: .toRight) { inAnimating, animView in
//
//        if inAnimating {
//            print("Animating ....")
//            self.animateWithTransition(.fromLeft)
//        }
//        else {
//            print("Animation Done 👍🏻")
//            self.animateWithTransition(.fromRight)
//        }
//
//        guard inAnimating else {
//            return
//        }
//
//          //  self.animateWithTransition(.)
//    }
    }
    func animateWithTransition(_ animator: AAViewAnimators) {
        animationview.aa_animate(duration: 0.7, springDamping: .slight, animation: animator) { inAnimating, animView in
               
               if inAnimating {
                   print("Animating ....")
               }
               else {
                   print("Animation Done 👍🏻")
               }
           }
       }
    
    @objc func occupationPressAction() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markOccupationDataLastState"), object: nil)
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showOccupationForm"), object: self, userInfo: ["data": self.myOccupationData as Any])
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.OCCUPATION_DATA_VC)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
    }
    @objc func applicationPressAction() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markAppDataLastState"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAppForm"), object: self, userInfo: ["data": self.myAppData as Any])
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
                           let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DATA_VC)
                           applyLoanNav.modalPresentationStyle = .overFullScreen
                           self.present(applyLoanNav, animated: true, completion: nil)
        
    }
    @objc func emergencyPressAction() {
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markEmergencyContactDataLastState"), object: nil)
              NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showEmergencyForm"), object: self, userInfo: ["data": self.myContactData as Any])
       let storyboard = UIStoryboard(name: "DA", bundle: nil)
                                 let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.EMERGENCY_CONTACT_VC)
                                 applyLoanNav.modalPresentationStyle = .overFullScreen
                                 self.present(applyLoanNav, animated: true, completion: nil)
    }
    @objc func guarantorPressAction() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markGuarantorDataLastState"), object: nil)
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showGuarantorForm"), object: self, userInfo: ["data": self.myGuarantorData as Any])
               let storyboard = UIStoryboard(name: "DA", bundle: nil)
               let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.GUARANTOR_VC)
               applyLoanNav.modalPresentationStyle = .overFullScreen
               self.present(applyLoanNav, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      //  guarantorPressView.isHidden = true
         self.doLoadSaveDAData()
//        mmflag.layer.cornerRadius = 5
//        engflag.layer.cornerRadius = 5
//         NotificationCenter.default.addObserver(self, selector: #selector(doSetOccupationData(notification:)), name: NSNotification.Name(rawValue: "SetOccupationData"), object: nil)
//       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markOccupationDataLastState"), object: nil)
//         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showOccupationForm"), object: self, userInfo: ["data": self.myOccupationData as Any])
        fillThisForm(data: myAppFormData)
       
//        self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
//        self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
//    self.mmflag.isUserInteractionEnabled = true
//    self.engflag.isUserInteractionEnabled = true
//
//        self.mmflag.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
//        self.engflag.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
        self.occupationPressView.isUserInteractionEnabled = true
        self.applicationTitleView.isUserInteractionEnabled = true
        self.emergencyPressView.isUserInteractionEnabled = true
       // self.guarantorPressView.isUserInteractionEnabled = true
             self.occupationPressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(occupationPressAction)))
        
        self.applicationTitleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applicationPressAction)))
           self.emergencyPressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emergencyPressAction)))
         // self.guarantorPressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(guarantorPressAction)))
//        self.applicationTitleView.layer.borderWidth = 1
//        self.applicationTitleView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        
     //   logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
//               self.phoneLabelBtn.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
//                                              self.nameLabelBtn.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
//                                    self.typeLabel.text = "Lv.2 : Login user"
//       self.backView.isUserInteractionEnabled = true
//             self.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtn)))
       //self.updateViews()
               
          
               
               NotificationCenter.default.addObserver(self, selector: #selector(choosePhotoVia(notification:)), name: NSNotification.Name(rawValue: "ChooseFoto"), object: nil)
               
                NotificationCenter.default.addObserver(self, selector: #selector(doSetAppData(notification:)), name: NSNotification.Name(rawValue: "SetAppData"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSetOccupationData(notification:)), name: NSNotification.Name(rawValue: "SetOccupationData"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSetEmergencyContactData(notification:)), name: NSNotification.Name(rawValue: "SetEmergencyContactData"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSetGuarantorData(notification:)), name: NSNotification.Name(rawValue: "SetGuarantorData"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSetLoanConfirmationData(notification:)), name: NSNotification.Name(rawValue: "SetLoanConfirmationData"), object: nil)
               
                NotificationCenter.default.addObserver(self, selector: #selector(doRegisterDA), name: NSNotification.Name(rawValue: "doRegistration"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(doSaveDA), name: NSNotification.Name(rawValue: "saveDA"), object: nil)
//               
//               NotificationCenter.default.addObserver(self, selector: #selector(tapOnNextAppData), name: NSNotification.Name(rawValue: "tapOnNext"), object: nil)
               
               NotificationCenter.default.addObserver(self, selector: #selector(showPreview), name: NSNotification.Name(rawValue: "showPreview"), object: nil)
               
             //  self.doLoadSaveDAData()
       
      
       
       
    }
   
    func fillThisForm(data: ApplicationDataRequest) {
         let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
         sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        self.nameLbl.text = "\(sessionInfo?.name ?? "")"//data.name
               self.dobLbl.text  = Utils.changeYMDDateformat(date: (sessionInfo?.dateOfBirth)!)
               let nrcStr = "\(sessionInfo?.nrcNo ?? "")"//data.nrcNo
               self.nrcNoLbl?.text = nrcStr
        
        
       
    }
    func occupationFillThisForm(data: OccupationDataRequest) {
        
//        self.ocCompanyName.text = data.companyName
//        self.ocBuildingNo.text = data.companyAddressBuildingNo
//        self.ocRoomNo.text = data.companyAddressRoomNo
    }
    func EmergencyFillThisForm(data: EmergencyContactRequest) {
//        self.emeNameResLabel.text = data.name
//        self.emePhoneNoResLabel.text = data.mobileNo
//        self.emeBuildingResLabel.text = data.currentAddressBuildingNo
       
    }
    
    func callNotification(image: UIImage) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectFoto"), object: self, userInfo: ["img": image])
    //        self.delegate?.didSelectfoto(image: image)
        }
        @objc func onTapMMLocale() {
            
             super.NewupdateLocale(flag: 1)
             updateViews()
          
         }
         @objc func onTapEngLocale() {
             print("click")
             super.NewupdateLocale(flag: 2)
             updateViews()
        
             
         }
    @objc override func updateViews() {
        super.updateViews()
        self.applicationLabel.text = "application_data.data".localized
        self.occupationDataLabel.text = "application_data.occupation".localized
        self.emergencyLabel.text = "application_data.emergency".localized
       // self.guarantorLabel.text = "application_data.guarantor".localized
      
        self.nameLabel.text = "application_data.title".localized
        self.nrcNoLabel.text = "application_data.nrc_no".localized
            self.dateofBirthLabel.text = "application_data.dob.label".localized
        self.ocDetailLabel.text = "occupation_company_detail".localized
        self.companyNameLabel.text = "occupation_company_name".localized
        self.buildingNoLabel.text = "occupation_building_no".localized
        self.roomNoLabel.text = "occupation_room_no".localized
        self.appDetailLabel.text = "occupation_company_detail".localized
        self.emeBuildingNo.text = "occupation_building_no".localized
        self.emePhoneNoLabel.text = "emergencycontact_mobileno".localized
        self.emeNameLabel.text = "occupation_company_name".localized
        self.emeDetailLabel.text = "occupation_company_detail".localized
//        self.guaNameLabel.text = "occupation_company_name".localized
//        self.guaNrcLabel.text = "application_data.nrc_no".localized
//        self.guaDateofBLabel.text = "application_data.dob.label".localized
//        self.guaDetailLabel.text = "occupation_company_detail".localized
        
    }
        func doRegisterDAApi() {
            
            let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
            tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
            
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            DAViewModel.init().doRegisterDigitalApplication(tokenInfo: self.tokenInfo!, appData: self.myAppData, companyData: self.myOccupationData, emergencyContact: self.myContactData, attachmentlist: self.myAttachments, loanData: self.myLoanData, guarantorData: self.myGuarantorData,  success: { (success) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
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
                        
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }) { (error) in
                
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
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
                    popup.dismiss(animated: false, completion: nil)
                    self.doRegisterDAApi()
                    
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
                    
//                    let appdata = ApplicationDataRequest(daApplicationInfoId: responseObjDA.daApplicationInfoId ?? 0, daApplicationTypeId: responseObjDA.daApplicationTypeId ?? 1, name: responseObjDA.name ?? "", dob: responseObjDA.dob ?? "", nrcNo: responseObjDA.nrcNo ?? "", fatherName: responseObjDA.fatherName ?? "",highestEducationTypeId: responseObjDA.highestEducationTypeId ?? 1, nationality: responseObjDA.nationality ?? 1, nationalityOther: responseObjDA.nationalityOther ?? "", gender: responseObjDA.gender!, maritalStatus: responseObjDA.maritalStatus ?? 1, currentAddress: responseObjDA.currentAddress ?? "", permanentAddress: responseObjDA.permanentAddress ?? "", typeOfResidence: responseObjDA.typeOfResidence ?? 1, typeOfResidenceOther: responseObjDA.typeOfResidenceOther ?? "", livingWith: responseObjDA.livingWith ?? 1, livingWithOther: responseObjDA.livingWithOther ?? "", yearOfStayYear: responseObjDA.yearOfStayYear ?? 0, yearOfStayMonth: responseObjDA.yearOfStayMonth ?? 0, mobileNo: responseObjDA.mobileNo ?? "", residentTelNo: responseObjDA.residentTelNo ?? "", otherPhoneNo: responseObjDA.otherPhoneNo ?? "", email: responseObjDA.email ?? "", customerId: responseObjDA.customerId ?? 0, status: responseObjDA.status ?? 0, currentAddressFloor: responseObjDA.currentAddressFloor ?? "", currentAddressBuildingNo: responseObjDA.currentAddressBuildingNo ?? "", currentAddressRoomNo: responseObjDA.currentAddressRoomNo ?? "", currentAddressStreet: responseObjDA.currentAddressStreet ?? "", currentAddressQtr: responseObjDA.currentAddressQtr ?? "", currentAddressTownship: responseObjDA.currentAddressTownship ?? 0, currentAddressCity: responseObjDA.currentAddressCity ?? 0, permanentAddressFloor: responseObjDA.permanentAddressFloor ?? "", permanentAddressBuildingNo: responseObjDA.permanentAddressBuildingNo ?? "", permanentAddressRoomNo: responseObjDA.permanentAddressRoomNo ?? "", permanentAddressStreet: responseObjDA.permanentAddressStreet ?? "", permanentAddressQtr: responseObjDA.permanentAddressQtr ?? "", permanentAddressTownship: responseObjDA.permanentAddressTownship ?? 0, permanentAddressCity: responseObjDA.permanentAddressCity ?? 0)
                    
                     var appdata = ApplicationDataRequest(daApplicationInfoId: responseObjDA.daApplicationInfoId ?? 0, daApplicationTypeId: responseObjDA.daApplicationTypeId ?? 0, name: responseObjDA.name ?? "", dob: responseObjDA.dob ?? "", nrcNo: responseObjDA.nrcNo ?? "", fatherName: responseObjDA.fatherName ?? "", highestEducationTypeId: responseObjDA.highestEducationTypeId ?? 0, nationality: responseObjDA.nationality ?? 0, nationalityOther: responseObjDA.nationalityOther ?? "", gender: responseObjDA.gender ?? 0, maritalStatus: responseObjDA.maritalStatus ?? 0, currentAddress: responseObjDA.currentAddress ?? "", permanentAddress: responseObjDA.permanentAddress ?? "", typeOfResidence: responseObjDA.typeOfResidence ?? 0, typeOfResidenceOther: responseObjDA.typeOfResidenceOther ?? "", livingWith: responseObjDA.livingWith ?? 0, livingWithOther: responseObjDA.livingWithOther ?? "", yearOfStayYear: responseObjDA.yearOfStayYear ?? 0, yearOfStayMonth: responseObjDA.yearOfStayMonth ?? 0, mobileNo: responseObjDA.mobileNo ?? "", residentTelNo: responseObjDA.residentTelNo ?? "", otherPhoneNo: responseObjDA.otherPhoneNo ?? "", email: responseObjDA.email ?? "", customerId: responseObjDA.customerId ?? 0, status: responseObjDA.status ?? 0, currentAddressFloor: responseObjDA.currentAddressFloor ?? "", currentAddressBuildingNo: responseObjDA.currentAddressBuildingNo ?? "", currentAddressRoomNo: responseObjDA.currentAddressRoomNo ?? "", currentAddressStreet: responseObjDA.currentAddressStreet ?? "", currentAddressQtr: responseObjDA.currentAddressQtr ?? "", currentAddressTownship: responseObjDA.currentAddressTownship ?? 0, currentAddressCity: responseObjDA.currentAddressCity ?? 0, permanentAddressCity: responseObjDA.permanentAddressCity ?? 0, permanentAddressFloor: responseObjDA.permanentAddressFloor ?? "", permanentAddressBuildingNo: responseObjDA.permanentAddressBuildingNo ?? "", permanentAddressRoomNo: responseObjDA.permanentAddressRoomNo ?? "", permanentAddressStreet: responseObjDA.permanentAddressStreet ?? "", permanentAddressQtr: responseObjDA.permanentAddressQtr ?? "", permanentAddressTownship: responseObjDA.permanentAddressTownship ?? 0)
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
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "applicationSuccessfully"), object: nil)
                       
//                        let alertController = UIAlertController(title: "Your application is successfully saved!", message: "", preferredStyle: .alert)
//                        alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
//                              
//                        }))
//                        self.present(alertController, animated: true, completion: nil)
                       
                       
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
                
    //            self.doRegisterDAApi()
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
//                        
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
                var emeData = EmergencyContactRequest(daEmergencyContactInfoId: 0, name: responseObjDA.emergencyContactInfoDto?.name ?? "", relationship: 0, relationshipOther: "", currentAddress: "", mobileNo: responseObjDA.emergencyContactInfoDto?.mobileNo ?? "", residentTelNo: "", otherPhoneNo: "", currentAddressFloor: "", currentAddressBuildingNo: responseObjDA.emergencyContactInfoDto?.currentAddressBuildingNo ?? "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0)
                var occudata = OccupationDataRequest(daApplicantCompanyInfoId: 0, companyName: responseObjDA.applicantCompanyInfoDto?.companyName ?? "", companyAddress: "", companyTelNo: "", contactTimeFrom: "", contactTimeTo: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, companyStatus: 0, companyStatusOther: "", monthlyBasicIncome: 0.0, otherIncome: 0.0, totalIncome: 0.0, salaryDay: 0, companyAddressBuildingNo: responseObjDA.applicantCompanyInfoDto?.companyAddressBuildingNo ?? "", companyAddressRoomNo: responseObjDA.applicantCompanyInfoDto?.companyAddressRoomNo ?? "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
                
                var appdata = ApplicationDataRequest(daApplicationInfoId: responseObjDA.daApplicationInfoId ?? 0, daApplicationTypeId: responseObjDA.daApplicationTypeId ?? 0, name: responseObjDA.name ?? "", dob: responseObjDA.dob ?? "", nrcNo: responseObjDA.nrcNo ?? "", fatherName: responseObjDA.fatherName ?? "", highestEducationTypeId: responseObjDA.highestEducationTypeId ?? 0, nationality: responseObjDA.nationality ?? 0, nationalityOther: responseObjDA.nationalityOther ?? "", gender: responseObjDA.gender ?? 0, maritalStatus: responseObjDA.maritalStatus ?? 0, currentAddress: responseObjDA.currentAddress ?? "", permanentAddress: responseObjDA.permanentAddress ?? "", typeOfResidence: responseObjDA.typeOfResidence ?? 0, typeOfResidenceOther: responseObjDA.typeOfResidenceOther ?? "", livingWith: responseObjDA.livingWith ?? 0, livingWithOther: responseObjDA.livingWithOther ?? "", yearOfStayYear: responseObjDA.yearOfStayYear ?? 0, yearOfStayMonth: responseObjDA.yearOfStayMonth ?? 0, mobileNo: responseObjDA.mobileNo ?? "", residentTelNo: responseObjDA.residentTelNo ?? "", otherPhoneNo: responseObjDA.otherPhoneNo ?? "", email: responseObjDA.email ?? "", customerId: responseObjDA.customerId ?? 0, status: responseObjDA.status ?? 0, currentAddressFloor: responseObjDA.currentAddressFloor ?? "", currentAddressBuildingNo: responseObjDA.currentAddressBuildingNo ?? "", currentAddressRoomNo: responseObjDA.currentAddressRoomNo ?? "", currentAddressStreet: responseObjDA.currentAddressStreet ?? "", currentAddressQtr: responseObjDA.currentAddressQtr ?? "", currentAddressTownship: responseObjDA.currentAddressTownship ?? 0, currentAddressCity: responseObjDA.currentAddressCity ?? 0, permanentAddressCity: responseObjDA.permanentAddressCity ?? 0, permanentAddressFloor: responseObjDA.permanentAddressFloor ?? "", permanentAddressBuildingNo: responseObjDA.permanentAddressBuildingNo ?? "", permanentAddressRoomNo: responseObjDA.permanentAddressRoomNo ?? "", permanentAddressStreet: responseObjDA.permanentAddressStreet ?? "", permanentAddressQtr: responseObjDA.permanentAddressQtr ?? "", permanentAddressTownship: responseObjDA.permanentAddressTownship ?? 0)
//                let appdata = ApplicationDataRequest(daApplicationInfoId: responseObjDA.daApplicationInfoId ?? 0, daApplicationTypeId: responseObjDA.daApplicationTypeId ?? 1, name: responseObjDA.name ?? "", dob: responseObjDA.dob ?? "", nrcNo: responseObjDA.nrcNo ?? "", fatherName: responseObjDA.fatherName ?? "",highestEducationTypeId: responseObjDA.highestEducationTypeId ?? 1, nationality: responseObjDA.nationality ?? 1, nationalityOther: responseObjDA.nationalityOther ?? "", gender: responseObjDA.gender!, maritalStatus: responseObjDA.maritalStatus ?? 1, currentAddress: responseObjDA.currentAddress ?? "", permanentAddress: responseObjDA.permanentAddress ?? "", typeOfResidence: responseObjDA.typeOfResidence ?? 1, typeOfResidenceOther: responseObjDA.typeOfResidenceOther ?? "", livingWith: responseObjDA.livingWith ?? 1, livingWithOther: responseObjDA.livingWithOther ?? "", yearOfStayYear: responseObjDA.yearOfStayYear ?? 0, yearOfStayMonth: responseObjDA.yearOfStayMonth ?? 0, mobileNo: responseObjDA.mobileNo ?? "", residentTelNo: responseObjDA.residentTelNo ?? "", otherPhoneNo: responseObjDA.otherPhoneNo ?? "", email: responseObjDA.email ?? "", customerId: responseObjDA.customerId ?? 0, status: responseObjDA.status ?? 0, currentAddressFloor: responseObjDA.currentAddressFloor ?? "", currentAddressBuildingNo: responseObjDA.currentAddressBuildingNo ?? "", currentAddressRoomNo: responseObjDA.currentAddressRoomNo ?? "", currentAddressStreet: responseObjDA.currentAddressStreet ?? "", currentAddressQtr: responseObjDA.currentAddressQtr ?? "", currentAddressTownship: responseObjDA.currentAddressTownship ?? 0, currentAddressCity: responseObjDA.currentAddressCity ?? 0, permanentAddressFloor: responseObjDA.permanentAddressFloor ?? "", permanentAddressBuildingNo: responseObjDA.permanentAddressBuildingNo ?? "", permanentAddressRoomNo: responseObjDA.permanentAddressRoomNo ?? "", permanentAddressStreet: responseObjDA.permanentAddressStreet ?? "", permanentAddressQtr: responseObjDA.permanentAddressQtr ?? "", permanentAddressTownship: responseObjDA.permanentAddressTownship ?? 0, permanentAddressCity: responseObjDA.permanentAddressCity ?? 0)

                
                self.myAppData = appdata
                myAppFormData = self.myAppData
                self.myOccupationData = occudata
                myOccupationFormData = self.myOccupationData
                self.myContactData = emeData
                myContactFormData = self.myContactData
                self.occupationFillThisForm(data: myOccupationFormData)
                self.EmergencyFillThisForm(data: myContactFormData)
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
                    let occudata = OccupationDataRequest(daApplicantCompanyInfoId: 0, companyName: "", companyAddress: "", companyTelNo: "", contactTimeFrom: "", contactTimeTo: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, companyStatus: 1, companyStatusOther: "", monthlyBasicIncome: 0.0, otherIncome: 0.0, totalIncome: 0.0, salaryDay: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
                    self.myAppData = appdata
                    myAppFormData = self.myAppData
                    self.myOccupationData = occudata
                    myOccupationFormData = self.myOccupationData
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
//
//        @objc func tapOnNextAppData(notification: Notification) {
//            print("tapOnNextAppData")
//            if let indexdict = notification.userInfo as? Dictionary<String, Any> {
//
//                if let sVar = indexdict["index"] as? Int {
//                    self.viewSwipeMenu.jump(to: sVar, animated: true)
//                }
//            }
//        }
        
//        override func updateViews() {
//            super.updateViews()
//            switch Locale.currentLocale {
//            case .EN:
//                bbLocaleFlag.image = UIImage(named: "mm_flag")
//            case .MY:
//
//                bbLocaleFlag.image = UIImage(named: "en_flag")
//            }
//           self.title = "aeonservice.da.form.title".localized
//
//        }
        
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

    @objc func backBtn() {
           self.dismiss(animated: true, completion: nil)
       }
//    @objc func showPreview(notitfication: Notification) {
//            //prepare data
//
//            if let attachmentdict = notitfication.userInfo as? Dictionary<String, Any> {
//
//                print("doshowPreview")
//                var tempAttachment = [PurchaseAttachmentResponse]()
//                if let attachmentarray = attachmentdict["attachment"] as? [AttachmentRequest] {
//
//                    for attachment in attachmentarray {
//                        var purchaseAttachment = PurchaseAttachmentResponse()
//                        purchaseAttachment.fileType = attachment.fileType
//                        purchaseAttachment.filePath = attachment.photoByte
//                        tempAttachment.append(purchaseAttachment)
//                    }
//                }
//
//    //            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPreview"), object: self, userInfo: ["attachment": tempArray, "processingfee": Double(self.tfProcessingfee.text ?? "0.0") ?? 0.0, "comSaving": Double(self.tfCompulsory.text ?? "0.0") ?? 0.0, "totalrepay": Double(self.tfTotalRepayment.text ?? "0.0") ?? 0.0, "firstrepay": Double(self.tfFirstRepayment.text ?? "0.0") ?? 0.0, "monthltyrepay": Double(self.tfMonthlyRepayment.text ?? "0.0") ?? 0.0])
//
//                let processingfee = attachmentdict["processingfee"] as? Double
//                let totalcomp = attachmentdict["comSaving"] as? Double
//                let totalrepay = attachmentdict["totalrepay"] as? Double
//                let firstpayment = attachmentdict["firstrepay"] as? Double//
//                let monthly = attachmentdict["monthltyrepay"] as? Double
//                let lastpay = attachmentdict["lastpay"] as? Double
//
//                var applicationdetailresponse = ApplicationDetailResponse(daApplicationInfoId: 0, applicationNo: "", appliedDate: "", daApplicationTypeId: 0, status: 0, settlementPendingComment: "", daInterestInfoId: 0, daCompulsoryInfoId: 0, name: self.myAppData.name, dob: self.myAppData.dob, nrcNo: self.myAppData.nrcNo, fatherName: self.myAppData.fatherName,highestEducationTypeId: self.myAppData.highestEducationTypeId, nationality: self.myAppData.nationality, nationalityOther: self.myAppData.nationalityOther, gender: self.myAppData.gender, maritalStatus: self.myAppData.maritalStatus, currentAddress: self.myAppData.currentAddress, permanentAddress: self.myAppData.permanentAddress, typeOfResidence: self.myAppData.typeOfResidence, typeOfResidenceOther: self.myAppData.typeOfResidenceOther, livingWith: self.myAppData.livingWith, livingWithOther: self.myAppData.livingWithOther, yearOfStayYear: self.myAppData.yearOfStayYear, yearOfStayMonth: self.myAppData.yearOfStayMonth, mobileNo: self.myAppData.mobileNo, residentTelNo: self.myAppData.residentTelNo, otherPhoneNo: self.myAppData.otherPhoneNo, email: self.myAppData.email, customerId: self.myAppData.customerId, daLoanTypeId: self.myLoanData.daLoanTypeId, financeAmount: self.myLoanData.financeAmount, financeTerm: self.myLoanData.financeTerm, daProductTypeId: self.myLoanData.daProductTypeId, productDescription: self.myLoanData.productDescription, channelType: self.myLoanData.channelType, applicantCompanyInfoDto: myOccupationData, emergencyContactInfoDto: self.myContactData, guarantorInfoDto: self.myGuarantorData, applicationInfoAttachmentDtoList: tempAttachment, processingFees: processingfee, totalConSaving: totalcomp, totalRepayment: totalrepay, firstPayment: firstpayment, monthlyInstallment: monthly, lastPayment: lastpay)
//
//                applicationdetailresponse.currentAddressBuildingNo = self.myAppData.currentAddressBuildingNo
//                applicationdetailresponse.currentAddressRoomNo = self.myAppData.currentAddressRoomNo
//                applicationdetailresponse.currentAddressFloor = self.myAppData.currentAddressFloor
//                applicationdetailresponse.currentAddressStreet = self.myAppData.currentAddressStreet
//                applicationdetailresponse.currentAddressQtr = self.myAppData.currentAddressQtr
//                applicationdetailresponse.currentAddressTownship = self.myAppData.currentAddressTownship
//                applicationdetailresponse.currentAddressCity = self.myAppData.currentAddressCity
//
//                applicationdetailresponse.permanentAddressBuildingNo = self.myAppData.permanentAddressBuildingNo
//                applicationdetailresponse.permanentAddressRoomNo = self.myAppData.permanentAddressRoomNo
//                applicationdetailresponse.permanentAddressFloor = self.myAppData.permanentAddressFloor
//                applicationdetailresponse.permanentAddressStreet = self.myAppData.permanentAddressStreet
//                applicationdetailresponse.permanentAddressQtr = self.myAppData.permanentAddressQtr
//                applicationdetailresponse.permanentAddressTownship = self.myAppData.permanentAddressTownship
//                applicationdetailresponse.permanentAddressCity = self.myAppData.permanentAddressCity
//
//                let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DETAIL_VC) as! ApplicationDetailVC
//                popupVC.modalPresentationStyle = .overCurrentContext
//                popupVC.modalTransitionStyle = .crossDissolve
//
//
//                popupVC.inquiryAppID =  0
//                popupVC.appinfoobj = applicationdetailresponse
//                popupVC.isPreviewing = true
//
//                let pVC = popupVC.popoverPresentationController
//                pVC?.permittedArrowDirections = .any
//
//
//
//                self.definesPresentationContext = true
//                //popupVC.delegate = self
//                self.present(popupVC, animated: true, completion: nil)
//
//            }
//        }
   
    @IBAction func loanConfirmationBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markLoanConfirmationLastState"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showLoanForm"), object: self, userInfo: ["data": self.myLoanData as Any])
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.LOAN_CONFIRMATION_VC)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
        
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        print("loan save")
        
    }
    
}
extension CustomerInfoFormViewController {
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

extension CustomerInfoFormViewController: CheckPasswordPopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController) {
         if password.text!.count > 0 {
            self.doPasswordVerification(strPassword: "\(password.text ?? "")", popup: popUpView)
        }
    }
}
