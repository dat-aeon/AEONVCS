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
    func loadNrcData(success:@escaping ([[String]]) -> Void,failure: @escaping (String) -> Void){
        RegisterModel.init().loadNRCData(siteActivationKey: Constants.site_activation_key ,success: { (result) in
            //UserDefaults.standard.set(result, forKey: Constants.NRC_TOWNSHIP_List)
            success(result)
            
        }, failure: { (error) in
            failure(error)
        })
    }
    
    //GET NRC DATA
    func getNrcData(success:@escaping ([[String]]) -> Void,failure: @escaping (String) -> Void) {
        var allTownShipList = [[String]]()
        let townships = UserDefaults.standard.array(forKey: Constants.NRC_TOWNSHIP_List) as! [String]
        
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
                success(result)
                
        }) { (error) in
            failure(error)
        }
    }
    
    //CHECK VERIFY USER INFO
    func checkVerifyUserInfo(verifyUserRequest: CheckVerifyUserInfoRequest,token: String,refreshToken: String, success: @escaping (CheckVerifyUserInfoResponse) -> Void, failure: @escaping (String) -> Void){
        
        RegisterModel.init().checkVerifiedUserInfo(verifyUserInfo: verifyUserRequest, token: token
            , success: { (result) in
                
                success(result)
                
        }) { (error) in
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: refreshToken, success: { (result) in
                    
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
                        
                        RegisterModel.init().checkVerifiedUserInfo(verifyUserInfo: verifyUserRequest, token: token.accessToken!
                            , success: { (result) in
                            
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
    
    //MAKE NEW MEMBER REGISTER
    func  makeRegisterNewMember(registerRequestData:RegisterRequestBean,memberResponseData:CheckMemberResponse,qaList:[SecQABean],success: @escaping (NewRegisterResponse) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = getRegisterNewRequestData(registerRequestData:registerRequestData, qaList: qaList)
        
        RegisterModel.init().registerNew(rawData:rawData, success: { (result) in
            if result.status == Constants.STATUS_200{
                success(result)
            } else{
                failure(Constants.SERVER_INTERNAL_FAILURE)
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
            osType: "iOS",
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
    func makeRegisterExistedMember(registerRequestData:RegisterRequestBean,profileImage:UIImage,memberResponseData:CheckMemberResponse,qaList:[SecQABean],success: @escaping (NewRegisterResponse) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = getRegisterExistedRequestData(registerRequestData:registerRequestData,memberResponseData: memberResponseData, qaList: qaList, profileImage: profileImage)
        
        RegisterModel.init().registerExisted(rawData : rawData, success: { (result) in
            if result.status == Constants.STATUS_200 {
                print("view model", result)
                success(result)
                
            }else{
                failure(result.status!)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    //GET REQUEST DATA FOR EXISTED MEMBER
    func getRegisterExistedRequestData(registerRequestData:RegisterRequestBean,memberResponseData:CheckMemberResponse,qaList:[SecQABean], profileImage: UIImage)->Data{
        
        let osVersion = "\(ProcessInfo().operatingSystemVersion.majorVersion).\(ProcessInfo().operatingSystemVersion.minorVersion).\(ProcessInfo().operatingSystemVersion.patchVersion)"
        let cpuArch = MemoryLayout<Int>.size == MemoryLayout<Int32>.size ? 32 : 64
        
        let  appUsageInfo = AppUsageInfoReqBean(
            phoneModel: UIDevice.modelName,
            manufacture: "-",
            sdk: "-",
            osType: "iOS",
            osVersion: osVersion,
            resolution: "\(UIScreen.main.bounds.width) x \(UIScreen.main.bounds.height)",
            instructionSet: "-",
            cpuArchitecture: "\(cpuArch)",
            registrationTime: "-")
        
        let imageData:NSData = profileImage.pngData()! as NSData
        let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        
        let existedMemberRequestData = RegisterExistedRequestData(
            dateOfBirth: registerRequestData.dob,
            nrcNo: registerRequestData.nrc,
            phoneNo: registerRequestData.phoneNo,
            password: registerRequestData.password ,
            photoPath: imageBase64,
            securityAnsweredInfoList: qaList,
            appUsageInfo:appUsageInfo)
        
//        let requestParamData = try! JSON(rawValue: existedMemberRequestData)
//        print("Request ParamData \(requestParamData)")
        do {
            let jsonData = try JSONEncoder().encode(existedMemberRequestData)
            //let jsonString = String(data: jsonData, encoding: .utf8)!
            //print("Encode \(jsonString)")

//            // and decode it back
////            let decodedSentences = try JSONDecoder().decode(RegisterExistedRequestData.self, from: jsonData)
////            print("Decode \(decodedSentences)")

            return jsonData
        } catch { print("Error \(error)") }

        return Data()
    }
    
    //MAKE EXISTED MEMBER REGISTER
    func updateRegisterNewMember(customerNo:String,profileImage:UIImage,memberResponseData:CheckMemberResponse,qaList:[SecQABean],success: @escaping (RegisterResponse) -> Void,failure: @escaping (String) -> Void){
        
//        RegisterModel.init().registerExisted(rawData:customerNo, success: { (result) in
//            if result.statusCode == "200"{
//                success(result)
//            }else{
//                failure(result.statusMessage!)
//            }
//        }) { (error) in
//            failure(error)
//        }
    }
    
    //MAKE VERIFY MEMBER REGISTER
    func updateVerifiedNewMember(customerId:String, customerNo:String, profileImage:UIImage , phoneNo:String, token:String, refreshToken:String, success: @escaping (LoginResponse) -> Void,failure: @escaping (String) -> Void){
        
        let imageData:NSData = profileImage.pngData()! as NSData
        let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        
        let rawData = [
            "customerId" : customerId,
            "customerNo" : customerNo,
            "photoByte" : imageBase64
        ]
        
        let jsonEncoder = JSONEncoder()
        let verifyData = try! jsonEncoder.encode(rawData)
        //let verifyData = String(data: jsonData, encoding: String.Encoding.utf8)
        
        RegisterModel.init().registerVerifyMember(rawData:verifyData, token: token, success: { (result) in
            if result.status == Constants.STATUS_200 {
                success(result)
                
            } else {
                failure(result.status)
            }
            
        }) { (error) in
            
            if error == Constants.EXPIRE_TOKEN {
                LoginAuthModel.init().refereshToken(refreshToken: refreshToken, success: { (result) in
                    
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
                        
                        RegisterModel.init().registerVerifyMember(rawData:verifyData,token: token.accessToken!, success: { (result) in
                            if result.status == Constants.STATUS_200 {
                                success(result)
                                
                            } else {
                                failure(result.status)
                            }
                            
                        }) { (error) in
                            failure(error)
                        }
                        
                    } else {
                        failure(result.status ?? "FAILED")
                    }
                    
                }) { (error) in
                    failure(Constants.EXPIRE_TOKEN)
                }
            }
            failure(error)
        }
    }
    
}
