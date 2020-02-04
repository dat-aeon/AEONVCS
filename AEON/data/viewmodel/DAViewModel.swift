//
//  DAViewModel.swift
//  AEONVCS
//
//  Created by mac on 10/9/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import SwiftyJSON

class DAViewModel {
    func doRegisterDigitalApplication(tokenInfo:TokenData, appData:ApplicationDataRequest,companyData:OccupationDataRequest,emergencyContact:EmergencyContactRequest,attachmentlist:[AttachmentRequest], loanData: LoanConfirmationRequest, guarantorData: GuarantorRequest, success: @escaping (Bool) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = getRegisterDAData(appData:appData,companyData:companyData,emergencyContact:emergencyContact,attachmentlist:attachmentlist, loanData: loanData, guarantorData: guarantorData)
        
        DAModel.init().registerDA(token: "\(tokenInfo.access_token ?? "")", rawData: rawData, success:{ (result) in
            //            if result.status == Constants.STATUS_200 {
            print("DA view model", result)
            success(result)
            
            //            }
            //            else{
            //                failure(result.status!)
            //            }
        }) { (error) in
            failure(error)
        }
        
        
        
    }
    
    //GET REQUEST DATA FOR EXISTED MEMBER
    func getRegisterDAData(appData:ApplicationDataRequest,companyData:OccupationDataRequest,emergencyContact:EmergencyContactRequest,attachmentlist:[AttachmentRequest], loanData: LoanConfirmationRequest, guarantorData: GuarantorRequest)-> Data{
        
        var registerRequest = RegisterDARequest(
            daApplicationTypeId: 1, name: appData.name ?? "", dob: appData.dob ?? "", nrcNo: appData.nrcNo ?? "", fatherName: appData.fatherName ?? "", nationality: appData.nationality ?? 0, nationalityOther: appData.nationalityOther ?? "", gender: appData.gender ?? 1, maritalStatus: appData.maritalStatus ?? 1, currentAddress: appData.currentAddress ?? "", permanentAddress: appData.permanentAddress ?? "", typeOfResidence: appData.typeOfResidence ?? 1, typeOfResidenceOther: appData.typeOfResidenceOther ?? "", livingWith: appData.livingWith ?? 1, livingWithOther: appData.livingWithOther ?? "", yearOfStayYear: appData.yearOfStayYear ?? 0, yearOfStayMonth: appData.yearOfStayMonth ?? 0, mobileNo: appData.mobileNo ?? "", residentTelNo: appData.residentTelNo ?? "", otherPhoneNo: appData.otherPhoneNo ?? "", email: appData.email ?? "", customerId: appData.customerId ?? 1, daLoanTypeId: loanData.daLoanTypeId ?? 1, financeAmount: loanData.financeAmount ?? 0.0, financeTerm: loanData.financeTerm ?? 0, daProductTypeId: loanData.daProductTypeId ?? 1, productDescription: loanData.productDescription ?? "", channelType: 1, status: appData.status, applicantCompanyInfoDto: companyData, emergencyContactInfoDto: emergencyContact, guarantorInfoDto: guarantorData, applicationInfoAttachmentDtoList: attachmentlist
        )
        registerRequest.currentAddressFloor = appData.currentAddressFloor ?? ""
        registerRequest.currentAddressBuildingNo = appData.currentAddressBuildingNo ?? ""
        registerRequest.currentAddressRoomNo = appData.currentAddressRoomNo ?? ""
        registerRequest.currentAddressStreet = appData.currentAddressStreet ?? ""
        registerRequest.currentAddressQtr = appData.currentAddressQtr ?? ""
        registerRequest.currentAddressTownship = appData.currentAddressTownship ?? 0
        registerRequest.currentAddressCity = appData.currentAddressCity ?? 0
        
        registerRequest.permanentAddressFloor = appData.permanentAddressFloor ?? ""
        registerRequest.permanentAddressBuildingNo = appData.permanentAddressBuildingNo ?? ""
        registerRequest.permanentAddressRoomNo = appData.permanentAddressRoomNo ?? ""
        registerRequest.permanentAddressStreet = appData.permanentAddressStreet ?? ""
        registerRequest.permanentAddressQtr = appData.permanentAddressQtr ?? ""
        registerRequest.permanentAddressTownship = appData.permanentAddressTownship ?? 0
        registerRequest.permanentAddressCity = appData.permanentAddressCity ?? 0
        
        
        
        do {
            let jsonData = try JSONEncoder().encode(registerRequest)
            //let jsonString = String(data: jsonData, encoding: .utf8)!
            //print("REQUEST DATA \(jsonString)")
            
            return jsonData
        } catch { print("Error \(error)") }
        
        return Data()
        
        
    }
    
