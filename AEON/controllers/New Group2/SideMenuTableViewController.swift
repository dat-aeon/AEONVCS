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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        self.tableView.contentInsetAdjustmentBehavior = .never
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }
        
        // Set up a cool background image for demo purposes
        //        let imageView = UIImageView(image: UIImage(named: "background"))
        //        imageView.contentMode = .scaleAspectFit
        //        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        //        tableView.backgroundView = imageView
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
        let position = indexPath.row
        if indexPath.row == 0 {
            self.dismiss(animated: true, completion: nil)
            
        }else if indexPath.row == 7{
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "MainViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            
        }else{
        let indexDataDict:[String: Int] = ["position": position]

        NotificationCenter.default.post(NSNotification.init(name: NSNotification.Name("ChangeContainer"), object: nil, userInfo:indexDataDict) as Notification)
        self.dismiss(animated: true, completion: nil)
        }
    }
    
}
