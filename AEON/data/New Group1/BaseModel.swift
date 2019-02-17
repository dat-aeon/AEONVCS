//
//  BaseModel.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseModel {
    private var Manager : Alamofire.SessionManager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            Constants.base_url: .disableEvaluation
        ]
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return man
    }()
    
//    func performRequest(endPoint:String, rawData:[String:String] , completion:@escaping (Result<Any>)->Void) -> Any {
//        let json = JSON(rawData)
//        let representation = json.rawString([.castNilToNSNull: true])
//        print("Request params :::::::::::\(representation)")
//        let parameters:Parameters = [
//            "param_data": representation as Any
//        ]
//        let url:String = Constants.base_url + endPoint
//        print("Url ====>\(url)")
//        let headers:HTTPHeaders = ["Content-Type":"application/json"]
//        return Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ (response) in
//            completion(response.result)
//        }
//
//    }
//
//    func performRequest(endPoint:String, rawData:Data , completion:@escaping (Result<Any>)->Void) -> DataRequest {
//        let json = JSON(rawData)
//        let representation = json.rawString([.castNilToNSNull: true])
//        print("Request params :::::::::::\(representation)")
//        let parameters:Parameters = [
//            "param_data": representation as Any
//        ]
//        let url:String = Constants.base_url + endPoint
//        print("Url ====>\(url)")
//        let headers:HTTPHeaders = ["Content-Type":"application/json"]
//        return Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ (response) in
//            completion(response.result)
//        }
//
//    }
    func performRequest(endPoint:String,rawData:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {

        let urlString = Constants.base_url + endPoint

        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSON(rawData).rawData()

        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        print("Request params :::::::::::\(rawData)")
        print("Request data :::::::::::\(request)")

        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)

            print("Response result :::::::::::\(response)")

        }

    }

    func performRequest(endPoint:String,rawData:Data,completion:@escaping (Result<Any>)->Void) -> DataRequest {

        let urlString = Constants.base_url + endPoint
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = rawData
        print("Request params :::::::::::\(rawData)")
        print("Request data :::::::::::\(request)")
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)

            print("Response result :::::::::::\(response)")

        }
    }
    
    func performRequestWithImage(endPoint:String,imageData:Data,rawData:String,completion:@escaping (SessionManager.MultipartFormDataEncodingResult)->Void) -> Any {
        print("Request params :::::::::::\(rawData)")
        
        let urlString = Constants.base_url + endPoint
        
        return Alamofire.upload(multipartFormData: { (multipartFormData) in
                                multipartFormData.append(imageData, withName: "img",fileName: "\(Date().timeIntervalSince1970).png", mimeType: "image/png")
                                multipartFormData.append(rawData.data(using: String.Encoding.utf8)!, withName: "param_data")
                            }, usingThreshold: UInt64.init(), to:urlString, method : .post) { (response) in
                                completion(response)
                                 print("Response result :::::::::::\(response)")
        }
    }
}

