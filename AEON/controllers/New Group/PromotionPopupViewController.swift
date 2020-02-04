//
//  PromotionPopupViewController.swift
//  AEONVCS
//
//  Created by mac on 4/23/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SafariServices

class PromotionPopupViewController: BaseUIViewController {

    @IBOutlet weak var svPromoScrollView: UIScrollView!
    @IBOutlet weak var imgCloseBtn: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var imgPromo: UIImageView!
    @IBOutlet weak var mapCardView: CardView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var imgPromoConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnLINK: UIButton!
    
    var mapDelegate :GMSMapViewDelegate?
    private let locationManager = CLLocationManager()
    var latitude : Double?
    var longitude : Double?
    let marker = GMSMarker()
    
    var promoBean : PromotionBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgCloseBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickClose(tapGestureRecognizer:))))
        
        self.mapView.delegate = self
        // load cell data to popup
        switch Locale.currentLocale {
        case .MY:
            self.lblTitle.text = promoBean?.titleMyn
            self.lblContent.text = promoBean?.contentMyn
            break
            
        case .EN:
            self.lblTitle.text = promoBean?.titleEng
            self.lblContent.text = promoBean?.contentEng
            break
        }
        self.lblDate.text = promoBean?.displayDate
        
        let photoPath = promoBean?.imagePath ?? Constants.BLANK
        let photoUrl = URL(string:Constants.PROMOTION_PHOTO_URL + photoPath)
        self.imgPromo.kf.indicatorType = .activity
        self.imgPromo.kf.setImage(with: photoUrl)
        
        self.btnLINK.setTitle("\(promoBean?.announcementUrl ?? "")", for: .normal)
        
//        var image: UIImage!
//        if let data = try? Data( contentsOf: photoUrl!)
//        {
//            image = UIImage( data:data)
//
//        } else {
//            image = UIImage(named: "non-image")
//        }
//        self.imgPromo.image = image
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            DispatchQueue.main.async {
     
                self.imgPromoConstraint.constant = 400.0
                self.imgPromo.layoutIfNeeded()
//                print("promo image size :", self.imgPromo.frame.width, self.imgPromo.frame.height)
            }
        }
        
        if promoBean!.isLocationNull {
            self.mapCardView.isHidden = true
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        } else {
            self.mapCardView.isHidden = false
            mapView.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
        }
        self.mapView.layoutIfNeeded()
        
        NotificationCenter.default.addObserver(self, selector: #selector(doForceDismissPromo), name: NSNotification.Name(rawValue: "doForceDismissPromo"), object: nil)
    }
    
    @objc func doForceDismissPromo() {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "doForceDismissPromo"), object: nil)
    }
    
    @objc func onClickClose(tapGestureRecognizer: UITapGestureRecognizer){
//        print("close popup")
        self.dismiss(animated: true, completion: nil)
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("Content Size : \(self.svPromoScrollView.contentSize.height)")
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .MY:
            self.lblTitle.text = promoBean?.titleMyn
            self.lblContent.text = promoBean?.contentMyn
            break
            
        case .EN:
            self.lblTitle.text = promoBean?.titleEng
            self.lblContent.text = promoBean?.contentEng
            break
        }
    }
    
    @IBAction func tappedOnLink(_ sender: Any) {
        
        //Goto URl link
        if let urltoGo = promoBean?.announcementUrl {
            
            if let url = URL(string: urltoGo) {
                let svc = SFSafariViewController(url: url)
                present(svc, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Invalid URL", message: "", preferredStyle: .alert) //
                let okAction = UIAlertAction(title: Constants.OK, style: .cancel, handler: { action in
                    
                    alertController.dismiss(animated: true, completion: nil)
                    
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}

extension PromotionPopupViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            let lastUseTime = Utils.generateLogoutTime()
            UserDefaults.standard.set(lastUseTime, forKey: Constants.LAST_USED_TIME)
//            print("App is inactive.")
//            print("Lastest Time: ", lastUseTime)
            return
        }
        // 4
        locationManager.startUpdatingLocation()

        //5
        mapView.settings.myLocationButton = true
        //mapView
//        print("Promotion ::: update location")
    }

    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        print("current location" ,location)
        let long: CLLocationDegrees = self.promoBean?.longitude ?? 0.0
        let lati: CLLocationDegrees = self.promoBean?.latitude ?? 0.0
        //let coordinate = CLLocationCoordinate2D(latitude: long, longitude: lati)


        // update camera position
        self.mapView.camera = GMSCameraPosition(latitude: lati, longitude: long, zoom: 15, bearing: 0, viewingAngle: 0)
        
        self.mapView.isMyLocationEnabled = true
        self.mapView.animate(toLocation: CLLocationCoordinate2DMake(lati, long))
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lati, long)
        //marker.title = "DIR-ACE Technology"
        //marker.snippet = "Myanmar"
        marker.map = self.mapView

        // 8
        locationManager.stopUpdatingLocation()
//        print("Promotion ::: change location (\(coordinate.latitude) , \(coordinate.longitude))")
//        print("Promotion ::: current location (\(location.coordinate.latitude) , \(location.coordinate.longitude))")
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        
    }
}

extension PromotionPopupViewController: GMSMapViewDelegate {
    //class code
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\((self.promoBean?.latitude)!),\((self.promoBean?.longitude)!)&zoom=14&views=traffic&q=\((self.promoBean?.latitude)!),\((self.promoBean?.longitude)!)")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string:
                "https://www.google.com/maps/search/?api=1&query=\((self.promoBean?.latitude)!),\((self.promoBean?.longitude)!)")! as URL)
        }
        return true
    }
    
    @objc(mapView:didTapOverlay:) func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
    
//        print("print")
    }
}
