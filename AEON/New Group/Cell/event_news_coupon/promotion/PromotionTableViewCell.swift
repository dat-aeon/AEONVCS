//
//  PromotionTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 4/23/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class PromotionTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var imgPromoPhoto: UIImageView!
    @IBOutlet weak var lbreadMore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(promoBean: PromotionBean){
        
        switch Locale.currentLocale {
        case .MY:
            self.lbTitle.text = promoBean.titleMyn
            self.lbContent.text = promoBean.contentMyn
            break
            
        case .EN:
            self.lbTitle.text = promoBean.titleEng
            self.lbContent.text = promoBean.contentEng
            break
        }
//        self.lbDate.text = promoBean.displayDate
        if (promoBean.displayDate != nil) {
                   self.lbDate.text = self.changegoodnewsDateformat(date : promoBean.publishedFromDate ?? "2019-06-18T17:30:00.000+0000")
               }else{
            
            self.lbDate.text = "-"
            
        }
        self.lbreadMore.text = "eventnews.readmore.label".localized
        let photoUrl = URL(string:Constants.PROMOTION_PHOTO_URL + promoBean.imagePath!)
//        var image: UIImage!
//        if let data = try? Data( contentsOf: photoUrl!)
//        {
//            image = UIImage( data:data)
//
//        } else {
//            image = UIImage(named: "non-image")
//        }
//        self.imgPromoPhoto.image = image
//
        self.imgPromoPhoto.kf.setImage(with: photoUrl)
        
        let jpegData = self.imgPromoPhoto.image?.jpegData(compressionQuality: 1.0)
        let jpegSize: Int = jpegData?.count ?? 0
        print("Promotion size of jpeg image in KB: %f ", Double(jpegSize) / 1024.0)
        
        //self.imgPromoPhoto.kf.setImage(with: photoUrl)
//        if jpegSize == 0 {
//            //self.imgNews.image = UIImage(named: "loading-gear")
//            self.imgPromoPhoto.loadGif(asset: "loading-gear")
//        } else {
//            self.imgPromoPhoto.kf.setImage(with: photoUrl)
//        }
    }
    func changegoodnewsDateformat ( date: String) -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Foundation.Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 23400)
        let convertDate = formatter.date(from: date)
        
        formatter.dateFormat = "dd-MM-yyyy"
        let myString = formatter.string(from: convertDate!)
        
        return myString
    }
    
}
