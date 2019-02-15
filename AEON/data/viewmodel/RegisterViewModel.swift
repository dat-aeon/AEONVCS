//
//  RegisterViewModel.swift
//  AEONVCS
//
//  Created by mac on 2/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class RegisterViewModel{
    
    //LOAD NRC DATA
    func loadNrcData(success:@escaping (String) -> Void,failure: @escaping (String) -> Void){
        RegisterModel.init().loadNRCData(success: { (result) in
            UserDefaults.standard.set(result, forKey: Constants.NRC_TOWNSHIP_List)
            success("")
        }, failure: { (error) in
            failure(error)
        })
    }
    //GET NRC DATA
    func getNrcData(success:@escaping ([[String]]) -> Void,failure: @escaping (String) -> Void) {
        var allTownShipList = [[String]]()
        let townships = UserDefaults.standard.array(forKey: Constants.NRC_TOWNSHIP_List) as! [String]
        if townships.count>0{
            for township in townships{
                var townshipList = township.components(separatedBy: ",")
                townshipList[0].removeFirst()
                townshipList[townshipList.count-1].removeLast()
                print("\(townshipList.count)")
                allTownShipList.append(townshipList)
            }
            success(allTownShipList)
        }else{
            failure("Cannot Load Township List")
        }
    }
    
    //CHECK MEMBER OR NON MEMBER
    func checkMember(registerBean: RegisterRequestBean, success: @escaping (CheckMemberResponse) -> Void, failure: @escaping (String) -> Void){
        
        RegisterModel.init().checkMemberData(registerReqBean: registerBean
            , success: { (result) in
                if result.message.isEmpty {
                    failure(result.message)
                }else{
                    if result.message == Constants.MEMBER{
                        // save in user default
                        UserDefaults.standard.set(result.message, forKey: Constants.CUSTOMER_TYPE)
                        UserDefaults.standard.set(result.memberDataBean!.importCustomerInfoId, forKey: Constants.IMPORT_CUSTOMER_INFO_ID)
                        UserDefaults.standard.set(result.memberDataBean!.customerNo, forKey: Constants.IMPORT_CUSTOMER_NO)
                        UserDefaults.standard.set(result.memberDataBean!.name, forKey: Constants.IMPORT_CUSTOMER_NAME)
                        UserDefaults.standard.set(result.memberDataBean!.gender, forKey: Constants.IMPORT_GENDER)
                        UserDefaults.standard.set(result.memberDataBean!.phoneNo, forKey: Constants.IMPORT_PHONE_NO)
                        UserDefaults.standard.set(result.memberDataBean!.nrcNo, forKey: Constants.IMPORT_NRC_NO)
                        UserDefaults.standard.set(result.memberDataBean!.dateOfBirth, forKey: Constants.IMPORT_DOB)
                        UserDefaults.standard.set(result.memberDataBean!.salary, forKey: Constants.IMPORT_SALARY)
                        UserDefaults.standard.set(result.memberDataBean!.age, forKey: Constants.IMPORT_AGE)
                        UserDefaults.standard.set(result.memberDataBean!.companyName, forKey: Constants.IMPORT_COMPANY_NAME)
                        UserDefaults.standard.set(result.memberDataBean!.townshipAddress, forKey: Constants.IMPORT_ADDRESS)
                        UserDefaults.standard.set(result.memberDataBean!.status, forKey: Constants.IMPORT_STATUS)
                        UserDefaults.standard.set(result.memberDataBean!.custAgreementListResDaoList, forKey: Constants.IMPORT_CUSTOMER_NO)
                        
                        success(result)
                    }else if result.message == Constants.NON_MEMBER {
                        // save in user default
                        UserDefaults.standard.set(result.message, forKey: Constants.CUSTOMER_TYPE)
                        
                        success(result)
                    }else{
                        failure("Invalid Member")
                    }
                }
        }) { (error) in
            failure(error)
        }
    }
    
    //MAKE NEW MEMBER REGISTER
    func makeRegisterNewMember(registerRequestData:RegisterRequestBean,memberResponseData:CheckMemberResponse,qaList:[SecQABean],success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = getRegisterNewRequestData(registerRequestData:registerRequestData, qaList: qaList)
        RegisterModel.init().registerNew(rawData:rawData, success: { (result) in
            if result.dataBean.customerId != "0"{
                success(result)
            }else{
                failure(result.message)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    //GET REQUEST DATA FOR NEW MEMBER
    func getRegisterNewRequestData(registerRequestData:RegisterRequestBean,qaList:[SecQABean])->Data{
            let  appUsageInfo = AppUsageInfoReqBean(
                phoneModel: "a",
                manufacture: "a",
                sdk: "a",
                osType: "a",
                osVersion: "a",
                resolution: "a",
                instructionSet: "a",
                cpuArchitecture: "a",
                registrationTime: "a")
            
        _ = UserDefaults.standard.string(forKey: "password")
            let existedMemberRequestData = RegisterNewRequestData(
                name: registerRequestData.name,
                dateOfBirth: registerRequestData.dob,
                nrcNo: registerRequestData.nrc,
                phoneNo: registerRequestData.phoneNo,
                password: registerRequestData.password,
                securityAnsweredInfoList: qaList,
                appUsageInfo:appUsageInfo)
        
            let requestParamData = try! JSON(existedMemberRequestData).rawData()
            print("Request ParamData \(requestParamData)")
            do {
                let jsonData = try JSONEncoder().encode(existedMemberRequestData)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                print("Encode \(jsonString)")
                
                // and decode it back
//                let decodedSentences = try JSONDecoder().decode(RegisterExistedRequestData.self, from: jsonData)
//                print("Decode \(decodedSentences)")
//                JSON(jsonData).rawData()
                return jsonData
            } catch { print("Error \(error)") }
            
            return Data()
        }
    //MAKE EXISTED MEMBER REGISTER
    func makeRegisterExistedMember(registerRequestData:RegisterRequestBean,profileImage:UIImage,memberResponseData:CheckMemberResponse,qaList:[SecQABean],success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = getRegisterExistedRequestData(registerRequestData:registerRequestData,memberResponseData: memberResponseData, qaList: qaList)
        RegisterModel.init().registerExisted(rawData:rawData,imageData:profileImage.pngData()!, success: { (result) in
            if result.dataBean.customerId != "0"{
                success(result)
            }else{
                failure(result.message)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    //GET REQUEST DATA FOR EXISTED MEMBER
    func getRegisterExistedRequestData(registerRequestData:RegisterRequestBean,memberResponseData:CheckMemberResponse,qaList:[SecQABean])->String{
        let  appUsageInfo = AppUsageInfoReqBean(
            phoneModel: "a",
            manufacture: "a",
            sdk: "a",
            osType: "a",
            osVersion: "a",
            resolution: "a",
            instructionSet: "a",
            cpuArchitecture: "a",
            registrationTime: "a")
        
        let password = registerRequestData.password
        let existedMemberRequestData = RegisterExistedRequestData(
            name: memberResponseData.memberDataBean?.name ?? "",
            dateOfBirth: memberResponseData.memberDataBean?.dateOfBirth ?? "",
            nrcNo: memberResponseData.memberDataBean?.nrcNo ?? "",
            phoneNo: memberResponseData.memberDataBean?.phoneNo ?? "",
            password: password ,
            importCustomerId: memberResponseData.memberDataBean?.importCustomerInfoId ?? 0,
            customerNo: memberResponseData.memberDataBean?.customerNo ?? "",
            photoPath: "",
            securityAnsweredInfoList: qaList,
            appUsageInfo:appUsageInfo)
        
        let requestParamData = try! JSON(rawValue: existedMemberRequestData)
        print("Request ParamData \(requestParamData)")
        do {
            let jsonData = try JSONEncoder().encode(existedMemberRequestData)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print("Encode \(jsonString)")
            
            // and decode it back
//            let decodedSentences = try JSONDecoder().decode(RegisterExistedRequestData.self, from: jsonData)
//            print("Decode \(decodedSentences)")
            
            return jsonString
        } catch { print("Error \(error)") }
        
        return ""
    }
}
