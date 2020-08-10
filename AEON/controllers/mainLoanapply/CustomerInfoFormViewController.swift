//
//  CustomerInfoFormViewController.swift
//  AEONVCS
//
//  Created by Ant on 06/08/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVFoundation

class CustomerInfoFormViewController: UIViewController {

    @IBOutlet weak var myscrollView: UIScrollView!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var applicationDataLabel: UILabel!
    @IBOutlet weak var occupationDataLabel: UILabel!
    @IBOutlet weak var emergencyContactLabel: UILabel!
    @IBOutlet weak var guarantorLabel: UILabel!
    @IBOutlet weak var loanConfirmationLabel: UILabel!
    @IBOutlet weak var saveLabel: UIButton!
    @IBOutlet weak var applicationChangeLabel: UIButton!
    @IBOutlet weak var occupationChangeLabel: UIButton!
    @IBOutlet weak var emergencyContactChangeLabel: UIButton!
    @IBOutlet weak var guarantorChangeLabel: UIButton!
    @IBOutlet weak var loanConfirmationChangeLabel: UIButton!
    
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
    }
    @objc func backBtn() {
           self.dismiss(animated: true, completion: nil)
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
    @IBAction func applicationDataChangeBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
                           let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DATA_VC)
                           applyLoanNav.modalPresentationStyle = .overFullScreen
                           self.present(applyLoanNav, animated: true, completion: nil)
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAppForm"), object: self, userInfo: ["data": self.myAppData as Any])
    }
    
    @IBAction func occupationDataChangeBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.OCCUPATION_DATA_VC)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAppForm"), object: self, userInfo: ["data": self.myAppData as Any])
                      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markAppDataLastState"), object: nil)
    }
    @IBAction func emergencyContactBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
                                  let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.EMERGENCY_CONTACT_VC)
                                  applyLoanNav.modalPresentationStyle = .overFullScreen
                                  self.present(applyLoanNav, animated: true, completion: nil)
      
    }
    @IBAction func GuarantorBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.GUARANTOR_VC)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
    }
    @IBAction func loanConfirmationBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.LOAN_CONFIRMATION_VC)
        applyLoanNav.modalPresentationStyle = .overFullScreen
        self.present(applyLoanNav, animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
    }
    
}
