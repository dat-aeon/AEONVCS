//
//  AttachmentEditVC.swift
//  AEONVCS
//
//  Created by mac on 11/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVFoundation

protocol AttachmentEditedDelegate {
    func refreshAppList()
}

class AttachmentEditVC: BaseUIViewController {
    
    
    @IBOutlet weak var tbAttachmentedit: UITableView!
    
    var inquiryAppID = 0
    var appinfoobj = ApplicationDetailResponse()
    var tokenInfo: TokenData?
    var attachmentArray = [PurchaseAttachmentResponse]()
    
    var currentfileIndex = 0
    var currentSelectedImage: UIImage?
    
    var attachmentObjArray = [AttachmentObj]()
    
    let myPickerController = UIImagePickerController()
    
    var editedImages = [String: UIImage]()
    
    var imageList = [UIImage]()
    
    // Attach Edit delegate
    var editDelegate : AttachmentEditedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    func setupView() {
        self.tbAttachmentedit.delegate = self
        self.tbAttachmentedit.dataSource = self
        
        self.doGetApplicationDetailAPI()
        
        self.editedImages.reserveCapacity(9)
    }
    
    func doGetApplicationDetailAPI() {
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        DAViewModel.init().doInquiryApplicationInfoDetail(tokenInfo: tokenInfo!, inquiryAppId: "\(self.inquiryAppID)", success: { (purchaseDetailObj) in
            self.appinfoobj = purchaseDetailObj
            //self.attachmentArray = self.appinfoobj.applicationInfoAttachmentDtoList!
            if let dtolist = purchaseDetailObj.applicationInfoAttachmentDtoList {
                for attach in dtolist {
                    if attach.editFlag ?? false {
                        self.attachmentArray.append(attach)
                    }
                }
            }
            
            self.tbAttachmentedit.reloadData()
        }) { (error) in
            print("doGetPurchaseDetailAPI : \(error)")
        }
    }
    
    @IBAction func tappedOnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkCameraAccess(isApplicant: Bool) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
            presentCameraSettings()
        case .authorized:
            print("Authorized, proceed")
            if isApplicant {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChooseFoto"), object: self, userInfo: ["isCamera": true])
            } else {
                self.showActionSheet(vc: self)
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                    self.showActionSheet(vc: self)
                } else {
                    print("Permission denied")
                }
            }
        @unknown default:
            print("unknown value")
        }
    }
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "To Allow Camera Access, Go to Settings",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
    
    func showActionSheet(vc: UIViewController) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            //            self.camera()
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            //            self.photoLibrary()
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            self.myPickerController.delegate = self;
            self.myPickerController.sourceType = .camera
            self.present( self.myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            self.myPickerController.delegate = self;
            self.myPickerController.sourceType = .photoLibrary
            self.present( self.myPickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedOnSave(_ sender: Any) {
        self.doEditAttachmentsAPI()
    }
    
    func doEditAttachmentsAPI() {
//        if imageList.count > 0 {
//
//            let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
//            tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
//            //let appattachmentid = self.attachmentArray.first?.daPurchaseInfoAttachmentId
//            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
//            DAViewModel.init().doEditAttachmentListMultipart(tokenInfo: tokenInfo!, appAttachmentid: self.inquiryAppID, attachmentlist: self.attachmentObjArray, imageList: self.imageList, success: { (success) in
//                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//                let alertController = UIAlertController(title: "Attachment editing success!", message: "", preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
//                    //do cancel api
//
//                }))
//                self.present(alertController, animated: true, completion: nil)
//            }) { (error) in
//                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//                if error == Constants.SERVER_FAILURE {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
//                    self.present(navigationVC, animated: true, completion: nil)
//
//                } else if error == Constants.EXPIRE_TOKEN {
//                    Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON " + Messages.EXPIRE_TOKEN_ERROR.localized)
//
//                } else {
//                    Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "" + error)
//                }
//            }
//        }
        if !attachmentObjArray.isEmpty {
            if attachmentObjArray.count == self.attachmentArray.count {
                CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                
                DAViewModel.init().doEditAttachmentList(tokenInfo: tokenInfo!, appAttachmentid: self.inquiryAppID, attachmentlist: self.attachmentObjArray, success: { (success) in
                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    let alertController = UIAlertController(title: Constants.EDIT_SUCCESS_TITLE, message: "Attachment editing success!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                        // close popup screen and search
                        self.editDelegate?.refreshAppList()
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }) { (error) in
                    CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                    if error == Constants.SERVER_FAILURE {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let navigationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                        self.present(navigationVC, animated: true, completion: nil)
                        
                    } else if error == Constants.EXPIRE_TOKEN {
                        Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "Attachment Edit " + Messages.EXPIRE_TOKEN_ERROR.localized)
                        
                    } else {
                        Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "" + error)
                    }
                }
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.EDIT_FAILED_TITLE, message: "Please edit all images.")
            }
            
        }
    }
}

