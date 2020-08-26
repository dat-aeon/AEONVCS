//
//  MemberCardHeaderView.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftGifOrigin

class MemberCardHeaderView: UITableViewCell {

    @IBOutlet weak var ivBackgroundGif: UIImageView!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCustomerNo: UILabel!
    @IBOutlet weak var lbMemberNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        //self.ivProfile.loadGif(name: "background-gif")
    }
    
    func setData(name:String,customerNo:String , memberNo:String){
        self.lblName.text = name
        self.lblCustomerNo.text = customerNo
        self.lbMemberNo.text = Constants.BLANK
        //self.ivBackgroundGif.loadGif(asset: "Aeon-Animate-1")
        //self.ivBackgroundGif.loadGif(asset: "AEON-gif")
        
//        let imageData = try! Data(contentsOf: Bundle.main.url(forResource: "background-gif", withExtension: "gif")!)
//        let gifImage = UIImage.gif(data: imageData)
//        self.ivProfile.image = gifImage
        
        //self.ivProfile.loadGif(name: "background-gif")
        
        //self.ivProfile.loadGif(name: "background-gif")
        
        //let gifImg = UIImage.gifImageWithName("background-gif")
        //self.ivProfile = UIImageView(image: gifImg)
        //self.ivProfile.image = UIImage.gifImageWithName("background-gif")
    }
}
