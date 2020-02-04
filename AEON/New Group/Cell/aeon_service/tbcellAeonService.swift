//
//  tbcellAeonService.swift
//  AEONVCS
//
//  Created by mac on 10/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

protocol tbCellAeonServiceDelegate {
//    func didSelectfoto(image: UIImage)
    func clickonApplyLoan()
    func clickonApplicationInquiry()
}


class tbcellAeonService: UITableViewCell {
    
    @IBOutlet weak var cellImgAccessory: UIImageView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLblTitle: UILabel!
    @IBOutlet weak var cellLblSubtitle: UILabel!
    @IBOutlet weak var cellLblSubtitleTwo: UILabel!
    
    var delegate: tbCellAeonServiceDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data:MenuItem, index: Int){
        self.cellImage.image = UIImage(named: data.image)
        self.cellLblTitle.text = data.name.localized
        
        self.cellLblSubtitle.text = "aeonservice.da.form.menu".localized
        self.cellLblSubtitleTwo.text = "aeonservice.da.list.menu".localized
    }
    
    @IBAction func tappedOnApplyLoan(_ sender: Any) {
        self.delegate?.clickonApplyLoan()
    }
    
    @IBAction func tappedOnApplicationInquiry(_ sender: Any) {
        self.delegate?.clickonApplicationInquiry()
    }
    

}
