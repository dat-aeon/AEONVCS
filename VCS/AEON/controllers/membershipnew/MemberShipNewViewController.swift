//
//  MemberShipNewViewController.swift
//  AEONVCS
//
//  Created by mac on 2/6/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

import SwiftyJSON
import SafariServices

class MemberShipNewViewController: BaseUIViewController {
    
    @IBOutlet weak var lblBarMemberType: UILabel!
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var tvMemberShipNew: UITableView!
//    @IBOutlet weak var imgCamera: UIImageView!
    
    var profileImageDelegate : ProfileImageNewClickDelegate?
    
    
    var sessionInfo:SessionDataBean?
       var tokenInfo: TokenData?
       
       var agreementNoList:[AgreementInfo] = []
       
       var cellHeight:[Int] = []
    
    var photoUrl = ""
               var name = ""
               var customerNo = ""
               var customerId = 0
    
 var logoutTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
        if let sessionData = sessionInfo{
            photoUrl = sessionData.photoPath ?? ""
            name = sessionData.name ?? ""
            customerNo = sessionData.customerNo ?? ""
            customerId = sessionData.customerId!
            
        }
        
        
       
        let customerType = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE)
                if customerType == Constants.MEMBER {
                    
                    self.tvMemberShipNew.register(UINib(nibName: "newMemberShipTableViewCell", bundle: nil), forCellReuseIdentifier: "newMemberShipTableViewCell")
                     self.tvMemberShipNew.register(UINib(nibName: "newMemberShipHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "newMemberShipHeaderTableViewCell")
                    self.tvMemberShipNew.register(UINib(nibName: "newMemberWarningTextTableViewCell", bundle: nil), forCellReuseIdentifier: "newMemberWarningTextTableViewCell")
                    
                    
                    self.tvMemberShipNew.dataSource = self
                    self.tvMemberShipNew.delegate = self
                    self.tvMemberShipNew.tableFooterView = UIView()
                    
                    
                    let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
                    sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
                    
                   
                    
                    if (sessionInfo?.customerAgreementDtoList) != nil{
        //                self.agreementNoList = agreementList
                        
                    }
        //            print("MemberCardInfoOneViewController agreementList::::::\(self.agreementNoList.count)")
                }
    
         self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
        
        
    }
   
    @objc func runTimedCode() {
          multiLoginGet()
      // print("kms\(logoutTimer)")
      }
    func multiLoginGet(){
         var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
               let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
          
           MultiLoginModel.init().makeMultiLogin(customerId: customerId
                   , loginDeviceId: deviceID, success: { (results) in
                   //print("kaungmyat san multi >>>  \(results)")
                   
                   if results.data.logoutFlag == true {
                       print("success stage logout")
                       // create the alert
                              let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)

                              // add an action (button)
                       alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                           self.logoutTimer?.invalidate()
                           let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                           navigationVC.modalPresentationStyle = .overFullScreen
                           self.present(navigationVC, animated: true, completion:nil)
                           
                       }))

                              // show the alert
                              self.present(alert, animated: true, completion: nil)
                       
                       
                   }
               }) { (error) in
                   print(error)
               }
           }
    @objc func onTapBack() {
       print("click")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onTapMMLocale() {
       print("click")
        super.NewupdateLocale(flag: 1)
        tvMemberShipNew.reloadData()
//        changeLocale()
    }
    @objc func onTapEngLocale() {
       print("click")
        super.NewupdateLocale(flag: 2)
        tvMemberShipNew.reloadData()
//        changeLocale()
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.doGetAgreementList()
    }
    
    
    func doGetAgreementList() {
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
               tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
        
        
        DAViewModel.init().getAgreementListsVM(tokenInfo: tokenInfo!, cusID: "\(sessionInfo?.customerId ?? 0)", success: { (infolist) in
            self.agreementNoList = infolist
            self.tvMemberShipNew.reloadData()
        }) { (error) in
            print("doGetAgreementlist error : \(error)")
        }
    }
    
    
    
    @objc func onClickImage(){
           profileImageDelegate!.onClickProfileImage()
       }

}

protocol ProfileImageNewClickDelegate {
    func onClickProfileImage()
}



