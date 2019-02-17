//
//  MemberCardHeaderView.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import Kingfisher

class MemberCardHeaderView: UITableViewCell {

    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCustomerNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(photoUrl:String,name:String,customerNo:String){
        let profileUrl = URL(string:Constants.photo_base_url+photoUrl)
        self.ivProfile.kf.setImage(with: profileUrl)
        self.lblName.text = name
        self.lblCustomerNo.text = customerNo
    }
}
