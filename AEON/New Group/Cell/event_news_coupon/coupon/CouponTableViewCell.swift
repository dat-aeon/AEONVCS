//
//  CouponTableViewCell.swift
//  AEON
//
//  Created by AcePlus101 on 2/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class CouponTableViewCell: UITableViewCell {

    @IBOutlet weak var lbCouponName: UILabel!
    @IBOutlet weak var lbExpireDate: UILabel!
    @IBOutlet weak var lbGoodPrice: UILabel!
    @IBOutlet weak var lbGoodPriceUnit: UILabel!
    @IBOutlet weak var lbCouponAmount: UILabel!
    @IBOutlet weak var lbDiscountUnit: UILabel!
    @IBOutlet weak var lbSpecialEvent: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var imgUsedStamp: UIImageView!
    @IBOutlet weak var imgCouponLogo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(couponBean: CouponBean){
        self.lbCouponName.text = couponBean.couponNameEN
        self.lbExpireDate.text = couponBean.expiredTime
        self.lbGoodPrice.text = couponBean.goodsPrice
        self.lbGoodPriceUnit.text = couponBean.discountUnit
        self.lbCouponAmount.text = couponBean.couponAmount
        self.lbDiscountUnit.text = couponBean.discountUnit
        self.lbSpecialEvent.text = couponBean.specialEventEN
        self.lbDescription.text = couponBean.descriptionEN
        let photoUrl = URL(string:couponBean.unuseImagePath)
        self.imgCouponLogo.kf.setImage(with: photoUrl)
        
        if couponBean.isUsed {
            self.imgUsedStamp.isHidden = false
        } else {
            self.imgUsedStamp.isHidden = true
        }
        
        let attributedString = NSMutableAttributedString(string: couponBean.goodsPrice)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))

        self.lbGoodPrice.attributedText = attributedString
    }
}
