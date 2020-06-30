//
//  DAData.swift
//  AEONVCS
//
//  Created by mac on 10/9/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation

struct ApplicationInfoResponse: Codable {
    var status: String?
    var data: RegisterDAResponse?
       
       enum CodingKeys: String, CodingKey {
           case status
           case data
       }
}

struct RegisterDARequest: Codable {
    var daApplicationInfoId:Int? = 0
    var daApplicationTypeId:Int? = 1
    var name:String? = ""
    var dob:String? = ""
    
    var nrcNo:String? = ""
    var fatherName:String? = ""
    var highestEducationTypeId:Int? = 1
    var nationality:Int? = 0
    
    var nationalityOther:String? = ""
    var gender:Int? = 0
    var maritalStatus:Int? = 0
    
    var currentAddress:String? = ""
    var permanentAddress:String? = ""
    
    var currentAddressFloor:String? = ""
    var currentAddressBuildingNo:String? = ""
    var currentAddressRoomNo:String? = ""
    var currentAddressStreet:String? = ""
    var currentAddressQtr:String? = ""
    var currentAddressTownship:Int? = 0
    var currentAddressCity:Int? = 0
    
    var permanentAddressFloor:String? = ""
    var permanentAddressBuildingNo:String? = ""
    var permanentAddressRoomNo:String? = ""
    var permanentAddressStreet:String? = ""
    var permanentAddressQtr:String? = ""
    var permanentAddressTownship:Int? = 0
    var permanentAddressCity:Int? = 0
    
    var typeOfResidence:Int? = 0
    
    var typeOfResidenceOther:String? = ""
    var livingWith:Int? = 0
    var livingWithOther:String? = ""
    
    var yearOfStayYear:Int? = 0
    var yearOfStayMonth:Int? = 0
    var mobileNo:String? = ""
    
    var residentTelNo:String? = ""
    var otherPhoneNo:String? = ""
    var email:String? = ""
    
    var customerId:Int? = 0
    
    var daLoanTypeId:Int? = 0
    var financeAmount:Double? = 0.0
    var financeTerm:Int? = 0
    
    var daProductTypeId:Int? = 0
    var productDescription:String? = ""
    var channelType:Int? = 0// 1
    var status:Int? = 0
    
    var applicantCompanyInfoDto: OccupationDataRequest?
    var emergencyContactInfoDto: EmergencyContactRequest?
    var guarantorInfoDto: GuarantorRequest?
    var applicationInfoAttachmentDtoList: [AttachmentRequest]?
    
    enum CodingKeys: String, CodingKey {
        case daApplicationInfoId
        case daApplicationTypeId
        case name
        case dob
        
        case nrcNo
        case fatherName
        case highestEducationTypeId
        case nationality
        
        case nationalityOther
        case gender
        case maritalStatus
        
        case currentAddress
        case permanentAddress
        case currentAddressFloor
        case currentAddressBuildingNo
        case currentAddressRoomNo
        case currentAddressStreet
        case currentAddressQtr
        case currentAddressTownship
        case currentAddressCity
        
        case permanentAddressFloor
        case permanentAddressBuildingNo
        case permanentAddressRoomNo
        case permanentAddressStreet
        case permanentAddressQtr
        case permanentAddressTownship
        
        case typeOfResidence
        case typeOfResidenceOther
        case livingWith
        case livingWithOther
        
        case yearOfStayYear
        case yearOfStayMonth
        case mobileNo
        
        case residentTelNo
        case otherPhoneNo
        case email
        
        case customerId
        
        case daLoanTypeId
        case financeAmount
        case financeTerm
        
        case daProductTypeId
        case productDescription
        case channelType
        case status
        
        case applicantCompanyInfoDto
        case emergencyContactInfoDto
        case guarantorInfoDto
        case applicationInfoAttachmentDtoList
    }
    
}

struct SaveDARequest: Codable {
    var daApplicationInfoId:Int? = 0
    var daApplicationTypeId:Int? = 1
    var name:String? = ""
    var dob:Date?
    
