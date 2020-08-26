//
//  LoanConfirmationVC.swift
//  AEONVCS
//
//  Created by mac on 10/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON
protocol ImageAndCaptionDelegate: class {
func userDidEnterInformation(image: UIImage)
}

class LoanConfirmationVC: BaseUIViewController {
    weak var delegate: ImageAndCaptionDelegate? = nil
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var svLoanConfirmation: UIScrollView!
    
    @IBOutlet weak var btnOne: UIButton! {
        didSet {
            self.btnOne.layer.cornerRadius = 10
            self.btnOne.layer.borderColor = UIColor.lightGray.cgColor
            self.btnOne.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var btnTwo: UIButton! {
        didSet {
            self.btnTwo.layer.cornerRadius = 10
            self.btnTwo.layer.borderColor = UIColor.lightGray.cgColor
            self.btnTwo.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var btnThree: UIButton! {
        didSet {
            self.btnThree.layer.cornerRadius = 10
            self.btnThree.layer.borderColor = UIColor.lightGray.cgColor
            self.btnThree.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var btnFour: UIButton! {
        didSet {
            self.btnFour.layer.cornerRadius = 10
            self.btnFour.layer.borderColor = UIColor.lightGray.cgColor
            self.btnFour.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var btnFive: UIButton! {
        didSet {
            self.btnFive.layer.cornerRadius = 10
            self.btnFive.layer.borderColor = UIColor.lightGray.cgColor
            self.btnFive.layer.borderWidth = 1.0
        }
    }
    
    @IBOutlet weak var btnSix: UIButton! {
        didSet {
            self.btnSix.layer.cornerRadius = 10
            self.btnSix.layer.borderColor = UIColor.lightGray.cgColor
            self.btnSix.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var btnSeven: UIButton! {
        didSet {
            self.btnSeven.layer.cornerRadius = 10
            self.btnSeven.layer.borderColor = UIColor.lightGray.cgColor
            self.btnSeven.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var btnEight: UIButton! {
        didSet {
            self.btnEight.layer.cornerRadius = 10
            self.btnEight.layer.borderColor = UIColor.lightGray.cgColor
            self.btnEight.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var btnNine: UIButton! {
        didSet {
            self.btnNine.layer.cornerRadius = 10
            self.btnNine.layer.borderColor = UIColor.lightGray.cgColor
            self.btnNine.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var btnTen: UIButton! {
        didSet {
            self.btnTen.layer.cornerRadius = 10
            self.btnTen.layer.borderColor = UIColor.lightGray.cgColor
            self.btnTen.layer.borderWidth = 1.0
        }
    }
    
    @IBOutlet weak var viewSample: UIView!
    @IBOutlet weak var imgChoosenNrcFront: UIImageView!
    
    @IBOutlet weak var stackNrcBacl: UIStackView!
    @IBOutlet weak var viewNewNrcBack: UIView!
    @IBOutlet weak var imgChoosenNrcBack: UIImageView!
    
    @IBOutlet weak var viewNewResidenceProof: UIView!
    @IBOutlet weak var stackResidenceProof: UIStackView!
    @IBOutlet weak var imgChoosenResidenceProof: UIImageView!
    
    @IBOutlet weak var viewNewIncomeProof: UIView!
    @IBOutlet weak var imgChoosenIncomeProof: UIImageView!
    @IBOutlet weak var stackIncomeProof: UIStackView!
    
    @IBOutlet weak var stackGuarantor: UIStackView!
    @IBOutlet weak var imgChoosenGuarantor: UIImageView!
    @IBOutlet weak var viewNewGuarantor: UIView!
    
    @IBOutlet weak var stackGuarantorBack: UIStackView!
    @IBOutlet weak var viewNewGuarantorBack: UIView!
    @IBOutlet weak var imgChoosenGuarantorBack: UIImageView!
    
    @IBOutlet weak var stackHousehold: UIStackView!
    @IBOutlet weak var viewNewHoushold: UIView!
    @IBOutlet weak var imgChoosenHousehold: UIImageView!
    
    @IBOutlet weak var stackApplicantFoto: UIStackView!
    @IBOutlet weak var viewNewApplicantFoto: UIView!
    @IBOutlet weak var imgChoosenApplicantFoto: UIImageView!
    
    @IBOutlet weak var viewNewCustomerSignature: UIView!
    @IBOutlet weak var stackCustomerSignature: UIStackView!
    @IBOutlet weak var imgChoosenCustomerSignature: UIImageView!
    
    @IBOutlet weak var viewNewGuarantorSignature: UIView!
    @IBOutlet weak var stackGuarantorSignature: UIStackView!
    @IBOutlet weak var imgChoosenGuarantorSignature: UIImageView!
    
    @IBOutlet weak var viewProductCategory: UIView! {
        didSet {
            self.viewProductCategory.clipsToBounds = true
            self.viewProductCategory.layer.cornerRadius = 5
            self.viewProductCategory.layer.borderWidth = 1.0
            self.viewProductCategory.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewNrcFront: UIView! {
        didSet {
            self.viewNrcFront.clipsToBounds = true
            self.viewNrcFront.layer.cornerRadius = 5
            self.viewNrcFront.layer.borderWidth = 1.0
            self.viewNrcFront.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewNrcBack: UIView! {
        didSet {
            self.viewNrcBack.clipsToBounds = true
            self.viewNrcBack.layer.cornerRadius = 5
            self.viewNrcBack.layer.borderWidth = 1.0
            self.viewNrcBack.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewIncomeProof: UIView! {
        didSet {
            self.viewIncomeProof.clipsToBounds = true
            self.viewIncomeProof.layer.cornerRadius = 5
            self.viewIncomeProof.layer.borderWidth = 1.0
            self.viewIncomeProof.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewResidenceProof: UIView! {
        didSet {
            self.viewResidenceProof.clipsToBounds = true
            self.viewResidenceProof.layer.cornerRadius = 5
            self.viewResidenceProof.layer.borderWidth = 1.0
            self.viewResidenceProof.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewGuarantorNrc: UIView! {
        didSet {
            self.viewGuarantorNrc.clipsToBounds = true
            self.viewGuarantorNrc.layer.cornerRadius = 5
            self.viewGuarantorNrc.layer.borderWidth = 1.0
            self.viewGuarantorNrc.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewGuarantorNrcBack: UIView! {
        didSet {
            self.viewGuarantorNrcBack.clipsToBounds = true
            self.viewGuarantorNrcBack.layer.cornerRadius = 5
            self.viewGuarantorNrcBack.layer.borderWidth = 1.0
            self.viewGuarantorNrcBack.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewHouseholdCriminal: UIView! {
        didSet {
            self.viewHouseholdCriminal.clipsToBounds = true
            self.viewHouseholdCriminal.layer.cornerRadius = 5
            self.viewHouseholdCriminal.layer.borderWidth = 1.0
            self.viewHouseholdCriminal.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewApplicantFoto: UIView! {
        didSet {
            self.viewApplicantFoto.clipsToBounds = true
            self.viewApplicantFoto.layer.cornerRadius = 5
            self.viewApplicantFoto.layer.borderWidth = 1.0
            self.viewApplicantFoto.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewCustomerSignature: UIView! {
        didSet {
            self.viewCustomerSignature.clipsToBounds = true
            self.viewCustomerSignature.layer.cornerRadius = 5
            self.viewCustomerSignature.layer.borderWidth = 1.0
            self.viewCustomerSignature.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet weak var viewGuarantorSignature: UIView! {
        didSet {
            self.viewGuarantorSignature.clipsToBounds = true
            self.viewGuarantorSignature.layer.cornerRadius = 5
            self.viewGuarantorSignature.layer.borderWidth = 1.0
            self.viewGuarantorSignature.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    @IBOutlet weak var lblProductCategoryText: UILabel!
    
    @IBOutlet weak var imgMobile: UIImageView!
    @IBOutlet weak var imgNonmobile: UIImageView!
    
    @IBOutlet weak var lblProductCategoryError: UILabel!
    @IBOutlet weak var lblProductDescError: UILabel!
    @IBOutlet weak var lblFinanceAmtError: UILabel!
    @IBOutlet weak var lblTermsFinanceError: UILabel!
    @IBOutlet weak var lblProcessingFeeError: UILabel!
    @IBOutlet weak var lblCompulsorySavingError: UILabel!
    @IBOutlet weak var lblTotalRepayAmtError: UILabel!
    @IBOutlet weak var lblFirstRepayAmtError: UILabel!
    @IBOutlet weak var lblMonthlyRepayAmtError: UILabel!
    @IBOutlet weak var lblLastpaymentError: UILabel!
    @IBOutlet weak var lblNrcFrontError: UILabel!
    @IBOutlet weak var lblNrcBackError: UILabel!
    @IBOutlet weak var lblIncomeProofError: UILabel!
    @IBOutlet weak var lblResidenceProofError: UILabel!
    @IBOutlet weak var lblGuarantorFrontError: UILabel!
    @IBOutlet weak var lblGuarantorBackError: UILabel!
    @IBOutlet weak var lblHouseholdError: UILabel!
    @IBOutlet weak var lblApplicantFotoError: UILabel!
    @IBOutlet weak var lblCustomerSignatureError: UILabel!
    @IBOutlet weak var lblGuarantorSignatureError: UILabel!
    
    @IBOutlet weak var lblLoanType: UILabel!
    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblFinanceAmt: UILabel!
    @IBOutlet weak var lblTermsFinance: UILabel!
    @IBOutlet weak var lblProcessingFee: UILabel!
    @IBOutlet weak var lblCompulsorySaving: UILabel!
    @IBOutlet weak var lblTotalRepayAmt: UILabel!
    @IBOutlet weak var lblFirstRepayAmt: UILabel!
    @IBOutlet weak var lblMonthlyRepayAmt: UILabel!
    @IBOutlet weak var lblLastpayment: UILabel!
    @IBOutlet weak var lblNrcFront: UILabel!
    @IBOutlet weak var lblNrcBack: UILabel!
    @IBOutlet weak var lblIncomeProof: UILabel!
    @IBOutlet weak var lblResidenceProof: UILabel!
    @IBOutlet weak var lblGuarantorFront: UILabel!
    @IBOutlet weak var lblGuarantorBack: UILabel!
    @IBOutlet weak var lblHousehold: UILabel!
    @IBOutlet weak var lblApplicantFoto: UILabel!
    @IBOutlet weak var lblCustomerSignature: UILabel!
    @IBOutlet weak var lblGuarantorSignature: UILabel!
    //@IBOutlet weak var lblTnC: UILabel!
    @IBOutlet weak var viewTermOfFinance: UIView! {
        didSet {
            self.viewTermOfFinance.clipsToBounds = true
            self.viewTermOfFinance.layer.cornerRadius = 5
            self.viewTermOfFinance.layer.borderWidth = 1.0
            self.viewTermOfFinance.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    
    @IBOutlet weak var tfProductDesc: UITextField!
    @IBOutlet weak var tfFinanceAmt: UITextField!
//    @IBOutlet weak var tfFinanceTerm: UITextField!
    @IBOutlet weak var tfProcessingfee: UITextField!
    @IBOutlet weak var tfCompulsory: UITextField!
    @IBOutlet weak var tfTotalRepayment: UITextField!
    @IBOutlet weak var tfFirstRepayment: UITextField!
    @IBOutlet weak var tfMonthlyRepayment: UITextField!
    @IBOutlet weak var tfLastPayment: UITextField!
    
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblNonmobile: UILabel!
    
    @IBOutlet weak var lblTermOfFinance: UILabel!
    
    @IBOutlet weak var imgNrcFrontIcon: UIImageView!
    @IBOutlet weak var lblNrcFrontInside: UILabel!
    
    @IBOutlet weak var imgNrcBackIcon: UIImageView!
    @IBOutlet weak var lblNrcBackInside: UILabel!
    
    @IBOutlet weak var imgIncomeProofIcon: UIImageView!
    @IBOutlet weak var lblIncomeProofInside: UILabel!
    
    @IBOutlet weak var imgResidenceProofIcon: UIImageView!
    @IBOutlet weak var lblResidenceProofInside: UILabel!
    
    @IBOutlet weak var imgGuarantorFrontIcon: UIImageView!
    @IBOutlet weak var lblGuarantorFrontInside: UILabel!
    
    @IBOutlet weak var imgGuarantorBackIcon: UIImageView!
    
    @IBOutlet weak var lblGuarantorBackInside: UILabel!
    
    @IBOutlet weak var imgHousholdIcon: UIImageView!
    @IBOutlet weak var lblHouseholdInside: UILabel!
    
    @IBOutlet weak var imgApplicantfotoIcon: UIImageView!
    @IBOutlet weak var lblApplicantFotoInside: UILabel!
    
    @IBOutlet weak var imgCusSignatureIcon: UIImageView!
    @IBOutlet weak var lblCusSignatureInside: UILabel!
    
    @IBOutlet weak var stackNrcFront: UIStackView!
    
    @IBOutlet weak var collectViewLoanTerm: UICollectionView!
    @IBOutlet weak var imgGuaSignatureIcon: UIImageView!
    @IBOutlet weak var lblGuaSignatureInside: UILabel!
    @IBOutlet weak var confirmTermCollectionCell: ConfrimTermCollectionViewCell!
//    @IBOutlet weak var imgOptionLoan: UIImageView!
//    @IBOutlet weak var cellLblLoanNumber: UILabel!
    var selectedLoanTerm = ""
    var selectedTerm = -1
    var loanTerms = [String]()
    
    var productCategoryMesgLocale: String?
    var productDescMesgLocale: String?
    var financeAmtMesgLocale: String?
    var termFinanceMesgLocale: String?
    var nrcFrontMesgLocale: String?
    var nrcBackMesgLocale: String?
    var IncomeProofMesgLocale: String?
    var residenceProofMesgLocale: String?
    var guarantorNrcFrontMesgLocale: String?
    var guarantorNrcBackMesgLocale: String?
    var householdMesgLocale: String?
    var applicantFotoMesgLocale: String?
    var cusSignatureMesgLocale: String?
    var guaSignatureMesgLocale: String?
    var termsOfFinance = [String]()
    
    var isNrcFrontChoosen = false
    var isNrcBackChoosen = false
    var isIncomeProofChoosen = false
    var isResidenceProofChoosen = false
    var isGuarantorNrcFrontChoosen = false
    var isGuarantorNrcBackChoosen = false
    var isHouseholdChoosen = false
    var isApplicantFotoChoosen = false
    var isCustomerSignatureChoosen = false
    var isGuarantorSignatureChoosen = false
//    var imagePicker: ImagePicker!
    
    var isNrcFront = false
    var imgNrcFront = UIImage()
    
    var isNRCBack = false
    var imgNrcBack = UIImage()
    
    var isIncomeProof = false
    var imgIncomeProof = UIImage()
    
    var isResidenceProof = false
    var imgResidenceProof = UIImage()
    
    var isGuarantorNrcFront = false
    var imgGuarantorNrcFront = UIImage()
    
    var isGuarantorNrcBack = false
    var imgGuarantorNrcBack = UIImage()
    
    var isHousehold = false
    var imgHousehold = UIImage()
    
    var isApplicantFoto = false
    var imgApplicantFoto = UIImage()
    
    var isCustomerSignature = false
    var imgCustomerSignature = UIImage()
    
    var isGuarantorSignature = false
    var imgGuarantorSignature = UIImage()
    
    var isMobileSelected = true
    
    var selectedProductTypeID = 0
    var selectedTermOfFinance = 0
    
    let oneToOneFifty = ["6"]
    let oneFiftyToSeventy = ["6", "9", "12", "18"]
    let overSeventyToTwoHundred = ["9", "12", "18"]
    var tokenInfo: TokenData?
    
    var producttypelist = [ProductTypeObj]()
    
     var categories = [String]()
    
    var nrcfrontImgView = UIImageView()
    var nrcfrontBtn = UIButton()
    
    var logoutTimer: Timer?
     let myPickerController = UIImagePickerController()
    
    
     var myAppData = ApplicationDataRequest(daApplicationInfoId: 0, daApplicationTypeId: 1, name: "", dob: "", nrcNo: "", fatherName: "", highestEducationTypeId: 1 , nationality: 1, nationalityOther: "", gender: 1, maritalStatus: 1, currentAddress: "", permanentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", yearOfStayYear: 0, yearOfStayMonth: 0, mobileNo: "", residentTelNo: "", otherPhoneNo: "", email: "", customerId: 0, status: 0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, permanentAddressCity: 0, permanentAddressFloor: "", permanentAddressBuildingNo: "", permanentAddressRoomNo: "", permanentAddressStreet: "", permanentAddressQtr: "", permanentAddressTownship: 0)
         
         var myLoanData = LoanConfirmationRequest(daLoanTypeId: 1, financeAmount: 0.0, financeTerm: 0, daProductTypeId: 1, productDescription: "", channelType: 2)
         
         var myGuarantorData = GuarantorRequest(daGuarantorInfoId: 0,name: "", dob: "", nrcNo: "", nationality: 1, nationalityOther: "", mobileNo: "", residentTelNo: "", relationship: 1, relationshipOther: "", currentAddress: "", typeOfResidence: 1, typeOfResidenceOther: "", livingWith: 1, livingWithOther: "", gender: 1, maritalStatus: 1, yearOfStayYear: 0, yearOfStayMonth: 0, companyName: "", companyTelNo: "", companyAddress: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, monthlyBasicIncome: 0.0, totalIncome: 0.0, currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
         
         var myOccupationData = OccupationDataRequest(daApplicantCompanyInfoId: 0, companyName: "", companyAddress: "", companyTelNo: "", contactTimeFrom: "", contactTimeTo: "", department: "", position: "", yearOfServiceYear: 0, yearOfServiceMonth: 0, companyStatus: 1, companyStatusOther: "", monthlyBasicIncome: 0.0, otherIncome: 0.0, totalIncome: 0.0, salaryDay: 0, companyAddressBuildingNo: "", companyAddressRoomNo: "", companyAddressFloor: "", companyAddressStreet: "", companyAddressQtr: "", companyAddressTownship: 0, companyAddressCity: 0)
         
         var myContactData = EmergencyContactRequest(daEmergencyContactInfoId: 0, name: "", relationship: 1, relationshipOther: "", currentAddress: "", mobileNo: "", residentTelNo: "", otherPhoneNo: "", currentAddressFloor: "", currentAddressBuildingNo: "", currentAddressRoomNo: "", currentAddressStreet: "", currentAddressQtr: "", currentAddressTownship: 0, currentAddressCity: 0)
         var myAttachments = [AttachmentRequest]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.isUserInteractionEnabled = true
                self.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtn)))
      //  logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.collectViewLoanTerm.delegate = self
        self.collectViewLoanTerm.dataSource = self
        
        self.tfProductDesc.setMaxLength(maxLength: 100)
        self.tfProductDesc.autocapitalizationType = .allCharacters
        
        // Do any additional setup after loading the view.
        self.lblProductCategoryError.text = Constants.BLANK
        self.lblProductDescError.text = Constants.BLANK
        self.lblFinanceAmtError.text = Constants.BLANK
        self.lblTermsFinanceError.text = Constants.BLANK
        self.lblProcessingFeeError.text = Constants.BLANK
        self.lblCompulsorySavingError.text = Constants.BLANK
        
        self.lblTotalRepayAmtError.text = Constants.BLANK
        self.lblFirstRepayAmtError.text = Constants.BLANK
        self.lblMonthlyRepayAmtError.text = Constants.BLANK
        self.lblLastpaymentError.text = Constants.BLANK
        self.lblNrcFrontError.text = Constants.BLANK
        self.lblNrcBackError.text = Constants.BLANK
        
        self.lblIncomeProofError.text = Constants.BLANK
        self.lblResidenceProofError.text = Constants.BLANK
        self.lblGuarantorFrontError.text = Constants.BLANK
        self.lblGuarantorBackError.text = Constants.BLANK
        self.lblHouseholdError.text = Constants.BLANK
        self.lblApplicantFotoError.text = Constants.BLANK
        
        self.lblCustomerSignatureError.text = Constants.BLANK
        
        //self.underlineLink()
        
        self.viewProductCategory.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickProductCategory)))
        
        //self.viewTermOfFinance.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickTermOfFinance)))
        
        self.tfFinanceAmt.addTarget(self, action: #selector(addSeparatorDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.tfProductDesc.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.updateViews()
        
        // initialize for camera image picker
//        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    
        NotificationCenter.default.addObserver(self, selector: #selector(markLoanConfirmationLastState), name: NSNotification.Name(rawValue: "markLoanConfirmationLastState"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(didSelectfoto(notification:)), name: NSNotification.Name(rawValue: "didSelectFoto"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLoanForm(notification:)), name: NSNotification.Name(rawValue: "showLoanForm"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorLabelLoan), name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(choosePhotoVia(notification:)), name: NSNotification.Name(rawValue: "ChooseFoto"), object: nil)
        self.doGetProductTypeListAPI()
        
        self.viewSample.isHidden = true
        self.viewNewNrcBack.isHidden = true
        self.viewNewResidenceProof.isHidden = true
        self.viewNewIncomeProof.isHidden = true
        self.viewNewGuarantor.isHidden = true
        self.viewNewGuarantorBack.isHidden = true
        self.viewNewHoushold.isHidden = true
        self.viewNewApplicantFoto.isHidden = true
        self.viewNewCustomerSignature.isHidden = true
        self.viewNewGuarantorSignature.isHidden = true
        
//         NotificationCenter.default.addObserver(self, selector: #selector(showPreview), name: NSNotification.Name(rawValue: "showPreview"), object: nil)
    }
    
    //            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPreview"), object: self, userInfo: ["attachment": tempArray, "processingfee": Double(self.tfProcessingfee.text ?? "0.0") ?? 0.0, "comSaving": Double(self.tfCompulsory.text ?? "0.0") ?? 0.0, "totalrepay": Double(self.tfTotalRepayment.text ?? "0.0") ?? 0.0, "firstrepay": Double(self.tfFirstRepayment.text ?? "0.0") ?? 0.0, "monthltyrepay": Double(self.tfMonthlyRepayment.text ?? "0.0") ?? 0.0])
                
              
        
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
            svLoanConfirmation.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
            
        } else {
            svLoanConfirmation.contentInset = UIEdgeInsets.zero
        }
        svLoanConfirmation.scrollIndicatorInsets = svLoanConfirmation.contentInset
    }

    @objc func showLoanForm(notification: Notification) {
           if let dict = notification.userInfo as? Dictionary<String, Any> {
           print("showemergencyform \(dict)")
           if let sVar = dict["data"] as? LoanConfirmationRequest {
               self.fillThisForm(data: sVar)
               }
           }
       }
       
       func fillThisForm(data: LoanConfirmationRequest) {
           
        self.tfProductDesc.text = data.productDescription
        self.textFieldDidChange(tfProductDesc)
        
        if data.financeAmount == 0 {
            self.tfFinanceAmt.text = ""
        } else {
            self.tfFinanceAmt.text = "\(Int(data.financeAmount))"
        }
        self.textFieldDidChange(self.tfFinanceAmt)
        
        if data.financeTerm == 0 {
            self.lblTermOfFinance.text = ""
        } else {
            self.lblTermOfFinance.text = "\(data.financeTerm)"
            //self.selectedTerm = data.financeTerm
            self.selectedLoanTerm = "\(data.financeTerm)"
        }
        
        if data.financeAmount > 50000 {
            self.doCalculateLoan(amt: self.tfFinanceAmt.text ?? "", terms: self.selectedLoanTerm)
        }
        
        if data.daLoanTypeId == 1 {
            self.doSelectMobile(UIButton())
        } else {
            self.doSelectNonmobile(UIButton())
        }
        
        self.selectedProductTypeID = data.daProductTypeId
        self.lblProductCategoryText.text = self.selectedProductTypeID == 0 ? self.categories[self.selectedProductTypeID] : self.categories[self.selectedProductTypeID - 1]
        self.refreshLoanTerm(amt: "\(Int(data.financeAmount))")
        
        // set selected term value
        self.selectedTerm = self.termsOfFinance.firstIndex(of: "\(data.financeTerm)") ?? -1
        
        print("save term ====>\(self.termsOfFinance) + \(self.selectedTerm)")
        self.collectViewLoanTerm.reloadData()
       }
    @objc func backBtn() {
           self.dismiss(animated: true, completion: nil)
       }
    
    @objc func markLoanConfirmationLastState() {
        
//        1: NRC FRONT, 2: NRC BACK, 3: RESIDENT PROOF, 4: INCOME PROOF, 5: GUARANTOR NRC FRONT, 6: GUARANTOR NRC BACK, 7: HOUSEHOLD OR CRIMINAL CLEARANCE, 8: APPLICANT PHOTO, 9: SIGNATURE, 10: OTHER
        DispatchQueue.main.async {
              var tempArray = [AttachmentRequest]()
            if self.isNrcFrontChoosen {
                      let imageData:NSData = self.imgNrcFront.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                       let attachment = AttachmentRequest(fileType: 1, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                  
            if self.isNrcBackChoosen {
                      let imageData:NSData = self.imgNrcBack.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 2, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                  
            if self.isIncomeProofChoosen {
                      let imageData:NSData = self.imgIncomeProof.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 3, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                 
            if self.isResidenceProofChoosen {
                      let imageData:NSData = self.imgResidenceProof.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 4, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                  
            if self.isGuarantorNrcFrontChoosen {
                      let imageData:NSData = self.imgGuarantorNrcFront.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 5, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                  
            if self.isGuarantorNrcBackChoosen {
                      let imageData:NSData = self.imgGuarantorNrcBack.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 6, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                  
            if self.isHouseholdChoosen {
                      let imageData:NSData = self.imgHousehold.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 7, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                  
            if self.isApplicantFotoChoosen {
                      let imageData:NSData = self.imgApplicantFoto.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 8, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                  
            if self.isCustomerSignatureChoosen {
                      let imageData:NSData = self.imgCustomerSignature.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 9, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
            if self.isGuarantorSignatureChoosen {
                      let imageData:NSData = self.imgGuarantorSignature.pngData()! as NSData
                      let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                      
                      let attachment = AttachmentRequest(fileType: 10, photoByte: imageBase64)
                      
                      tempArray.append(attachment)
                  }
                  
                  let attachmentlist = tempArray
                  
                  let amtfinance = self.tfFinanceAmt.text ?? "0"
                  let removedComma = amtfinance.replacingOccurrences(of: ",", with: "")
                  
                  
                  
                  let appData = LoanConfirmationRequest(daLoanTypeId: self.isMobileSelected ? 1 : 2, financeAmount: Double(removedComma
                      
                      ) ?? 0.0, financeTerm: Int(self.selectedLoanTerm) ?? 0, daProductTypeId: self.selectedProductTypeID, productDescription: self.tfProductDesc.text ?? "", channelType: 1)
                  
                  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetLoanConfirmationData"), object: self, userInfo: ["appData": appData, "attachment": attachmentlist])
        }
        self.markLoanErrorCount()
        
      
        
        self.view.endEditing(true)
    }
    
    @objc func showErrorLabelLoan() {
          _ = self.isErrorExit()
    }
    
    @objc func didSelectfoto(notification: Notification) {
        print("didSelectfoto")
        if let dict = notification.userInfo as? Dictionary<String, Any> {
            
            if let image = dict["img"] as? UIImage {
               
                    print("didSelectfoto resize")
                    self.doResizeAndAssignImages(image: image)
                
            }
        }
        
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.lblMobile.text = "loanconfirmation_mobile_type".localized
        self.lblNonmobile.text = "loanconfirmation_nonmobile_type".localized
        self.lblLoanType.text = "loanconfirmation_loan_type".localized
        self.lblProductCategory.text = "loanconfirmation_product_category".localized
        self.lblProductDesc.text = "loanconfirmation_product_desc".localized
        self.lblFinanceAmt.text = "loanconfirmation_finance_amt".localized
        self.lblTermsFinance.text = "loanconfirmation_finance_term".localized
        self.lblProcessingFee.text = "loan.fee".localized
        self.lblCompulsorySaving.text = "loan.compulsory_saving".localized
        self.lblTotalRepayAmt.text = "loan.total_repay".localized
        self.lblFirstRepayAmt.text = "loan.first_repay".localized
        self.lblMonthlyRepayAmt.text = "loan.monthly_repay".localized
        self.lblLastpayment.text = "loan.last_payment".localized
        self.lblNrcFront.text = "loanconfirmation_nrc_front".localized
        self.lblNrcBack.text = "loanconfirmation_nrc_back".localized
        self.lblIncomeProof.text = "loanconfirmation_income_proof".localized
        self.lblResidenceProof.text = "loanconfirmation_residence_proof".localized
        self.lblGuarantorFront.text = "loanconfirmation_guarantor_front".localized
        self.lblGuarantorBack.text = "loanconfirmation_guarantor_back".localized
        self.lblHousehold.text = "loanconfirmation_household".localized
        self.lblApplicantFoto.text = "loanconfirmation_applicant_foto".localized
        self.lblCustomerSignature.text = "loanconfirmation_customer_signature".localized
        self.lblGuarantorSignature.text = "loanconfirmation_guarantor_signature".localized
        
        
        self.lblProductDescError.text = productDescMesgLocale?.localized
        self.lblFinanceAmtError.text = financeAmtMesgLocale?.localized
        self.lblTermsFinanceError.text = termFinanceMesgLocale?.localized
        self.lblNrcFrontError.text = nrcFrontMesgLocale?.localized
        self.lblNrcBackError.text = nrcBackMesgLocale?.localized
        self.lblIncomeProofError.text = IncomeProofMesgLocale?.localized
        self.lblResidenceProofError.text = residenceProofMesgLocale?.localized
        self.lblGuarantorFrontError.text = guarantorNrcFrontMesgLocale?.localized
        self.lblGuarantorBackError.text = guarantorNrcBackMesgLocale?.localized
        self.lblHouseholdError.text = householdMesgLocale?.localized
        self.lblApplicantFotoError.text = applicantFotoMesgLocale?.localized
        self.lblCustomerSignatureError.text = cusSignatureMesgLocale?.localized
        self.lblGuarantorSignatureError.text = guaSignatureMesgLocale?.localized
    }
    
//    func underlineLink() {
//        let text = "AEON's Terms & Conditions *"
//        let textRange = NSRange(location: 0, length: (text.count))
//        let attributedText = NSMutableAttributedString(string: text)
//        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
//        lblTnC.attributedText = attributedText
//    }
   
    @objc func onClickProductCategory() {
        self.openProductCategory()
    }
    
    @objc func onClickTermOfFinance() {
        self.openTermOfFinance()
    }
    
    func openProductCategory() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: categories, action: { (value)  in
                self.lblProductCategoryText.text = value
//                self.selectedProductTypeID = self.categories.firstIndex(of: value)! + 1
                
                let filteredArrayNON =  self.producttypelist.filter { $0.name == value }
                print(filteredArrayNON)
                
                if filteredArrayNON.count > 0 {
                    let currentDict = filteredArrayNON.first
                    self.selectedProductTypeID = currentDict?.productTypeId ?? 0
                }
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lblProductCategoryText
            }
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: categories, action: { (value)  in
                self.lblProductCategoryText.text = value
                
                let filteredArrayNON =  self.producttypelist.filter { $0.name == value }
                print(filteredArrayNON)
                
                if filteredArrayNON.count > 0 {
                    let currentDict = filteredArrayNON.first
                    self.selectedProductTypeID = currentDict?.productTypeId ?? 0
                }
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openTermOfFinance() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: termsOfFinance, action: { (value)  in
                self.lblTermOfFinance.text = value
                self.selectedTermOfFinance = self.termsOfFinance.firstIndex(of: value)!
                self.doCalculateLoan(amt: self.tfFinanceAmt.text ?? "", terms: self.lblTermOfFinance.text ?? "")
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lblTermOfFinance
            }
            self.present(action, animated: true, completion: nil)
            
        } else {
           let action = UIAlertController.actionSheetWithItems(items: termsOfFinance, action: { (value)  in
            self.lblTermOfFinance.text = value
            self.selectedTermOfFinance = self.termsOfFinance.firstIndex(of: value)!
            
            self.doCalculateLoan(amt: self.tfFinanceAmt.text ?? "", terms: self.lblTermOfFinance.text ?? "")
            print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func doSelectMobile(_ sender: Any) {
        self.imgMobile.image = UIImage(named: "circle_selected")
        self.imgNonmobile.image = UIImage(named: "circle")

        self.isMobileSelected = true
    }
    
    @IBAction func doSelectNonmobile(_ sender: Any) {
        
        self.imgNonmobile.image = UIImage(named: "circle_selected")
        self.imgMobile.image = UIImage(named: "circle")

        self.isMobileSelected = false
    }
    
    @IBAction func tappedOnTnC(_ sender: Any) {
        
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.DATNC_VC) as! DATncVC
        
        self.present(popupVC, animated: true, completion: nil)
    }
    
    
    func isErrorExit() -> Bool {
        
        var isError = false
        
        if self.tfProductDesc?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfProductDesc?.text = Constants.BLANK
            self.lblProductDescError.text = Messages.PRODUCT_DESC_EMPTY_ERROR.localized
            self.productDescMesgLocale = Messages.PRODUCT_DESC_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblProductDescError.text = Constants.BLANK
            self.productDescMesgLocale = Constants.BLANK
        }
        
        if self.tfFinanceAmt?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfFinanceAmt?.text = Constants.BLANK
            self.lblFinanceAmtError.text = Messages.FINANCE_AMT_EMPTY_ERROR.localized
            self.financeAmtMesgLocale = Messages.FINANCE_AMT_EMPTY_ERROR
            isError = true
            
        } else {
            let amt = Int(self.tfFinanceAmt.text?.replacingOccurrences(of: ",", with: "") ?? "0")
            if amt! < 50000 || amt! > 2000000 {
                self.tfFinanceAmt?.text = Constants.BLANK
                self.lblFinanceAmtError.text = Messages.FINANCE_AMT_LIMIT_ERROR.localized
                self.financeAmtMesgLocale = Messages.FINANCE_AMT_LIMIT_ERROR
                isError = true
                
            } else {
                self.lblFinanceAmtError.text = Constants.BLANK
                self.financeAmtMesgLocale = Constants.BLANK
            }
        }
        
        if self.lblTermOfFinance?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lblTermOfFinance?.text = Constants.BLANK
            self.lblTermsFinanceError.text = Messages.FINANCE_TERM_EMPTY_ERROR.localized
            self.termFinanceMesgLocale = Messages.FINANCE_TERM_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblTermsFinanceError.text = Constants.BLANK
            self.termFinanceMesgLocale = Constants.BLANK
        }
        
        if !isNrcFrontChoosen {
           
            self.lblNrcFrontError.text = Messages.NRC_FRONT_EMPTY_ERROR.localized
            self.nrcFrontMesgLocale = Messages.NRC_FRONT_EMPTY_ERROR
            isError = true
        } else {
            self.lblTermsFinanceError.text = Constants.BLANK
            self.termFinanceMesgLocale = Constants.BLANK
        }
        
        if !isNrcBackChoosen {
            
            self.lblNrcBackError.text = Messages.NRC_BACK_EMPTY_ERROR.localized
            self.nrcBackMesgLocale = Messages.NRC_BACK_EMPTY_ERROR
            isError = true
        } else {
            self.lblNrcBackError.text = Constants.BLANK
            self.nrcBackMesgLocale = Constants.BLANK
        }
        
        if !isIncomeProofChoosen {
            
            self.lblIncomeProofError.text = Messages.INCOME_PROOF_EMPTY_ERROR.localized
            self.IncomeProofMesgLocale = Messages.INCOME_PROOF_EMPTY_ERROR
            isError = true
        } else {
            self.lblIncomeProofError.text = Constants.BLANK
            self.IncomeProofMesgLocale = Constants.BLANK
        }
        
        
        if !isResidenceProofChoosen {
            
            self.lblResidenceProofError.text = Messages.RESIDENCE_PROOF_EMPTY_ERROR.localized
            self.residenceProofMesgLocale = Messages.RESIDENCE_PROOF_EMPTY_ERROR
            isError = true
        } else {
            self.lblResidenceProofError.text = Constants.BLANK
            self.residenceProofMesgLocale = Constants.BLANK
        }
        
        if !isGuarantorNrcFrontChoosen {
            
            self.lblGuarantorFrontError.text = Messages.GUARANTOR_FRONT_EMPTY_ERROR.localized
            self.guarantorNrcFrontMesgLocale = Messages.GUARANTOR_FRONT_EMPTY_ERROR
            isError = true
        } else {
            self.lblGuarantorFrontError.text = Constants.BLANK
            self.guarantorNrcFrontMesgLocale = Constants.BLANK
        }
        
        if !isGuarantorNrcBackChoosen {
            
            self.lblGuarantorBackError.text = Messages.GUARANTOR_BACK_EMPTY_ERROR.localized
            self.guarantorNrcBackMesgLocale = Messages.GUARANTOR_BACK_EMPTY_ERROR
            isError = true
        } else {
            self.lblGuarantorBackError.text = Constants.BLANK
            self.guarantorNrcBackMesgLocale = Constants.BLANK
        }
        
        //household
        if !isHouseholdChoosen {
            
            self.lblHouseholdError.text = Messages.HOUSEHOLD_EMPTY_ERROR.localized
            self.householdMesgLocale = Messages.HOUSEHOLD_EMPTY_ERROR
            isError = true
        } else {
            self.lblHouseholdError.text = Constants.BLANK
            self.householdMesgLocale = Constants.BLANK
        }
        //applicant
        if !isApplicantFotoChoosen {
            
            self.lblApplicantFotoError.text = Messages.APPLICANT_FOTO_EMPTY_ERROR.localized
            self.applicantFotoMesgLocale = Messages.APPLICANT_FOTO_EMPTY_ERROR
            isError = true
        } else {
            self.lblApplicantFotoError.text = Constants.BLANK
            self.applicantFotoMesgLocale = Constants.BLANK
        }
        //customer signature
        if !isCustomerSignatureChoosen {
            
            self.lblCustomerSignatureError.text = Messages.CUSTOMER_SIGNATURE_EMPTY_ERROR.localized
            self.cusSignatureMesgLocale = Messages.CUSTOMER_SIGNATURE_EMPTY_ERROR
            
            isError = true
            
        } else {
            self.lblCustomerSignatureError.text = Constants.BLANK
            self.cusSignatureMesgLocale = Constants.BLANK
        }
        if !isGuarantorSignatureChoosen {
            self.lblGuarantorSignatureError.text = Messages.GUARANTOR_SIGNATURE_EMPTY_ERROR.localized
            self.guaSignatureMesgLocale = Messages.GUARANTOR_SIGNATURE_EMPTY_ERROR
        }else{
            self.lblGuarantorSignatureError.text = Constants.BLANK
            self.cusSignatureMesgLocale = Constants.BLANK
        }
        return isError
    }
    
    func markLoanErrorCount() {
        
        var errorcount = 0
        
        if self.tfProductDesc?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        }
        
        if self.tfFinanceAmt?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else {
            let val = Double(self.tfFinanceAmt.text!.replacingOccurrences(of: ",", with: ""))!
            let amt = Int(val)
            if amt < 50000 || amt > 2000000{
                errorcount += 1
            }
        }
        
        if self.lblTermOfFinance?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        }
        
        if !isNrcFrontChoosen {
           
           errorcount += 1
        }
        
        if !isNrcBackChoosen {
            
            errorcount += 1
        }
        
        if !isIncomeProofChoosen {
            
            errorcount += 1
        }
        
        
        if !isResidenceProofChoosen {
            
            errorcount += 1
        }
        
        if !isGuarantorNrcFrontChoosen {
            
            errorcount += 1
        }
        
        if !isGuarantorNrcBackChoosen {
            
            errorcount += 1
        }
        
        //household
        if !isHouseholdChoosen {
            
           errorcount += 1
        }
        //applicant
        if !isApplicantFotoChoosen {
            
            errorcount += 1
        }
        //customer signature
        if !isCustomerSignatureChoosen {
            
            errorcount += 1
        }
        //Guarantor signature
        if !isGuarantorSignatureChoosen {
            errorcount += 1
        }
        //
        UserDefaults.standard.set(errorcount, forKey: Constants.LOAN_CONFIRMATION_ERROR_COUNT)
    }
    
//    func checkCameraAccess(isApplicant: Bool) {
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//        case .denied:
//            print("Denied, request permission from settings")
//            presentCameraSettings()
//        case .restricted:
//            print("Restricted, device owner must approve")
//            presentCameraSettings()
//        case .authorized:
//            print("Authorized, proceed")
//            if isApplicant {
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChooseFoto"), object: self, userInfo: ["isCamera": true])
//            } else {
//                DispatchQueue.main.async {
//                    self.showActionSheet(vc: self)
//                }
//            }
//        case .notDetermined:
//            AVCaptureDevice.requestAccess(for: .video) { success in
//                if success {
//                    print("Permission granted, proceed")
//                    DispatchQueue.main.async {
//                        self.showActionSheet(vc: self)
//                    }
//                } else {
//                    print("Permission denied")
//                }
//            }
//        @unknown default:
//            print("unknown")
//        }
//    }
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "To Allow Camera Access, Go to Settings",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
    
    func showActionSheet(vc: UIViewController) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
//            self.camera()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChooseFoto"), object: self, userInfo: ["isCamera": true])
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
//            self.photoLibrary()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChooseFoto"), object: self, userInfo: ["isCamera": false])
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func tappedOnNRCFront(_ sender: Any) {
        self.isNrcFront = true
        self.checkCameraAccess(isApplicant: false)
        
        
    }
    
    @IBAction func tappedOnNRCBack(_ sender: Any) {
        self.isNRCBack = true
        self.checkCameraAccess(isApplicant: false)
    }
    
    @IBAction func tappedOnIncomeProof(_ sender: Any) {
        self.isIncomeProof = true
        self.checkCameraAccess(isApplicant: false)
    }
    
    @IBAction func tappedOnResidenceProof(_ sender: Any) {
        self.isResidenceProof = true
        self.checkCameraAccess(isApplicant: false)
    }
    
    @IBAction func tappedOnGuarantorFront(_ sender: Any) {
        self.isGuarantorNrcFront = true
        self.checkCameraAccess(isApplicant: false)
    }
    
    
    @IBAction func tappedOnGuarantorBack(_ sender: Any) {
        self.isGuarantorNrcBack = true
        self.checkCameraAccess(isApplicant: false)
    }
    
    @IBAction func tappedOnHousehold(_ sender: Any) {
        self.isHousehold = true
        self.checkCameraAccess(isApplicant: false)
    }
    
    @IBAction func tappedOnApplicantfoto(_ sender: Any) {
        self.isApplicantFoto = true
        self.checkCameraAccess(isApplicant: true)
    }
    
    
    @IBAction func tappedOnCustomerSignature(_ sender: Any) {
        self.isCustomerSignature = true
        self.checkCameraAccess(isApplicant: false)
    }
    
    @IBAction func tappedOnGuarantorSignature(_ sender: UIButton) {
        self.isGuarantorSignature = true
        self.checkCameraAccess(isApplicant: false)
    }
        func checkCameraAccess(isApplicant: Bool) {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .denied:
                print("Denied, request permission from settings")
                presentCameraSettings()
            case .restricted:
                print("Restricted, device owner must approve")
                presentCameraSettings()
            case .authorized:
                print("Authorized, proceed")
                if isApplicant {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChooseFoto"), object: self, userInfo: ["isCamera": true])
                } else {
                    DispatchQueue.main.async {
                        self.showActionSheet(vc: self)
                    }
                }
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { success in
                    if success {
                        print("Permission granted, proceed")
                        DispatchQueue.main.async {
                            self.showActionSheet(vc: self)
                        }
                    } else {
                        print("Permission denied")
                    }
                }
            @unknown default:
                print("unknown")
            }
        }
    func doResizeAndAssignImages(image: UIImage) {
        
        // print("image is not null")
        // resize image
        var resizeImage = UIImage()
        let jpegData = image.jpegData(compressionQuality: 2.0)
        let jpegSize: Int = jpegData?.count ?? 0
        print("original size of image in KB: %f ", Double(jpegSize) / 1024.0)
        //            print("original image width & height", image!.size.width, image!.size.height)
        
        if jpegSize == 0 {
            Utils.showAlert(viewcontroller: self, title: "Image is invalid.", message: "Please choose again.")
            //return
        } else {
            
            if jpegSize <= Constants.LOW_QUALITY_IMAGE_250 {
                resizeImage = image.resizeWithPercent(percentage: 1.0)!
                
            } else if jpegSize > Constants.LOW_QUALITY_IMAGE_250 && jpegSize <= Constants.MEDIUM_QUALITY_IMAGE_500 {
                resizeImage = image.resizeWithPercent(percentage: 0.8)!
                
            } else if jpegSize > Constants.MEDIUM_QUALITY_IMAGE_500 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_1500 {
                resizeImage = image.resizeWithPercent(percentage: 0.7)!
                
            } else {
                resizeImage = image.resizeWithPercent(percentage: 0.1)!
               // resizeImage = image.resizeWithPercent(percentage: 0.2)!
                
            }
            let rejpegData = resizeImage.jpegData(compressionQuality: 0.2)
            let rejpegSize: Int = rejpegData?.count ?? 0
            print("resize size of image in KB: %f ", Double(rejpegSize) / 9500.0)
            
            if self.isNrcFront {
                self.imgNrcFront = resizeImage
                self.isNrcFront = false
                self.isNrcFrontChoosen = true
                
                //                self.imgNrcFrontIcon.image = UIImage(named: "success")
                //                self.lblNrcFrontInside.text = "Ready to upload"
                
                self.addAfterImageCapturingView()
            }
            
            if self.isNRCBack {
                self.imgNrcBack = resizeImage
                self.isNRCBack = false
                self.isNrcBackChoosen = true
                
                //                self.imgNrcBackIcon.image = UIImage(named: "success")
                //                self.lblNrcBackInside.text = "Ready to upload"
                
                self.addAfterImageCapturingViewNRCBACK()
            }
            
            if self.isIncomeProof {
                self.imgIncomeProof = resizeImage
                self.isIncomeProof = false
                self.isIncomeProofChoosen = true
                
                //                self.imgIncomeProofIcon.image = UIImage(named: "success")
                //                self.lblIncomeProofInside.text = "Ready to upload"
                
                self.addAfterImageCapturingViewIncomeProof()
            }
            
            if self.isResidenceProof {
                self.imgResidenceProof = resizeImage
                self.isResidenceProof = false
                self.isResidenceProofChoosen = true
                
                //                self.imgResidenceProofIcon.image = UIImage(named: "success")
                //                self.lblResidenceProofInside.text = "Ready to upload"
                self.addAfterImageCapturingViewResidenceProof()
            }
            
            if self.isGuarantorNrcFront {
                self.imgGuarantorNrcFront = resizeImage
                self.isGuarantorNrcFront = false
                self.isGuarantorNrcFrontChoosen = true
                
                //                self.imgGuarantorFrontIcon.image = UIImage(named: "success")
                //                self.lblGuarantorFrontInside.text = "Ready to upload"
                
                self.addAfterImageCapturingViewGuarantor()
            }
            
            if self.isGuarantorNrcBack {
                self.imgGuarantorNrcBack = resizeImage
                self.isGuarantorNrcBack = false
                self.isGuarantorNrcBackChoosen = true
                
                //                self.imgGuarantorBackIcon.image = UIImage(named: "success")
                //                self.lblGuarantorBackInside.text = "Ready to upload"
                
                self.addAfterImageCapturingViewGuarantorBack()
            }
            
            if self.isHousehold {
                self.imgHousehold = resizeImage
                self.isHousehold = false
                self.isHouseholdChoosen = true
                
                //                self.imgHousholdIcon.image = UIImage(named: "success")
                //                self.lblHouseholdInside.text = "Ready to upload"
                
                self.addAfterImageCapturingViewHousehold()
            }
            
            if self.isApplicantFoto {
                self.imgApplicantFoto = resizeImage
                self.isApplicantFoto = false
                self.isApplicantFotoChoosen = true
                
                //                self.imgApplicantfotoIcon.image = UIImage(named: "success")
                //                self.lblApplicantFotoInside.text = "Ready to upload"
                
                self.addAfterImageCapturingViewApplicantFoto()
            }
            
            if self.isCustomerSignature {
                self.imgCustomerSignature = resizeImage
                self.isCustomerSignature = false
                self.isCustomerSignatureChoosen = true
                
                //                self.imgCusSignatureIcon.image = UIImage(named: "success")
                //                self.lblCusSignatureInside.text = "Ready to upload"
                
                self.addAfterImageCapturingViewCustomerSignature()
            }
            if self.isGuarantorSignature {
                self.imgGuarantorSignature = resizeImage
                self.isGuarantorSignature = false
                self.isGuarantorSignatureChoosen = true
                
                self.addAfterImageCapturingViewGuarantorSignature()
            }
        
            
        }
        
    }
    
    @IBAction func doTappedOnRegister(_ sender: Any) {
        self.logoutTimer?.invalidate()
        self.markLoanConfirmationLastState()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doRegistration"), object: nil)
    }
    

    
    //Loan Functions
    @objc func addSeparatorDidChange(_ textField: UITextField) {
        print("textfield did change")
        
        let totalString = "\(textField.text ?? "")"
        let removedComma = totalString.replacingOccurrences(of: ",", with: "")
        self.tfFinanceAmt.text = Int(removedComma)?.thousandsFormat
        self.selectedTerm = -1
        self.selectedLoanTerm = "0"
        self.collectViewLoanTerm.reloadData()
        self.refreshLoanTerm(amt: removedComma)
        
        if textField.text == "" {
            textField.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
        } else {
            textField.backgroundColor = UIColor.white
        }
    }
    
        func refreshLoanTerm(amt: String) {
            if let number = Int(amt) {
                if number > 2000000 {
                    
                    self.termsOfFinance = []
                    
                } else if number < 50000 {
                    
                    self.termsOfFinance = []
                } else if number >= 50000 && number <= 150000 {
                    let tempArray = self.termsOfFinance
                    
                    self.termsOfFinance = self.oneToOneFifty
                    
                    if !tempArray.elementsEqual(self.termsOfFinance) {
                        self.selectedTermOfFinance = 0
                        self.selectedTerm = -1
                    }
                    
                } else if number > 150000 && number <= 700000 {
                    let tempArray = self.termsOfFinance
                     
                    self.termsOfFinance = self.oneFiftyToSeventy
                    
                    if !tempArray.elementsEqual(self.termsOfFinance) {
                        self.selectedTermOfFinance = 0
                         self.selectedTerm = -1
                    }
                    
                    
                } else if number > 700000 {
                    let tempArray = self.termsOfFinance
                   
                    self.termsOfFinance = self.overSeventyToTwoHundred
                    
                    if !tempArray.elementsEqual(self.termsOfFinance) {
                       self.selectedTermOfFinance = 0
                         self.selectedTerm = -1
                    }
                   
                } else {
    //                self.isWarningShowing = false
                }
               
                if self.termsOfFinance.count > 0 {
                    self.lblTermOfFinance.text = self.termsOfFinance[self.selectedTermOfFinance]
                    self.doCalculateLoan(amt: self.tfFinanceAmt.text ?? "", terms: self.selectedLoanTerm)
                } else {
                    self.lblTermOfFinance.text = ""
                    self.resetLoanResult()
                }
            }
            
            self.collectViewLoanTerm.reloadData()
            
//            self.viewDidLayoutSubviews()
        }
    
    func doCalculateLoan(amt: String, terms: String) {
        
        if amt == "" || terms == "" || amt == "0.0" || terms == "0" {
            return
        }
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        let removedComma = amt.replacingOccurrences(of:  ",", with: "")
        
        let loanRequest = LoanCalculatorRequest(financeAmount: "\(removedComma)", loanTerm: terms, motorCycleLoanFlag: "false")
        
        
        
        print("loan Request Amt: \(loanRequest.financeAmount) Term: \(loanRequest.loanTerm) motorcycle: \(loanRequest.motorCycleLoanFlag)")
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        LoanCalculatorViewModel.init().executeLoanCalculator(calculatorInfo: loanRequest, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.showLoanResult(loanResult: result)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            self.resetLoanResult()
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else if error == Constants.EXPIRE_TOKEN {
                Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON " + Messages.EXPIRE_TOKEN_ERROR.localized)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "News " + error)
            }
        }
        
    }
    
    func showLoanResult(loanResult: LoanCalculator) {
        self.tfProcessingfee.text = Int(loanResult.processingFees ?? 0).thousandsFormat
        self.tfCompulsory.text = Int(loanResult.conSaving ?? 0).thousandsFormat
        self.tfTotalRepayment.text = Int(loanResult.totalRepayment ?? 0).thousandsFormat
        self.tfFirstRepayment.text = Int(loanResult.firstPayment ?? 0).thousandsFormat
        self.tfMonthlyRepayment.text = Int(loanResult.monthlyPayment ?? 0).thousandsFormat
        self.tfLastPayment.text = Int(loanResult.lastPayment ?? 0).thousandsFormat
    }
    
    func resetLoanResult() {
        self.tfProcessingfee.text = ""
        self.tfCompulsory.text = ""
        self.tfTotalRepayment.text = ""
        self.tfFirstRepayment.text = ""
        self.tfMonthlyRepayment.text = ""
        self.tfLastPayment.text = ""
    }
    
    func doGetProductTypeListAPI() {
        DAViewModel.init().getProductTypeList(success: { (typelist) in
            self.producttypelist = typelist
            
            var tempstringarray = [String]()
            for producttype in self.producttypelist {
                tempstringarray.append(producttype.name ?? "")
            }
            self.categories = tempstringarray
        }) { (error) in
            print("\(error)")
        }
    }
    
    
    func addAfterImageCapturingView() {
        self.viewSample.isHidden = false
       
        self.viewNrcFront.isHidden = true
        
        self.imgChoosenNrcFront.image = self.imgNrcFront
      
    self.stackNrcFront.addArrangedSubview(self.viewSample)
        
        
    }
    
    
    func addAfterImageCapturingViewNRCBACK() {
           self.viewNewNrcBack.isHidden = false
          
           self.viewNrcBack.isHidden = true
           
           self.imgChoosenNrcBack.image = self.imgNrcBack
       self.stackNrcBacl.addArrangedSubview(self.viewNewNrcBack)
           
           
       }
    
    func addAfterImageCapturingViewResidenceProof() {
              self.viewNewResidenceProof.isHidden = false
             
              self.viewResidenceProof.isHidden = true
              
              self.imgChoosenResidenceProof.image = self.imgResidenceProof
          self.stackResidenceProof.addArrangedSubview(self.viewNewResidenceProof)
              
              
          }
    
    func addAfterImageCapturingViewIncomeProof() {
        self.viewNewIncomeProof.isHidden = false
       
        self.viewIncomeProof.isHidden = true
        
        self.imgChoosenIncomeProof.image = self.imgIncomeProof
    self.stackIncomeProof.addArrangedSubview(self.viewNewIncomeProof)
        
        
    }
    
    func addAfterImageCapturingViewGuarantor() {
        self.viewNewGuarantor.isHidden = false
       
        self.viewGuarantorNrc.isHidden = true
        
        self.imgChoosenGuarantor.image = self.imgGuarantorNrcFront
    self.stackGuarantor.addArrangedSubview(self.viewNewGuarantor)
        
        
    }
    
    func addAfterImageCapturingViewGuarantorBack() {
        self.viewNewGuarantorBack.isHidden = false
       
        self.viewGuarantorNrcBack.isHidden = true
        
        self.imgChoosenGuarantorBack.image = self.imgGuarantorNrcBack
    self.stackGuarantorBack.addArrangedSubview(self.viewNewGuarantorBack)
        
        
    }
    
    func addAfterImageCapturingViewHousehold() {
        self.viewNewHoushold.isHidden = false
       
        self.viewHouseholdCriminal.isHidden = true
        
        self.imgChoosenHousehold.image = self.imgHousehold
    self.stackHousehold.addArrangedSubview(self.viewNewHoushold)
        
        
    }
    
    func addAfterImageCapturingViewApplicantFoto() {
        self.viewNewApplicantFoto.isHidden = false
       
        self.viewApplicantFoto.isHidden = true
        
        self.imgChoosenApplicantFoto.image = self.imgApplicantFoto
    self.stackApplicantFoto.addArrangedSubview(self.viewNewApplicantFoto)
        
    }
    
    func addAfterImageCapturingViewCustomerSignature() {
        self.viewNewCustomerSignature.isHidden = false
       
        self.viewCustomerSignature.isHidden = true
        
        self.imgChoosenCustomerSignature.image = self.imgCustomerSignature
    self.stackCustomerSignature.addArrangedSubview(self.viewNewCustomerSignature)
        
    }
    func addAfterImageCapturingViewGuarantorSignature() {
        self.viewNewGuarantorSignature.isHidden = false
        self.viewGuarantorSignature.isHidden = true
        self.imgChoosenGuarantorSignature.image = self.imgGuarantorSignature
        self.stackGuarantorSignature.addArrangedSubview(self.viewNewGuarantorSignature)
        
    }
    
    @IBAction func tappedOnPreview(_ sender: Any) {
        var tempArray = [AttachmentRequest]()
               if isNrcFrontChoosen {
                   let imageData:NSData = self.imgNrcFront.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                    let attachment = AttachmentRequest(fileType: 1, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
               
               if isNrcBackChoosen {
                   let imageData:NSData = self.imgNrcBack.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                   let attachment = AttachmentRequest(fileType: 2, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
               
               if isIncomeProofChoosen {
                   let imageData:NSData = self.imgIncomeProof.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                   let attachment = AttachmentRequest(fileType: 3, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
              
               if isResidenceProofChoosen {
                   let imageData:NSData = self.imgResidenceProof.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                   let attachment = AttachmentRequest(fileType: 4, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
               
               if isGuarantorNrcFrontChoosen {
                   let imageData:NSData = self.imgGuarantorNrcFront.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                   let attachment = AttachmentRequest(fileType: 5, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
               
               if isGuarantorNrcBackChoosen {
                   let imageData:NSData = self.imgGuarantorNrcBack.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                   let attachment = AttachmentRequest(fileType: 6, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
               
               if isHouseholdChoosen {
                   let imageData:NSData = self.imgHousehold.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                   let attachment = AttachmentRequest(fileType: 7, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
               
               if isApplicantFotoChoosen {
                   let imageData:NSData = self.imgApplicantFoto.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                   let attachment = AttachmentRequest(fileType: 8, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
               
               if isCustomerSignatureChoosen {
                   let imageData:NSData = self.imgCustomerSignature.pngData()! as NSData
                   let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   
                   let attachment = AttachmentRequest(fileType: 9, photoByte: imageBase64)
                   
                   tempArray.append(attachment)
               }
                if isGuarantorSignatureChoosen {
                    let imageData:NSData = self.imgGuarantorSignature.pngData()! as NSData
                    let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            
                    let attachment = AttachmentRequest(fileType: 10, photoByte: imageBase64)
            
                    tempArray.append(attachment)
        }
        
        let fee = Double(self.tfProcessingfee.text?.replacingOccurrences(of: ",", with: "") ?? "0.0")
        let consave = Double(self.tfCompulsory.text?.replacingOccurrences(of: ",", with: "") ?? "0.0")
        let totalrepay = Double(self.tfTotalRepayment.text?.replacingOccurrences(of: ",", with: "") ?? "0.0")
        let firstrepay = Double(self.tfFirstRepayment.text?.replacingOccurrences(of: ",", with: "") ?? "0.0")
        let monthlyrepay = Double(self.tfMonthlyRepayment.text?.replacingOccurrences(of: ",", with: "") ?? "0.0")
        let lastpay = Double(self.tfLastPayment.text?.replacingOccurrences(of: ",", with: "") ?? "0.0")
        
        //print("fee : \(self.tfProcessingfee.text)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPreview"), object: self, userInfo: ["attachment": tempArray, "processingfee": fee, "comSaving": consave, "totalrepay": totalrepay, "firstrepay": firstrepay, "monthltyrepay": monthlyrepay, "lastpay": lastpay])
       
        DispatchQueue.main.async {
             self.collectViewLoanTerm.reloadData()
        }
       
    }
}


extension LoanConfirmationVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.termsOfFinance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("call size for item ")
//        if self.loanTerms.count > 3 {
            let calculatedWidth = Int(self.collectViewLoanTerm.frame.size.width)/self.termsOfFinance.count
            print("\(calculatedWidth)")
        
            //let totalWidth = calculatedWidth * self.loanTerms.count
        //let actualWidth = self.viewTermOfFinance.frame.size.width - self.lblTitleLoanTerm.frame.size.width
        
        //print("totalwidht : \(totalWidth), actual width : \(actualWidth)")
        
        if UIDevice().screenType == .iPhone5 {
            if self.termsOfFinance.count > 3 {
                return CGSize(width: calculatedWidth, height: Int(self.collectViewLoanTerm.frame.size.height))
            } else {
               return CGSize(width: 50, height: Int(self.collectViewLoanTerm.frame.size.height))
            }
            
        }
       else {
            return CGSize(width: 50, height: Int(self.collectViewLoanTerm.frame.size.height))
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "confirmTermCollectionCell", for: indexPath) as? ConfrimTermCollectionViewCell)!
        if selectedTerm == indexPath.item {
            cell.imgOptionTerm.image = UIImage(named: "imgCircleDot")
             self.selectedLoanTerm = self.termsOfFinance[indexPath.item]
        } else {
             cell.imgOptionTerm.image = UIImage(named: "imgCircle")
        }
        
        cell.lblOptionTerm.text = "\(self.termsOfFinance[indexPath.item])"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item < self.termsOfFinance.count {
            self.selectedTerm = indexPath.item
            self.selectedLoanTerm = self.termsOfFinance[indexPath.item]
            self.collectViewLoanTerm.reloadData()
            
            self.doCalculateLoan(amt: self.tfFinanceAmt.text ?? "", terms: self.selectedLoanTerm)
            
        }
    }
    func callNotification(image: UIImage) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectFoto"), object: self, userInfo: ["img": image])
    //        self.delegate?.didSelectfoto(image: image)
        }
}
extension LoanConfirmationVC {
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

//extension LoanConfirmationVC: applyLoanDelegate {
//    func didSelectfoto(image: UIImage) {
//        print("did selct foto delegate method")
//
//            if image != nil {
//                print("do Resize & Assign Images")
//                self.doResizeAndAssignImages(image: image)
//            }
//    }
//}


