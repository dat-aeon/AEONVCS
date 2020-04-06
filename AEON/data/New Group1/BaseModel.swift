//
// BaseModel.swift
// AEON
//
// Created by AcePlus101 on 2/3/19.
// Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseModel {
    func performRequest(endPoint:String,rawData:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {

        let urlString = Constants.base_url + endPoint

        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
        do {
            request.httpBody = try JSON(rawData).rawData()

        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        print("Request data :::::::::::\(request)\(rawData)")

        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }

    func performRequest(endPoint:String,rawData:Data,completion:@escaping (Result<Any>)->Void) -> DataRequest {

        let urlString = Constants.base_url + endPoint
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.httpBody = rawData
        request.timeoutInterval = 180
        print("Request data :::::::::::\(request)\(rawData)")
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
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
    
    
    func performRequestData(endPoint:String,rawData:[String:String],completion:@escaping (Result<Data>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
        do {
            request.httpBody = try JSON(rawData).rawData()
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        print("Request params :::::::::::\(rawData)")
        print("Request data :::::::::::\(request)")
        
        
        return Alamofire.request(request).responseData { (response) in
            completion(response.result)
        
        }
    }
    
    func requestToken(endPoint:String,rawData:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICAITON_X_WWW_FORM_URLENCODED, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.setValue(ApiServiceEndPoint.BASIC_AUTHORIZE_CODE, forHTTPHeaderField: ApiServiceEndPoint.AUTHORIZATION)
        request.timeoutInterval = 180
        
        let parameters: Parameters = rawData
        //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
        
        do {
            //request.httpBody = try JSON(rawData).rawData()
            let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            //print("Request data :::::::::::\(encodedURLRequest)")
            
            return Alamofire.request(encodedURLRequest).authenticate(user: ApiServiceEndPoint.API_USER_NAME, password: ApiServiceEndPoint.API_USER_PASSWORD).responseJSON{ (response) in
                completion(response.result)
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        //print("Request params for login:::::::::::\(rawData)")
        
        return Alamofire.request(request).authenticate(user: ApiServiceEndPoint.API_USER_NAME, password: ApiServiceEndPoint.API_USER_PASSWORD).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    func refreshToken(endPoint:String,rawData:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICAITON_X_WWW_FORM_URLENCODED, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.setValue(ApiServiceEndPoint.BASIC_AUTHORIZE_CODE, forHTTPHeaderField: ApiServiceEndPoint.AUTHORIZATION)
        request.timeoutInterval = 180
        
        let parameters: Parameters = rawData
        //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
        
        do {
            //request.httpBody = try JSON(rawData).rawData()
            let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            print("Request data :::::::::::\(encodedURLRequest)")
            
            return Alamofire.request(encodedURLRequest).authenticate(user: ApiServiceEndPoint.API_USER_NAME, password: ApiServiceEndPoint.API_USER_PASSWORD).responseJSON{ (response) in
                completion(response.result)
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        print("Request params for login:::::::::::\(rawData)")
        
        return Alamofire.request(request).authenticate(user: ApiServiceEndPoint.API_USER_NAME, password: ApiServiceEndPoint.API_USER_PASSWORD).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    func requestDataWithToken(endPoint:String,rawData:[String:String],token:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
        
        let parameters: Parameters = token
        //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
        
        do {
            request.httpBody = try JSON(rawData).rawData()
            let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            print("Request data :::::::::::\(encodedURLRequest)\(rawData)")
            
            return Alamofire.request(encodedURLRequest).responseJSON{ (response) in
                completion(response.result)
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    //DA
    func requestDataWithTokenDAWithStringDict(endPoint:String,rawData:[String:String],token:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.daso_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
        
        let parameters: Parameters = token
        //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
        
        do {
            request.httpBody = try JSON(rawData).rawData()
            let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            print("Request data :::::::::::\(encodedURLRequest)\(rawData)")
            
            return Alamofire.request(encodedURLRequest).responseJSON{ (response) in
                completion(response.result)
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    // requestData with GET
    func requestDataWithGETToken(endPoint:String,rawData:[String:String],token:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.GET_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
        
        let parameters: Parameters = token
        //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
        
        do {
//            request.httpBody = try JSON(rawData).rawData()
            let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            //print("Request data :::::::::::\(encodedURLRequest)\(rawData)")
            
            return Alamofire.request(encodedURLRequest).responseJSON{ (response) in
                completion(response.result)
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    
    
    func requestDataWithGETTokenDA(endPoint:String,rawData:[String:String],token:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
            
            let urlString = Constants.daso_url + endPoint
            
            let url = URL(string: urlString)
            var request        = URLRequest(url: url!)
            request.httpMethod = ApiServiceEndPoint.GET_METHOD
            request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
            request.timeoutInterval = 180
            
            let parameters: Parameters = token
            //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            
            do {
    //            request.httpBody = try JSON(rawData).rawData()
                let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
                //print("Request data :::::::::::\(encodedURLRequest)\(rawData)")
                
                return Alamofire.request(encodedURLRequest).responseJSON{ (response) in
                    completion(response.result)
                }
                
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
            
            return Alamofire.request(request).responseJSON{ (response) in
                completion(response.result)
            }
        }
    
    //DA
    
    func doEditAttachListWithImage(endPoint:String,imageDataList:[UIImage],rawData:Data, token:String ,completion:@escaping (SessionManager.MultipartFormDataEncodingResult)->Void) -> Any {
        
        let urlString = Constants.base_url + endPoint
        print("Request params :::::::::::\(urlString)")
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        
         return Alamofire.upload(multipartFormData: { multipartFormData in
            for image in imageDataList {
                if let imageData = image.jpegData(compressionQuality: 1) {
                    multipartFormData.append(imageData, withName:"img", fileName: "imageDataList[\(String(describing: index))]", mimeType: "image/jpg")
                }
            }
            multipartFormData.append(rawData, withName: "applicationInfoDto")
            multipartFormData.append(token.data(using: String.Encoding.utf8)!, withName: "access_token")
            
        },
        to:urlString)
        { (result) in
            switch result {
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })

                upload.responseJSON { response in
                     print(response.result.value)
                    return 
                }

            case .failure(let encodingError):
                print(encodingError)
            }
        }
//        return Alamofire.upload(
//
//            multipartFormData: { multipartFormData in
//                for image in imageDataList {
//                    if let imageData = image.jpegData(compressionQuality: 1) {
//                        multipartFormData.append(imageData, withName: "imageDataList[\(String(describing: index))]", fileName: "img", mimeType: "image/jpeg")
//                    }
//                }
//                multipartFormData.append(rawData, withName: "applicationInfoDto")
//                multipartFormData.append(token.data(using: String.Encoding.utf8)!, withName: "access_token")
//
//        }, to: urlString
//        , encodingCompletion: { encodingResult in
//            switch encodingResult{
//            case .success( let upload, _, _):
//                upload.responseJSON { response in
//                    print(response.result.value)
//                }
//            case .failure(let encodigError):
//                print(encodigError)
//
//            }
//
//        })
        
        
//        return Alamofire.upload(
//            multipartFormData: { (multipartFormData) in
//
//                for image in imageDataList {
//                    if let imageData = image.jpegData(compressionQuality: 1) {
//                        multipartFormData.append(imageData, withName: "imageDataList[\(String(describing: index))]", fileName: "img", mimeType: "image/jpg")
//                    }
//                }
//            multipartFormData.append(rawData, withName: "applicationInfoDto")
//            multipartFormData.append(token.data(using: String.Encoding.utf8)!, withName: "access_token")
//        }, usingThreshold: UInt64.init(), to:urlString, method : .post) { (response) in
//            completion(response)
//            print("Response result :::::::::::\(response)")
//        }
    }
    
    func requestDataObjWithTokenDA(endPoint:String,rawData:Data,token:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
         let urlString = Constants.daso_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //request.setValue("Basic dmNzLWFwaS1jbGllbnQ6dmNzLWFwaS1jbGllbnQ=", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 180
        
        let parameters: Parameters = token
        //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
        
        do {
            request.httpBody = try JSON(rawData).rawData()
            let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            //print("Request data :::::::::::\(encodedURLRequest)\(try JSON(rawData).rawData())")
            
            return Alamofire.request(encodedURLRequest).responseJSON{ (response) in
                completion(response.result)
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        //print("Request params for login:::::::::::\(rawData)")
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    func requestDataWithTokenDA(endPoint:String,rawData:[String:String],token:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.daso_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
        
        let parameters: Parameters = token
        //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
        
        do {
            request.httpBody = try JSON(rawData).rawData()
            let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            print("Request data :::::::::::\(encodedURLRequest)\(request)")
            
            return Alamofire.request(encodedURLRequest).responseJSON{ (response) in
                completion(response.result)
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    // request with Data Obj
    func requestDataObjWithToken(endPoint:String,rawData:Data,token:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //request.setValue("Basic dmNzLWFwaS1jbGllbnQ6dmNzLWFwaS1jbGllbnQ=", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 180
        
        let parameters: Parameters = token
        //let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
        
        do {
            request.httpBody = try JSON(rawData).rawData()
            let encodedURLRequest = try URLEncoding.queryString.encode(request, with: parameters)
            //print("Request data :::::::::::\(encodedURLRequest)\(rawData)")
            
            return Alamofire.request(encodedURLRequest).responseJSON{ (response) in
                completion(response.result)
            }
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        //print("Request params for login:::::::::::\(rawData)")
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    // call get api without access token
    func requestGETWithoutToken(endPoint:String,rawData:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.GET_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
//        do {
//            request.httpBody = try JSON(rawData).rawData()
//            
//        } catch let error {
//            print("Error : \(error.localizedDescription)")
//        }
        //print("Request data :::::::::::\(request)\(rawData)")
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    // call post api without access token
    func requestPOSTWithoutToken(endPoint:String,rawData:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.POST_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
        do {
            request.httpBody = try JSON(rawData).rawData()
            
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        //print("Request data :::::::::::\(request)\(rawData)")
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }

    
    // call get api without access token with ASSM2
    func requestGETtoASSM(endPoint:String,rawData:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
        request.httpMethod = ApiServiceEndPoint.GET_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
//        do {
//            request.httpBody = try JSON(rawData).rawData()
//
//        } catch let error {
//            print("Error : \(error.localizedDescription)")
//        }
        //print("Request data :::::::::::\(request)\(rawData)")
        
        return Alamofire.request(request).responseJSON{ (response) in
            completion(response.result)
        }
    }
    
    //call getVideo file path
    func getVideoFilePath(endPoint:String,rawData:[String:String],completion:@escaping (Result<Any>)->Void) -> DataRequest {
        
        let urlString = Constants.base_url + endPoint
        
        let url = URL(string: urlString)
        var request        = URLRequest(url: url!)
       request.httpMethod = ApiServiceEndPoint.GET_METHOD
        request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
        request.timeoutInterval = 180
        
         return Alamofire.request(request).responseJSON{ (response) in
                   completion(response.result)
               }
    }
//    func getAskProductUnread(endPoint: String,rawData:[String:Int],completion:@escaping (Result<Any>)->Void)-> DataRequest {
//        let urlString = Constants.base_url + endPoint
//
//        let url = URL(string: urlString)
//        var request = URLRequest(url: url!)
//        request.httpMethod = ApiServiceEndPoint.POST_METHOD
//        return Alamofire.request(request).responseJSON{ (response) in
//            completion(response.result)
//        }
//
//        }
    
    func getAskProductUnread(endPoint:String,rawData:[String:Int],completion:@escaping (Result<Any>)->Void) -> DataRequest {

           let urlString = Constants.base_url + endPoint

           let url = URL(string: urlString)
           var request        = URLRequest(url: url!)
           request.httpMethod = ApiServiceEndPoint.POST_METHOD
           request.setValue(ApiServiceEndPoint.APPLICATION_JSON, forHTTPHeaderField: ApiServiceEndPoint.CONTENT_TYPE)
           request.timeoutInterval = 180
           do {
               request.httpBody = try JSON(rawData).rawData()

           } catch let error {
               print("Error : \(error.localizedDescription)")
           }
           print("Request data :::::::::::\(request)\(rawData)")

           return Alamofire.request(request).responseJSON{ (response) in
               completion(response.result)
           }
       }


    
}