    var nrcNo:String? = ""
    var fatherName:String? = ""
    var highestEducationTypeId:Int? = 1
    var nationality:Int? = 0
    var nationalityOther:String? = ""
    var gender:Int? = 0
    var maritalStatus:Int? = 0
    
    var currentAddress:String = ""
    var currentAddressFloor:String = ""
    var currentAddressBuildingNo:String = ""
    var currentAddressRoomNo:String = ""
    var currentAddressStreet:String = ""
    var currentAddressQtr:String = ""
    var currentAddressTownship:Int = 0
    var currentAddressCity:Int = 0
    
    var permanentAddress:String = ""
    var permanentAddressFloor:String = ""
    var permanentAddressBuildingNo:String = ""
    var permanentAddressRoomNo:String = ""
    var permanentAddressStreet:String = ""
    var permanentAddressQtr:String = ""
    var permanentAddressTownship:Int = 0
    var permanentAddressCity:Int = 0
    
    var typeOfResidence:Int? = 0
    
    var typeOfResidenceOther:String? = ""
    var livingWith:Int? = 0
    var livingWithOther:String? = ""
    
    var yearOfStayYear:Int? = 0
    var yearOfStayMonth:Int? = 0
    var mobileNo:String? = ""
    
    var residentTelNo:String? = ""
    var otherPhoneNo:String? = ""
    var email:String? = ""
    
    var customerId:Int? = 0
    
    var daLoanTypeId:Int? = 0
    var financeAmount:Double? = 0.0
    var financeTerm:Int? = 0
    
    var daProductTypeId:Int? = 0
    var productDescription:String? = ""
    var channelType:Int? = 0// 1
    var status:Int? = 0
    
    var applicantCompanyInfoDto: OccupationDataRequest?
    var emergencyContactInfoDto: EmergencyContactRequest?
    var guarantorInfoDto: GuarantorRequest?
    
    enum CodingKeys: String, CodingKey {
        case daApplicationInfoId
        case daApplicationTypeId
        case name
        case dob
        
        case nrcNo
        case fatherName
        case nationality
        case highestEducationTypeId
        
        case nationalityOther
        case gender
        case maritalStatus
        
        case currentAddress
        case permanentAddress

        case currentAddressFloor
        case currentAddressBuildingNo
        case currentAddressRoomNo
        case currentAddressStreet
        case currentAddressQtr
        case currentAddressTownship
        case currentAddressCity
        
        case permanentAddressFloor
        case permanentAddressBuildingNo
        case permanentAddressRoomNo
        case permanentAddressStreet
        case permanentAddressQtr
        case permanentAddressTownship
        
        case typeOfResidence
        case typeOfResidenceOther
        case livingWith
        case livingWithOther
        
        case yearOfStayYear
        case yearOfStayMonth
        case mobileNo
        
        case residentTelNo
        case otherPhoneNo
        case email
        
        case customerId
        
        case daLoanTypeId
        case financeAmount
        case financeTerm
        
        case daProductTypeId
        case productDescription
        case channelType
        case status
        
        case applicantCompanyInfoDto
        case emergencyContactInfoDto
        case guarantorInfoDto
        
    }
    
}

struct OccupationDataRequest: Codable {
    var daApplicantCompanyInfoId:Int
    var companyName:String
    var companyAddress:String
    var companyTelNo:String
    
    var contactTimeFrom:String
    var contactTimeTo:String
    var department:String
    
    var position:String
    var yearOfServiceYear:Int
    var yearOfServiceMonth:Int
    
    var companyStatus:Int
    var companyStatusOther:String
    var monthlyBasicIncome:Double
    
    var otherIncome:Double
    var totalIncome:Double
    var salaryDay:Int
    
    var companyAddressBuildingNo:String
    var companyAddressRoomNo:String
    var companyAddressFloor:String
    var companyAddressStreet:String
    var companyAddressQtr:String
    var companyAddressTownship:Int
    var companyAddressCity:Int
    
