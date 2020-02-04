//
//  SideMenuTableViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SideMenu
import SwiftyJSON

class SideMenuTableViewController: UITableViewController {

    var sessionInfo : SessionDataBean?
    
    var menuItemList:[MenuItem] = []
    
    var cellExpanded = false

    override func viewDidLoad() {
        let menuItem1 = MenuItem(image: "address-icon", name: "sidemenu.home")
        let menuItem2 = MenuItem(image: "user-icon", name: "sidemenu.membership")
        let menuItem3 = MenuItem(image: "update-icon", name: "sidemenu.infoupdate")
        let menuItem4 = MenuItem(image: "message-icon", name: "sidemenu.aeonservice")
        let menuItem5 = MenuItem(image: "events-icon", name: "sidemenu.eventsandnews")
        let menuItem6 = MenuItem(image: "phone-icon", name: "sidemenu.contactus")
        let menuItem7 = MenuItem(image: "help-primary-icon", name: "sidemenu.faq")
        let menuItem8 = MenuItem(image: "marker-menu", name: "sidemenu.nearby")
        let menuItem9 = MenuItem(image: "logout-icon", name: "sidemenu.logout")
        let menuItem10 = MenuItem(image: "calculator-icon", name: "sidemenu.loan")
        let menuItem11 = MenuItem(image: "shopping-icon", name: "sidemenu.agentchannel")
        
        menuItemList.append(menuItem1)
        menuItemList.append(menuItem2)
        menuItemList.append(menuItem3)
        menuItemList.append(menuItem4)
        menuItemList.append(menuItem10)
        menuItemList.append(menuItem5)
        
        
        menuItemList.append(menuItem8)
        menuItemList.append(menuItem6)
        menuItemList.append(menuItem7)
        menuItemList.append(menuItem11)
        menuItemList.append(menuItem9)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.register(UINib(nibName: CommonNames.SIDE_MENU_HEADER_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SIDE_MENU_HEADER_TABLE_CELL)
        tableView.register(UINib(nibName: CommonNames.SIDE_MENU_LIST_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.SIDE_MENU_LIST_TABLE_CELL)
        tableView.register(UINib(nibName: CommonNames.AEON_SERVICE_TABLE_CELL_XIB, bundle: nil), forCellReuseIdentifier: CommonNames.AEON_SERVICE_TABLE_CELL)
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0);
       
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "dismissKeyboard"), object: self, userInfo: nil)
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SIDE_MENU_HEADER_TABLE_CELL) as! SideMenuHeaderTableViewCell
            cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
            cell.selectionStyle = .none
            var photoUrl = ""
            var name = ""
            var customerNo = ""
            var customerId = 0
            if let sessionData = sessionInfo{
                photoUrl = sessionData.photoPath ?? ""
                name = sessionData.name ?? ""
                customerNo = sessionData.customerNo ?? ""
                customerId = sessionData.customerId!
                
                if customerNo != Constants.BLANK {
                    cell.profileImageDelegate = self
                    cell.ivProfile.isUserInteractionEnabled = true
                    cell.ivCameraCapture.isUserInteractionEnabled = true
                    
                } else {
                    cell.ivProfile.isUserInteractionEnabled = false
                    cell.ivCameraCapture.isUserInteractionEnabled = false
                }
            }
            
            cell.setData(photoUrl: photoUrl,name: name,customerNo: customerNo, customerId: customerId)
            
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.AEON_SERVICE_TABLE_CELL) as! tbcellAeonService

            cell.selectionStyle = .none
            cell.delegate = self
            cell.setData(data:self.menuItemList[indexPath.row-1], index: indexPath.row)
                       
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.SIDE_MENU_LIST_TABLE_CELL) as! SideMenuListTableViewCell
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        cell.setData(data:self.menuItemList[indexPath.row-1], index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("click item at \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 4 {
            if cellExpanded {
                cellExpanded = false
                
                let cell = tableView.cellForRow(at: indexPath) as! tbcellAeonService
                cell.cellImgAccessory.image = UIImage(named: "expand")
            } else {
                cellExpanded = true
                
                let cell = tableView.cellForRow(at: indexPath) as! tbcellAeonService
                cell.cellImgAccessory.image = UIImage(named: "collapse")
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        } else {
        
            self.dismiss(animated: true, completion: nil)
            let position = indexPath.row
            let indexDataDict:[String: Int] = ["position": position]
            
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(NSNotification.init(name: NSNotification.Name("ChangeContainer"), object: nil, userInfo:indexDataDict) as Notification)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItemList.count+1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
             if UIDevice().screenType == .iPhone5 {
                return 165
            }
            return 230
        }
        
        if indexPath.row == 4 {
            
            if cellExpanded {
                return 133
            } else {
                return 45
            }
        }
        return 45
    }
    
}

extension SideMenuTableViewController : ProfileImageClickDelegate {
    func onClickProfileImage() {
        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.PHOTO_UPLOAD_VIEW_CONTROLLER) as! UINavigationController
        let vc = navigationVC.children.first as! PhotoUploadViewController
        vc.isPhotoUpdate = true
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
        
    }
}

extension SideMenuTableViewController : tbCellAeonServiceDelegate {
    func clickonApplyLoan() {
        
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLY_LOAN_NAV) as! UINavigationController
        _ = applyLoanNav.children.first as! ApplyLoanVC
        applyLoanNav.modalPresentationStyle = .overFullScreen
        let currVC = self.presentingViewController
        self.dismiss(animated: true, completion: {
            currVC?.present(applyLoanNav,  animated: false, completion: nil)
        })
        
    }
    
    func clickonApplicationInquiry() {
        
        let storyboard = UIStoryboard(name: "DA", bundle: nil)
        let applyLoanNav = storyboard.instantiateViewController(withIdentifier: CommonNames.INQUIRY_LOAN_NAV) as! UINavigationController
        _ = applyLoanNav.children.first as! ApplicationListVC
        applyLoanNav.modalPresentationStyle = .overFullScreen
        let currVC = self.presentingViewController
        self.dismiss(animated: true, completion: {
            currVC?.present(applyLoanNav,  animated: false, completion: nil)
        })
        
    }
    
    
}

struct MenuItem {
    var image:String
    var name:String
}
