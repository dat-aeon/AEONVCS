//
//  PromotionViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class PromotionViewController: BaseUIViewController {

    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarCusType: UILabel!
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    
    @IBOutlet weak var tvPromotion: UITableView!
    
    var promoList = [PromotionBean]()
    var selectedRow = 0
    var selectedPromoBean:PromotionBean?
    var tokenInfo: TokenData?
    var isDidLoad = false
    var logoutTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        self.reloadPromotionList()
        
        self.tvPromotion.register(UINib(nibName: CommonNames.PROMOTION_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.PROMOTION_TABLE_CELL)
        self.tvPromotion.dataSource = self
        self.tvPromotion.delegate = self
        self.tvPromotion.tableFooterView = UIView()
        
        if (UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME) == nil) {
                   self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
                   self.lblBarName.text = ""
                   self.lblBarCusType.text = "Lv.1 : Application user"
               }else{
                   self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
                              self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
                    self.lblBarCusType.text = "Lv.2 : Login user"
               }
        if lblBarCusType.text == "Lv.2 : Login user" {
                      
                 logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
                   }
        
        self.isDidLoad = true
        
    
    }
   
    @objc func runTimedCode() {
                multiLoginGet()
            // print("kms\(logoutTimer)")
            }
    func multiLoginGet(){
               let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
            var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
           MultiLoginModel.init().makeMultiLogin(customerId: customerId
                   , loginDeviceId: deviceID, success: { (results) in
                  // print("kaungmyat san multi >>>  \(results)")
                   
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
        updateViews()
    }
    @objc func onTapEngLocale() {
       print("click")
        super.NewupdateLocale(flag: 2)
        updateViews()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.tvPromotion.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isDidLoad {
            isDidLoad = false
        } else {
            self.reloadPromotionList()
        }
    }
    
    func reloadPromotionList(){
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
//        PromotionViewModel.init().getPromoRequest(tokenInfo: tokenInfo!,  success: { (result) in
         PromotionViewModel.init().getNewPromoRequest(success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.promoList = result
//            print("promo list ::::::: \(self.promoList.count)")
            self.tvPromotion.reloadData()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                 navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else if error == Constants.EXPIRE_TOKEN {
                Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON " + Messages.EXPIRE_TOKEN_ERROR.localized)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "Promotion " + error)
            }
            
        }
        
    }
}

extension PromotionViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.promoList.count
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.PROMOTION_TABLE_CELL, for: indexPath) as! PromotionTableViewCell
        
//        let bgColorView = UIView()
//        bgColorView.backgroundColor = .blue
//        cell.selectedBackgroundView = bgColorView
        cell.selectionStyle = .none
        cell.setData(promoBean: self.promoList[indexPath.row])
        
        return cell
    }
    
}

extension PromotionViewController:UITableViewDelegate, UIPopoverControllerDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        
        self.selectedPromoBean = self.promoList[indexPath.row]
        self.selectedRow = indexPath.row
        
        //let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PROMOTION_POPUP_VIEW_CONTROLLER) as! PromotionPopupViewController
        popupVC.modalPresentationStyle = .fullScreen
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.promoBean = self.selectedPromoBean!
        
        let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        
        //pVC?.sourceView = sender
        //pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
        
        self.definesPresentationContext = true
        //popupVC.delegate = self
        self.present(popupVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGFloat(300.0)
        }
        
       let beanObj = self.promoList[indexPath.row]
         var titlestr = ""
         switch Locale.currentLocale {
                case .MY:
                 titlestr = beanObj.titleMyn!
                    break
                    
                case .EN:
                 titlestr = beanObj.titleEng!
                    break
                }
         
         let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.tvPromotion.frame.size.width - 20, height: 0))
         lbl.font = UIFont(name: "PyidaungsuBook-Bold", size: 24)
        lbl.numberOfLines = 0
         lbl.text = titlestr
        let calculateHeight = lbl.requiredHeightForNewsEventsTitle
         let totalHeight = 210 + calculateHeight
         return totalHeight
    }
}