    enum CodingKeys: String, CodingKey {
        case daApplicantCompanyInfoId
        case companyName
        case companyAddress
        case companyTelNo
        case contactTimeFrom
        case contactTimeTo
        case department
        case position
        case yearOfServiceYear
        case yearOfServiceMonth
        
        case companyStatus
        case companyStatusOther
        case monthlyBasicIncome
        
        case otherIncome
        case totalIncome
        case salaryDay
        
        case companyAddressBuildingNo
        case companyAddressRoomNo
        case companyAddressFloor
        case companyAddressStreet
        case companyAddressQtr
        case companyAddressTownship
        case companyAddressCity
    }
}

struct EmergencyContactRequest: Codable {
    var daEmergencyContactInfoId:Int
    var name:String
    var relationship:Int
    var relationshipOther:String
    
    var currentAddress:String
    var mobileNo:String
    var residentTelNo:String
    var otherPhoneNo:String
    
    var currentAddressFloor:String
    var currentAddressBuildingNo:String
    var currentAddressRoomNo:String
    var currentAddressStreet:String
    var currentAddressQtr:String
    var currentAddressTownship:Int
    var currentAddressCity:Int
    
    
    enum CodingKeys: String, CodingKey {
       
        case daEmergencyContactInfoId
        case name
        case relationship
        case relationshipOther
        
        case currentAddress
        case mobileNo
        case residentTelNo
        
        case otherPhoneNo
        
        case currentAddressFloor
        case currentAddressBuildingNo
        case currentAddressRoomNo
        case currentAddressStreet
        case currentAddressQtr
        case currentAddressTownship
        case currentAddressCity
    }
}

struct GuarantorRequest: Codable {
    var daGuarantorInfoId:Int
    var name:String
    var dob:String
    var nrcNo:String
    
    var nationality:Int
    var nationalityOther:String
    var mobileNo:String
    
    var residentTelNo:String
    var relationship:Int
    var relationshipOther:String
    
    var currentAddress:String
    var typeOfResidence:Int
    var typeOfResidenceOther:String
    
    var livingWith:Int
    var livingWithOther:String
    var gender:Int
    
    var maritalStatus:Int
    var yearOfStayYear:Int
    var yearOfStayMonth:Int
    
    var companyName:String
    var companyTelNo:String
    var companyAddress:String
    
    var department:String
    var position:String
    var yearOfServiceYear:Int
    
    var yearOfServiceMonth:Int
    var monthlyBasicIncome:Double
    var totalIncome:Double
    
    var currentAddressFloor:String
    var currentAddressBuildingNo:String
    var currentAddressRoomNo:String
    var currentAddressStreet:String
    var currentAddressQtr:String
    var currentAddressTownship:Int
    var currentAddressCity:Int
    
    var companyAddressBuildingNo:String
    var companyAddressRoomNo:String
    var companyAddressFloor:String
    var companyAddressStreet:String
    var companyAddressQtr:String
    var companyAddressTownship:Int
    var companyAddressCity:Int
    
    enum CodingKeys: String, CodingKey {
        
        case daGuarantorInfoId
        
        case name
        case dob
        case nrcNo
        
        case nationality
        case nationalityOther
        case mobileNo
        
        case residentTelNo
        case relationship
        case relationshipOther
        
        case currentAddress
        case typeOfResidence
        case typeOfResidenceOther
        
        case livingWith
        case livingWithOther
        case gender
        
        case maritalStatus
        case yearOfStayYear
        case yearOfStayMonth
        
        case companyName
        case companyTelNo
        case companyAddress
        
        case department
        case position
        case yearOfServiceYear
        
        case yearOfServiceMonth
        case monthlyBasicIncome
        case totalIncome
        
        case currentAddressFloor
        case currentAddressBuildingNo
        case currentAddressRoomNo
        case currentAddressStreet
        case currentAddressQtr
        case currentAddressTownship
        case currentAddressCity
        case companyAddressBuildingNo
        case companyAddressRoomNo
        case companyAddressFloor
        case companyAddressStreet
        case companyAddressQtr
        case companyAddressTownship
        case companyAddressCity
    }
}


