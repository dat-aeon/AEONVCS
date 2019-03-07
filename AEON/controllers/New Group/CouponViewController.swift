//
//  CuponViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
class CouponViewController: UIViewController {
    
    @IBOutlet weak var tvCoupon: UITableView!
    
    var registerResponse:RegisterResponse?
    var loginResponse:LoginResponse?
    var couponList = [CouponBean]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registerResponseString = UserDefaults.standard.string(forKey: Constants.REGISTER_RESPONSE)
        
        registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: JSON(parseJSON: registerResponseString ?? "").rawData())
        
        let loginResponseString = UserDefaults.standard.string(forKey: Constants.LOGIN_RESPONSE)
        
        loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: JSON(parseJSON: loginResponseString ?? "").rawData())
        
        var customerId = Constants.BLANK
        if let registerData = registerResponse{
            customerId = "\(registerData.customerId ?? 0)"
        }
        if let loginData = loginResponse{
            customerId = "\(loginData.customerId ?? 0)"
        }
        print("Coupon CustomerId:::::::\(customerId)")
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        CouponViewModel.init().getCouponRequest(siteActivationKey: Constants.SITE_ACTIVATION_KEY, customerId: customerId, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.couponList = result
            print("couponList ::::::: \(self.couponList.count)")
            self.tvCoupon.reloadData()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Coupon Failed", message: error)
        }
        
        self.tvCoupon.register(UINib(nibName: "CouponTableViewCell", bundle: nil), forCellReuseIdentifier: "CouponTableViewCell")
        
        self.tvCoupon.dataSource = self
        self.tvCoupon.delegate = self
        
        self.tvCoupon.estimatedRowHeight = CGFloat(200.0)
        self.tvCoupon.rowHeight = UITableView.automaticDimension
        self.tvCoupon.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        var customerId = Constants.BLANK
        if let registerData = registerResponse{
            customerId = "\(registerData.customerId ?? 0)"
        }
        if let loginData = loginResponse{
            customerId = "\(loginData.customerId ?? 0)"
        }
        print("View Appear Coupon CustomerId:::::::\(customerId)")
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        CouponViewModel.init().getCouponRequest(siteActivationKey: Constants.SITE_ACTIVATION_KEY, customerId: customerId, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.couponList = result
            print("couponList ::::::: \(self.couponList.count)")
            self.tvCoupon.reloadData()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Coupon Failed", message: error)
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell", for: indexPath) as! CouponTableViewCell
   
        cell.setData(couponBean:self.couponList[indexPath.row])
        //cell.lbSpecialEvent.isHidden = true
        //cell.imgUsedStamp.isHidden = true
        return cell
    }
    
    
}

extension CouponViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var couponBean: CouponBean = self.couponList[indexPath.row]
        let alertController = UIAlertController(title: "Input Password", message: nil, preferredStyle: .alert)
        alertController.addTextField { (tf) in
            tf.placeholder = "Enter coupon password"
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (okAction) in
            
            let password = alertController.textFields?[0]
            print("Coupon Password :::: \(password?.text ?? "error")")
            if password?.text == Constants.BLANK {
                return
            } else {
                print("Password wrong")
            }
                
            CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
            CouponViewModel.init().updateCoupon(customerId:couponBean.customerId, couponId:couponBean.couponId, shopId:couponBean.shopId, couponPassword: (password?.text)!, success: { (result) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                
                couponBean.isUsed = true
                self.couponList[indexPath.row] = couponBean
                print("ISUSED :::::: \(self.couponList[indexPath.row].isUsed)")
                self.tvCoupon.reloadData()

            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: "Coupon password Failed", message: error)
            }
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CouponViewController: UITextFieldDelegate {
    
}
