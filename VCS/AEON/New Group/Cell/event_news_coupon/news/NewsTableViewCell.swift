//
//  NewsTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 4/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lbReadMore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgNews.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(newsInfoBean: NewsInfoBean){
        
        switch Locale.currentLocale {
        case .MY:
            self.lbTitle.text = newsInfoBean.titleMyn
            self.lbContent.text = newsInfoBean.contentMyn
            break
            
        case .EN:
            self.lbTitle.text = newsInfoBean.titleEng
            self.lbContent.text = newsInfoBean.contentEng
            break
        }
//        self.lbDate.text = newsInfoBean.displayDate
        print("DDate\(newsInfoBean.displayDate ?? "Hello")")
         if (newsInfoBean.displayDate != nil) {
                   self.lbDate.text = self.changegoodnewsDateformat(date : newsInfoBean.publishedFromDate ?? "2019-06-18T17:30:00.000+0000")
               }else{
            
            self.lbDate.text = "-"
            
        }
       
        
        self.lbReadMore.text = "eventnews.readmore.label".localized
        let photoUrl = URL(string:Constants.NEWS_PHOTO_URL + newsInfoBean.imagePath!)
        
//        var image: UIImage!
//        if let data = try? Data( contentsOf: photoUrl!)
//        {
//            image = UIImage( data:data)
//
//        } else {
//            image = UIImage(named: "non-image")
//        }
//        self.imgNews.image = image
        self.imgNews.kf.setImage(with: photoUrl)
        
        let jpegData = self.imgNews.image?.jpegData(compressionQuality: 1.0)
        let jpegSize: Int = jpegData?.count ?? 0
        print("News size of jpeg image ", jpegSize)
        print("News size of jpeg image in KB: %f ", Double(jpegSize) / 1024.0)
        
//        if jpegSize == 0 {
//            //self.imgNews.image = UIImage(named: "loading-gear")
//            self.imgNews.loadGif(asset: "loading-gear")
//        } else {
//            self.imgNews.kf.setImage(with: photoUrl)
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
