//
//  SideMenuHeaderTableViewCell.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuHeaderTableViewCell: UITableViewVibrantCell {

    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCustomerNo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(photoUrl:String,name:String,customerNo:String){
        let profileUrl = URL(string:Constants.photo_base_url+photoUrl)
        self.ivProfile.kf.setImage(with: profileUrl)
        self.lblName.text = name
        self.lblCustomerNo.text = customerNo
    }
    
}
