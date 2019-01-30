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
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.reloadData()
        
        self.tableView.contentInsetAdjustmentBehavior = .never
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
            //        case 0:
            //            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! UINavigationController
            //            self.present(navigationVC, animated: true, completion: nil)
        //            break
        case 1:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "MemberCardInfoViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            break
        case 2:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "CustomerInfoUpdateViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            break
        case 3:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "ApplyAeonServiceViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            break
        case 4:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "EventNewViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            break
        case 5:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "ContactUsViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            break
        case 6:
            //let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "FAQViewController") as! UINavigationController
            //self.present(navigationVC, animated: true, completion: nil)
            break
        case 7:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
