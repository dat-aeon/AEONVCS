//
//  CouponTableViewCell.swift
//  AEON
//
//  Created by AcePlus101 on 2/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import Kingfisher

class CouponTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivCouponCell: UIView!
    @IBOutlet weak var lbCouponName: UILabel!
    @IBOutlet weak var lbDateLabel: UILabel!
    @IBOutlet weak var lbExpireDate: UILabel!
    @IBOutlet weak var lbGoodPrice: UILabel!
    @IBOutlet weak var lbGoodPriceUnit: UILabel!
    @IBOutlet weak var lbCouponAmount: UILabel!
    @IBOutlet weak var lbDiscountUnit: UILabel!
    @IBOutlet weak var lbSpecialEvent: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var imgUsedStamp: UIImageView!
    @IBOutlet weak var imgCouponLogo: UIImageView!
    
    var couponCodeList: [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if UIScreen.main.bounds.width == 320.0 {
            self.lbCouponName.font = UIFont.boldSystemFont(ofSize: 15)
            self.lbGoodPrice.font = UIFont.boldSystemFont(ofSize: 25)
            self.lbGoodPriceUnit.font = UIFont.boldSystemFont(ofSize: 14)
            self.lbCouponAmount.font = UIFont.boldSystemFont(ofSize: 55)
            
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.lbCouponName.font = UIFont.boldSystemFont(ofSize: 25)
            self.lbGoodPrice.font = UIFont.boldSystemFont(ofSize: 40)
            self.lbGoodPriceUnit.font = UIFont.boldSystemFont(ofSize: 25)
            self.lbCouponAmount.font = UIFont.boldSystemFont(ofSize: 110)
            self.lbDiscountUnit.font = UIFont.boldSystemFont(ofSize: 28)
            self.lbExpireDate.font = UIFont.boldSystemFont(ofSize: 20)
            self.lbDateLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.lbSpecialEvent.font = UIFont.boldSystemFont(ofSize: 20)
            self.lbDescription.font =  UIFont.boldSystemFont(ofSize: 20)
            
        }
        self.layoutIfNeeded()
    }
    
    func setData(couponBean: CouponBean){
        
        switch Locale.currentLocale {
        case .MY:
            self.lbCouponName.text = couponBean.couponNameMM
            self.lbSpecialEvent.text = couponBean.specialEventMM
            self.lbDescription.text = couponBean.descriptionMM
            break
        case .EN:
            self.lbCouponName.text = couponBean.couponNameEN
            self.lbSpecialEvent.text = couponBean.specialEventEN
            self.lbDescription.text = couponBean.descriptionEN
            break
        }
        self.lbExpireDate.text = couponBean.expiredTime
        self.lbGoodPrice.text = couponBean.goodsPrice
        self.lbGoodPriceUnit.text = couponBean.discountUnit
        self.lbCouponAmount.text = couponBean.couponAmount
        self.lbDiscountUnit.text = couponBean.discountUnit
        
        self.couponCodeList?.append(couponBean.couponCode)
        
        let photoUrl = URL(string:Constants.COUPON_PHOTO_URL + couponBean.unuseImagePath)
        //print("photo URL \(photoUrl)")
        var image : UIImage!
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            DispatchQueue.main.async {
                
                if !couponBean.unuseImagePath.isEmpty {
                    // resize image
                    if let data = try? Data( contentsOf: photoUrl!)
                    {
                        image = UIImage( data:data)
                        
                    } else {
                        image = UIImage(named: "non-image")
                    }
                    let resizeImage = self.ResizeImage(image: image!, targetSize: CGSize(width: 200, height: 200))
                    self.imgCouponLogo.image = resizeImage
                    self.imgCouponLogo.frame = CGRect(x: 18, y: 0, width: 200, height: 200)
                    self.imgCouponLogo.center.y = self.ivCouponCell.center.y
                    //print("resize image.", self.imgCouponLogo.frame.width)
                }
                var couponName = self.lbCouponName.frame
                //print("coupon frame :\(couponName.origin.x) +\(couponName.origin.y)")
                couponName.origin.y = 35
                couponName.origin.x = self.imgCouponLogo.frame.width + 30.0
                self.lbCouponName.frame = couponName
                
                var endDate = self.lbDateLabel.frame
                //print("label date frame :\(endDate.origin.x) +\(endDate.origin.y)")
                endDate.origin.x = self.ivCouponCell.frame.width - endDate.width - 40.0
                endDate.origin.y = 70.0
                self.lbDateLabel.frame = endDate
                
                var expireDate = self.lbExpireDate.frame
                //print("date frame :\(expireDate.origin.x) +\(expireDate.origin.y)")
                expireDate.origin.x = self.ivCouponCell.frame.width - expireDate.width - 40.0
                expireDate.origin.y = endDate.origin.y + 25.0
                self.lbExpireDate.frame = expireDate
                
                var goodPrice = self.lbGoodPrice.frame
                //print("Price frame :\(goodPrice.origin.x) +\(goodPrice.origin.y) + \(goodPrice.width)")
                goodPrice.origin.x = self.imgCouponLogo.frame.width + 30.0
                goodPrice.origin.y = 75.0
                self.lbGoodPrice.frame = goodPrice
                
                var goodPriceUnit = self.lbGoodPriceUnit.frame
                //print("Price Unit frame :\(goodPriceUnit.origin.x) +\(goodPriceUnit.origin.y)")
                goodPriceUnit.origin.x = goodPrice.origin.x + goodPrice.width + 5.0
                goodPriceUnit.origin.y = goodPrice.origin.y + 10.0
                self.lbGoodPriceUnit.frame = goodPriceUnit
                
                var couponAmount = self.lbCouponAmount.frame
                //print("Price Unit frame :\(couponAmount.origin.x) +\(couponAmount.origin.y)")
                couponAmount.origin.x = self.imgCouponLogo.frame.width + 30.0
                self.lbCouponAmount.frame = couponAmount
                
                var discountUnit = self.lbDiscountUnit.frame
                //print("Price Unit frame :\(discountUnit.origin.x) +\(discountUnit.origin.y)")
                discountUnit.origin.x = couponAmount.origin.x + couponAmount.width + 10.0
                self.lbDiscountUnit.frame = discountUnit
                
                self.imgCouponLogo.setNeedsLayout()
                self.lbCouponName.setNeedsLayout()
                self.layoutIfNeeded()
            }
            
        } else {

            self.imgCouponLogo.kf.indicatorType = .activity
            self.imgCouponLogo.kf.setImage(with: photoUrl)
        }
        
        if couponBean.isUsed {
            self.imgUsedStamp.isHidden = false
            self.isUserInteractionEnabled = false
        } else {
            self.imgUsedStamp.isHidden = true
            self.isUserInteractionEnabled = true
        }
        
        // hidden when text is blank
        if couponBean.specialEventEN.isEmpty || couponBean.specialEventMM.isEmpty {
            self.lbSpecialEvent.isHidden = true
        } else {
            self.lbSpecialEvent.isHidden = false
        }
        if couponBean.descriptionEN.isEmpty || couponBean.descriptionMM.isEmpty {
            self.lbDescription.isHidden = true
        } else {
            self.lbDescription.isHidden = false
        }
        
        let attributedString = NSMutableAttributedString(string: couponBean.goodsPrice)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        
        self.lbGoodPrice.attributedText = attributedString
        
        self.layoutIfNeeded()
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        print("new size", newSize)
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
