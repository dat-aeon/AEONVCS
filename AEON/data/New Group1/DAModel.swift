//
//  DAModel.swift
//  AEONVCS
//
//  Created by mac on 10/9/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DAModel: BaseModel {
    func registerDA(token:String, rawData:Data,success: @escaping (Bool) -> Void,failure: @escaping (String) -> Void){
        
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataObjWithTokenDA(endPoint: ApiServiceEndPoint.daRegister, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("register response : ", response)
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    
                    success (true)
                    
                } else if response[ModelConstants.STATUS] as! String == Constants.STATUS_500 {
                    if response[ModelConstants.MESSAGE_CODE] as! String == Constants.APPLICATION_LIMIT {
                        failure(Constants.APPLICATION_LIMIT)
                    
                    } else if response[ModelConstants.MESSAGE_CODE] as! String == Constants.INVALID_TOTAL_FINANCE_AMOUNT {
                        failure(Constants.INVALID_TOTAL_FINANCE_AMOUNT)
                    
                    }  else if response[ModelConstants.MESSAGE_CODE] as! String == Constants.INVALID_FINANCE_AMOUNT {
                        failure(Constants.INVALID_TOTAL_FINANCE_AMOUNT)
                    
                    }  else if response[ModelConstants.MESSAGE_CODE] as! String == Constants.INVALID_REQUEST_PARAMETER {
                        failure(Constants.INVALID_REQUEST_PARAMETER)
                    
                    }
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
                
            case .failure( _):
                //print("Register New error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func loadSaveDataDA(token:String, cusID: String,success: @escaping (RegisterDAResponse) -> Void,failure: @escaping (String) -> Void){
        
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "customerId" : cusID
        ]
        let _ = super.requestDataWithTokenDA(endPoint: ApiServiceEndPoint.daLoadSaveData, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("load save data response : ", response)
                
                var daData = RegisterDAResponse()
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    
                    if  (response[ModelConstants.DATA] as? Dictionary<String, Any>) == nil {
                        failure("Empty")
                    }
                        
                    else {
                        
                        let data = response[ModelConstants.DATA] as AnyObject
                        
                        daData.daApplicationInfoId = data["daApplicationInfoId"] as? Int
                        daData.applicationNo = data["applicationNo"] as? String
                        daData.appliedDate = data["appliedDate"] as? String
                        daData.status = data[ModelConstants.STATUS] as? Int
                        daData.settlementPendingComment = data["settlementPendingComment"] as? String
                        daData.daInterestInfoId = data["daInterestInfoId"] as? Int
                        daData.daCompulsoryInfoId = data["daCompulsoryInfoId"] as? Int
                        daData.daApplicationTypeId = data["daApplicationTypeId"] as? Int
                        daData.name = data["name"] as? String
                        daData.dob = data["dob"] as? String
                        daData.nrcNo = data["nrcNo"] as? String
                        daData.fatherName = data["fatherName"] as? String
                        daData.nationality = data["nationality"] as? Int
                        daData.nationalityOther = data["nationalityOther"] as? String
                        daData.gender = data["gender"] as? Int
                        daData.maritalStatus = data["maritalStatus"] as? Int
                        daData.currentAddress = data["currentAddress"] as? String
                        daData.currentAddressBuildingNo = data["currentAddressBuildingNo"] as? String
                        daData.currentAddressRoomNo = data["currentAddressRoomNo"] as? String
                        daData.currentAddressFloor = data["currentAddressFloor"] as? String
                        daData.currentAddressStreet = data["currentAddressStreet"] as? String
                        daData.currentAddressQtr = data["currentAddressQtr"] as? String
                        daData.currentAddressCity = data["currentAddressCity"] as? Int
                        daData.currentAddressTownship = data["currentAddressTownship"] as? Int
                        daData.permanentAddress = data["permanentAddress"] as? String
                        daData.permanentAddressBuildingNo = data["permanentAddressBuildingNo"] as? String
                        daData.permanentAddressRoomNo = data["permanentAddressRoomNo"] as? String
                        daData.permanentAddressFloor = data["permanentAddressFloor"] as? String
                        daData.permanentAddressStreet = data["permanentAddressStreet"] as? String
                        daData.permanentAddressQtr = data["permanentAddressQtr"] as? String
                        daData.permanentAddressCity = data["permanentAddressCity"] as? Int
                        daData.permanentAddressTownship = data["permanentAddressTownship"] as? Int
                        daData.typeOfResidence = data["typeOfResidence"] as? Int
                        daData.typeOfResidenceOther = data["typeOfResidenceOther"] as? String
                        daData.livingWith = data["livingWith"] as? Int
                        daData.livingWithOther = data["livingWithOther"] as? String
                        daData.yearOfStayYear = data["yearOfStayYear"] as? Int
                        daData.yearOfStayMonth = data["yearOfStayMonth"] as? Int
                        daData.mobileNo = data["mobileNo"] as? String
                        daData.residentTelNo = data["residentTelNo"] as? String
                        daData.otherPhoneNo = data["otherPhoneNo"] as? String
                        daData.email = data["email"] as? String
                        daData.customerId = data["customerId"] as? Int
                        daData.daLoanTypeId = data["daLoanTypeId"] as? Int
                        daData.financeAmount = data["financeAmount"] as? Double
                        daData.financeTerm = data["financeTerm"] as? Int
                        daData.daProductTypeId = data["daProductTypeId"] as? Int
                        daData.productDescription = data["productDescription"] as? String
                        daData.channelType = data["channelType"] as? Int
                        
                        //address
                        var appfloor = ""
                        if let floor = data["currentAddressFloor"] as? String {
                            appfloor = floor
                        }
                        daData.currentAddressFloor = appfloor
                        
                        var appBldNo = ""
                        if let floor = data["currentAddressBuildingNo"] as? String {
                            appBldNo = floor
                        }
                        daData.currentAddressBuildingNo = appBldNo
                        
                        var appRoomNo = ""
                        if let floor = data["currentAddressRoomNo"] as? String {
                            appRoomNo = floor
                        }
                        daData.currentAddressRoomNo = appRoomNo
                        
                        var appStreet = ""
                        if let floor = data["currentAddressStreet"] as? String {
                            appStreet = floor
                        }
                        daData.currentAddressStreet = appStreet
                        
                        var appQtr = ""
                        if let floor = data["currentAddressQtr"] as? String {
                            appQtr = floor
                        }
                        daData.currentAddressQtr = appQtr
                        
                        var appTownship = 0
                        if let floor = data["currentAddressTownship"] as? Int {
                            appTownship  = floor
                        }
                        daData.currentAddressTownship = appTownship
                        
                        var appCity = 0
                        if let floor = data["currentAddressCity"] as? Int {
                            appCity  = floor
                        }
                        daData.currentAddressCity = appCity
                        
                        //permanent address
                        
                        var perBldNo = ""
                        if let floor = data["permanentAddressBuildingNo"] as? String {
                            perBldNo = floor
                        }
                        daData.permanentAddressBuildingNo = perBldNo
                        
                        var perRoomNo = ""
                        if let floor = data["permanentAddressRoomNo"] as? String {
                            perRoomNo = floor
                        }
                        daData.permanentAddressRoomNo = perRoomNo
                        
                        var perFloor = ""
                        if let floor = data["permanentAddressFloor"] as? String {
                            perFloor = floor
                        }
                        daData.permanentAddressFloor = perFloor
                        
                        var perStreet = ""
                        if let floor = data["permanentAddressStreet"] as? String {
                            perStreet = floor
                        }
                        daData.permanentAddressStreet = perStreet
                        
                        var perQtr = ""
                        if let floor = data["permanentAddressQtr"] as? String {
                            perQtr = floor
                        }
                        daData.permanentAddressQtr = perQtr
                        
                        var perTownship = 0
                        if let floor = data["permanentAddressTownship"] as? Int {
                            perTownship  = floor
                        }
                        daData.permanentAddressTownship = perTownship
                        
                        var perCity = 0
                        if let floor = data["permanentAddressCity"] as? Int {
                            perCity  = floor
                        }
                        daData.permanentAddressCity = perCity
                        
                        if let statusint = data[ModelConstants.STATUS] as? Int {
                            daData.status = statusint
                        }
                        
                        if let companyInfo = data["applicantCompanyInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestring = companyInfo["companyName"] as? String {
                                name = namestring
                            }
                            
                            var companyAddress = ""
                            if let addressstring = companyInfo["companyAddress"] as? String {
                                companyAddress = addressstring
                            }
                            
                            var telNO = ""
                            if let telnostring = companyInfo["companyTelNo"] as? String {
                                telNO = telnostring
                            }
                            
                            var contactTimeFrom = ""
                            if let timefrom = companyInfo["contactTimeFrom"] as? String {
                                contactTimeFrom = timefrom
                            }
                            
                            var contactTimeTo = ""
                            if let timeTo = companyInfo["contactTimeTo"] as? String {
                                contactTimeTo = timeTo
                            }
                            
                            var department = ""
                            if let departmentstring = companyInfo["department"] as? String {
                                department = departmentstring
                            }
                            
                            var position = ""
                            if let positionstr = companyInfo["position"] as? String {
                                position = positionstr
                            }
                            
                            var yearOfServiceYear = 0
                            if let yearserviceint = companyInfo["yearOfServiceYear"] as? Int {
                                yearOfServiceYear = yearserviceint
                            }
                            
                            var yearOfServiceMonth = 0
                            if let monthserviceint = companyInfo["yearOfServiceMonth"] as? Int {
                                yearOfServiceMonth = monthserviceint
                            }
                            
                            var companyStatus = 1
                            if let companystatusint = companyInfo["companyStatus"] as? Int {
                                companyStatus = companystatusint
                            }
                            
                            var companyStatusOther = ""
                            if let statusOther = companyInfo["companyStatusOther"] as? String {
                                companyStatusOther = statusOther
                            }
                            
                            var monthlyBasicIncome = 0.0
                            if let basicincome = companyInfo["monthlyBasicIncome"] as? Double {
                                monthlyBasicIncome = basicincome
                            }
                            
                            var otherIncome = 0.0
                            if let otherincomedouble = companyInfo["otherIncome"] as? Double {
                                otherIncome = otherincomedouble
                            }
                            var totalIncome = 0.0
                            if let totalincomedouble = companyInfo["totalIncome"] as? Double {
                                totalIncome = totalincomedouble
                            }
                            
                            var salaryDate = 1
                            if let salarydatestr = companyInfo["salaryDay"] as? Int {
                                salaryDate = salarydatestr
                            }
                            
                            var companyID = 0
                            if let emergencyid = companyInfo["daApplicantCompanyInfoId"] as? Int {
                                companyID = emergencyid
                            }
                        
                            
                            var companyBldNo = ""
                            if let statusOther = companyInfo["companyAddressBuildingNo"] as? String {
                                companyBldNo = statusOther
                            }
                            
                            var companyRoomNo = ""
                            if let statusOther = companyInfo["companyAddressRoomNo"] as? String {
                                companyRoomNo = statusOther
                            }
                            
                            var companyFloor = ""
                            if let statusOther = companyInfo["companyAddressFloor"] as? String {
                                companyFloor = statusOther
                            }
                            
                            var companyStreet = ""
                            if let statusOther = companyInfo["companyAddressStreet"] as? String {
                                companyStreet = statusOther
                            }
                            
                            var companyQtr = ""
                            if let statusOther = companyInfo["companyAddressQtr"] as? String {
                                companyQtr = statusOther
                            }
                            
                            var companyTownship = 0
                            if let statusOther = companyInfo["companyAddressTownship"] as? Int {
                                companyTownship = statusOther
                            }
                            
                            var companyCity = 0
                            if let statusOther = companyInfo["companyAddressCity"] as? Int {
                                companyCity = statusOther
                            }
                            
                            
                            daData.applicantCompanyInfoDto = OccupationDataRequest(daApplicantCompanyInfoId: companyID, companyName: name, companyAddress: companyAddress, companyTelNo: telNO, contactTimeFrom: contactTimeFrom, contactTimeTo: contactTimeTo, department: department, position: position, yearOfServiceYear: yearOfServiceYear, yearOfServiceMonth: yearOfServiceMonth, companyStatus: companyStatus, companyStatusOther: companyStatusOther, monthlyBasicIncome: monthlyBasicIncome, otherIncome: otherIncome, totalIncome: totalIncome, salaryDay: salaryDate, companyAddressBuildingNo: companyBldNo, companyAddressRoomNo: companyRoomNo, companyAddressFloor: companyFloor, companyAddressStreet: companyStreet, companyAddressQtr: companyQtr, companyAddressTownship: companyTownship, companyAddressCity: companyCity)
                        }
                        
                        if let emergency = data["emergencyContactInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestr = emergency["name"] as? String {
                                name = namestr
                            }
                            
                            var relationship = 0
                            if let rsInt = emergency["relationship"] as? Int {
                                relationship = rsInt
                            }
                            
                            var currentAddress = ""
                            if let addressstr = emergency["currentAddress"] as? String {
                                currentAddress =  addressstr
                            }
                            
                            var rsOtherwith = ""
                            if let rsOther = emergency["relationshipOther"] as? String {
                                rsOtherwith = rsOther
                            }
                            
                            var mobileNo = ""
                            if let phno = emergency["mobileNo"] as? String {
                                mobileNo = phno
                            }
                            
                            var residentTelNo = ""
                            if let rsTelNo = emergency["residentTelNo"] as? String {
                                residentTelNo = rsTelNo
                            }
                            
                            var otherphnumber = ""
                            if let otherPh = emergency["otherPhoneNo"] as? String {
                                otherphnumber = otherPh
                            }
                            
                            var emergencyID = 0
                            if let emergencyid = emergency["daEmergencyContactInfoId"] as? Int {
                                emergencyID = emergencyid
                            }
                            
                            
                            var emerFloor = ""
                            if let statusOther = emergency["currentAddressFloor"] as? String {
                                emerFloor = statusOther
                            }
                            
                            var emer_Bldno = ""
                            if let statusOther = emergency["currentAddressBuildingNo"] as? String {
                                emer_Bldno = statusOther
                            }
                            
                            var emer_roomno = ""
                            if let statusOther = emergency["currentAddressRoomNo"] as? String {
                                emer_roomno = statusOther
                            }
                            
                            var emer_street = ""
                            if let statusOther = emergency["currentAddressStreet"] as? String {
                                emer_street = statusOther
                            }
                            
                            var emer_qtr = ""
                            if let statusOther = emergency["currentAddressQtr"] as? String {
                                emer_qtr = statusOther
                            }
                            
                            var emer_township = 0
                            if let statusOther = emergency["currentAddressTownship"] as? Int {
                                emer_township = statusOther
                            }
                            
                            var emer_city = 0
                            if let statusOther = emergency["currentAddressCity"] as? Int {
                                emer_city = statusOther
                            }
                            
                            daData.emergencyContactInfoDto = EmergencyContactRequest(daEmergencyContactInfoId: emergencyID, name: name, relationship: relationship, relationshipOther: rsOtherwith, currentAddress: currentAddress, mobileNo: mobileNo, residentTelNo: residentTelNo, otherPhoneNo: otherphnumber, currentAddressFloor: emerFloor, currentAddressBuildingNo: emer_Bldno, currentAddressRoomNo: emer_roomno, currentAddressStreet: emer_street, currentAddressQtr: emer_qtr, currentAddressTownship: emer_township, currentAddressCity: emer_city)
                        }
                        
                        if let guarantor = data["guarantorInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestr = guarantor["name"] as? String {
                                name = namestr
                            }
                            var dob = ""
                            if let dobstr = guarantor["dob"] as? String {
                                dob = dobstr
                            }
                            
                            var nrcNo = ""
                            if let nrcstr = guarantor["nrcNo"] as? String {
                                nrcNo = nrcstr
                            }
                            
                            var nationality = 1
                            if let nationalityint = guarantor["nationality"] as? Int {
                                nationality = nationalityint
                            }
                            
                            var nother = ""
                            if let nationalityOther = guarantor["nationalityOther"] as? String {
                                nother = nationalityOther
                            }
                            
                            var mobileNo = ""
                            if let phnostr = guarantor["mobileNo"] as? String {
                                mobileNo = phnostr
                            }
                            
                            var residentTelNo = ""
                            if let rsTelNo = guarantor["residentTelNo"] as? String {
                                residentTelNo = rsTelNo
                            }
                            
                            var relationship = 1
                            if let rsInt = guarantor["relationship"] as? Int {
                                relationship = rsInt
                            }
                            var rsOther = ""
                            if let relationshipOther = guarantor["relationshipOther"] as? String  {
                                rsOther = relationshipOther
                            }
                            
                            var currentAddress = ""
                            if let addressstr = guarantor["currentAddress"] as? String {
                                currentAddress = addressstr
                            }
                            
                            var typeOfResidence = 1
                            if let typeint = guarantor["typeOfResidence"] as? Int {
                                typeOfResidence = typeint
                            }
                            var type = ""
                            if let typeOfResidenceOther = guarantor["typeOfResidenceOther"] as? String  {
                                type = typeOfResidenceOther
                            }
                            
                            var livingWith = 1
                            if let lwint = guarantor["livingWith"] as? Int {
                                livingWith = lwint
                            }
                            var livewithOther = ""
                            if let livingWithOther = guarantor["livingWithOther"] as? String  {
                                livewithOther = livingWithOther
                            }
                            
                            var gender = 1
                            if let genderint = guarantor["gender"] as? Int {
                                gender = genderint
                            }
                            
                            var maritalStatus = 1
                            if let mStatus = guarantor["maritalStatus"] as? Int {
                                maritalStatus = mStatus
                            }
                            
                            var yearOfStayYear = 0
                            if let yearyear = guarantor["yearOfStayYear"] as? Int {
                                yearOfStayYear = yearyear
                            }
                            
                            var yearOfStayMonth = 0
                            if let yearMohth = guarantor["yearOfStayMonth"] as? Int {
                                yearOfStayMonth = yearMohth
                            }
                            
                            var companyName = ""
                            if let cName = guarantor["companyName"] as? String {
                                companyName = cName
                            }
                            
                            var companyTelNo = ""
                            if let cTelNo = guarantor["companyTelNo"] as? String {
                                companyTelNo = cTelNo
                            }
                            
                            var companyAddress = ""
                            if let cAddress = guarantor["companyAddress"] as? String {
                                companyAddress = cAddress
                            }
                            
                            var department = ""
                            if let dpart = guarantor["department"] as? String  {
                                
                                department = dpart
                            }
                            
                            var position = ""
                            if let positionstr = guarantor["position"] as? String {
                                position = positionstr
                            }
                            
                            var yearOfServiceYear = 0
                            if let yearservice = guarantor["yearOfServiceYear"] as? Int {
                                yearOfServiceYear = yearservice
                            }
                            
                            var yearOfServiceMonth = 0
                            if let monthService = guarantor["yearOfServiceMonth"] as? Int {
                                yearOfServiceMonth = monthService
                            }
                            
                            var monthlyBasicIncome = 0.0
                            if let basicincome = guarantor["monthlyBasicIncome"] as? Double {
                                monthlyBasicIncome = basicincome
                            }
                            
                            var totalIncome = 0.0
                            if let totaldouble = guarantor["totalIncome"] as? Double {
                                totalIncome = totaldouble
                            }
                            
                            var guarantorId = 0
                            if let emergencyid = guarantor["daGuarantorInfoId"] as? Int {
                                guarantorId = emergencyid
                            }
                            
                            var guaFloor = ""
                            if let cAddress = guarantor["currentAddressFloor"] as? String {
                                guaFloor = cAddress
                            }

                            var guaBldNo = ""
                            if let cAddress = guarantor["currentAddressBuildingNo"] as? String {
                                guaBldNo = cAddress
                            }
                            
                            var guaRoomNo = ""
                            if let cAddress = guarantor["currentAddressRoomNo"] as? String {
                                guaRoomNo = cAddress
                            }
                            
                            var guaStreet = ""
                            if let cAddress = guarantor["currentAddressStreet"] as? String {
                                guaStreet = cAddress
                            }
                            
                            var guaQtr = ""
                            if let cAddress = guarantor["currentAddressQtr"] as? String {
                                guaQtr = cAddress
                            }
                            
                            var guaTownship = 0
                            if let cAddress = guarantor["currentAddressTownship"] as? Int {
                                guaTownship = cAddress
                            }
                            
                            var guaCity = 0
                            if let cAddress = guarantor["currentAddressCity"] as? Int {
                                guaCity = cAddress
                            }
                            //companyaddress
                            var guaCompanyFloor = ""
                            if let cAddress = guarantor["companyAddressFloor"] as? String {
                                guaCompanyFloor = cAddress
                            }

                            var guaCompanyBldNo = ""
                            if let cAddress = guarantor["companyAddressBuildingNo"] as? String {
                                guaCompanyBldNo = cAddress
                            }
                            
                            var guaCompanyRoomNo = ""
                            if let cAddress = guarantor["companyAddressRoomNo"] as? String {
                                guaCompanyRoomNo = cAddress
                            }
                            
                            var guaCompanyStreet = ""
                            if let cAddress = guarantor["companyAddressStreet"] as? String {
                                guaCompanyStreet = cAddress
                            }
                            
                            var guaCompanyQtr = ""
                            if let cAddress = guarantor["companyAddressQtr"] as? String {
                                guaCompanyQtr = cAddress
                            }
                            
                            var guaCompanyTownship = 0
                            if let cAddress = guarantor["companyAddressTownship"] as? Int {
                                guaCompanyTownship = cAddress
                            }
                            
                            var guaCompanyCity = 0
                            if let cAddress = guarantor["companyAddressCity"] as? Int {
                                guaCompanyCity = cAddress
                            }
                            
                            daData.guarantorInfoDto = GuarantorRequest(daGuarantorInfoId: guarantorId,name: name, dob: dob, nrcNo: nrcNo, nationality: nationality, nationalityOther: nother, mobileNo: mobileNo, residentTelNo: residentTelNo, relationship: relationship, relationshipOther: rsOther, currentAddress: currentAddress, typeOfResidence: typeOfResidence, typeOfResidenceOther: type, livingWith: livingWith, livingWithOther: livewithOther, gender: gender, maritalStatus: maritalStatus, yearOfStayYear: yearOfStayYear, yearOfStayMonth: yearOfStayMonth, companyName: companyName, companyTelNo: companyTelNo, companyAddress: companyAddress, department: department, position: position, yearOfServiceYear: yearOfServiceYear, yearOfServiceMonth: yearOfServiceMonth, monthlyBasicIncome: monthlyBasicIncome, totalIncome: totalIncome, currentAddressFloor: guaFloor, currentAddressBuildingNo: guaBldNo, currentAddressRoomNo: guaRoomNo, currentAddressStreet: guaStreet, currentAddressQtr: guaQtr, currentAddressTownship: guaTownship, currentAddressCity: guaCity, companyAddressBuildingNo: guaCompanyBldNo, companyAddressRoomNo: guaCompanyRoomNo, companyAddressFloor: guaCompanyFloor, companyAddressStreet: guaCompanyStreet, companyAddressQtr: guaCompanyQtr, companyAddressTownship: guaCompanyTownship, companyAddressCity: guaCompanyCity)
                        }
                        success(daData)
                        
                    }
                } else {
                    if response["messageCode"] as! String == "SERVICE_UNAVAILABLE" {
                        failure(Constants.SERVER_FAILURE)
                    } else {
                        failure(Constants.JSON_FAILURE)
                    }
                }
                
                
            case .failure( _):
                //print("Register New error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    //https://ass.aeoncredit.com.mm/daso/application/save-draft?
    
    func saveDA(token:String, rawData:Data, success: @escaping (RegisterDAResponse) -> Void,failure: @escaping (String) -> Void) {
        
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataObjWithTokenDA(endPoint: ApiServiceEndPoint.daSave, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("save DA response : ", response)
                
                var daData = RegisterDAResponse()
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    
                    if  (response[ModelConstants.DATA] as? Dictionary<String, Any>) == nil {
                        failure("Empty")
                    }
                        
                    else {
                        
                        let data = response[ModelConstants.DATA] as AnyObject
                        
                        daData.daApplicationInfoId = data["daApplicationInfoId"] as? Int
                        daData.applicationNo = data["applicationNo"] as? String
                        daData.appliedDate = data["appliedDate"] as? String
                        daData.status = data[ModelConstants.STATUS] as? Int
                        daData.settlementPendingComment = data["settlementPendingComment"] as? String
                        daData.daInterestInfoId = data["daInterestInfoId"] as? Int
                        daData.daCompulsoryInfoId = data["daCompulsoryInfoId"] as? Int
                        daData.daApplicationTypeId = data["daApplicationTypeId"] as? Int
                        daData.name = data["name"] as? String
                        daData.dob = data["dob"] as? String
                        daData.nrcNo = data["nrcNo"] as? String
                        daData.fatherName = data["fatherName"] as? String
                        daData.nationality = data["nationality"] as? Int
                        daData.nationalityOther = data["nationalityOther"] as? String
                        daData.gender = data["gender"] as? Int
                        daData.maritalStatus = data["maritalStatus"] as? Int
                        daData.currentAddress = data["currentAddress"] as? String
                        daData.permanentAddress = data["permanentAddress"] as? String
                        daData.typeOfResidence = data["typeOfResidence"] as? Int
                        daData.typeOfResidenceOther = data["typeOfResidenceOther"] as? String
                        daData.livingWith = data["livingWith"] as? Int
                        daData.livingWithOther = data["livingWithOther"] as? String
                        daData.yearOfStayYear = data["yearOfStayYear"] as? Int
                        daData.yearOfStayMonth = data["yearOfStayMonth"] as? Int
                        daData.mobileNo = data["mobileNo"] as? String
                        daData.residentTelNo = data["residentTelNo"] as? String
                        daData.otherPhoneNo = data["otherPhoneNo"] as? String
                        daData.email = data["email"] as? String
                        daData.customerId = data["customerId"] as? Int
                        daData.daLoanTypeId = data["daLoanTypeId"] as? Int
                        
                        if (data["financeAmount"] as? Double) != nil {
                            daData.financeAmount = data["financeAmount"] as? Double
                        } else {
                            daData.financeAmount = 0.0
                        }
                        
                        if (data["financeTerm"] as? Int) != nil {
                            daData.financeTerm = data["financeTerm"] as? Int
                        } else {
                            daData.financeTerm = 0
                        }
                        
                        
                        daData.daProductTypeId = data["daProductTypeId"] as? Int
                        daData.productDescription = data["productDescription"] as? String
                        daData.channelType = data["channelType"] as? Int
                        
                        //address
                        var appfloor = ""
                        if let floor = data["currentAddressFloor"] as? String {
                            appfloor = floor
                        }
                        daData.currentAddressFloor = appfloor
                        
                        var appBldNo = ""
                        if let floor = data["currentAddressBuildingNo"] as? String {
                            appBldNo = floor
                        }
                        daData.currentAddressBuildingNo = appBldNo
                        
                        var appRoomNo = ""
                        if let floor = data["currentAddressRoomNo"] as? String {
                            appRoomNo = floor
                        }
                        daData.currentAddressRoomNo = appRoomNo
                        
                        var appStreet = ""
                        if let floor = data["currentAddressStreet"] as? String {
                            appStreet = floor
                        }
                        daData.currentAddressStreet = appStreet
                        
                        var appQtr = ""
                        if let floor = data["currentAddressQtr"] as? String {
                            appQtr = floor
                        }
                        daData.currentAddressQtr = appQtr
                        
                        var appTownship = 0
                        if let floor = data["currentAddressTownship"] as? Int {
                            appTownship  = floor
                        }
                        daData.currentAddressTownship = appTownship
                        
                        var appCity = 0
                        if let floor = data["currentAddressCity"] as? Int {
                            appCity  = floor
                        }
                        daData.currentAddressCity = appCity
                        
                        //permanent address
                        
                        var perBldNo = ""
                        if let floor = data["permanentAddressBuildingNo"] as? String {
                            perBldNo = floor
                        }
                        daData.permanentAddressBuildingNo = perBldNo
                        
                        var perRoomNo = ""
                        if let floor = data["permanentAddressRoomNo"] as? String {
                            perRoomNo = floor
                        }
                        daData.permanentAddressRoomNo = perRoomNo
                        
                        var perFloor = ""
                        if let floor = data["permanentAddressFloor"] as? String {
                            perFloor = floor
                        }
                        daData.permanentAddressFloor = perFloor
                        
                        var perStreet = ""
                        if let floor = data["permanentAddressStreet"] as? String {
                            perStreet = floor
                        }
                        daData.permanentAddressStreet = perStreet
                        
                        var perQtr = ""
                        if let floor = data["permanentAddressQtr"] as? String {
                            perQtr = floor
                        }
                        daData.permanentAddressQtr = perQtr
                        
                        var perTownship = 0
                        if let floor = data["permanentddressTownship"] as? Int {
                            perTownship  = floor
                        }
                        daData.permanentAddressTownship = perTownship
                        
                        var perCity = 0
                        if let floor = data["permanentAddressCity"] as? Int {
                            perCity  = floor
                        }
                        daData.permanentAddressCity = perCity
                        
                        if let statusint = data[ModelConstants.STATUS] as? Int {
                            daData.status = statusint
                        }
                        
                        if let companyInfo = data["applicantCompanyInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestring = companyInfo["companyName"] as? String {
                                name = namestring
                            }
                            
                            var companyAddress = ""
                            if let addressstring = companyInfo["companyAddress"] as? String {
                                companyAddress = addressstring
                            }
                            
                            var telNO = ""
                            if let telnostring = companyInfo["companyTelNo"] as? String {
                                telNO = telnostring
                            }
                            
                            var contactTimeFrom = ""
                            if let timefrom = companyInfo["contactTimeFrom"] as? String {
                                contactTimeFrom = timefrom
                            }
                            
                            var contactTimeTo = ""
                            if let timeTo = companyInfo["contactTimeTo"] as? String {
                                contactTimeTo = timeTo
                            }
                            
                            var department = ""
                            if let departmentstring = companyInfo["department"] as? String {
                                department = departmentstring
                            }
                            
                            var position = ""
                            if let positionstr = companyInfo["position"] as? String {
                                position = positionstr
                            }
                            
                            var yearOfServiceYear = 0
                            if let yearserviceint = companyInfo["yearOfServiceYear"] as? Int {
                                yearOfServiceYear = yearserviceint
                            }
                            
                            var yearOfServiceMonth = 0
                            if let monthserviceint = companyInfo["yearOfServiceMonth"] as? Int {
                                yearOfServiceMonth = monthserviceint
                            }
                            
                            var companyStatus = 1
                            if let companystatusint = companyInfo["companyStatus"] as? Int {
                                companyStatus = companystatusint
                            }
                            
                            var companyStatusOther = ""
                            if let statusOther = companyInfo["companyStatusOther"] as? String {
                                companyStatusOther = (statusOther as? String)!
                            }
                            
                            var monthlyBasicIncome = 0.0
                            if let basicincome = companyInfo["monthlyBasicIncome"] as? Double {
                                monthlyBasicIncome = basicincome
                            }
                            
                            var otherIncome = 0.0
                            if let otherincomedouble = companyInfo["otherIncome"] as? Double {
                                otherIncome = otherincomedouble
                            }
                            var totalIncome = 0.0
                            if let totalincomedouble = companyInfo["totalIncome"] as? Double {
                                totalIncome = totalincomedouble
                            }
                            
                            var salaryDate = 1
                            if let salarydatestr = companyInfo["salaryDay"] as? Int {
                                salaryDate = salarydatestr
                            }
                            
                            var companyID = 0
                            if let emergencyid = companyInfo["daApplicantCompanyInfoId"] as? Int {
                                companyID = emergencyid
                            }
                            
                            var companyBldNo = ""
                            if let statusOther = companyInfo["companyAddressBuildingNo"] as? String {
                                companyBldNo = statusOther
                            }
                            
                            var companyRoomNo = ""
                            if let statusOther = companyInfo["companyAddressRoomNo"] as? String {
                                companyRoomNo = statusOther
                            }
                            
                            var companyFloor = ""
                            if let statusOther = companyInfo["companyAddressFloor"] as? String {
                                companyFloor = statusOther
                            }
                            
                            var companyStreet = ""
                            if let statusOther = companyInfo["companyAddressStreet"] as? String {
                                companyStreet = statusOther
                            }
                            
                            var companyQtr = ""
                            if let statusOther = companyInfo["companyAddressQtr"] as? String {
                                companyQtr = statusOther
                            }
                            
                            var companyTownship = 0
                            if let statusOther = companyInfo["companyAddressTownship"] as? Int {
                                companyTownship = statusOther
                            }
                            
                            var companyCity = 0
                            if let statusOther = companyInfo["companyAddressCity"] as? Int {
                                companyCity = statusOther
                            }
                            
                            daData.applicantCompanyInfoDto = OccupationDataRequest(daApplicantCompanyInfoId: companyID, companyName: name, companyAddress: companyAddress, companyTelNo: telNO, contactTimeFrom: contactTimeFrom, contactTimeTo: contactTimeTo, department: department, position: position, yearOfServiceYear: yearOfServiceYear, yearOfServiceMonth: yearOfServiceMonth, companyStatus: companyStatus, companyStatusOther: companyStatusOther, monthlyBasicIncome: monthlyBasicIncome, otherIncome: otherIncome, totalIncome: totalIncome, salaryDay: salaryDate, companyAddressBuildingNo: companyBldNo, companyAddressRoomNo: companyRoomNo, companyAddressFloor: companyFloor, companyAddressStreet: companyStreet, companyAddressQtr: companyQtr, companyAddressTownship: companyTownship, companyAddressCity: companyCity)
                        }
                        
                        if let emergency = data["emergencyContactInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestr = emergency["name"] as? String {
                                name = namestr
                            }
                            
                            var relationship = 0
                            if let rsInt = emergency["relationship"] as? Int {
                                relationship = rsInt
                            }
                            
                            var currentAddress = ""
                            if let addressstr = emergency["currentAddress"] as? String {
                                currentAddress =  addressstr
                            }
                            
                            var rsOtherwith = ""
                            if let rsOther = emergency["relationshipOther"] as? String {
                                rsOtherwith = (rsOther as? String)!
                            }
                            
                            var mobileNo = ""
                            if let phno = emergency["mobileNo"] as? String {
                                mobileNo = phno
                            }
                            
                            var residentTelNo = ""
                            if let rsTelNo = emergency["residentTelNo"] as? String {
                                residentTelNo = rsTelNo
                            }
                            
                            var otherphnumber = ""
                            if let otherPh = emergency["otherPhoneNo"] as? String {
                                otherphnumber = (otherPh as? String)!
                            }
                            
                            var emergencyID = 0
                            if let emergencyid = emergency["daEmergencyContactInfoId"] as? Int {
                                emergencyID = emergencyid
                            }
                            
                            var emerFloor = ""
                            if let statusOther = emergency["currentAddressFloor"] as? String {
                                emerFloor = statusOther
                            }
                            
                            var emer_Bldno = ""
                            if let statusOther = emergency["currentAddressBuildingNo"] as? String {
                                emer_Bldno = statusOther
                            }
                            
                            var emer_roomno = ""
                            if let statusOther = emergency["currentAddressRoomNo"] as? String {
                                emer_roomno = statusOther
                            }
                            
                            var emer_street = ""
                            if let statusOther = emergency["currentAddressStreet"] as? String {
                                emer_street = statusOther
                            }
                            
                            var emer_qtr = ""
                            if let statusOther = emergency["currentAddressQtr"] as? String {
                                emer_qtr = statusOther
                            }
                            
                            var emer_township = 0
                            if let statusOther = emergency["currentAddressTownship"] as? Int {
                                emer_township = statusOther
                            }
                            
                            var emer_city = 0
                            if let statusOther = emergency["currentAddressCity"] as? Int {
                                emer_city = statusOther
                            }

                            
                            daData.emergencyContactInfoDto = EmergencyContactRequest(daEmergencyContactInfoId: emergencyID, name: name, relationship: relationship, relationshipOther: rsOtherwith, currentAddress: currentAddress, mobileNo: mobileNo, residentTelNo: residentTelNo, otherPhoneNo: otherphnumber, currentAddressFloor: emerFloor, currentAddressBuildingNo: emer_Bldno, currentAddressRoomNo: emer_roomno, currentAddressStreet: emer_street, currentAddressQtr: emer_qtr, currentAddressTownship: emer_township, currentAddressCity: emer_city)
                        }
                        
                        if let guarantor = data["guarantorInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestr = guarantor["name"] as? String {
                                name = namestr
                            }
                            var dob = ""
                            if let dobstr = guarantor["dob"] as? String {
                                dob = dobstr
                            }
                            
                            var nrcNo = ""
                            if let nrcstr = guarantor["nrcNo"] as? String {
                                nrcNo = nrcstr
                            }
                            
                            var nationality = 1
                            if let nationalityint = guarantor["nationality"] as? Int {
                                nationality = nationalityint
                            }
                            
                            var nother = ""
                            if let nationalityOther = guarantor["nationalityOther"] as? String {
                                nother = (nationalityOther as? String)!
                            }
                            
                            var mobileNo = ""
                            if let phnostr = guarantor["mobileNo"] as? String {
                                mobileNo = phnostr
                            }
                            
                            var residentTelNo = ""
                            if let rsTelNo = guarantor["residentTelNo"] as? String {
                                residentTelNo = rsTelNo
                            }
                            
                            var relationship = 1
                            if let rsInt = guarantor["relationship"] as? Int {
                                relationship = rsInt
                            }
                            var rsOther = ""
                            if let relationshipOther = guarantor["relationshipOther"] as? String  {
                                rsOther = (relationshipOther as? String)!
                            }
                            
                            var currentAddress = ""
                            if let addressstr = guarantor["currentAddress"] as? String {
                                currentAddress = addressstr
                            }
                            
                            var typeOfResidence = 1
                            if let typeint = guarantor["typeOfResidence"] as? Int {
                                typeOfResidence = typeint
                            }
                            var type = ""
                            if let typeOfResidenceOther = guarantor["typeOfResidenceOther"] as? String  {
                                type = (typeOfResidenceOther as? String)!
                            }
                            
                            var livingWith = 1
                            if let lwint = guarantor["livingWith"] as? Int {
                                livingWith = lwint
                            }
                            var livewithOther = ""
                            if let livingWithOther = guarantor["livingWithOther"] as? String  {
                                livewithOther = (livingWithOther as? String)!
                            }
                            
                            var gender = 1
                            if let genderint = guarantor["gender"] as? Int {
                                gender = genderint
                            }
                            
                            var maritalStatus = 1
                            if let mStatus = guarantor["maritalStatus"] as? Int {
                                maritalStatus = mStatus
                            }
                            
                            var yearOfStayYear = 0
                            if let yearyear = guarantor["yearOfStayYear"] as? Int {
                                yearOfStayYear = yearyear
                            }
                            
                            var yearOfStayMonth = 0
                            if let yearMohth = guarantor["yearOfStayMonth"] as? Int {
                                yearOfStayMonth = yearMohth
                            }
                            
                            var companyName = ""
                            if let cName = guarantor["companyName"] as? String {
                                companyName = cName
                            }
                            
                            var companyTelNo = ""
                            if let cTelNo = guarantor["companyTelNo"] as? String {
                                companyTelNo = cTelNo
                            }
                            
                            var companyAddress = ""
                            if let cAddress = guarantor["companyAddress"] as? String {
                                companyAddress = cAddress
                            }
                            
                            var department = ""
                            if let dpart = guarantor["department"] as? String  {
                                
                                department = dpart
                            }
                            
                            var position = ""
                            if let positionstr = guarantor["position"] as? String {
                                position = positionstr
                            }
                            
                            var yearOfServiceYear = 0
                            if let yearservice = guarantor["yearOfServiceYear"] as? Int {
                                yearOfServiceYear = yearservice
                            }
                            
                            var yearOfServiceMonth = 0
                            if let monthService = guarantor["yearOfServiceMonth"] as? Int {
                                yearOfServiceMonth = monthService
                            }
                            
                            var monthlyBasicIncome = 0.0
                            if let basicincome = guarantor["monthlyBasicIncome"] as? Double {
                                monthlyBasicIncome = basicincome
                            }
                            
                            var totalIncome = 0.0
                            if let totaldouble = guarantor["totalIncome"] as? Double {
                                totalIncome = totaldouble
                            }
                            
                            var guarantorId = 0
                            if let emergencyid = guarantor["daGuarantorInfoId"] as? Int {
                                guarantorId = emergencyid
                            }
                            
                            var guaFloor = ""
                            if let cAddress = guarantor["currentAddressFloor"] as? String {
                                guaFloor = cAddress
                            }

                            var guaBldNo = ""
                            if let cAddress = guarantor["currentAddressBuildingNo"] as? String {
                                guaBldNo = cAddress
                            }
                            
                            var guaRoomNo = ""
                            if let cAddress = guarantor["currentAddressRoomNo"] as? String {
                                guaRoomNo = cAddress
                            }
                            
                            var guaStreet = ""
                            if let cAddress = guarantor["currentAddressStreet"] as? String {
                                guaStreet = cAddress
                            }
                            
                            var guaQtr = ""
                            if let cAddress = guarantor["currentAddressQtr"] as? String {
                                guaQtr = cAddress
                            }
                            
                            var guaTownship = 0
                            if let cAddress = guarantor["currentAddressTownship"] as? Int {
                                guaTownship = cAddress
                            }
                            
                            var guaCity = 0
                            if let cAddress = guarantor["currentAddressCity"] as? Int {
                                guaCity = cAddress
                            }
                            //companyaddress
                            var guaCompanyFloor = ""
                            if let cAddress = guarantor["companyAddressFloor"] as? String {
                                guaFloor = cAddress
                            }

                            var guaCompanyBldNo = ""
                            if let cAddress = guarantor["companyAddressBuildingNo"] as? String {
                                guaCompanyBldNo = cAddress
                            }
                            
                            var guaCompanyRoomNo = ""
                            if let cAddress = guarantor["companyAddressRoomNo"] as? String {
                                guaCompanyRoomNo = cAddress
                            }
                            
                            var guaCompanyStreet = ""
                            if let cAddress = guarantor["companyAddressStreet"] as? String {
                                guaCompanyStreet = cAddress
                            }
                            
                            var guaCompanyQtr = ""
                            if let cAddress = guarantor["companyAddressQtr"] as? String {
                                guaCompanyQtr = cAddress
                            }
                            
                            var guaCompanyTownship = 0
                            if let cAddress = guarantor["companyAddressTownship"] as? Int {
                                guaCompanyTownship = cAddress
                            }
                            
                            var guaCompanyCity = 0
                            if let cAddress = guarantor["companyAddressCity"] as? Int {
                                guaCompanyCity = cAddress
                            }
                            
                            daData.guarantorInfoDto = GuarantorRequest(daGuarantorInfoId: guarantorId,name: name, dob: dob, nrcNo: nrcNo, nationality: nationality, nationalityOther: nother, mobileNo: mobileNo, residentTelNo: residentTelNo, relationship: relationship, relationshipOther: rsOther, currentAddress: currentAddress, typeOfResidence: typeOfResidence, typeOfResidenceOther: type, livingWith: livingWith, livingWithOther: livewithOther, gender: gender, maritalStatus: maritalStatus, yearOfStayYear: yearOfStayYear, yearOfStayMonth: yearOfStayMonth, companyName: companyName, companyTelNo: companyTelNo, companyAddress: companyAddress, department: department, position: position, yearOfServiceYear: yearOfServiceYear, yearOfServiceMonth: yearOfServiceMonth, monthlyBasicIncome: monthlyBasicIncome, totalIncome: totalIncome, currentAddressFloor: guaFloor, currentAddressBuildingNo: guaBldNo, currentAddressRoomNo: guaRoomNo, currentAddressStreet: guaStreet, currentAddressQtr: guaQtr, currentAddressTownship: guaTownship, currentAddressCity: guaCity, companyAddressBuildingNo: guaCompanyBldNo, companyAddressRoomNo: guaCompanyRoomNo, companyAddressFloor: guaCompanyFloor, companyAddressStreet: guaCompanyStreet, companyAddressQtr: guaCompanyQtr, companyAddressTownship: guaCompanyTownship, companyAddressCity: guaCompanyCity)
                        }
                        success(daData)
                        
                    }
                } else if response[ModelConstants.STATUS] as! String == Constants.STATUS_500 {
                    if response["messageCode"] as! String == Constants.APPLICATION_LIMIT {
                        failure(Constants.APPLICATION_LIMIT)
                    }
                    
                } else {
                    failure(Constants.JSON_FAILURE)
                }
                
            case .failure(let error):
                //print("Register New error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func getLoanApplicationList(token:String, listRequest: DAInquiryResquest , success: @escaping ([DAInquiryResponse]) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "customerId": listRequest.customerId,
            "daLoanTypeId": listRequest.daLoanTypeId,
            "appliedDate": listRequest.appliedDate,
            "applicationNo": listRequest.applicationNo,
            "status": listRequest.status,
            "offset": listRequest.offset,
            "limit": listRequest.limit
        ]
        
        let _ = super.requestDataWithTokenDAWithStringDict(endPoint: ApiServiceEndPoint.daListRequest, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                let response = result as AnyObject
                print("getLoanApplicationList : ", response)
                var daData = DAInquiryResponse()
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    
                    if  (response[ModelConstants.DATA] as? Dictionary<String, Any>) == nil {
                        failure("Empty")
                    }
                        
                    else {
                        
                        let data = response[ModelConstants.DATA] as AnyObject
                        
                        if let listData = data["applicationInfoDtoList"] as? [Dictionary<String, Any>] {
                            let daInquryList = self.getLoanApplicationInquiryList(arrlist: listData)
                            success(daInquryList)
                        }
                    }
                } else {
                    if response["messageCode"] as! String == "SERVICE_UNAVAILABLE" {
                        failure(Constants.SERVER_FAILURE)
                    } else {
                        failure(Constants.JSON_FAILURE)
                    }
                }
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                
            }
        }
    }
    
    func getLoanApplicationInquiryList(arrlist: [Dictionary<String, Any>]) -> [DAInquiryResponse] {
        var responseArray = [DAInquiryResponse]()
        for arr in arrlist {
            var daResponse = DAInquiryResponse()
            daResponse.daApplicationInfoId = arr["daApplicationInfoId"] as? Int
            daResponse.daLoanTypeId = arr["daLoanTypeId"] as? Int
            daResponse.financeAmount = arr["financeAmount"] as? Double
            daResponse.financeTerm = arr["financeTerm"] as? Int
            daResponse.status = arr["status"] as? Int
            daResponse.appliedDate = arr["appliedDate"] as? String
            daResponse.applicationNo = arr["applicationNo"] as? String
            responseArray.append(daResponse)
        }
        
        return responseArray
    }
    
    func getPurchaseDetail(token:String, applicationID: String, success: @escaping (PurchaseDetailResponse) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "daApplicationInfoId": applicationID
        ]
        
        let _ = super.requestDataWithTokenDAWithStringDict(endPoint: ApiServiceEndPoint.daPurchaseInfoDetail, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                //print("News Response result :::::::::::\(result)")
                
                if let newsResponse = try? JSONDecoder().decode(PurchaseDetailResponse.self, from: responseValue){
                    success(newsResponse)
                }else{
                    failure(Constants.EXPIRE_TOKEN)
                }
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                
            }
        }
    }
    
    func getApplicationInfoDetail(token:String, applicationID: String, success: @escaping (ApplicationDetailResponse) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "daApplicationInfoId": applicationID
        ]
        
        let _ = super.requestDataWithTokenDAWithStringDict(endPoint: ApiServiceEndPoint.daApplicationInfoDetail, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("app info detail response : ", response)
                
                var daData = ApplicationDetailResponse()
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    
                    if  (response[ModelConstants.DATA] as? Dictionary<String, Any>) == nil {
                        failure("Empty")
                    }
                        
                    else {
                        
                        let data = response[ModelConstants.DATA] as AnyObject
                        
                        daData.daApplicationInfoId = data["daApplicationInfoId"] as? Int
                        daData.applicationNo = data["applicationNo"] as? String
                        daData.appliedDate = data["appliedDate"] as? String
                        daData.status = data["status"] as? Int
                        daData.settlementPendingComment = data["settlementPendingComment"] as? String
                        daData.daInterestInfoId = data["daInterestInfoId"] as? Int
                        daData.daCompulsoryInfoId = data["daCompulsoryInfoId"] as? Int
                        daData.daApplicationTypeId = data["daApplicationTypeId"] as? Int
                        daData.name = data["name"] as? String
                        daData.dob = data["dob"] as? String
                        daData.nrcNo = data["nrcNo"] as? String
                        daData.fatherName = data["fatherName"] as? String
                        daData.nationality = data["nationality"] as? Int
                        daData.nationalityOther = data["nationalityOther"] as? String
                        daData.gender = data["gender"] as? Int
                        daData.maritalStatus = data["maritalStatus"] as? Int
                        daData.currentAddress = data["currentAddress"] as? String
                        daData.currentAddressBuildingNo = data["currentAddressBuildingNo"] as? String
                        daData.currentAddressFloor = data["currentAddressFloor"] as? String
                        daData.currentAddressRoomNo = data["currentAddressRoomNo"] as? String
                        daData.currentAddressStreet = data["currentAddressStreet"] as? String
                        daData.currentAddressQtr = data["currentAddressQtr"] as? String
                        daData.currentAddressTownship = data["currentAddressTownship"] as? Int
                        daData.currentAddressCity = data["currentAddressCity"] as? Int
                        daData.permanentAddress = data["permanentAddress"] as? String
                        daData.permanentAddressBuildingNo = data["permanentAddressBuildingNo"] as? String
                        daData.permanentAddressRoomNo = data["permanentAddressRoomNo"] as? String
                        daData.permanentAddressFloor = data["permanentAddressFloor"] as? String
                        daData.permanentAddressStreet = data["permanentAddressStreet"] as? String
                        daData.permanentAddressQtr = data["permanentAddressQtr"] as? String
                        daData.permanentAddressTownship = data["permanentAddressTownship"] as? Int
                        daData.permanentAddressCity = data["permanentAddressCity"] as? Int
                        daData.typeOfResidence = data["typeOfResidence"] as? Int
                        daData.typeOfResidenceOther = data["typeOfResidenceOther"] as? String
                        daData.livingWith = data["livingWith"] as? Int
                        daData.livingWithOther = data["livingWithOther"] as? String
                        daData.yearOfStayYear = data["yearOfStayYear"] as? Int
                        daData.yearOfStayMonth = data["yearOfStayMonth"] as? Int
                        daData.mobileNo = data["mobileNo"] as? String
                        daData.residentTelNo = data["residentTelNo"] as? String
                        daData.otherPhoneNo = data["otherPhoneNo"] as? String
                        daData.email = data["email"] as? String
                        daData.customerId = data["customerId"] as? Int
                        daData.daLoanTypeId = data["daLoanTypeId"] as? Int
                        daData.financeAmount = data["financeAmount"] as? Double
                        daData.financeTerm = data["financeTerm"] as? Int
                        daData.daProductTypeId = data["daProductTypeId"] as? Int
                        daData.productDescription = data["productDescription"] as? String
                        daData.channelType = data["channelType"] as? Int
                        
                        if let statusint = data["status"] as? Int {
                            daData.status = statusint
                        }
                        
                        if let companyInfo = data["applicantCompanyInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestring = companyInfo["companyName"] as? String {
                                name = namestring
                            }
                            
                            var companyAddress = ""
                            if let addressstring = companyInfo["companyAddress"] as? String {
                                companyAddress = addressstring
                            }
                            
                            var telNO = ""
                            if let telnostring = companyInfo["companyTelNo"] as? String {
                                telNO = telnostring
                            }
                            
                            var contactTimeFrom = ""
                            if let timefrom = companyInfo["contactTimeFrom"] as? String {
                                contactTimeFrom = timefrom
                            }
                            
                            var contactTimeTo = ""
                            if let timeTo = companyInfo["contactTimeTo"] as? String {
                                contactTimeTo = timeTo
                            }
                            
                            var department = ""
                            if let departmentstring = companyInfo["department"] as? String {
                                department = departmentstring
                            }
                            
                            var position = ""
                            if let positionstr = companyInfo["position"] as? String {
                                position = positionstr
                            }
                            
                            var yearOfServiceYear = 0
                            if let yearserviceint = companyInfo["yearOfServiceYear"] as? Int {
                                yearOfServiceYear = yearserviceint
                            }
                            
                            var yearOfServiceMonth = 0
                            if let monthserviceint = companyInfo["yearOfServiceMonth"] as? Int {
                                yearOfServiceMonth = monthserviceint
                            }
                            
                            var companyStatus = 1
                            if let companystatusint = companyInfo["companyStatus"] as? Int {
                                companyStatus = companystatusint
                            }
                            
                            var companyStatusOther = ""
                            if let statusOther = companyInfo["companyStatusOther"] as? String {
                                companyStatusOther = statusOther
                            }
                            
                            var monthlyBasicIncome = 0.0
                            if let basicincome = companyInfo["monthlyBasicIncome"] as? Double {
                                monthlyBasicIncome = basicincome
                            }
                            
                            var otherIncome = 0.0
                            if let otherincomedouble = companyInfo["otherIncome"] as? Double {
                                otherIncome = otherincomedouble
                            }
                            var totalIncome = 0.0
                            if let totalincomedouble = companyInfo["totalIncome"] as? Double {
                                totalIncome = totalincomedouble
                            }
                            
                            var salaryDate = 1
                            if let salarydatestr = companyInfo["salaryDay"] as? Int {
                                salaryDate = salarydatestr
                            }
                            
                            var companyID = 0
                            if let emergencyid = companyInfo["daApplicantCompanyInfoId"] as? Int {
                                companyID = emergencyid
                            }
                            
                            var companyBldNo = ""
                            if let statusOther = companyInfo["companyAddressBuildingNo"] as? String {
                                companyBldNo = statusOther
                            }
                            
                            var companyRoomNo = ""
                            if let statusOther = companyInfo["companyAddressRoomNo"] as? String {
                                companyRoomNo = statusOther
                            }
                            
                            var companyFloor = ""
                            if let statusOther = companyInfo["companyAddressFloor"] as? String {
                                companyFloor = statusOther
                            }
                            
                            var companyStreet = ""
                            if let statusOther = companyInfo["companyAddressStreet"] as? String {
                                companyStreet = statusOther
                            }
                            
                            var companyQtr = ""
                            if let statusOther = companyInfo["companyAddressQtr"] as? String {
                                companyQtr = statusOther
                            }
                            
                            var companyTownship = 0
                            if let statusOther = companyInfo["companyAddressTownship"] as? Int {
                                companyTownship = statusOther
                            }
                            
                            var companyCity = 0
                            if let statusOther = companyInfo["companyAddressCity"] as? Int {
                                companyCity = statusOther
                            }
                            
                            daData.applicantCompanyInfoDto = OccupationDataRequest(daApplicantCompanyInfoId: companyID, companyName: name, companyAddress: companyAddress, companyTelNo: telNO, contactTimeFrom: contactTimeFrom, contactTimeTo: contactTimeTo, department: department, position: position, yearOfServiceYear: yearOfServiceYear, yearOfServiceMonth: yearOfServiceMonth, companyStatus: companyStatus, companyStatusOther: companyStatusOther, monthlyBasicIncome: monthlyBasicIncome, otherIncome: otherIncome, totalIncome: totalIncome, salaryDay: salaryDate, companyAddressBuildingNo: companyBldNo, companyAddressRoomNo: companyRoomNo, companyAddressFloor: companyFloor, companyAddressStreet: companyStreet, companyAddressQtr: companyQtr, companyAddressTownship: companyTownship, companyAddressCity: companyCity)
                        }
                        
                        if let emergency = data["emergencyContactInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestr = emergency["name"] as? String {
                                name = namestr
                            }
                            
                            var relationship = 0
                            if let rsInt = emergency["relationship"] as? Int {
                                relationship = rsInt
                            }
                            
                            var currentAddress = ""
                            if let addressstr = emergency["currentAddress"] as? String {
                                currentAddress =  addressstr
                            }
                            
                            var rsOtherwith = ""
                            if let rsOther = emergency["relationshipOther"] as? String {
                                rsOtherwith = rsOther
                            }
                            
                            var mobileNo = ""
                            if let phno = emergency["mobileNo"] as? String {
                                mobileNo = phno
                            }
                            
                            var residentTelNo = ""
                            if let rsTelNo = emergency["residentTelNo"] as? String {
                                residentTelNo = rsTelNo
                            }
                            
                            var otherphnumber = ""
                            if let otherPh = emergency["otherPhoneNo"] as? String {
                                otherphnumber = otherPh
                            }
                            
                            var emergencyID = 0
                            if let emergencyid = emergency["daEmergencyContactInfoId"] as? Int {
                                emergencyID = emergencyid
                            }
                            
                            var emerFloor = ""
                            if let statusOther = emergency["currentAddressFloor"] as? String {
                                emerFloor = statusOther
                            }
                            
                            var emer_Bldno = ""
                            if let statusOther = emergency["currentAddressBuildingNo"] as? String {
                                emer_Bldno = statusOther
                            }
                            
                            var emer_roomno = ""
                            if let statusOther = emergency["currentAddressRoomNo"] as? String {
                                emer_roomno = statusOther
                            }
                            
                            var emer_street = ""
                            if let statusOther = emergency["currentAddressStreet"] as? String {
                                emer_street = statusOther
                            }
                            
                            var emer_qtr = ""
                            if let statusOther = emergency["currentAddressQtr"] as? String {
                                emer_qtr = statusOther
                            }
                            
                            var emer_township = 0
                            if let statusOther = emergency["currentAddressTownship"] as? Int {
                                emer_township = statusOther
                            }
                            
                            var emer_city = 0
                            if let statusOther = emergency["currentAddressCity"] as? Int {
                                emer_city = statusOther
                            }
                            
                            daData.emergencyContactInfoDto = EmergencyContactRequest(daEmergencyContactInfoId: emergencyID, name: name, relationship: relationship, relationshipOther: rsOtherwith, currentAddress: currentAddress, mobileNo: mobileNo, residentTelNo: residentTelNo, otherPhoneNo: otherphnumber, currentAddressFloor: emerFloor, currentAddressBuildingNo: emer_Bldno, currentAddressRoomNo: emer_roomno, currentAddressStreet: emer_street, currentAddressQtr: emer_qtr, currentAddressTownship: emer_township, currentAddressCity: emer_city)
                        }
                        
                        if let guarantor = data["guarantorInfoDto"] as? AnyObject {
                            var name = ""
                            if let namestr = guarantor["name"] as? String {
                                name = namestr
                            }
                            var dob = ""
                            if let dobstr = guarantor["dob"] as? String {
                                dob = dobstr
                            }
                            
                            var nrcNo = ""
                            if let nrcstr = guarantor["nrcNo"] as? String {
                                nrcNo = nrcstr
                            }
                            
                            var nationality = 1
                            if let nationalityint = guarantor["nationality"] as? Int {
                                nationality = nationalityint
                            }
                            
                            var nother = ""
                            if let nationalityOther = guarantor["nationalityOther"] as? String {
                                nother = nationalityOther
                            }
                            
                            var mobileNo = ""
                            if let phnostr = guarantor["mobileNo"] as? String {
                                mobileNo = phnostr
                            }
                            
                            var residentTelNo = ""
                            if let rsTelNo = guarantor["residentTelNo"] as? String {
                                residentTelNo = rsTelNo
                            }
                            
                            var relationship = 1
                            if let rsInt = guarantor["relationship"] as? Int {
                                relationship = rsInt
                            }
                            var rsOther = ""
                            if let relationshipOther = guarantor["relationshipOther"] as? String  {
                                rsOther = relationshipOther
                            }
                            
                            var currentAddress = ""
                            if let addressstr = guarantor["currentAddress"] as? String {
                                currentAddress = addressstr
                            }
                            
                            var typeOfResidence = 1
                            if let typeint = guarantor["typeOfResidence"] as? Int {
                                typeOfResidence = typeint
                            }
                            var type = ""
                            if let typeOfResidenceOther = guarantor["typeOfResidenceOther"] as? String  {
                                type = typeOfResidenceOther
                            }
                            
                            var livingWith = 1
                            if let lwint = guarantor["livingWith"] as? Int {
                                livingWith = lwint
                            }
                            var livewithOther = ""
                            if let livingWithOther = guarantor["livingWithOther"] as? String  {
                                livewithOther = livingWithOther
                            }
                            
                            var gender = 1
                            if let genderint = guarantor["gender"] as? Int {
                                gender = genderint
                            }
                            
                            var maritalStatus = 1
                            if let mStatus = guarantor["maritalStatus"] as? Int {
                                maritalStatus = mStatus
                            }
                            
                            var yearOfStayYear = 0
                            if let yearyear = guarantor["yearOfStayYear"] as? Int {
                                yearOfStayYear = yearyear
                            }
                            
                            var yearOfStayMonth = 0
                            if let yearMohth = guarantor["yearOfStayMonth"] as? Int {
                                yearOfStayMonth = yearMohth
                            }
                            
                            var companyName = ""
                            if let cName = guarantor["companyName"] as? String {
                                companyName = cName
                            }
                            
                            var companyTelNo = ""
                            if let cTelNo = guarantor["companyTelNo"] as? String {
                                companyTelNo = cTelNo
                            }
                            
                            var companyAddress = ""
                            if let cAddress = guarantor["companyAddress"] as? String {
                                companyAddress = cAddress
                            }
                            
                            var department = ""
                            if let dpart = guarantor["department"] as? String  {
                                
                                department = dpart
                            }
                            
                            var position = ""
                            if let positionstr = guarantor["position"] as? String {
                                position = positionstr
                            }
                            
                            var yearOfServiceYear = 0
                            if let yearservice = guarantor["yearOfServiceYear"] as? Int {
                                yearOfServiceYear = yearservice
                            }
                            
                            var yearOfServiceMonth = 0
                            if let monthService = guarantor["yearOfServiceMonth"] as? Int {
                                yearOfServiceMonth = monthService
                            }
                            
                            var monthlyBasicIncome = 0.0
                            if let basicincome = guarantor["monthlyBasicIncome"] as? Double {
                                monthlyBasicIncome = basicincome
                            }
                            
                            var totalIncome = 0.0
                            if let totaldouble = guarantor["totalIncome"] as? Double {
                                totalIncome = totaldouble
                            }
                            
                            var guarantorId = 0
                            if let emergencyid = guarantor["daGuarantorInfoId"] as? Int {
                                guarantorId = emergencyid
                            }
                            
                            var guaFloor = ""
                            if let cAddress = guarantor["currentAddressFloor"] as? String {
                                guaFloor = cAddress
                            }

                            var guaBldNo = ""
                            if let cAddress = guarantor["currentAddressBuildingNo"] as? String {
                                guaBldNo = cAddress
                            }
                            
                            var guaRoomNo = ""
                            if let cAddress = guarantor["currentAddressRoomNo"] as? String {
                                guaRoomNo = cAddress
                            }
                            
                            var guaStreet = ""
                            if let cAddress = guarantor["currentAddressStreet"] as? String {
                                guaStreet = cAddress
                            }
                            
                            var guaQtr = ""
                            if let cAddress = guarantor["currentAddressQtr"] as? String {
                                guaQtr = cAddress
                            }
                            
                            var guaTownship = 0
                            if let cAddress = guarantor["currentAddressTownship"] as? Int {
                                guaTownship = cAddress
                            }
                            
                            var guaCity = 0
                            if let cAddress = guarantor["currentAddressCity"] as? Int {
                                guaCity = cAddress
                            }
                            //companyaddress
                            var guaCompanyFloor = ""
                            if let cAddress = guarantor["companyAddressFloor"] as? String {
                                guaCompanyFloor = cAddress
                            }

                            var guaCompanyBldNo = ""
                            if let cAddress = guarantor["companyAddressBuildingNo"] as? String {
                                guaCompanyBldNo = cAddress
                            }
                            
                            var guaCompanyRoomNo = ""
                            if let cAddress = guarantor["companyAddressRoomNo"] as? String {
                                guaCompanyRoomNo = cAddress
                            }
                            
                            var guaCompanyStreet = ""
                            if let cAddress = guarantor["companyAddressStreet"] as? String {
                                guaCompanyStreet = cAddress
                            }
                            
                            var guaCompanyQtr = ""
                            if let cAddress = guarantor["companyAddressQtr"] as? String {
                                guaCompanyQtr = cAddress
                            }
                            
                            var guaCompanyTownship = 0
                            if let cAddress = guarantor["companyAddressTownship"] as? Int {
                                guaCompanyTownship = cAddress
                            }
                            
                            var guaCompanyCity = 0
                            if let cAddress = guarantor["companyAddressCity"] as? Int {
                                guaCompanyCity = cAddress
                            }
                            
                            daData.guarantorInfoDto = GuarantorRequest(daGuarantorInfoId: guarantorId,name: name, dob: dob, nrcNo: nrcNo, nationality: nationality, nationalityOther: nother, mobileNo: mobileNo, residentTelNo: residentTelNo, relationship: relationship, relationshipOther: rsOther, currentAddress: currentAddress, typeOfResidence: typeOfResidence, typeOfResidenceOther: type, livingWith: livingWith, livingWithOther: livewithOther, gender: gender, maritalStatus: maritalStatus, yearOfStayYear: yearOfStayYear, yearOfStayMonth: yearOfStayMonth, companyName: companyName, companyTelNo: companyTelNo, companyAddress: companyAddress, department: department, position: position, yearOfServiceYear: yearOfServiceYear, yearOfServiceMonth: yearOfServiceMonth, monthlyBasicIncome: monthlyBasicIncome, totalIncome: totalIncome, currentAddressFloor: guaFloor, currentAddressBuildingNo: guaBldNo, currentAddressRoomNo: guaRoomNo, currentAddressStreet: guaStreet, currentAddressQtr: guaQtr, currentAddressTownship: guaTownship, currentAddressCity: guaCity, companyAddressBuildingNo: guaCompanyBldNo, companyAddressRoomNo: guaCompanyRoomNo, companyAddressFloor: guaCompanyFloor, companyAddressStreet: guaCompanyStreet, companyAddressQtr: guaCompanyQtr, companyAddressTownship: guaCompanyTownship, companyAddressCity: guaCompanyCity)
                        }
                        if let attachments = data["applicationInfoAttachmentDtoList"] as? [AnyObject] {
                            var attachArray = [PurchaseAttachmentResponse]()
                            for usercard in attachments {
                                var attachid = 0
                                if let emergencyid = usercard["daApplicationInfoAttachmentId"] as? Int {
                                    attachid = emergencyid
                                }
                                
                                var applicationinfoid = 0
                                if let emergencyid = usercard["daApplicationInfoId"] as? Int {
                                    applicationinfoid = emergencyid
                                }
                                
                                var path = ""
                                if let cAddress = usercard["filePath"] as? String {
                                    path = cAddress
                                }
                                
                                var ftype = 0
                                if let cAddress = usercard["fileType"] as? Int {
                                    ftype = cAddress
                                }
                                
                                var eFlag = false
                                if let ef = usercard["editFlag"] as? Bool {
                                    eFlag = ef
                                }
                                
                                let attachobj = PurchaseAttachmentResponse(daPurchaseInfoAttachmentId: attachid, daPurchaseInfoId: applicationinfoid, filePath: path, fileType: ftype, editFlag: eFlag)
                                attachArray.append(attachobj)
                            }
                            
                            daData.applicationInfoAttachmentDtoList = attachArray
                            
                            var pfee = 0.0
                            if let pf = data["processingFees"] as? Double {
                                pfee = pf
                            }
                            daData.processingFees = pfee
                            
                            var consave = 0.0
                            if let cs = data["totalConSaving"] as? Double {
                                consave = cs
                            }
                            daData.totalConSaving = consave
                            
                            var repay = 0.0
                            if let totalrepay = data["totalRepayment"] as? Double {
                                repay = totalrepay
                            }
                            daData.totalRepayment = repay
                            
                            var fpayment = 0.0
                            if let fp = data["firstPayment"] as? Double {
                                fpayment = fp
                            }
                            daData.firstPayment = fpayment
                            
                            var mPayment = 0.0
                            if let mPay = data["monthlyInstallment"] as? Double {
                                mPayment = mPay
                            }
                            daData.monthlyInstallment = mPayment
                            
                            var lastPayment = 0.0
                            if let lPay = data["lastPayment"] as? Double {
                                lastPayment = lPay
                            }
                            daData.lastPayment = lastPayment
                            
                        }
                        success(daData)
                        
                    }
                } else {
                    if response["messageCode"] as! String == "SERVICE_UNAVAILABLE" {
                        failure(Constants.SERVER_FAILURE)
                    } else {
                        failure(Constants.JSON_FAILURE)
                    }
                }
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                
            }
        }
    }
    
    func doApplicationCancel(token:String, applicationID: String, success: @escaping (ApplicationCancelResponse) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "daApplicationInfoId": applicationID
        ]
        
        let _ = super.requestDataWithTokenDAWithStringDict(endPoint: ApiServiceEndPoint.daApplicationCancel, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("app cancel response : ", response)
                
                let status = response[ModelConstants.STATUS] as! String
                //let code = response["messageCode"] as! String
                //let msgStr = response["message"] as! String
                
                let daObj = ApplicationCancelResponse(status: status)
                success(daObj)
                
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func getAgreementList(token:String, customerid: String, success: @escaping ([AgreementInfo]) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "customerId": customerid
        ]
        
        let _ = super.requestDataWithTokenDAWithStringDict(endPoint: ApiServiceEndPoint.agreementlist, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("agreetment list response : ", response)
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    var agreementlist = [AgreementInfo]()
                    if let data = response[ModelConstants.DATA] as? [AnyObject] {
                        
                        for item in data {
                            var agreement = AgreementInfo()
                            var agreementstr = ""
                            if let agreeNoStr = item["agreementNo"] as? String {
                                agreementstr = agreeNoStr
                            }
                            agreement.agreementNo = agreementstr
                            
                            var appNo = ""
                            if let agreementAppNo = item["applicationNo"] as? String {
                                appNo = agreementAppNo
                            }
                            agreement.applicationNo = appNo
                            
                            var encodeQRStr = ""
                            if let qrStr = item["encodeStringForQr"] as? String {
                                encodeQRStr = qrStr
                            }
                            agreement.encodeStringForQr = encodeQRStr
                            
                            var cusid = 0
                            if let emergencyid = item["custAgreementId"] as? Int {
                                cusid = emergencyid
                            }
                            agreement.custAgreementId = cusid
                            //                        agreement.qrShow
                            var appinfoID = 0
                            if let appid = item["daApplicationInfoId"] as? Int {
                                appinfoID = appid
                            }
                            agreement.daApplicationInfoId = appinfoID
                            var financeamt = 0
                            if let amt = item["financialAmt"] as? Int {
                                financeamt = amt
                            }
                            agreement.financialAmt = financeamt
                            
                            var term = 0
                            if let tm = item["financialTerm"] as? Int {
                                term = tm
                            }
                            agreement.financialTerm = term
                            
                            var importcusid = 0
                            if let importid = item["importCustomerId"] as? Int {
                                importcusid = importid
                            }
                            agreement.importCustomerId = importcusid
                            var qr = 0
                            if let qrstatus = item["qrShow"] as? Int {
                                qr = qrstatus
                            }
                            agreement.qrShow = qr
                            
                            
                            var lastPaymentdate = ""
                            if let lastPaymentDate = item["lastPaymentDate"] as? String {
                                lastPaymentdate = lastPaymentDate
                            }
                            agreement.lastPaymentDate = lastPaymentdate
                           
                            agreementlist.append(agreement)
                        }
                    }
                    success(agreementlist)
                }
                
                
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    
    func getQRCodeProductInfo(token:String, appInfoID: String, success: @escaping (QRProductInfo) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "daApplicationInfoId": appInfoID
        ]
        
        let _ = super.requestDataWithTokenDAWithStringDict(endPoint: ApiServiceEndPoint.qrcodeproductinfo, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("QR Product Info response : ", response)
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    var agreement = QRProductInfo()
                    if let data = response[ModelConstants.DATA] as? AnyObject {
                        
                        var agreementstr = ""
                        if let agreeNoStr = data["agreementNo"] as? String {
                            agreementstr = agreeNoStr
                        }
                        agreement.agreementNo = agreementstr
                        
                        var appNo = 0
                        if let agreementAppNo = data["daPurchaseInfoId"] as? Int {
                            appNo = agreementAppNo
                        }
                        agreement.daPurchaseInfoId = appNo
                        
                        var cusid = 0
                        if let emergencyid = data["daApplicationInfoId"] as? Int {
                            cusid = emergencyid
                        }
                        agreement.daApplicationInfoId = cusid
                        
                        var appinfoID = ""
                        if let appid = data["productCode"] as? String {
                            appinfoID = appid
                        }
                        agreement.productCode = appinfoID
                        
                        var financeamt = ""
                        if let amt = data["productName"] as? String {
                            financeamt = amt
                        }
                        agreement.productName = financeamt
                        
                        var term = 0
                        if let tm = data["daLoanTypeId"] as? Int {
                            term = tm
                        }
                        agreement.daLoanTypeId = term
                        
                        var importcusid = ""
                        if let importid = data["purchaseDate"] as? String {
                            importcusid = importid
                        }
                        agreement.purchaseDate = importcusid
                        
                        var qr = ""
                        if let qrstatus = data["model"] as? String {
                            qr = qrstatus
                        }
                        agreement.model = qr
                        
                        var brandstr = ""
                        if let qrstatus = data["brand"] as? String {
                            brandstr = qrstatus
                        }
                        agreement.brand = brandstr
                        
                        var priced = 0.0
                        if let qrstatus = data["price"] as? Double {
                            priced = qrstatus
                        }
                        agreement.price = priced
                        
                        var cashDownAmountd = 0.0
                        if let qrstatus = data["cashDownAmount"] as? Double {
                            cashDownAmountd = qrstatus
                        }
                        agreement.cashDownAmount = cashDownAmountd
                        
                        var outletNamed = ""
                        if let qrstatus = data["outletName"] as? String {
                            outletNamed = qrstatus
                        }
                        agreement.outletName = outletNamed
                        
                        var invoiceNostr = ""
                        if let qrstatus = data["invoiceNo"] as? String {
                            invoiceNostr = qrstatus
                        }
                        agreement.invoiceNo = invoiceNostr
                        
                        var statusd = 0
                        if let qrstatus = data["status"] as? Int {
                            statusd = qrstatus
                        }
                        agreement.status = statusd
                        
                        
                    }
                    success(agreement)
                }
                
                
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func getProductInfoConfirm(token:String, purchaseid: String, cusId: String, appid: String, success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "daPurchaseInfoId": purchaseid,
            "customerId": cusId,
            "daApplicationInfoId": appid
        ]
        
        let _ = super.requestDataWithTokenDAWithStringDict(endPoint: ApiServiceEndPoint.productinfoconfirm, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("Product Info Confirm response : ", response)
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    
                    success("Success")
                } else {
                    failure("Something Wrong with Product info")
                }
                
                
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func getProductInfoCancel(token:String, purchaseid: String, cusId: String, appid: String, success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        let token = [
            "access_token" : token
        ]
        
        let rawData = [
            "daPurchaseInfoId": purchaseid,
            "customerId": cusId,
            "daApplicationInfoId": appid
        ]
        
        let _ = super.requestDataWithTokenDAWithStringDict(endPoint: ApiServiceEndPoint.productinfocancel, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("Product Info Cancel response : ", response)
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    
                    success("Success")
                } else {
                    failure("Something Wrong with Product info")
                }
                
                
            case .failure(let error):
                print("Failure on News List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func editAttachmentList(token:String, rawData:Data,success: @escaping (Bool) -> Void,failure: @escaping (String) -> Void){
        
        let token = [
            "access_token" : token
        ]
        let _ = super.requestDataObjWithTokenDA(endPoint: ApiServiceEndPoint.attachmentedit, rawData: rawData, token: token) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("edit attachment response : ", response)
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    
                    success (true)
                    
                }  else {
                    failure(Constants.JSON_FAILURE)
                }
                
            case .failure( _):
                //print("Register New error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func editAttachmentListMultipart(token:String, rawData:Data, imageDataList: [UIImage],success: @escaping (Bool) -> Void,failure: @escaping (String) -> Void){
        
//        let token = [
//            "access_token" : token
//        ]
        do {
            //let tokenStr = try JSON(token).rawData()
            
            let _ = super.doEditAttachListWithImage(endPoint: ApiServiceEndPoint.attachmenteditMultipart, imageDataList: imageDataList, rawData: rawData, token: token) { (result) in
                switch result{
                case .success(let result):
                    
                    let response = result as AnyObject
                    print("edit attachment response : ", response)
                    
                    if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                        
                        success (true)
                        
                    }  else {
                        failure(Constants.JSON_FAILURE)
                    }
                    
                case .failure( _):
                    //print("Register New error",error.localizedDescription)
                    failure(Constants.SERVER_FAILURE)
                }
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        
        
    }
    
    func getProductTypeList(success: @escaping ([ProductTypeObj]) -> Void,failure: @escaping (String) -> Void) {
        
        let _ = super.requestDataWithGETTokenDA(endPoint: ApiServiceEndPoint.producttypelist, rawData: ["": ""], token: ["":""]) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                //print("register response : ", response)
                
                if response[ModelConstants.STATUS] as! String == Constants.STATUS_200 {
                    var typelist = [ProductTypeObj]()
                    if let data = response[ModelConstants.DATA] as? [AnyObject] {
                        
                        for item in data {
                            var producttype = ProductTypeObj()
                            var producttypeid = 0
                            if let typeid = item["productTypeId"] as? Int {
                                producttypeid = typeid
                            }
                            producttype.productTypeId = producttypeid
                            
                            var producttypename = ""
                            if let typename = item["name"] as? String {
                                producttypename = typename
                            }
                            producttype.name = producttypename
                            
                            typelist.append(producttype)
                        }
                    }
                    
                    success (typelist)
                    
                }  else {
                    failure(Constants.JSON_FAILURE)
                }
                
            case .failure( _):
                //print("Register New error",error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
    }
    
    func getCityTownshipInfoList(success: @escaping ([CityTownshipData]) -> Void,failure: @escaping (String) -> Void) {
        
        let _ = super.requestDataWithGETTokenDA(endPoint: ApiServiceEndPoint.cityTownshipInfoList, rawData: ["": ""], token: ["":""]) { (result) in
            switch result{
            case .success(let result):

                let responseJsonData = JSON(result)
                let responseValue  = try! responseJsonData.rawData()
                if let nrcResponse = try? JSONDecoder().decode(CityTownshipResponse.self, from: responseValue){
                    //success(checkMemberResponse)
                    var cityList = [CityInfoBean]()
                    var townshipList = [[TownshipInfoData]]()
                    for data in nrcResponse.data {
                        var cityData = CityInfoBean()
                        cityData.cityId = data.cityId
                        cityData.name = data.name
                        cityList.append(cityData)
                        
                        townshipList.append(data.townshipInfoList)
                        print("\(townshipList.count)")
                    }
                    success(nrcResponse.data)
                }else{
                    failure(Constants.JSON_FAILURE)
                }

                
            case .failure( _):
                //print("NRC error", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
            }
        }
        
    }
}