struct ApplicationDataRequest: Codable {
    var daApplicationInfoId:Int
    var daApplicationTypeId:Int
    var name:String
    var dob:String
    
    var nrcNo:String
    var fatherName:String
    var highestEducationTypeId:Int
    var nationality:Int
   
    var nationalityOther:String
    var gender:Int
    var maritalStatus:Int
    
    var currentAddress:String
    var permanentAddress:String
    var typeOfResidence:Int
    
    var typeOfResidenceOther:String
    var livingWith:Int
    var livingWithOther:String
    
    var yearOfStayYear:Int
    var yearOfStayMonth:Int
    var mobileNo:String
    
    var residentTelNo:String
    var otherPhoneNo:String
    var email:String
    
    var customerId:Int
    
    var status: Int
    
    var currentAddressFloor:String
    var currentAddressBuildingNo:String
    var currentAddressRoomNo:String
    var currentAddressStreet:String
    var currentAddressQtr:String
    var currentAddressTownship:Int
    var currentAddressCity:Int
    
    var permanentAddressFloor:String
    var permanentAddressBuildingNo:String
    var permanentAddressRoomNo:String
    var permanentAddressStreet:String
    var permanentAddressQtr:String
    var permanentAddressTownship:Int
    var permanentAddressCity:Int
    
    enum CodingKeys: String, CodingKey {
        case daApplicationInfoId
        case daApplicationTypeId
        case name
        case dob
        
        case nrcNo
        case fatherName
        case highestEducationTypeId
        case nationality
      
        
        case nationalityOther
        case gender
        case maritalStatus
        
        case currentAddress
        case permanentAddress
        case typeOfResidence
        
        case typeOfResidenceOther
        case livingWith
        case livingWithOther
        
        case yearOfStayYear
        case yearOfStayMonth
        case mobileNo
        
        case residentTelNo
        case otherPhoneNo
        case email
        
        case customerId
        
        case status
        
        case currentAddressFloor
        case currentAddressBuildingNo
        case currentAddressRoomNo
        case currentAddressStreet
        case currentAddressQtr
        case currentAddressTownship
        case currentAddressCity
        
        case permanentAddressFloor
        case permanentAddressBuildingNo
        case permanentAddressRoomNo
        case permanentAddressStreet
        case permanentAddressQtr
        case permanentAddressTownship
        case permanentAddressCity
    }
}

struct LoanConfirmationRequest: Codable {
    var daLoanTypeId:Int
    var financeAmount:Double
    var financeTerm:Int
    
    var daProductTypeId:Int
    var productDescription:String
    var channelType:Int // 1
    
    enum CodingKeys: String, CodingKey {
        
        
        case daLoanTypeId
        case financeAmount
        case financeTerm
        
        case daProductTypeId
        case productDescription
        case channelType // 1
    }
}

struct AttachmentRequest: Codable {
    var fileType: Int
    var photoByte: String
    
    enum CodingKeys: String, CodingKey {
        case fileType
        case photoByte
    
    }
}


struct RegisterDAResponse: Codable {
    var daApplicationInfoId:Int? = 1
    var applicationNo:String? = ""
    
    var appliedDate:String? = ""
    var daApplicationTypeId:Int? = 1
    
    var status:Int? = 0
    var settlementPendingComment:String? = ""
    
    var daInterestInfoId:Int? = 1
    var daCompulsoryInfoId:Int? = 1
    
    var name:String? = ""
    var dob:String? = ""
    
    var nrcNo:String? = ""
    var fatherName:String? = ""
    var highestEducationTypeId:Int? = 1
    var nationality:Int? = 0
    
    var nationalityOther:String? = ""
    var gender:Int? = 0
    var maritalStatus:Int? = 0
    
    var currentAddress:String? = ""
    var permanentAddress:String? = ""
    var typeOfResidence:Int? = 0
    
