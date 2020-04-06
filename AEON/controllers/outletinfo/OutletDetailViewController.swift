//
//  OutletDetailViewController.swift
//  AEONVCS
//
//  Created by mac on 7/27/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import GoogleMaps

class OutletDetailViewController: BaseUIViewController {

    @IBOutlet weak var ivBackBtn: UIImageView!
    @IBOutlet weak var ivOutletPhoto: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var vCallNow: UIView!
    @IBOutlet weak var lbCallNow: UILabel!
    @IBOutlet weak var vMapNavigateBtn: UIView!
    @IBOutlet weak var lbMapNav: UILabel!
    
    @IBOutlet weak var labelCallPhone: UILabel!
    var currentLocation : CLLocation?
    
    var outletInfo : OutletInfoBean?
    var phoneNo : String!
    var longitude : Double!
    var lattitude : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ivBackBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickBack)))
        
        if outletInfo != nil {
            lbName.text = self.outletInfo?.outletName
            lbAddress.text = self.outletInfo?.address
            lbPhone.text = self.outletInfo?.phoneNo
            labelCallPhone.text = self.outletInfo?.phoneNo
            
            if self.outletInfo?.phoneNo != nil {
                self.vCallNow.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickCallNow)))
                self.vCallNow.isUserInteractionEnabled = true
                self.phoneNo = self.outletInfo?.phoneNo
            }
            
            if self.outletInfo?.latitude != nil && self.outletInfo?.longitude != nil {
                self.vMapNavigateBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickMapNav)))
                self.vMapNavigateBtn.isUserInteractionEnabled = true
                self.lattitude = self.outletInfo?.latitude
                self.longitude = self.outletInfo?.longitude
            }
            
            if self.outletInfo?.imagePath != nil {
                let photoPath = self.outletInfo?.imagePath
                let photoUrl = URL(string:Constants.OUTLET_DETAIL_PHOTO_URL + photoPath!)
                self.ivOutletPhoto.kf.indicatorType = .activity
                self.ivOutletPhoto.kf.setImage(with: photoUrl)
                self.ivOutletPhoto.isHidden = false
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    DispatchQueue.main.async {
                        
                        self.imageHeight.constant = 400.0
                        self.ivOutletPhoto.layoutIfNeeded()
                        //                print("promo image size :", self.imgPromo.frame.width, self.imgPromo.frame.height)
                    }
                }
                
            } else {
                self.imageHeight.constant = 0
            }
        }
    }
    
    @objc func onClickBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickCallNow() {
        if let phoneNo = self.outletInfo?.phoneNo {
            phoneNo.makeCall()
        }
    }
    
    @objc func onClickMapNav(){
        let locationManager = CLLocationManager()
        let myLatitude = locationManager.location?.coordinate.latitude
        let myLongitude = locationManager.location?.coordinate.longitude
        
        if (UIApplication.shared.canOpenURL(URL.init(string:"comgooglemaps://")!)) {
            
            UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=\(self.currentLocation?.coordinate.latitude ?? myLatitude!),\(self.currentLocation?.coordinate.longitude ?? myLongitude!)&daddr=\(self.lattitude!),\(self.longitude!)&directionsmode=driving")!)
            
        } else {
            
            UIApplication.shared.open(URL(string: "https://maps.google.com/maps?saddr=\(self.currentLocation?.coordinate.latitude ?? myLatitude!),\(self.currentLocation?.coordinate.longitude ?? myLongitude!)&daddr=\(self.lattitude!),\(self.longitude!)&directionsmode=driving")! as URL)
            
        }
    }
}
//for outlet image URL
//https://ass.aeoncredit.com.mm/vcsm2/outlet-info/outlet-image-file/20190730102008542.png?
