//
//  MemberCardInfoOneViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import SafariServices

class MemberCardInfoOneViewController: UIViewController {
    @IBOutlet weak var tvMemberCardInfo: UITableView!
    
    var sessionInfo:SessionDataBean?
    var tokenInfo: TokenData?
    
    var agreementNoList:[AgreementInfo] = []
    
    var cellHeight:[Int] = []
    
    
    override func viewDidLoad() {
//        print("Start MemberCardInfoOneViewController :::::::::::::::")
        super.viewDidLoad()
        let customerType = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE)
        if customerType == Constants.MEMBER {
            self.tvMemberCardInfo.register(UINib(nibName: CommonNames.MEMBER_CARD_HEADER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.MEMBER_CARD_HEADER_TABLE_CELL)
            self.tvMemberCardInfo.register(UINib(nibName: CommonNames.MEMBER_CARD_INFO_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.MEMBER_CARD_INFO_TABLE_CELL)
            self.tvMemberCardInfo.dataSource = self
            self.tvMemberCardInfo.delegate = self
            self.tvMemberCardInfo.tableFooterView = UIView()
            
            self.tvMemberCardInfo.backgroundView = UIImageView(image: UIImage.gif(asset: "AEON-gif"))
            
            let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
            sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
            
           
            
            if let agreementList = sessionInfo!.customerAgreementDtoList{
//                self.agreementNoList = agreementList
                
            }
//            print("MemberCardInfoOneViewController agreementList::::::\(self.agreementNoList.count)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         self.doGetAgreementList()
    }
    
    func doGetAgreementList() {
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
               tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
        
        
        DAViewModel.init().getAgreementListsVM(tokenInfo: tokenInfo!, cusID: "\(sessionInfo?.customerId ?? 0)", success: { (infolist) in
            self.agreementNoList = infolist
            self.tvMemberCardInfo.reloadData()
        }) { (error) in
            print("doGetAgreementlist error : \(error)")
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
extension MemberCardInfoOneViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return agreementNoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.MEMBER_CARD_HEADER_TABLE_CELL) as! MemberCardHeaderView
            var name = ""
            var customerNo = ""
            
            if sessionInfo?.customerNo != nil{
                name = (sessionInfo?.name)!
                customerNo = (sessionInfo?.customerNo)!
            }
            cell.setData(name: name,customerNo: customerNo, memberNo: sessionInfo?.memberNo ?? "Member")
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.MEMBER_CARD_INFO_TABLE_CELL, for: indexPath) as! MemberCardInfoTableViewCell
        cell.delegate = self
        cell.btnAgreementList.tag = indexPath.row
        cell.btnQRcode.tag = indexPath.row
        cell.setData(data:self.agreementNoList[indexPath.row])
        return cell
    }
    
}
extension MemberCardInfoOneViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(200.0)
        }
//        var tableView = UITableView()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 160
        if agreementNoList[indexPath.row].qrShow == 2 {
            return CGFloat(250.0)
            
        }
        return CGFloat(100.0)
    }
}

extension MemberCardInfoOneViewController: MemberCardInfoCellDelegate {
    func alertQR() {
        print("tap alertQR ckick")
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

}