    var typeOfResidenceOther:String? = ""
    var livingWith:Int? = 0
    var livingWithOther:String? = ""
    
    var yearOfStayYear:Int? = 0
    var yearOfStayMonth:Int? = 0
    var mobileNo:String? = ""
    
    var residentTelNo:String? = ""
    var otherPhoneNo:String? = ""
    var email:String? = ""
    
    var customerId:Int? = 0
    
    var daLoanTypeId:Int? = 0
    var financeAmount:Double? = 0.0
    var financeTerm:Int? = 0
    
    var daProductTypeId:Int? = 0
    var productDescription:String? = ""
    var channelType:Int? = 0// 1
    
    var currentAddressFloor:String? = ""
    var currentAddressBuildingNo:String? = ""
    var currentAddressRoomNo:String? = ""
    var currentAddressStreet:String? = ""
    var currentAddressQtr:String? = ""
    var currentAddressTownship:Int? = 0
    var currentAddressCity:Int? = 0
    
    var permanentAddressFloor:String? = ""
    var permanentAddressBuildingNo:String? = ""
    var permanentAddressRoomNo:String? = ""
    var permanentAddressStreet:String? = ""
    var permanentAddressQtr:String? = ""
    var permanentAddressTownship:Int? = 0
    var permanentAddressCity:Int? = 0
 
    
    var applicantCompanyInfoDto: OccupationDataRequest?
    var emergencyContactInfoDto: EmergencyContactRequest?
    var guarantorInfoDto: GuarantorRequest?
    var applicationInfoAttachmentDtoList: [AttachmentRequest]?
    
    enum CodingKeys: String, CodingKey {
        
        case daApplicationInfoId
        case applicationNo
        
        case appliedDate
        
        
        case status
        case settlementPendingComment
        
        case daInterestInfoId
        case daCompulsoryInfoId
        
        case daApplicationTypeId
        case name
        case dob
        
        case nrcNo
        case fatherName
        case highestEducationTypeId
        case nationality
        
        case nationalityOther
        case gender
        case maritalStatus
        
        case currentAddress
        case permanentAddress
        case typeOfResidence
        
        case typeOfResidenceOther
        case livingWith
        case livingWithOther
        
        case yearOfStayYear
        case yearOfStayMonth
        case mobileNo
        
        case residentTelNo
        case otherPhoneNo
        case email
        
        case customerId
        
        case daLoanTypeId
        case financeAmount
        case financeTerm
        
        case daProductTypeId
        case productDescription
        case channelType
        
        case applicantCompanyInfoDto
        case emergencyContactInfoDto
        case guarantorInfoDto
        case applicationInfoAttachmentDtoList
        
        case currentAddressFloor
        case currentAddressBuildingNo
        case currentAddressRoomNo
        case currentAddressStreet
        case currentAddressQtr
        case currentAddressTownship
        case currentAddressCity
        
        case permanentAddressFloor
        case permanentAddressBuildingNo
        case permanentAddressRoomNo
        case permanentAddressStreet
        case permanentAddressQtr
        case permanentAddressTownship
        case permanentAddressCity
    }
    
}

struct DAInquiryResponse: Codable {
   var daApplicationInfoId:Int? = 1
    var applicationNo:String? = ""
    var financeAmount:Double? = 0.0
    var financeTerm:Int? = 0
    var daLoanTypeId:Int? = 1
    var appliedDate:String? = ""
    var status:Int? = 1
    var agreementNo:String = ""
    var approvedFinanceAmount:Int? = 0
    var approvedFinanceTerm:Int? = 0
   enum CodingKeys: String, CodingKey {
       
       case daApplicationInfoId
        case applicationNo
       case financeAmount
       case financeTerm
       case daLoanTypeId
       case appliedDate
       case status
        case agreementNo
       case approvedFinanceAmount
    case approvedFinanceTerm
   }
}

struct DAInquiryResquest: Codable {
    
