//
//  OutletListTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 7/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class OutletListTableViewCell: UITableViewCell {

    @IBOutlet weak var ivMarker: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var ivForwardDetail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setOutletData (outletInfo : OutletInfoBean) {
        if outletInfo.isAeonOutlet! {
            self.ivMarker.image = UIImage(named: "marker-aeon")
            
        } else {
            self.ivMarker.image = UIImage(named: "marker-mobile")
            if outletInfo.roleType == 1 {
                self.ivMarker.tintColor = UIColor.blue
                
            } else if outletInfo.roleType == 2 {
                self.ivMarker.tintColor = UIColor.yellow
                
            }else if outletInfo.roleType == 3 {
                self.ivMarker.tintColor = UIColor.red
                
            }else if outletInfo.roleType == 4 {
                self.ivMarker.tintColor = UIColor.green
                
            }else if outletInfo.roleType == 5 {
                self.ivMarker.tintColor = UIColor.orange
            }
        }
        self.lbName.text = outletInfo.outletName
        self.lbAddress.text = outletInfo.address
        let roundvalue = Int(round(100*outletInfo.distance!)/100)
        
        self.lbDistance.text = String(roundvalue) + "m"
        
    }
}
