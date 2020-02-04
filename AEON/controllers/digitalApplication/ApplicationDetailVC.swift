//
//  ApplicationDetailVC.swift
//  AEONVCS
//
//  Created by mac on 11/6/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class ApplicationDetailVC: BaseUIViewController {
    
    @IBOutlet weak var tbApplication: UITableView!
    
    var appInquiryDetail = ["da.application_number", "da.application_date", "da.member_card_no"]
    var appData = ["da.name", "da.dob", "da.nrc_no", "da.father_name", "da.nationality", "da.gender", "da.marital_status", "da.current_address","da.buildno", "da.roomno", "da.floor", "da.street", "da.quarter", "da.township", "da.city", "da.permenent_address","da.buildno", "da.roomno", "da.floor", "da.street", "da.quarter", "da.township", "da.city", "da.type_of_residence", "da.living_with", "da.yearofstay", "da.mobileno", "da.resident_tel_no", "da.other_ph_no", "da.email"]
    
    var occData = ["da.company_name", "da.comapny_address","da.buildno", "da.roomno", "da.floor", "da.street", "da.quarter", "da.township", "da.city", "da.company_tel", "da.contact_time", "da.department", "da.position", "da.yearservice", "da.companystatus", "da.monthly_income", "da.other_income", "da.total_income", "da.salary_date"]
    
    var contactData = ["da.name", "da.rs_with_applicant","da.current_address","da.buildno", "da.roomno", "da.floor", "da.street", "da.quarter", "da.township", "da.city", "da.mobileno", "da.resident_tel_no", "da.other_ph_no"]
    
    var guarantorData = ["da.name", "da.dob", "da.nrc_no", "da.nationality", "da.mobileno", "da.resident_tel_no", "da.rs_with_applicant", "da.current_address","da.buildno", "da.roomno", "da.floor", "da.street", "da.quarter", "da.township", "da.city", "da.type_of_residence", "da.living_with", "da.gender", "da.marital_status", "da.yearofstay", "da.company_name", "da.comapny_address","da.buildno", "da.roomno", "da.floor", "da.street", "da.quarter", "da.township", "da.city", "da.company_tel", "da.department", "da.position", "da.yearservice", "da.monthly_income", "da.total_income"]
    
    var loanData = ["da.status", "da.loan_type", "da.product_category", "da.product_desc", "da.finance_amt", "Term of Finance", "da.processing_fee", "da.compulsory_saving", "da.total_repayment", "da.first_repayment", "da.monthly_repayment", "da.last_repayment", "da.nrc_front", "da.nrc_back", "da.income_proof", "da.residence_proof", "da.guarantor_nrc_front", "da.guarantor_nrc_back", "da.household", "da.applicant_foto", "da.customer_signature"]
    
    var inquiryAppID = 0
    var appinfoobj = ApplicationDetailResponse()
    var tokenInfo: TokenData?
    var sessionInfo:SessionDataBean?
    
    var isPreviewing = false
    var cityTownshipModel = CityTownShipModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTownshipModel = CityTownShipModel()
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        DAViewModel.init().getCityTownshipList(success: { (model) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.cityTownshipModel = model
            
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
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !self.isPreviewing {
            self.doGetApplicationDetailAPI()
        }
    }
    
    func doGetApplicationDetailAPI() {
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        DAViewModel.init().doInquiryApplicationInfoDetail(tokenInfo: tokenInfo!, inquiryAppId: "\(self.inquiryAppID)", success: { (purchaseDetailObj) in
            self.appinfoobj = purchaseDetailObj
            self.tbApplication.reloadData()
        }) { (error) in
            print("doGetPurchaseDetailAPI : \(error)")
        }
    }
    
    @IBAction func tappedOnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func updateViews() {
        super.updateViews()
        self.tbApplication.reloadData()
    }
    
    
    func setupView()
    {
        self.tbApplication.delegate = self
        self.tbApplication.dataSource = self
    }
    
    func getRepectiveStringForApplicationInquiryData(index: Int) -> String {
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        var returnString = ""
        
        switch index {
        case 0:
            returnString = self.appinfoobj.applicationNo ?? ""
        case 1:
            returnString = Utils.changeYMDDateformat(date: self.appinfoobj.appliedDate ?? "")
        case 2:
            returnString = sessionInfo?.memberNo ?? ""
            
        default:
            returnString = ""
        }
        
        return returnString
    }
    
    func getRespectiveStringForApplicationData(index: Int) -> String {
        var returnString = ""
        switch index {
        case 0:
            returnString = self.appinfoobj.name ?? ""
        case 1:
            returnString = Utils.changeYMDDateformat(date: self.appinfoobj.dob ?? "")
        case 2:
            returnString = self.appinfoobj.nrcNo ?? ""
        case 3:
            returnString = self.appinfoobj.fatherName ?? ""
        case 4:
            var str = "Myanmar"
            if self.appinfoobj.nationality != 1 {
                str = self.appinfoobj.nationalityOther ?? ""
            }
            returnString = str
        case 5:
            var str = "Male"
            if self.appinfoobj.gender != 1 {
                str = "Female"
            }
            returnString = str
        case 6:
            var str = "Single"
            if self.appinfoobj.maritalStatus != 1 {
                str = "Married"
            }
            returnString = str
        case 7:
            returnString = ""//self.appinfoobj.currentAddress ?? ""
            
        case 8:
            returnString = self.appinfoobj.currentAddressBuildingNo ?? ""
            
        case 9:
            returnString = self.appinfoobj.currentAddressRoomNo ?? ""
            
        case 10:
            returnString = self.appinfoobj.currentAddressFloor ?? ""
            
        case 11:
            returnString = self.appinfoobj.currentAddressStreet ?? ""
            
        case 12:
            returnString = self.appinfoobj.currentAddressQtr ?? ""
            
        case 13:
            if self.appinfoobj.currentAddressTownship != 0 {
                let townId = self.appinfoobj.currentAddressTownship
                if let townNameId = self.cityTownshipModel.townNameIdDic {
                    for townName in townNameId.keys{
                        let id = townNameId[townName]
                        if id == townId {
                            returnString = townName
                            break
                        }
                    }
                }
            }
            
        case 14:
            if self.appinfoobj.currentAddressCity != 0 {
                let cityId = self.appinfoobj.currentAddressCity
                if let cityNameId = self.cityTownshipModel.cityNameIdDic{
                    for cityName in cityNameId.keys{
                        let id = cityNameId[cityName]
                        if id == cityId {
                            returnString = cityName
                            break
                        }
                    }
                }
            }
            
        case 15:
            returnString = ""//self.appinfoobj.permanentAddress ?? ""
            
        case 16:
            returnString = self.appinfoobj.permanentAddressBuildingNo ?? ""
            
        case 17:
            returnString = self.appinfoobj.permanentAddressRoomNo ?? ""
            
        case 18:
            returnString = self.appinfoobj.permanentAddressFloor ?? ""
            
        case 19:
            returnString = self.appinfoobj.permanentAddressStreet ?? ""
            
        case 20:
            returnString = self.appinfoobj.permanentAddressQtr ?? ""
            
        case 21:
            if self.appinfoobj.permanentAddressTownship != 0 {
                let townId = self.appinfoobj.permanentAddressTownship
                if let townNameId = self.cityTownshipModel.townNameIdDic {
                    for townName in townNameId.keys{
                        let id = townNameId[townName]
                        if id == townId {
                            returnString = townName
                            break
                        }
                    }
                }
            }
            
        case 22:
            if self.appinfoobj.permanentAddressCity != 0 {
                let cityId = self.appinfoobj.permanentAddressCity
                if let cityNameId = self.cityTownshipModel.cityNameIdDic {
                    for cityName in cityNameId.keys{
                        let id = cityNameId[cityName]
                        if id == cityId {
                            returnString = cityName
                            break
                        }
                    }
                }
            }
            
        case 23:
            var indexnow = 0
            if self.appinfoobj.typeOfResidence! > 0 {
                indexnow = self.appinfoobj.typeOfResidence! - 1
            }
            var str = Constants.typeResidenceList[indexnow]
            if str == "Other" {
                str = self.appinfoobj.typeOfResidenceOther ?? ""
            }
            returnString =  str
            
        case 24:
            var str = ""
            if let living = self.appinfoobj.livingWith {
                if living == 0 {
                    str = Constants.livingWithList[living]
                } else {
                    str = Constants.livingWithList[living - 1]
                }
            }
            //var str = Constants.livingWithList[self.appinfoobj.livingWith! - 1]
//            if str == "Other" {
//                str = self.appinfoobj.livingWithOther ?? ""
//            }
            returnString =  str
            
        case 25:
            returnString = "\(self.appinfoobj.yearOfStayYear ?? 0) Yrs \(self.appinfoobj.yearOfStayMonth ?? 0) Months"
            
        case 26:
            returnString = self.appinfoobj.mobileNo ?? ""
            
        case 27:
            returnString = self.appinfoobj.residentTelNo ?? ""
            
        case 28:
            returnString = self.appinfoobj.otherPhoneNo ?? ""
            
        case 29:
            //let email = self.appinfoobj.email
            returnString = self.appinfoobj.email ?? ""
            
        default:
            returnString = ""
        }
        
        return returnString
    }
    
    func getRepectiveStringForOccupationData(index: Int) -> String {
        var returnString = ""
        if let occupation = self.appinfoobj.applicantCompanyInfoDto {
            switch index {
            case 0:
                returnString = occupation.companyName
            case 1:
                returnString = ""//occupation.companyAddress
            case 2:
                returnString = occupation.companyAddressBuildingNo
            case 3:
                returnString = occupation.companyAddressRoomNo
            case 4:
                returnString = occupation.companyAddressFloor
            case 5:
                returnString = occupation.companyAddressStreet
            case 6:
                returnString = occupation.companyAddressQtr
            case 7:
                if occupation.companyAddressTownship != 0 {
                    let townId = occupation.companyAddressTownship
                    if let townNameId = self.cityTownshipModel.townNameIdDic {
                        for townName in townNameId.keys{
                            let id = townNameId[townName]
                            if id == townId {
                                returnString = townName
                                break
                            }
                        }
                    }
                }
                
            case 8:
                if occupation.companyAddressCity != 0 {
                    let cityId = occupation.companyAddressCity
                    if let cityNameId = self.cityTownshipModel.cityNameIdDic {
                        for cityName in cityNameId.keys{
                            let id = cityNameId[cityName]
                            if id == cityId {
                                returnString = cityName
                                break
                            }
                        }
                    }
                }
                
            case 9:
                returnString = occupation.companyTelNo
            case 10:
                returnString = "\(occupation.contactTimeTo) - \(occupation.contactTimeFrom)"
            case 11:
                returnString = occupation.department
            case 12:
                returnString = occupation.position
            case 13:
                returnString = "\(occupation.yearOfServiceYear) Yrs \(occupation.yearOfServiceMonth) Months"
            case 14:
                var str = Constants.companyStatusList[occupation.companyStatus - 1]
                if str == "Other" {
                    str = occupation.companyStatusOther
                }
                returnString = str
            case 15:
                returnString = "\(Int(Double(occupation.monthlyBasicIncome)).thousandsFormat)"
            case 16:
                returnString = "\(Int(Double(occupation.otherIncome)).thousandsFormat)"
            case 17:
                returnString = "\(Int(Double(occupation.totalIncome)).thousandsFormat)"
            case 18:
                returnString = "\(occupation.salaryDay)"
            default:
                returnString = ""
            }
        }
        
        return returnString
    }
    
    func getRepectiveStringForEmergencyData(index: Int) -> String {
        var returnString = ""
        if let emergency = self.appinfoobj.emergencyContactInfoDto {
            switch index {
            case 0:
                returnString = emergency.name
            case 1:
                var str = Constants.rsWithList[emergency.relationship-1]
                if str == "Other" {
                    str = emergency.relationshipOther
                }
                returnString = str
                
            case 2:
                returnString = ""//emergency.currentAddress
            case 3:
                returnString = emergency.currentAddressBuildingNo
            case 4:
                returnString = emergency.currentAddressRoomNo
            case 5:
                returnString = emergency.currentAddressFloor
            case 6:
                returnString = emergency.currentAddressStreet
            case 7:
                returnString = emergency.currentAddressQtr
            case 8:
                if emergency.currentAddressTownship != 0 {
                    let townId = emergency.currentAddressTownship
                    if let townNameId = self.cityTownshipModel.townNameIdDic {
                        for townName in townNameId.keys{
                            let id = townNameId[townName]
                            if id == townId {
                                returnString = townName
                                break
                            }
                        }
                    }
                }
                
            case 9:
                if emergency.currentAddressCity != 0 {
                    let cityId = emergency.currentAddressCity
                    if let cityNameId = self.cityTownshipModel.cityNameIdDic {
                        for cityName in cityNameId.keys{
                            let id = cityNameId[cityName]
                            if id == cityId {
                                returnString = cityName
                                break
                            }
                        }
                    }
                }
                
            case 10:
                returnString = emergency.mobileNo
            case 11:
                returnString = emergency.residentTelNo
            case 12:
                returnString = emergency.otherPhoneNo
                
            default:
                returnString = ""
            }
        }
        
        return returnString
    }
    
    func getRepectiveStringForGuarantorData(index: Int) -> String {
        var returnString = ""
        if let guarantor = self.appinfoobj.guarantorInfoDto {
            switch index {
            case 0:
                returnString = guarantor.name
            case 1:
                returnString = Utils.changeYMDDateformat(date: guarantor.dob)
            case 2:
                returnString = guarantor.nrcNo
            case 3:
                var str = "Myanmar"
                if guarantor.nationality != 1 {
                    str = guarantor.nationalityOther
                }
                returnString = str
            case 4:
                returnString = guarantor.mobileNo
            case 5:
                returnString = guarantor.residentTelNo
            case 6:
                var str = Constants.rsWithGuarantorList[guarantor.relationship - 1]
                if str == "Other" {
                    str = guarantor.relationshipOther
                }
                returnString = str
                
            case 7:
                returnString = guarantor.currentAddress
                
            case 8:
                returnString = guarantor.currentAddressBuildingNo
            case 9:
                returnString = guarantor.currentAddressRoomNo
            case 10:
                returnString = guarantor.currentAddressFloor
            case 11:
                returnString = guarantor.currentAddressStreet
            case 12:
                returnString = guarantor.currentAddressQtr
            case 13:
                if guarantor.currentAddressTownship != 0 {
                    let townId = guarantor.currentAddressTownship
                    if let townNameId = self.cityTownshipModel.townNameIdDic {
                        for townName in townNameId.keys{
                            let id = townNameId[townName]
                            if id == townId {
                                returnString = townName
                                break
                            }
                        }
                    }
                }
                
            case 14:
                if guarantor.currentAddressCity != 0 {
                    let cityId = guarantor.currentAddressCity
                    if let cityNameId = self.cityTownshipModel.cityNameIdDic {
                        for cityName in cityNameId.keys{
                            let id = cityNameId[cityName]
                            if id == cityId {
                                returnString = cityName
                                break
                            }
                        }
                    }
                }
                
            case 15:
                var str = Constants.typeResidenceList[guarantor.typeOfResidence - 1]
                if str == "Other" {
                    str = guarantor.typeOfResidenceOther
                }
                returnString =  str
                
            case 16:
                var str = ""
                if guarantor.livingWith == 0 {
                    str = Constants.livingWithList[guarantor.livingWith]
                } else {
                    str = Constants.livingWithList[guarantor.livingWith - 1]
                }
                
//                if str == "Other" {
//                    str = guarantor.livingWithOther
//                }
                returnString =  str
                
            case 17:
                var str = "Male"
                if guarantor.gender != 1 {
                    str = "Female"
                }
                returnString = str
                
            case 18:
                var str = "Single"
                if guarantor.maritalStatus != 1 {
                    str = "Married"
                }
                returnString = str
                
            case 19:
                
                returnString = "\(guarantor.yearOfStayYear) Yrs \(guarantor.yearOfStayMonth) Months"
                
            case 20:
                
                returnString = guarantor.companyName
            case 21:
                returnString = guarantor.companyAddress
            case 22:
                returnString = guarantor.companyAddressBuildingNo
            case 23:
                returnString = guarantor.companyAddressRoomNo
            case 24:
                returnString = guarantor.companyAddressFloor
            case 25:
                returnString = guarantor.companyAddressStreet
            case 26:
                returnString = guarantor.companyAddressQtr
            case 27:
                if guarantor.companyAddressTownship != 0 {
                    let townId = guarantor.companyAddressTownship
                    if let townNameId = self.cityTownshipModel.townNameIdDic {
                        for townName in townNameId.keys{
                            let id = townNameId[townName]
                            if id == townId {
                                returnString = townName
                                break
                            }
                        }
                    }
                }
                
            case 28:
                if guarantor.companyAddressCity != 0 {
                    let cityId = guarantor.companyAddressCity
                    if let cityNameId = self.cityTownshipModel.cityNameIdDic {
                        for cityName in cityNameId.keys{
                            let id = cityNameId[cityName]
                            if id == cityId {
                                returnString = cityName
                                break
                            }
                        }
                    }
                }
              
            case 29:
                returnString = guarantor.companyTelNo
            case 30:
                returnString = guarantor.department
            case 31:
                returnString = guarantor.position
            case 32:
                returnString = "\(guarantor.yearOfServiceYear) Yrs \(guarantor.yearOfServiceMonth) Months"
            case 33:
                returnString = "\(Int(Double(guarantor.monthlyBasicIncome)).thousandsFormat)"
            case 34:
                returnString = "\(Int(Double(guarantor.totalIncome)).thousandsFormat)"
            default:
                returnString = ""
            }
        }
        
        return returnString
    }
    
    func getRepectiveStringForLoanData(index: Int) -> String {
        var returnString = ""
        //       var appStatus = ["Select Status","Rejected", "Purchase Confirmed", "Purchase Canceled", "Canceled", "Applied", "Approve", "Attachment Edit Requested"]
        //       var appStatusIndex = ["0", "9", "14", "11", "8", "2", "10", "5"]
        switch index {
            case 0:
                switch self.appinfoobj.status ?? 0 {
                    case 2,3,4,5,6,7:
                        returnString = "On Process"
                    case 8:
                        returnString = "Canceled"
                    case 9:
                        returnString = "Unsuccessful"
                    case 10:
                        returnString = "Approve"
                    case 11,12,13,14:
                        returnString = "Purchase Confirmed"
                    case 15,16,17:
                        returnString = "Purchase Completed"
                    default:
                        returnString = ""
                }
        case 1:
            var str = "Mobile"
            if self.appinfoobj.daLoanTypeId != 1 {
                str = "Nonmobile"
            }
            returnString = str
        case 2:
            
            returnString = Constants.categoriesList[self.appinfoobj.daProductTypeId ?? 0]
        case 3:
            returnString = self.appinfoobj.productDescription ?? ""
        case 4:
            returnString = "\(Int(Double(self.appinfoobj.financeAmount ?? 0.0)).thousandsFormat)"
        case 5:
            returnString = "\(self.appinfoobj.financeTerm ?? 0)"
        case 6:
            returnString = "\(Int(Double(self.appinfoobj.processingFees ?? 0.0)).thousandsFormat)" //Processing fee
        case 7:
            returnString = "\(Int(Double(self.appinfoobj.totalConSaving ?? 0.0)).thousandsFormat)" //Compulsory saving
        case 8:
            returnString = "\(Int(Double(self.appinfoobj.totalRepayment ?? 0.0)).thousandsFormat)" //total repay
        case 9:
            returnString = "\(Int(Double(self.appinfoobj.firstPayment ?? 0.0)).thousandsFormat)" //first repay
        case 10:
            returnString = "\(Int(Double(self.appinfoobj.monthlyInstallment ?? 0.0)).thousandsFormat)" //monthly repay
        case 11:
            returnString = "\(Int(Double(self.appinfoobj.lastPayment ?? 0.0)).thousandsFormat)" //last payment
        default:
            returnString = ""
        }
        
        
        return returnString
    }
    
    
}