   var customerId:String
    var daLoanTypeId:String
    var applicationNo:String
    var appliedDate:String
    var status:String
    var offset:String
    var limit:String
   
   enum CodingKeys: String, CodingKey {
       
       case customerId
       case daLoanTypeId
       case applicationNo
       case appliedDate
       case status
       case offset
       case limit
   }
    
    init(customerId:String, daLoanTypeId:String, applicationNo:String, appliedDate:String, status:String, offset: String, limit: String) {
        
        self.customerId = customerId
        self.daLoanTypeId = daLoanTypeId
        self.applicationNo = applicationNo
        self.appliedDate = appliedDate
        self.status = status
        self.offset = offset
        self.limit = limit
        
    }
}

//"daPurchaseInfoId": 1,
//"daApplicationInfoId": 22,
//"customerId": null,

//"productCode": "P0002",
//"productName": "Samsung Galaxy",
//"daLoanTypeId": 1,

//"agreementNo": "2019-5-0000001979",
//"purchaseDate": "2019-09-22T17:30:00.000+0000",

//"model": "GTX0025",
//"brand": "Samsung",
//"price": 400000.0,

//"cashDownAmount": 0.0,
//"outletId": 1,
//"outletName": "KMD Samsung Showroom",

//"invoiceNo": "SAM00023",
//"agentId": 2,
//"agentName": "KMD",

//"status": 4,
//"settlementAmount": 450000.0,


struct PurchaseDetailResponse: Codable {
    var status: String?
    var data: PurchaseDetail?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
}
struct PurchaseInfoProductDtoList: Codable {
    var productDescription: String?
    var brand: String?
    var model: String?
    var price: Double?
    var cashDownAmount: Double?
    var daLoanTypeId: Int?
    var daPurchaseInfoId: Int?
    var daPurchaseInfoProductId: Int?
    var daProductTypeId: Int?
    
    enum CodingKeys: String, CodingKey {
        case productDescription = "productDescription"
        case brand = "brand"
        case model = "model"
        case price = "price"
        case cashDownAmount = "cashDownAmount"
        case daLoanTypeId = "daLoanTypeId"
        case daPurchaseInfoId = "daPurchaseInfoId"
        case daPurchaseInfoProductId = "daPurchaseInfoProductId"
        case daProductTypeId = "daProductTypeId"
    }
}
struct PurchaseDetail: Codable {

    var daPurchaseInfoId:Int?
    var daApplicationInfoId:Int?
    var customerId:Int?
    var agreementNo:String?
    var purchaseDate:String? = ""
    var outletId:Int?
    var outletName:String?
    var invoiceNo:String?
    var agentId:Int?
    var agentName:String?
    var financeAmount:Double?
    var financeTerm:Int?
    var processingFees:Double?
    var compulsoryAmount:Double?
    var status:Int!
    var settlementAmount:Double?
   // var productDescription:String!
  //  var model:String!
  //  var brand:String!
  //  var price:Double!
   // var daLoanTypeId:Int?
    var purchaseLocation:String?
    var delFlag:Bool?
    var cashDownAmount:Double?
//    var productCode:String? = ""
//    var productName:String? = ""
    var purchaseInfoAttachmentDtoList: [PurchaseAttachmentDetailResponse]?
    var purchaseInfoProductDtoList: [PurchaseInfoProductDtoList]?

enum CodingKeys: String, CodingKey {
    
        case daPurchaseInfoId
        case daApplicationInfoId
        case customerId
        case agreementNo
        case purchaseDate
        case outletId
        case outletName
        case invoiceNo
        case agentId
        case agentName
        case financeAmount
        case financeTerm
        case processingFees
        case compulsoryAmount
        case status
        case settlementAmount
//        case productDescription
//        case model
//        case brand
//        case price
      //  case daLoanTypeId
        case purchaseLocation
        case delFlag
        case cashDownAmount
//        case productCode
//        case productName
        case purchaseInfoAttachmentDtoList
        case purchaseInfoProductDtoList
        
    }
 
}
struct PurchaseAttachmentDetailResponse: Codable {
 
