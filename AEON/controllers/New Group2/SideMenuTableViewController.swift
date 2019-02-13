//
//  SideMenuTableViewController.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {
    override func viewDidLoad() {
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0);
        
        
        // Set up a cool background image for demo purposes
        //        let imageView = UIImageView(image: UIImage(named: "background"))
        //        imageView.contentMode = .scaleAspectFit
        //        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        //        tableView.backgroundView = imageView
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
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        if indexPath.row == 0 {
            cell.selectionStyle = .none
        }
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
    
}