extension MemberShipNewViewController : ProfileImageNewClickDelegate {
    func onClickProfileImage() {
//        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.PHOTO_UPLOAD_VIEW_CONTROLLER) as! UINavigationController
//        let vc = navigationVC.children.first as! PhotoUploadViewController
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.PHOTO_UPLOAD_VIEW_CONTROLLER) as! PhotoUploadViewController
        vc.isPhotoUpdate = true
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension MemberShipNewViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 2{
            return 1
        }
        return agreementNoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newMemberShipHeaderTableViewCell") as! newMemberShipHeaderTableViewCell
            var name = ""
            var customerNo = ""
            
            if sessionInfo?.customerNo != nil{
                name = (sessionInfo?.name)!
                customerNo = (sessionInfo?.customerNo)!
            }
//            cell.setData(name: name,customerNo: customerNo, memberNo: sessionInfo?.memberNo ?? "Member")
//
            cell.imgCamera.isUserInteractionEnabled = true
             self.profileImageDelegate = self

            cell.imgCamera.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickImage)))
            
            cell.setData(photoUrl: self.photoUrl,name: name,customerNo: customerNo, customerId: customerId,memberId: sessionInfo?.memberNo)
            
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "newMemberWarningTextTableViewCell") as! newMemberWarningTextTableViewCell
            
            cell.setData()
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMemberShipTableViewCell", for: indexPath) as! newMemberShipTableViewCell
        cell.delegate = self
//        cell.btnAgreementList.tag = indexPath.row
//        cell.btnQRcode.tag = indexPath.row
        cell.setData(data:self.agreementNoList[indexPath.row],index: indexPath.row)
        return cell
    }
    
}
extension MemberShipNewViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(267.0)
        }else if indexPath.section == 2{
            return CGFloat(70.0)
           
        }
//        var tableView = UITableView()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 160
        if agreementNoList[indexPath.row].qrShow == 2 {
            return CGFloat(165.0)
            
        }else{
             return CGFloat(70)
        }
    }
}

extension MemberShipNewViewController: MemberCardInfoCellDelegate {
    
    func alertQR() {
           let alert = UIAlertController(title: "No Product Information", message: "", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
              
                self.present(alert, animated: true, completion: nil)
       }
    
    func tappedOnQRcode(currentIndex: Int) {
        let agreement = self.agreementNoList[currentIndex]
        self.doGetQRProductInfo(appid: agreement.daApplicationInfoId ?? 0)
//        if agreement.daApplicationInfoId != 0 {
//
//        }
    }
    
    func tappedOnAgreementNumber(currentIndex: Int) {
        //
        let agreement = self.agreementNoList[currentIndex]
        let getlink = "http://aeoncredit.com.mm:8081/scd/dpsh?agrNo=\(agreement.agreementNo ?? "")" //1905-1-0000644710-7
        print("\(getlink)")
        //Goto URl link
        if let url = URL(string: getlink) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Invalid URL", message: "", preferredStyle: .alert) //
            let okAction = UIAlertAction(title: Constants.OK, style: .cancel, handler: { action in
                    
                alertController.dismiss(animated: true, completion: nil)
                    
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    func doGetQRProductInfo(appid: Int) {
            let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
                   tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
            
            DAViewModel.init().getQRCodeProductInfoVM(tokenInfo: tokenInfo!, appid: "\(appid)", success: { (infolist) in
    //            self.qrproductinfo = infolist
    //            self.purchaseid = self.qrproductinfo.daPurchaseInfoId ?? 0
    //            self.fillDataUI()
                if infolist.daPurchaseInfoId != 0 {
                        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.QR_PRODUCT_INFO_VC) as! ProductInfoVC
                        popupVC.modalPresentationStyle = .overCurrentContext
                        popupVC.modalTransitionStyle = .crossDissolve
                        popupVC.preferredContentSize = CGSize(width: 400, height: 300)
                        popupVC.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
                                //popupVC.ivMainView.alpha = 0.5
                        let pVC = popupVC.popoverPresentationController
                        pVC?.permittedArrowDirections = .any
                                
                                //pVC?.sourceView = sender
                        pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
                                
                        self.definesPresentationContext = true
                    //            popupVC.delegate = self
                    //            popupVC.titleString = "Enter Password"
                        popupVC.qrproductinfo = infolist
                        popupVC.purchaseid = infolist.daPurchaseInfoId ?? 0
                        popupVC.appinfoid = appid
                        self.present(popupVC, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "There is no purchase confirmation waiting.", message: "", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }) { (error) in
                print("doGetAgreementlist error : \(error)")
            }
        }

}