    var daPurchaseInfoAttachmentId:Int?
    var daPurchaseInfoId:Int?
    
    var filePath:String?
    var fileType:Int?
    
   
    

enum CodingKeys: String, CodingKey {
    
    
        case daPurchaseInfoAttachmentId
        case daPurchaseInfoId
        
        case filePath
        case fileType
    
       
    }
 
}
struct PurchaseAttachmentResponse: Codable {
 
    var daPurchaseInfoAttachmentId:Int?
    var daPurchaseInfoId:Int?
    
    var filePath:String?
    var fileType:Int?
    
    var editFlag:Bool?
    

enum CodingKeys: String, CodingKey {
    
    
        case daPurchaseInfoAttachmentId
        case daPurchaseInfoId
        
        case filePath
        case fileType
    
        case editFlag
    }
 
}

struct ApplicationDetailResponse: Codable {
    var daApplicationInfoId:Int? = 1
    var applicationNo:String? = ""
    
    var appliedDate:String? = ""
    var daApplicationTypeId:Int? = 1
    
    var status:Int? = 0
    var settlementPendingComment:String? = ""
    
    var daInterestInfoId:Int? = 1
    var daCompulsoryInfoId:Int? = 1
    
    var name:String? = ""
    var dob:String? = ""
    
    var nrcNo:String? = ""
    var fatherName:String? = ""
    var highestEducationTypeId:Int? = 1
    var nationality:Int? = 0
    
    var nationalityOther:String? = ""
    var gender:Int? = 0
    var maritalStatus:Int? = 0
    
    var currentAddress:String? = ""
    var permanentAddress:String? = ""
    
    var currentAddressFloor:String? = ""
    var currentAddressBuildingNo:String? = ""
    var currentAddressRoomNo:String? = ""
    var currentAddressStreet:String? = ""
    var currentAddressQtr:String? = ""
    var currentAddressTownship:Int? = 0
    var currentAddressCity:Int? = 0
    
    var permanentAddressFloor:String? = ""
    var permanentAddressBuildingNo:String? = ""
    var permanentAddressRoomNo:String? = ""
    var permanentAddressStreet:String? = ""
    var permanentAddressQtr:String? = ""
    var permanentAddressTownship:Int? = 0
    var permanentAddressCity:Int? = 0
    
    var typeOfResidence:Int? = 0
    
    var typeOfResidenceOther:String? = ""
    var livingWith:Int? = 0
    var livingWithOther:String? = ""
    
    var yearOfStayYear:Int? = 0
    var yearOfStayMonth:Int? = 0
    var mobileNo:String? = ""
    
    var residentTelNo:String? = ""
    var otherPhoneNo:String? = ""
    var email:String? = ""
    
    var customerId:Int? = 0
    
    var daLoanTypeId:Int? = 0
    var financeAmount:Double? = 0.0
    var financeTerm:Int? = 0
    
    var daProductTypeId:Int? = 0
    var productDescription:String? = ""
    var channelType:Int? = 0// 1
 
    
    var applicantCompanyInfoDto: OccupationDataRequest?
    var emergencyContactInfoDto: EmergencyContactRequest?
    var guarantorInfoDto: GuarantorRequest?
    var applicationInfoAttachmentDtoList: [PurchaseAttachmentResponse]?
    
    var processingFees:Double? = 0.0
    var totalConSaving:Double? = 0.0
    var totalRepayment:Double? = 0.0//
    var firstPayment:Double? = 0.0
    var monthlyInstallment:Double? = 0.0
    var lastPayment:Double? = 0.0
    
    enum CodingKeys: String, CodingKey {
        
        case daApplicationInfoId
        case applicationNo
        case appliedDate
        
        case status
        case settlementPendingComment
        
        case daInterestInfoId
        case daCompulsoryInfoId
        case daApplicationTypeId
        case name
        case dob
        
