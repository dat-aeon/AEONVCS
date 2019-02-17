//
//  SideMenuListTableViewCell.swift
//  AEONVCS
//
//  Created by AcePlus101 on 2/17/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuListTableViewCell: UITableViewVibrantCell {

    @IBOutlet weak var ivMenuImage: UIImageView!
    
    @IBOutlet weak var lblMenuName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:MenuItem){
        self.ivMenuImage.image = UIImage(named: data.image)
        self.lblMenuName.text = data.name
    }
    
}
