//
//  SideMenuListTableViewCell.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SideMenu



class SideMenuListTableViewCell: UITableViewVibrantCell {

    @IBOutlet weak var ivMenuImage: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var lblMesgCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data:MenuItem, index: Int){
        self.ivMenuImage.image = UIImage(named: data.image)
        self.lblMenuName.text = data.name.localized
        
        if index == 8 {
//            let unreadArray = UserDefaults.standard.array(forKey: Constants.UNREAD_MESSAGE_ARRAY)  as? [Int] ?? [Int]()
//            if unreadArray.count > 0 {
            let count = UserDefaults.standard.integer(forKey: Constants.UNREAD_MESSAGE_COUNT) 
            if count > 0 {
                self.lblMesgCount.isHidden = false
                self.lblMesgCount.text = "\(count)"
                
            } else {
                self.lblMesgCount.isHidden = true
            }
        } else {
            self.lblMesgCount.isHidden = true
        }
       
        if index == 10 {
            let count = UserDefaults.standard.integer(forKey: Constants.AT_UNREAD_MESSAGE_COUNT)
            if count > 0 {
                self.lblMesgCount.isHidden = false
                self.lblMesgCount.text = "\(count)"
            } else {
                self.lblMesgCount.isHidden = true
            }
        } else {
            self.lblMesgCount.isHidden = true
        }
        self.layoutIfNeeded()
    }
}
