//
//  OutletModel.swift
//  AEONVCS
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OutletModel:BaseModel {
    
    func getOutletList(success: @escaping (OutletInfoResponse) -> Void,failure: @escaping (String) -> Void){
        
        let rawData = [
            "access_token" : ""
        ]
        let _ = super.requestGETtoASSM(endPoint: ApiServiceEndPoint.outletInfo, rawData: rawData) { (result) in
            switch result{
            case .success(let result):
                
                let response = result as AnyObject
                print("check oulet list response : ", response)
                
                var outletResponse = OutletInfoResponse()
                outletResponse.data = OutletData()
                if response["status"] as! String == Constants.STATUS_200 {
                    outletResponse.status = (response["status"] as? String)!
                    let data = response["data"] as AnyObject
                    outletResponse.data.outletLimitMetre = data["outletLimitMetre"] as? Int
                    outletResponse.data.outletInfoList = [OutletInfoBean]()
                    if let outletList = data["outletInfoList"] as? [AnyObject] {
                        for outlet in outletList {
                            var outletBean = OutletInfoBean()
                            //let agree:NSObject = agreeList as! NSObject
                            outletBean.outletId = outlet.value(forKey: "outletId") as? Int
                            outletBean.outletName = outlet.value(forKey: "outletName") as? String
                            outletBean.address = outlet.value(forKey: "outletAddress") as? String
                            outletBean.imagePath = outlet.value(forKey: "imagePath") as? String
                            if let longitude = outlet.value(forKey: "longitude") as? String {
                                outletBean.longitude = Double(longitude)
                            }
                            if let latitude = outlet.value(forKey: "latitude") as? String {
                                outletBean.latitude = Double(latitude)
                            }
                            outletBean.phoneNo = outlet.value(forKey: "phoneNo") as? String
                            outletBean.isAeonOutlet = outlet.value(forKey: "isAeon") as? Bool
                            outletBean.roleType = outlet.value(forKey: "roleId") as? Int
                            
                            outletResponse.data.outletInfoList.append(outletBean)
                        }
                    }
                    
                    
                } else {
                    if response["messageCode"] as! String == "SERVICE_UNAVAILABLE" {
                        failure(Constants.SERVER_FAILURE)
                    } else {
                        failure(Constants.JSON_FAILURE)
                    }
                }
                success(outletResponse)
                
                
            case .failure(let error):
                print("Failure on Promo List:", error.localizedDescription)
                failure(Constants.SERVER_FAILURE)
                
            }
        }
    }
}
