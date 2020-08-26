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
    @IBOutlet weak var ivCameraCapture: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCustomerNo: UILabel!
    
    var profileImageDelegate : ProfileImageClickDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // add action to Photo
        self.ivProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickImage)))
        self.ivCameraCapture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickImage)))
        
        self.ivProfile.layer.cornerRadius = self.ivProfile.frame.height/2
        self.ivProfile.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(photoUrl:String,name:String,customerNo:String , customerId : Int){
        
        print("photo ::: \(photoUrl)")
        if photoUrl.isEmpty{
            let image:UIImage  = UIImage(named: "user-icon")!
            self.ivProfile.image = image
            self.ivCameraCapture.isHidden = true
            
        } else {
            let profileUrl = URL(string:Constants.PROFILE_PHOTO_URL + photoUrl)
            self.ivProfile.kf.indicatorType = .activity
            self.ivProfile.kf.setImage(with: profileUrl)
            
            if self.ivProfile == nil {
                self.ivProfile.image = UIImage(named: "user-icon")!
            }
            self.ivCameraCapture.isHidden = false
        }
        self.lblName.text = name
        self.lblCustomerNo.text = customerNo
    }
    
    @objc func onClickImage(){
        profileImageDelegate!.onClickProfileImage()
    }
}

protocol ProfileImageClickDelegate {
    func onClickProfileImage()
}
