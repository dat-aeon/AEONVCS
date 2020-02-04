//
//  CuponViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
class CouponViewController: BaseUIViewController {
    
    @IBOutlet weak var tvCoupon: UITableView!
    
    var sessionInfo:SessionDataBean?
    var couponList = [CouponBean]()
    var selectedRow = 0
    var selectedCouponBean:CouponBean?
    var tokenInfo : TokenData?
    var usedCouponList : [CouponBean]?
    var isDidLoad = false
    var isInsert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadCouponList()
        
        self.tvCoupon.register(UINib(nibName: CommonNames.COUPON_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.COUPON_TABLE_CELL)
        
        self.tvCoupon.dataSource = self
        self.tvCoupon.delegate = self
        
        self.tvCoupon.estimatedRowHeight = CGFloat(200.0)
        self.tvCoupon.rowHeight = UITableView.automaticDimension
        self.tvCoupon.tableFooterView = UIView()
        self.isDidLoad = true
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.tvCoupon.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isDidLoad {
            self.isDidLoad = false
        } else {
           self.reloadCouponList()
        }
        
    }
    
    func reloadCouponList() {
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
        var customerId = Constants.BLANK
        if let sessionData = sessionInfo{
            customerId = "\(sessionData.customerId ?? 0)"
        }
        
        if customerId == Constants.BLANK {
            customerId = UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0"
        }
//        print("Coupon CustomerId:::::::\(customerId)")
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        CouponViewModel.init().getCouponRequest(token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, customerId: customerId, success: { (result) in
            
            let usedCouponString = UserDefaults.standard.string(forKey: Constants.USED_COUPON_LIST)
            self.usedCouponList = try? JSONDecoder().decode([CouponBean].self, from: JSON(parseJSON: usedCouponString ?? "").rawData())
            
            if self.usedCouponList == nil {
                self.couponList = result
                
            } else {
                self.couponList = self.updateCouponList(newList: result, usedList: self.usedCouponList!)
            }
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
//            print("couponList ::::::: \(self.couponList.count)")
            self.tvCoupon.reloadData()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                 navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else if error == Constants.EXPIRE_TOKEN {
                Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON " + Messages.EXPIRE_TOKEN_ERROR.localized)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON" + error)
            }
            
        }
    }
    
    func updateCouponList (newList: [CouponBean], usedList: [CouponBean]) -> [CouponBean]{
        
        var newCouponList = newList
        
        for used in usedList {
            var index = 0
            
            //if newList size is 0, only append the used list.
            if newList.count == 0 {
                newCouponList.append(used)
                
            } else {
                var isInsert = false
                for new in newList {
                    if new.startTime < used.startTime {
                        newCouponList.insert(used, at: index)
                        isInsert = true
                        break
                    }
                    index += 1
                }
                if !isInsert {
                    newCouponList.append(used)
                }
            }
        }
        
        return newCouponList
    }
}

extension CouponViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.couponList.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.COUPON_TABLE_CELL, for: indexPath) as! CouponTableViewCell
        
        cell.setData(couponBean:self.couponList[indexPath.row])
        //cell.lbSpecialEvent.isHidden = true
        //cell.imgUsedStamp.isHidden = true
        return cell
    }
    
}

extension CouponViewController:UITableViewDelegate, UIPopoverControllerDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedCouponBean = self.couponList[indexPath.row]
        self.selectedRow = indexPath.row
        
        //let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.COUPON_POPUP_VIEW_CONTROLLER) as! CouponPopupViewController
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
        popupVC.delegate = self
        super.present(popupVC, animated: true, completion: nil)
        
        //self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGFloat(260.0)
        }
        
        return CGFloat(180.0)
    }
}

extension CouponViewController: PopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController) {
        if password.text == Constants.BLANK {
            password.showError(message: Messages.PASSWORD_EMPTY_ERROR.localized)
            return
        }
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        CouponViewModel.init().updateCoupon(customerId:self.selectedCouponBean!.customerId, couponId:self.selectedCouponBean!.couponId, couponPassword: (password.text)!,tokenInfo: tokenInfo!, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if result == Constants.INCORRECT_PWD {
                password.text = Constants.BLANK
                password.showError(message: Messages.PASSWORD_WRONG_ERROR.localized)
                return
                
            } else if result == Constants.COUPON_REDEEM {
                password.text = Constants.BLANK
                password.showError(message: Messages.COUPON_REDEEM_ERROR.localized)
                return
            }
            
            self.selectedCouponBean!.isUsed = true
            self.couponList[self.selectedRow] = self.selectedCouponBean!
//            print("ISUSED :::::: \(self.couponList[self.selectedRow].isUsed)")
            
            // update used coupon list of Userdefaults
            let usedCouponString = UserDefaults.standard.string(forKey: Constants.USED_COUPON_LIST)
            var usedCouponList = try? JSONDecoder().decode([CouponBean].self, from: JSON(parseJSON: usedCouponString ?? "").rawData())
            
            if usedCouponList == nil {
                usedCouponList = [CouponBean]()
            }
            usedCouponList?.append(self.selectedCouponBean!)
//            print("used array size", usedCouponList?.count ?? 0)
            let usedCouponJson = try? JSONEncoder().encode(usedCouponList)
            let usedString = String(data: usedCouponJson!, encoding: .utf8)!
            UserDefaults.standard.set(usedString, forKey: Constants.USED_COUPON_LIST)
            
            self.tvCoupon.reloadData()
            popUpView.dismiss(animated: true, completion: nil)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                 navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else if error == Constants.EXPIRE_TOKEN {
                Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON " + Messages.EXPIRE_TOKEN_ERROR.localized)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.SERVER_ERROR_TITLE, message: error)
            }
            
        }
    }
}