    //    https://ass.aeoncredit.com.mm/daso/application/last-application-info
    
    func doLoadSaveDataDigitalApplication(tokenInfo:TokenData, cusID:String, success: @escaping (RegisterDAResponse) -> Void,failure: @escaping (String) -> Void){
        
        
        DAModel.init().loadSaveDataDA(token: "\(tokenInfo.access_token ?? "")", cusID: cusID, success: { (responseDA) in
            success(responseDA)
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().loadSaveDataDA(token: "\(tokenInfo.access_token ?? "")", cusID: cusID, success: { (responseDA) in
                            success(responseDA)
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
        
        
    }
    
    func doSaveDigitalApplication(tokenInfo:TokenData, appData:ApplicationDataRequest,companyData:OccupationDataRequest,emergencyContact:EmergencyContactRequest, loanData: LoanConfirmationRequest, guarantorData: GuarantorRequest, success: @escaping (RegisterDAResponse) -> Void,failure: @escaping (String) -> Void) {
        
        let rawData = getSaveDAData(appData:appData,companyData:companyData,emergencyContact:emergencyContact, loanData: loanData, guarantorData: guarantorData)
        
        DAModel.init().saveDA(token: "\(tokenInfo.access_token ?? "")", rawData: rawData, success:{ (result) in
            //            if result.status == Constants.STATUS_200 {
            print("DA view model", result)
            success(result)
            
            //            }
            //            else{
            //                failure(result.status!)
            //            }
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().saveDA(token: "\(tokenInfo.access_token ?? "")", rawData: rawData, success:{ (responseDA) in
                            success(responseDA)
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
        
    }
    
    func getSaveDAData(appData:ApplicationDataRequest,companyData:OccupationDataRequest,emergencyContact:EmergencyContactRequest, loanData: LoanConfirmationRequest, guarantorData: GuarantorRequest)-> Data {
        
        var registerRequest = SaveDARequest (
            daApplicationTypeId: 1, name: appData.name, nrcNo: appData.nrcNo ?? "", fatherName: appData.fatherName ?? "", nationality: appData.nationality , nationalityOther: appData.nationalityOther ?? "", gender: appData.gender , maritalStatus: appData.maritalStatus , currentAddress: appData.currentAddress ?? "", permanentAddress: appData.permanentAddress ?? "", typeOfResidence: appData.typeOfResidence , typeOfResidenceOther: appData.typeOfResidenceOther ?? "", livingWith: appData.livingWith ?? 1, livingWithOther: appData.livingWithOther ?? "", yearOfStayYear: appData.yearOfStayYear ?? 0, yearOfStayMonth: appData.yearOfStayMonth ?? 0, mobileNo: appData.mobileNo ?? "", residentTelNo: appData.residentTelNo ?? "", otherPhoneNo: appData.otherPhoneNo ?? "", email: appData.email ?? "", customerId: appData.customerId ?? 1, daLoanTypeId: loanData.daLoanTypeId ?? 1, financeAmount: loanData.financeAmount , financeTerm: loanData.financeTerm ?? 0, daProductTypeId: loanData.daProductTypeId ?? 1, productDescription: loanData.productDescription ?? "", channelType: 1, status: appData.status, applicantCompanyInfoDto: companyData, emergencyContactInfoDto: emergencyContact, guarantorInfoDto: guarantorData
        )
        //let dobDate = appData.dob
        registerRequest.currentAddressFloor = appData.currentAddressFloor ?? ""
        registerRequest.currentAddressBuildingNo = appData.currentAddressBuildingNo ?? ""
        registerRequest.currentAddressRoomNo = appData.currentAddressRoomNo ?? ""
        registerRequest.currentAddressStreet = appData.currentAddressStreet ?? ""
        registerRequest.currentAddressQtr = appData.currentAddressQtr ?? ""
        registerRequest.currentAddressTownship = appData.currentAddressTownship ?? 0
        registerRequest.currentAddressCity = appData.currentAddressCity ?? 0
        
        registerRequest.permanentAddressFloor = appData.permanentAddressFloor ?? ""
        registerRequest.permanentAddressBuildingNo = appData.permanentAddressBuildingNo ?? ""
        registerRequest.permanentAddressRoomNo = appData.permanentAddressRoomNo ?? ""
        registerRequest.permanentAddressStreet = appData.permanentAddressStreet ?? ""
        registerRequest.permanentAddressQtr = appData.permanentAddressQtr ?? ""
        registerRequest.permanentAddressTownship = appData.permanentAddressTownship ?? 0
        registerRequest.permanentAddressCity = appData.permanentAddressCity ?? 0
        
        do {
            let jsonData = try JSONEncoder().encode(registerRequest)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            
            return jsonData
        } catch { print("Error \(error)") }
        
        return Data()
        
    }
    
    func doGetApplicationInquiryList(tokenInfo:TokenData, mylistRequest: DAInquiryResquest, success: @escaping ([DAInquiryResponse]) -> Void,failure: @escaping (String) -> Void) {
        
        DAModel.init().getLoanApplicationList(token: "\(tokenInfo.access_token ?? "")", listRequest: mylistRequest, success:{ (result) in
            //            if result.status == Constants.STATUS_200 {
            print("DA view model", result)
            success(result)
            
            
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().getLoanApplicationList(token: "\(tokenInfo.access_token ?? "")", listRequest: mylistRequest, success:{ (responseDA) in
                            success(responseDA)
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
        
    }
    
    func doInquiryPurchaseDetail(tokenInfo:TokenData, inquiryAppId: String, success: @escaping (PurchaseDetail) -> Void,failure: @escaping (String) -> Void){
        
        DAModel.init().getPurchaseDetail(token: "\(tokenInfo.access_token ?? "")", applicationID: inquiryAppId, success: { (result) in
            
            if result.status == Constants.STATUS_200 {
                
                if result.data != nil {
                    let calculatorResult = result.data
                    success(calculatorResult!)
                } else {
                    failure("No detail getPurchaseDetail")
                }
                
                
                
            } else {
                failure(result.status!)
            }
            
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().getPurchaseDetail(token: "\(tokenInfo.access_token ?? "")", applicationID: inquiryAppId, success: { (result) in
                            
                            if result.status == Constants.STATUS_200 {
                                let calculatorResult = result.data
                                success(calculatorResult!)
                                
                            } else {
                                failure(result.status!)
                            }
                            
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
        
    }
    
    func doInquiryApplicationInfoDetail(tokenInfo:TokenData, inquiryAppId: String, success: @escaping (ApplicationDetailResponse) -> Void,failure: @escaping (String) -> Void){
        
        DAModel.init().getApplicationInfoDetail(token: "\(tokenInfo.access_token ?? "")", applicationID: inquiryAppId, success: { (result) in
           
            success(result)
            
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().getApplicationInfoDetail(token: "\(tokenInfo.access_token ?? "")", applicationID: inquiryAppId, success: { (result) in
                            
                            
                            success(result)
                            
                            
                            
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
        
    }
    
    func doCancelApplication(tokenInfo:TokenData, inquiryAppId: String, success: @escaping (ApplicationCancelResponse) -> Void,failure: @escaping (String) -> Void){
        
        DAModel.init().doApplicationCancel(token: "\(tokenInfo.access_token ?? "")", applicationID: inquiryAppId, success: { (result) in
            
            success(result)
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().doApplicationCancel(token: "\(tokenInfo.access_token ?? "")", applicationID: inquiryAppId, success: { (result) in
                            
                            
                            success(result)
                            
                            
                            
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
    func getAgreementListsVM(tokenInfo:TokenData, cusID: String, success: @escaping ([AgreementInfo]) -> Void,failure: @escaping (String) -> Void){
        
        DAModel.init().getAgreementList(token: "\(tokenInfo.access_token ?? "")", customerid: cusID, success: { (result) in
            
            success(result)
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().getAgreementList(token: "\(tokenInfo.access_token ?? "")", customerid: cusID, success: { (result) in
                            
                            
                            success(result)
                            
                            
                            
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
    func getQRCodeProductInfoVM(tokenInfo:TokenData, appid: String, success: @escaping (QRProductInfo) -> Void,failure: @escaping (String) -> Void){
        
        DAModel.init().getQRCodeProductInfo(token: "\(tokenInfo.access_token ?? "")", appInfoID: appid, success: { (result) in
            
            success(result)
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().getQRCodeProductInfo(token: "\(tokenInfo.access_token ?? "")", appInfoID: appid, success: { (result) in
                            
                            
                            success(result)
                            
                            
                            
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
    func getProductInfoConfirmVM(tokenInfo:TokenData, purchaseid: String, cusId: String, appid: String, success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        
        DAModel.init().getProductInfoConfirm(token: "\(tokenInfo.access_token ?? "")", purchaseid: purchaseid, cusId: cusId, appid: appid, success: { (result) in
            
            success(result)
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().getProductInfoConfirm(token: "\(tokenInfo.access_token ?? "")", purchaseid: purchaseid, cusId: cusId, appid: appid, success: { (result) in
                            
                            success(result)
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
    func getProductInfoCancelVM(tokenInfo:TokenData, purchaseid: String, cusId: String, appid: String, success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        
        DAModel.init().getProductInfoCancel(token: "\(tokenInfo.access_token ?? "")", purchaseid: purchaseid, cusId: cusId, appid: appid, success: { (result) in
            
            success(result)
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: tokenInfo.refresh_token!, success: { (result) in
                    
                    if result.status == Constants.STATUS_200 {
                        var token = TokenBean()
                        token.accessToken = result.data.access_token
                        token.refreshToken = result.data.refresh_token
                        token.tokenType = result.data.token_type
                        token.scope = result.data.scope
                        token.expireIn = result.data.expire_in
                        
                        let jsonData = try? JSONEncoder().encode(result)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        UserDefaults.standard.set(jsonString, forKey: Constants.TOKEN_DATA)
                        
                        DAModel.init().getProductInfoCancel(token: "\(tokenInfo.access_token ?? "")", purchaseid: purchaseid, cusId: cusId, appid: appid, success: { (result) in
                            
                            success(result)
                        }) { (error) in
                            failure(Constants.EXPIRE_TOKEN)
                        }
                        
                    } else {
                        failure(Constants.EXPIRE_TOKEN)
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
    //Attachment Edit
    func doEditAttachmentList(tokenInfo:TokenData, appAttachmentid: Int, attachmentlist:[AttachmentObj], success: @escaping (Bool) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = getAttachmentEditData(applicationattachmentid: appAttachmentid, attachmentlist: attachmentlist)
        
        DAModel.init().editAttachmentList(token: "\(tokenInfo.access_token ?? "")", rawData: rawData, success:{ (result) in
            //            if result.status == Constants.STATUS_200 {
            print("DA view model", result)
            success(result)
            
        }) { (error) in
            failure(error)
        }
        
    }
    
    //Attachment Edit with multipart
    func doEditAttachmentListMultipart(tokenInfo:TokenData, appAttachmentid: Int, attachmentlist:[AttachmentObj] ,imageList:[UIImage], success: @escaping (Bool) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = getAttachmentEditData(applicationattachmentid: appAttachmentid, attachmentlist: attachmentlist)
        
        DAModel.init().editAttachmentListMultipart(token: "\(tokenInfo.access_token ?? "")", rawData: rawData, imageDataList: imageList, success:{ (result) in
            //            if result.status == Constants.STATUS_200 {
            print("DA view model", result)
            success(result)
            
        }) { (error) in
            failure(error)
        }
        
    }
    
    //GET REQUEST DATA Attachment edit
    func getAttachmentEditData(applicationattachmentid: Int, attachmentlist:[AttachmentObj]) -> Data {
        
        let registerRequest = AttachmentEditRequest(daApplicationInfoId: applicationattachmentid, applicationInfoAttachmentDtoList: attachmentlist)
        
        do {
            let jsonData = try JSONEncoder().encode(registerRequest)
            
            
            return jsonData
        } catch { print("Error \(error)") }
        
        return Data()
        
        
    }
    
    
    func getProductTypeList(success: @escaping ([ProductTypeObj]) -> Void,failure: @escaping (String) -> Void) {
        
        DAModel.init().getProductTypeList(success: { (typelist) in
            success(typelist)
        }) { (errorstring) in
            failure(errorstring)
        }
        
    }
    
    func getCityTownshipList(success: @escaping (CityTownShipModel) -> Void,failure: @escaping (String) -> Void) {
        
        DAModel.init().getCityTownshipInfoList(success: { (cityTownData) in
            //success(typelist)
            
            var cityNameIdDic = Dictionary<String, Int>()
            var cityIdTownListDic = Dictionary<Int, [String]>()
            var townNameIdDic = Dictionary<String, Int>()
            
            for city in cityTownData {
                var townNameList = [String]()
                cityNameIdDic[city.name!] = city.cityId
                
                for town in city.townshipInfoList {
                    townNameList.append(town.name!)
                    
                    townNameIdDic[town.name!] = town.townshipId
                }
                cityIdTownListDic[city.cityId!] = townNameList
            }
            
            var cityTownModel = CityTownShipModel()
            cityTownModel.cityIdTownListDic = cityIdTownListDic
            cityTownModel.cityNameIdDic = cityNameIdDic
            cityTownModel.townNameIdDic = townNameIdDic
            success(cityTownModel)
            
        }) { (errorstring) in
            failure(errorstring)
        }
        
    }
    
    
    
}