extension ApplicationDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isPreviewing {
            return 5
        }
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isPreviewing {
            switch section {
            case 0:
                return self.appData.count
            case 1:
                return self.occData.count
            case 2:
                return self.contactData.count
            case 3:
                return self.guarantorData.count
            case 4:
                return self.loanData.count
                
            default:
                return 1
            }
        } else {
            switch section {
            case 0:
                return self.appInquiryDetail.count
            case 1:
                return self.appData.count
            case 2:
                return self.occData.count
            case 3:
                return self.contactData.count
            case 4:
                return self.guarantorData.count
            case 5:
                return self.loanData.count
            default:
                return 1
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let baseview = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let header = UILabel(frame: CGRect(x: 20, y: 10, width: 500, height: 27))
        baseview.backgroundColor = UIColor(red: 183.0/255.0, green: 0.0, blue: 129.0/255.0, alpha: 1)
        if self.isPreviewing {
            switch section {
            case 0:
                header.text = "da.application_data".localized
            case 1:
                header.text = "da.occupation_data".localized
            case 2:
                header.text = "da.emergenct_contact".localized
            case 3:
                header.text = "da.guarantor".localized
            case 4:
                header.text = "da.loan_confirmation".localized
                
            default:
                header.text = ""
            }
        } else {
            switch section {
            case 0:
                header.text = "da.application_inquiry_detail".localized
            case 1:
                header.text = "da.application_data".localized
            case 2:
                header.text = "da.occupation_data".localized
            case 3:
                header.text = "da.emergenct_contact".localized
            case 4:
                header.text = "da.guarantor".localized
            case 5:
                header.text = "da.loan_confirmation".localized
            default:
                header.text = ""
            }
        }
        header.textColor = .white
        header.font = UIFont(name: "PyidaungsuBook-Bold", size: 20)
        baseview.addSubview(header)
        return baseview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var currentsection = 5
        //        var  currentrow = 11
        if self.isPreviewing {
            currentsection = 4
            //            currentrow = 10
        }
        
        if indexPath.section == currentsection && indexPath.row > 11 {
            return 200
        }
        
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var currentsection = 5
        //        var  currentrow = 11
        if self.isPreviewing {
            currentsection = 4
            //            currentrow = 10
        }
        
        if indexPath.section == currentsection && indexPath.row > 11 {
            
            let subtitleString = self.loanData[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "idApplicationUserCardCell", for: indexPath) as! cellPurchaseImages
            
            let attachmentfiles = self.appinfoobj.applicationInfoAttachmentDtoList
            var imagefile = ""
            var imagefileArray = [String]()
            var filteredArray = [PurchaseAttachmentResponse]()
            if attachmentfiles != nil {
                if self.isPreviewing {
                    switch indexPath.row {
                        
                    case 12:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 1 }
                    case 13:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 2 }
                    case 14:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 3 }
                    case 15:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 4 }
                    case 16:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 5 }
                    case 17:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 6 }
                    case 18:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 7 }
                    case 19:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 8 }
                    case 20:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 9 }
                        
                    default:
                        imagefile = ""
                    }
                } else {
                    switch indexPath.row {
                    case 12:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 1 }
                    case 13:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 2 }
                    case 14:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 3 }
                    case 15:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 4 }
                    case 16:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 5 }
                    case 17:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 6 }
                    case 18:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 7 }
                    case 19:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 8 }
                    case 20:
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 9 }
                        
                    default:
                        imagefile = ""
                    }
                }
                if !isPreviewing {
                    for attachment in filteredArray {
                        imagefile = "https://ass.aeoncredit.com.mm/daso/digital-application-image-files/\(attachment.filePath ?? "")"
                        imagefileArray.append(imagefile)
                        
                    }
                } else {
                    for attachment in filteredArray {
                        
                        imagefile = "\(attachment.filePath ?? "")"
                        //
                        imagefileArray.append(imagefile)
                        
                    }
                }
            }
            
            cell.cellLbltitle.text = subtitleString.localized
            if imagefileArray.count > 0 {
                print("index : \(indexPath.section) \(indexPath.row)")
                cell.isPreviewing = self.isPreviewing
                
                cell.imagefilename = imagefile
                cell.imagefiles = imagefileArray
                cell.setData()
            } else {
                
                cell.isPreviewing = self.isPreviewing
                cell.imagefilename = imagefile
                cell.imagefiles = imagefileArray
                cell.setDataWithoutImage()
            }
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.APPLICATION_DETAIL_CELL, for: indexPath) as! cellPurchaseList
        
        
        var subtitleString = ""
        var currentdata = [String]()
        
        if self.isPreviewing {
            switch indexPath.section {
                
            case 0:
                currentdata = self.appData
                subtitleString = self.getRespectiveStringForApplicationData(index: indexPath.row)
            case 1:
                currentdata = self.occData
                subtitleString = self.getRepectiveStringForOccupationData(index: indexPath.row)
                
            case 2:
                currentdata = self.contactData
                subtitleString = self.getRepectiveStringForEmergencyData(index: indexPath.row)
            case 3:
                currentdata = self.guarantorData
                subtitleString = self.getRepectiveStringForGuarantorData(index: indexPath.row)
            case 4:
                currentdata = self.loanData
                subtitleString = self.getRepectiveStringForLoanData(index: indexPath.row)
                
            default:
                currentdata = []
            }
        } else {
            
            switch indexPath.section {
                
            case 0:
                currentdata = self.appInquiryDetail
                subtitleString = self.getRepectiveStringForApplicationInquiryData(index: indexPath.row)
            case 1:
                currentdata = self.appData
                subtitleString = self.getRespectiveStringForApplicationData(index: indexPath.row)
                
            case 2:
                currentdata = self.occData
                subtitleString = self.getRepectiveStringForOccupationData(index: indexPath.row)
            case 3:
                currentdata = self.contactData
                subtitleString = self.getRepectiveStringForEmergencyData(index: indexPath.row)
            case 4:
                currentdata = self.guarantorData
                subtitleString = self.getRepectiveStringForGuarantorData(index: indexPath.row)
            case 5:
                currentdata = self.loanData
                subtitleString = self.getRepectiveStringForLoanData(index: indexPath.row)
                
                
            default:
                currentdata = []
            }
        }
        
        cell.setData(purchasedetail: currentdata[indexPath.row].localized, subtitle: subtitleString)
        
        return cell
        
    }
    
    
}
