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
            "10.1.9.100:8081/assm/": .disableEvaluation
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

           //print("Response result :::::::::::\(response)")
     
    }
  
}
}