extension AttachmentEditVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let filteredArray =  self.attachmentArray.filter { $0.editFlag == true }
        print("attachment size \(attachmentArray.count)")
        return attachmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.ATTACHMENT_EDIT_CELL, for: indexPath) as! cellAttachmentEdit
        cell.cellBtnEdit.tag = indexPath.row
        cell.delegate = self as cellAttachmentEditDelegate
        
        let strindex = "\(indexPath.row)"
        let img = self.editedImages[strindex]
        cell.setData(para: self.attachmentArray[indexPath.row], imgfile: img)
        
        //let filteredArrayNON =  self.attachmentArray.filter { $0.fileType == indexPath.row+1 }
        //if filteredArrayNON.count > 0 {
            //            if currentfiletype == indexPath.row + 1 {
            //cell.setData(para: filteredArrayNON.first!, imgfile: img)
            //            } else {
            //                cell.setData(para: filteredArrayNON.first!, imgfile: nil)
            //            }
            
       // }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 264
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        var resizeImage = UIImage()
        let jpegData = image.jpegData(compressionQuality: 1.0)
        let jpegSize: Int = jpegData?.count ?? 0
        print("original size of image in KB: %f ", Double(jpegSize) / 1024.0)
        print("original image width & height", image.size.width, image.size.height)
        
        if jpegSize <= Constants.LOW_QUALITY_IMAGE_250 {
            resizeImage = image.resizeWithPercent(percentage: 1.0)!
            
        } else if jpegSize > Constants.LOW_QUALITY_IMAGE_250 && jpegSize <= Constants.MEDIUM_QUALITY_IMAGE_500 {
            resizeImage = image.resizeWithPercent(percentage: 0.8)!
            
        } else if jpegSize > Constants.MEDIUM_QUALITY_IMAGE_500 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_1500 {
            resizeImage = image.resizeWithPercent(percentage: 0.7)!
            
        } else {
            //                resizeImage = image!.resizeWithPercent(percentage: 0.5)!
            resizeImage = image.resizeWithPercent(percentage: 0.2)!
            
        }
        let rejpegData = resizeImage.jpegData(compressionQuality: 1.0)
        let rejpegSize: Int = rejpegData?.count ?? 0
        print("resize size of image in KB: %f ", Double(rejpegSize) / 1024.0)
        print("resize image width & height", resizeImage.size.width, resizeImage.size.height)
        return resizeImage
    }
}


extension AttachmentEditVC: cellAttachmentEditDelegate {
    func editAction(index: Int) {
        self.currentfileIndex = index // + 1
        self.checkCameraAccess(isApplicant: false)
    }
    
    func setImageByteToAttachmentObj(img: UIImage) {
        var attachObj = AttachmentObj()
        attachObj.daApplicationInfoAttachmentId = self.attachmentArray[self.currentfileIndex].daPurchaseInfoAttachmentId
        attachObj.filePath = self.attachmentArray[self.currentfileIndex].filePath
        attachObj.fileType = self.attachmentArray[self.currentfileIndex].fileType
        attachObj.fileName = Utils.generateLogoutTime()
        
        let imageData:NSData = resizeImage(image: img).pngData()! as NSData
        let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        
        //let attachment = AttachmentRequest(fileType: 7, photoByte: imageBase64)
        
        attachObj.photoByte = imageBase64
        self.attachmentObjArray.append(attachObj)
        //let filteredArrayNON =  self.attachmentObjArray.filter { $0.fileType == self.currentfiletype }
        
        //if filteredArrayNON.count == 0 {
         //       self.attachmentObjArray.append(attachObj)
       // } else {
//                var temparr = [AttachmentObj]()
//                for i in 0..<self.attachmentObjArray.count{
//                    let currentobj = self.attachmentObjArray[i]
//                    if currentobj.fileType == self.currentfiletype {
//                        temparr.append(attachObj)
//                    } else {
//                        temparr.append(currentobj)
//                    }
//                }
//                self.attachmentObjArray = temparr
        //    }
        // filter
        // self.editedImages.insert(img, at: self.currentfiletype - 1)
        let strindex = "\(self.currentfileIndex)"
        self.editedImages[strindex] = img
        self.imageList.append(resizeImage(image: img))
        self.currentSelectedImage = img
        self.tbAttachmentedit.reloadData()
        
    }
    
}

extension AttachmentEditVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.myPickerController.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            guard let originImage = info[.originalImage] as? UIImage else {
                self.setImageByteToAttachmentObj(img: UIImage())
                return
            }
            self.setImageByteToAttachmentObj(img: originImage)
            return
        }
        self.setImageByteToAttachmentObj(img: image)
        return
    }
}