        case nrcNo
        case fatherName
        case highestEducationTypeId
        case nationality
        
        case nationalityOther
        case gender
        case maritalStatus
        
        case currentAddress
        case permanentAddress
        
        case currentAddressFloor
        case currentAddressBuildingNo
        case currentAddressRoomNo
        case currentAddressStreet
        case currentAddressQtr
        case currentAddressTownship
        case currentAddressCity
        
        case permanentAddressFloor
        case permanentAddressBuildingNo
        case permanentAddressRoomNo
        case permanentAddressStreet
        case permanentAddressQtr
        case permanentAddressTownship
        
        case typeOfResidence
        case typeOfResidenceOther
        case livingWith
        case livingWithOther
        
        case yearOfStayYear
        case yearOfStayMonth
        case mobileNo
        
        case residentTelNo
        case otherPhoneNo
        case email
        
        case customerId
        
        case daLoanTypeId
        case financeAmount
        case financeTerm
        
        case daProductTypeId
        case productDescription
        case channelType
        
        case applicantCompanyInfoDto
        case emergencyContactInfoDto
        case guarantorInfoDto
        case applicationInfoAttachmentDtoList
        
        case processingFees
        case totalConSaving
        case totalRepayment
        case firstPayment
        case monthlyInstallment
        case lastPayment
    }
    
}


struct ApplicationCancelResponse: Codable {
    var status: String?
    var messageCode: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case messageCode
        case message
    }
    
}

struct QRProductInfo: Codable {
    var daPurchaseInfoId: Int?
    var daApplicationInfoId: Int?
    var productCode: String?
    var productName: String?
    var daLoanTypeId: Int?
    var agreementNo: String?
    var purchaseDate: String?
    var model: String?
    var brand: String?
    var price: Double?
    var cashDownAmount: Double?
    var outletName: String?
    var invoiceNo: String?
    var status: Int?
    
    enum CodingKeys: String, CodingKey {
        case daPurchaseInfoId
        case daApplicationInfoId
        case productCode
        case productName
        case daLoanTypeId
        case agreementNo
        case purchaseDate
        case model
        case brand
        case price
        case cashDownAmount
        case outletName
        case invoiceNo
        case status
        
    }
}


struct AttachmentObj: Codable {
    var daApplicationInfoAttachmentId:Int?
    var fileType:Int?
    var filePath:String?
    var fileName:String?
    var photoByte:String?
    
    enum CodingKeys: String, CodingKey {
        case daApplicationInfoAttachmentId
        case fileType
        case filePath
        case fileName
        case photoByte
    }
}

//
//"daApplicationInfoId": 26,
//   "applicationInfoAttachmentDtoList": [
//           {
//               "daApplicationInfoAttachmentId":110,
//               "filePath":"/1910000008/20191004061357518.jpg",
//               "fileType": 1,
//               "photoByte":

struct AttachmentEditRequest: Codable {
 
    var daApplicationInfoId:Int
    var applicationInfoAttachmentDtoList:[AttachmentObj]

    enum CodingKeys: String, CodingKey {
        case daApplicationInfoId
        case applicationInfoAttachmentDtoList
    }
}

struct ProductTypeObj: Codable {
    var productTypeId: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case productTypeId
        case name
    }
}

struct CityTownshipResponse: Codable {
    let status: String?
    let data: [CityTownshipData]
}

struct CityTownshipData: Codable {
    var cityId: Int?
    var name: String?
    var townshipInfoList: [TownshipInfoData]
    
    enum CodingKeys: String, CodingKey {
        case cityId
        case name, townshipInfoList
    }
}

struct CityInfoBean: Codable {
    var cityId: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case cityId
        case name
    }
}

struct TownshipInfoData: Codable {
    var townshipId: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case townshipId
        case name
    }
}

struct CityTownShipModel : Codable {
    var cityNameIdDic : Dictionary<String, Int>?
    var cityIdTownListDic : Dictionary<Int, [String]>?
    var townNameIdDic : Dictionary<String, Int>?
    
}
