//
//  cellPurchaseList.swift
//  AEONVCS
//
//  Created by mac on 11/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class cellPurchaseList: UITableViewCell {
    
    @IBOutlet weak var cellLblTitle: UILabel!
    
    @IBOutlet weak var cellLblSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(purchasedetail: String, subtitle: String) {
        self.cellLblTitle.text = purchasedetail
        self.cellLblSubtitle.text = subtitle
    }

}
