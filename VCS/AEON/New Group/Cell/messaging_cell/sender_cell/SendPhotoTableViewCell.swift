//
//  ReceiverPhotoTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 5/7/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import Kingfisher

class SendPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var vMainView: UIView!
    @IBOutlet weak var lbSendDate: UILabel!
    @IBOutlet weak var imgContent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(messageBean: MessageBean){
        self.lbSendDate.text = messageBean.sendTime
        let photoUrl = URL(string:messageBean.message ?? "")
        //print("photo path", photoUrl?.absoluteString as Any)
        self.imgContent.kf.indicatorType = .activity
        self.imgContent.kf.setImage(with: photoUrl)
        
        //let jpegData = self.imgContent.image?.jpegData(compressionQuality: 1.0)
        //let jpegSize: Int = jpegData?.count ?? 0
        //print("Messaging size of jpeg image in KB: %f ", Double(jpegSize) / 1024.0)
        
    }
}

extension UIImageView {
    func test() {
        var kf = self.kf
        kf.indicatorType = .activity
    }
}
