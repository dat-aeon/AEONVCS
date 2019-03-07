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
        print("Township size \(townships.count)")
        if townships.count > 0{
            for township in townships{
                var townshipList = township.components(separatedBy: ",")
                townshipList[0].removeFirst()
                townshipList[townshipList.count-1].removeLast()
                print("\(townshipList.count)")
                allTownShipList.append(townshipList)
            }
            print("Prepared township size \(allTownShipList.count)")
            success(allTownShipList)
        }else{
            failure("Cannot Load Township List")
        }
    }
    
    //CHECK MEMBER OR NON MEMBER
    func checkMember(registerBean: RegisterRequestBean, success: @escaping (CheckMemberResponse) -> Void, failure: @escaping (String) -> Void){
        
        RegisterModel.init().checkMemberData(registerReqBean: registerBean
            , success: { (result) in
                if result.statusCode == "200" {
                    success(result)
                    
                }else if result.statusCode == "500"{
                    failure(result.message ?? "Server error occurs.")
                }else{
                    failure("Server error occurs.")
                }
        }) { (error) in
            failure(error)
        }
    }
    
    //CHECK VERIFY USER INFO
    func checkVerifyUserInfo(verifyUserRequest: CheckVerifyUserInfoRequest, success: @escaping (CheckVerifyUserInfoResponse) -> Void, failure: @escaping (String) -> Void){
        
        RegisterModel.init().checkVerifiedUserInfo(verifyUserInfo: verifyUserRequest
            , success: { (result) in
                if result.statusCode.isEmpty {
                    failure("Server error")
                }else{
                    if result.verifyStatus == Constants.VALID_MEMBER{
                        success(result)
                    }else{
                        failure("Invalid Member Information")
                    }
                }
        }) { (error) in
            failure(error)
        }
    }
    
    //MAKE NEW MEMBER REGISTER
    func makeRegisterNewMember(registerRequestData:RegisterRequestBean,memberResponseData:CheckMemberResponse,qaList:[SecQABean],success: @escaping (NewRegisterResponse) -> Void,failure: @escaping (String) -> Void){
        let rawData = getRegisterNewRequestData(registerRequestData:registerRequestData, qaList: qaList)
        RegisterModel.init().registerNew(rawData:rawData, success: { (result) in
            if result.statusCode == "200"{
                success(result)
            }else{
                failure(result.statusMessage!)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    //GET REQUEST DATA FOR NEW MEMBER
    func getRegisterNewRequestData(registerRequestData:RegisterRequestBean,qaList:[SecQABean])->Data{
        let osVersion = "\(ProcessInfo().operatingSystemVersion.majorVersion).\(ProcessInfo().operatingSystemVersion.minorVersion).\(ProcessInfo().operatingSystemVersion.patchVersion)"
        let cpuArch = MemoryLayout<Int>.size == MemoryLayout<Int32>.size ? 32 : 64
        
        let  appUsageInfo = AppUsageInfoReqBean(
            phoneModel: UIDevice.modelName,
            manufacture: "-",
            sdk: "-",
            osType: "-",
            osVersion: osVersion,
            resolution: "\(UIScreen.main.bounds.width) x \(UIScreen.main.bounds.height)",
            instructionSet: "-",
            cpuArchitecture: "\(cpuArch)",
            registrationTime: "-")
            
        _ = UserDefaults.standard.string(forKey: "password")
            let existedMemberRequestData = RegisterNewRequestData(
                name: registerRequestData.name,
                dateOfBirth: registerRequestData.dob,
                nrcNo: registerRequestData.nrc,
                phoneNo: registerRequestData.phoneNo,
                password: registerRequestData.password,
                securityAnsweredInfoList: qaList,
                appUsageInfo:appUsageInfo)
        
//            let requestParamData = try! JSON(existedMemberRequestData).rawData()
//            print("Request ParamData \(requestParamData)")
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
        RegisterModel.init().registerExisted(rawData:rawData,imageData:profileImage.jpegData(compressionQuality: 1)!, success: { (result) in
            if result.statusCode == "200"{
                success(result)
            }else{
                failure(result.statusMessage!)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    //GET REQUEST DATA FOR EXISTED MEMBER
    func getRegisterExistedRequestData(registerRequestData:RegisterRequestBean,memberResponseData:CheckMemberResponse,qaList:[SecQABean])->String{
        let osVersion = "\(ProcessInfo().operatingSystemVersion.majorVersion).\(ProcessInfo().operatingSystemVersion.minorVersion).\(ProcessInfo().operatingSystemVersion.patchVersion)"
        let cpuArch = MemoryLayout<Int>.size == MemoryLayout<Int32>.size ? 32 : 64
        
        let  appUsageInfo = AppUsageInfoReqBean(
            phoneModel: UIDevice.modelName,
            manufacture: "-",
            sdk: "-",
            osType: "-",
            osVersion: osVersion,
            resolution: "\(UIScreen.main.bounds.width) x \(UIScreen.main.bounds.height)",
            instructionSet: "-",
            cpuArchitecture: "\(cpuArch)",
            registrationTime: "-")
        
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
        
//        let requestParamData = try! JSON(rawValue: existedMemberRequestData)
//        print("Request ParamData \(requestParamData)")
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
    
    //MAKE EXISTED MEMBER REGISTER
    func updateRegisterNewMember(customerNo:String,profileImage:UIImage,memberResponseData:CheckMemberResponse,qaList:[SecQABean],success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        
        RegisterModel.init().registerExisted(rawData:customerNo,imageData:profileImage.pngData()!, success: { (result) in
            if result.statusCode == "200"{
                success(result)
            }else{
                failure(result.statusMessage!)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    //MAKE VERIFY MEMBER REGISTER
    func updateVerifiedNewMember(customerId:String,customerNo:String,profileImage:UIImage ,success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = [
            "customerId" : customerId,
            "customerNo" : customerNo
        ]
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(rawData)
        let verifyData = String(data: jsonData, encoding: String.Encoding.utf8)
        
        RegisterModel.init().registerVerifyMember(rawData:verifyData!,imageData:profileImage.pngData()!, success: { (result) in
            if result.statusCode == "200"{
                success(result)
            }else{
                failure(result.statusMessage!)
            }
        }) { (error) in
            failure(error)
        }
    }
}
