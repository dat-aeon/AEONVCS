//
//  newMemberShipHeaderTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 2/7/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit



class newMemberShipHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cameraView: CardView!
    var sessionInfo : SessionDataBean?

    @IBOutlet weak var lblCustomerId: UILabel!
    @IBOutlet weak var imgCamera: UIImageView!
    @IBOutlet weak var lblMemberId: UILabel!
    @IBOutlet weak var ivProfileImage: UIImageView!
    
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        
    }
    
//    func setData(name:String,customerNo:String , memberNo:String){
//
//        self.lblMemberId.text = memberNo
//
//        }
    
    func setData(photoUrl:String,name:String,customerNo:String , customerId : Int, memberId : String?){
        
      
        
        print("photo ::: \(photoUrl)")
        if photoUrl.isEmpty{
            let image:UIImage  = UIImage(named: "user-icon")!
            self.ivProfileImage.image = image
            self.imgCamera.isHidden = true
            
        } else {
            let profileUrl = URL(string:Constants.PROFILE_PHOTO_URL + photoUrl)
            self.ivProfileImage.kf.indicatorType = .activity
            self.ivProfileImage.kf.setImage(with: profileUrl)
            
            if self.ivProfileImage == nil {
                self.ivProfileImage.image = UIImage(named: "user-icon")!
            }
            self.imgCamera.isHidden = false
        }
//        self.lblName.text = name
//        self.lblMemberId.text = "\(customerId)"
        
         self.lblMemberId.text = memberId
        self.lblCustomerId.text = "\(customerNo)"
      //  self.lbReadMore.text = "eventnews.readmore.label".localized
    }
    

    
    
}
