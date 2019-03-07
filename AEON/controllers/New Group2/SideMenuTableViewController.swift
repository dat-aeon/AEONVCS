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

    var registerResponse:RegisterResponse?
    var loginResponse:LoginResponse?
    
    var menuItemList:[MenuItem] = []

    override func viewDidLoad() {
        let menuItem1 = MenuItem(image: "address-icon", name: "sidemenu.home")
        let menuItem2 = MenuItem(image: "user-icon", name: "sidemenu.membership")
        let menuItem3 = MenuItem(image: "update-icon", name: "sidemenu.infoupdate")
        let menuItem4 = MenuItem(image: "message-icon", name: "sidemenu.aeonservice")
        let menuItem5 = MenuItem(image: "events-icon", name: "sidemenu.eventsandnews")
        let menuItem6 = MenuItem(image: "phone-icon", name: "sidemenu.contactus")
        let menuItem7 = MenuItem(image: "help-primary-icon", name: "sidemenu.faq")
        let menuItem8 = MenuItem(image: "logout-icon", name: "sidemenu.logout")
        menuItemList.append(menuItem1)
        menuItemList.append(menuItem2)
        menuItemList.append(menuItem3)
        menuItemList.append(menuItem4)
        menuItemList.append(menuItem5)
        menuItemList.append(menuItem6)
        menuItemList.append(menuItem7)
        menuItemList.append(menuItem8)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.register(UINib(nibName: "SideMenuHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuHeaderTableViewCell")
        tableView.register(UINib(nibName: "SideMenuListTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuListTableViewCell")
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
       
        let registerResponseString = UserDefaults.standard.string(forKey: Constants.REGISTER_RESPONSE)
        
        registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: JSON(parseJSON: registerResponseString ?? "").rawData())
        
        let loginResponseString = UserDefaults.standard.string(forKey: Constants.LOGIN_RESPONSE)
        
        loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: JSON(parseJSON: loginResponseString ?? "").rawData())
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
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
//        if indexPath.row == 0 {
//            let cell = super.tableView(tableView, cellForRowAt: indexPath) as! SideMenuHeaderTableViewCell
//            cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
//            cell.selectionStyle = .none
//            return cell
//        }
//        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! SideMenuListTableViewCell
//        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
//        return cell
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuHeaderTableViewCell") as! SideMenuHeaderTableViewCell
            cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
            cell.selectionStyle = .none
            var photoUrl = ""
            var name = ""
            var customerNo = ""
            if let registerData = registerResponse{
                photoUrl = registerData.photoPath ?? ""
                name = registerData.name ?? ""
                customerNo = registerData.customerNo ?? ""
            }
            if let loginData = loginResponse{
                photoUrl = loginData.photoPath ?? ""
                name = loginData.name ?? ""
                customerNo = loginData.customerNo ?? ""
            }
            cell.setData(photoUrl: photoUrl,name: name,customerNo: customerNo)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuListTableViewCell") as! SideMenuListTableViewCell
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        cell.setData(data:self.menuItemList[indexPath.row-1])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click item at \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true, completion: nil)
        let position = indexPath.row
        let indexDataDict:[String: Int] = ["position": position]
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(NSNotification.init(name: NSNotification.Name("ChangeContainer"), object: nil, userInfo:indexDataDict) as Notification)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItemList.count+1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 230
        }
        return 45
    }
    
}

struct MenuItem {
    var image:String
    var name:String
}
