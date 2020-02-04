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

    @IBOutlet weak var tvPromotion: UITableView!
    
    var promoList = [PromotionBean]()
    var selectedRow = 0
    var selectedPromoBean:PromotionBean?
    var tokenInfo: TokenData?
    var isDidLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadPromotionList()
        
        self.tvPromotion.register(UINib(nibName: CommonNames.PROMOTION_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.PROMOTION_TABLE_CELL)
        self.tvPromotion.dataSource = self
        self.tvPromotion.delegate = self
        self.tvPromotion.tableFooterView = UIView()
        
        self.isDidLoad = true
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
        PromotionViewModel.init().getPromoRequest(tokenInfo: tokenInfo!,  success: { (result) in
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
//        
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
        popupVC.modalPresentationStyle = .overCurrentContext
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
         lbl.text = titlestr
        let calculateHeight = lbl.requiredHeightForNewsEventsTitle
         let totalHeight = 210 + calculateHeight
         return totalHeight
    }
}

