//
//  EventNewForPh1ViewController.swift
//  AEONVCS
//
//  Created by mac on 4/7/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventNewForPh1ViewController: BaseUIViewController {
    
    @IBOutlet weak var tvCouponView: UITableView!
    
    var sessionData: SessionDataBean?
    var couponList = [CouponBean]()
    
    var selectedRow = 0
    var selectedCouponBean:CouponBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sessionDataString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        
        sessionData = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionDataString ?? "").rawData())
        
        
        var customerId = Constants.BLANK
        if let sessionBean = sessionData{
            customerId = "\(sessionBean.customerId ?? 0)"
            
        }
        if customerId == Constants.BLANK {
            customerId = UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0"
        }
//        print("Coupon CustomerId:::::::\(customerId)")
        
//        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
//        CouponViewModel.init().getCouponRequest(siteActivationKey: Constants.site_activation_key, customerId: customerId, success: { (result) in
//            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            self.couponList = result
//            print("couponList ::::::: \(self.couponList.count)")
//            self.tvCouponView.reloadData()
//
//        }) { (error) in
//            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//
//            if error == Constants.SERVER_FAILURE {
//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
//                self.present(navigationVC, animated: true, completion: nil)
//
//            } else {
//                Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON" + error)
//            }
//
//        }
        
        self.tvCouponView.register(UINib(nibName: CommonNames.COUPON_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.COUPON_TABLE_CELL)
        
        self.tvCouponView.dataSource = self
        self.tvCouponView.delegate = self
        
        self.tvCouponView.estimatedRowHeight = CGFloat(200.0)
        self.tvCouponView.rowHeight = UITableView.automaticDimension
        self.tvCouponView.tableFooterView = UIView()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.tvCouponView.reloadData()
        
    }
    
}

extension EventNewForPh1ViewController:UITableViewDataSource{
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

extension EventNewForPh1ViewController:UITableViewDelegate, UIPopoverControllerDelegate {
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
        self.present(popupVC, animated: true, completion: nil)
        
        //self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGFloat(260.0)
        }
        
        return CGFloat(180.0)
    }
}

extension EventNewForPh1ViewController: PopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController) {
        if password.text == Constants.BLANK {
            password.showError(message: Messages.PASSWORD_EMPTY_ERROR.localized)
            return
        }
        
//        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
//        CouponViewModel.init().updateCoupon(customerId:self.selectedCouponBean!.customerId, couponId:self.selectedCouponBean!.couponId, couponPassword: (password.text)!, success: { (result) in
//            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//
//            if result.statusMessage == Constants.INCORRECT_PWD {
//                password.text = Constants.BLANK
//                password.showError(message: Messages.PASSWORD_NOT_MATCH_ERROR)
//                return
//
//            } else if result.statusMessage == Constants.COUPON_REDEEM {
//                password.text = Constants.BLANK
//                password.showError(message: Messages.COUPON_REDEEM_ERROR)
//                return
//            }
//
//            self.selectedCouponBean!.isUsed = true
//            self.couponList[self.selectedRow] = self.selectedCouponBean!
//            print("ISUSED :::::: \(self.couponList[self.selectedRow].isUsed)")
//            self.tvCouponView.reloadData()
//            popUpView.dismiss(animated: true, completion: nil)
//
//        }) { (error) in
//            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            if error == Constants.SERVER_FAILURE {
//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
//                self.present(navigationVC, animated: true, completion: nil)
//
//            } else {
//                Utils.showAlert(viewcontroller: self, title: Constants.SERVER_ERROR_TITLE, message: error)
//            }
//
//        }
    }
}
