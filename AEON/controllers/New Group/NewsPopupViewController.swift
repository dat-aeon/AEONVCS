//
//  NewsPopupViewController.swift
//  AEONVCS
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import GoogleMaps
import SafariServices

class NewsPopupViewController: BaseUIViewController {

    @IBOutlet weak var svNewsScrollView: UIScrollView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var mapCardView: CardView!
    @IBOutlet weak var newsMapView: GMSMapView!
    @IBOutlet weak var imgNewsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnLink: UIButton!
    
    var mapDelegate :GMSMapViewDelegate?
    private let locationManager = CLLocationManager()
    var latitude : Double?
    var longitude : Double?
    let marker = GMSMarker()
    
    var newsInfoBean : NewsInfoBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgClose.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickClose(tapGestureRecognizer:))))
        
        self.newsMapView.delegate = self
        // load cell data to popup
        switch Locale.currentLocale {
        case .MY:
            self.lbTitle.text = newsInfoBean?.titleMyn
            self.lbContent.text = newsInfoBean?.contentMyn
            break
            
        case .EN:
            self.lbTitle.text = newsInfoBean?.titleEng
            self.lbContent.text = newsInfoBean?.contentEng
            break
        }
//        self.lbDate.text = newsInfoBean?.displayDate
        if (newsInfoBean?.displayDate != nil) {
            self.lbDate.text = self.changegoodnewsDateformat(date : newsInfoBean?.publishedFromDate ?? "2019-06-18T17:30:00.000+0000")
               }else{
            
            self.lbDate.text = "-"
            
        }
        
        let photoPath = newsInfoBean?.imagePath ?? Constants.BLANK
        let photoUrl = URL(string:Constants.NEWS_PHOTO_URL + photoPath)
        self.imgNews.kf.indicatorType = .activity
        self.imgNews.kf.setImage(with: photoUrl)
        
        self.btnLink.setTitle("\(newsInfoBean?.newsUrl ?? "")", for: .normal)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            DispatchQueue.main.async {
                
                self.imgNewsConstraint.constant = 400.0
                self.imgNews.layoutIfNeeded()
//                print("promo image size :", self.imgNews.frame.width, self.imgNews.frame.height)
            }
        }
        
        if newsInfoBean!.isLocationNull {
            self.mapCardView.isHidden = true
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        } else {
            self.mapCardView.isHidden = false
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
        }
        self.mapCardView.layoutIfNeeded()
        
        NotificationCenter.default.addObserver(self, selector: #selector(doForceDismiss), name: NSNotification.Name(rawValue: "doForceDismiss"), object: nil)
    }
    
    @objc func doForceDismiss() {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "doForceDismiss"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("Content Size : \(self.svNewsScrollView.contentSize.height)")
    }
    
    @objc func onClickClose(tapGestureRecognizer: UITapGestureRecognizer){
//        print("close popup")
        self.dismiss(animated: true, completion: nil)
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .MY:
            self.lbTitle.text = newsInfoBean?.titleMyn
            self.lbContent.text = newsInfoBean?.contentMyn
            break
            
        case .EN:
            self.lbTitle.text = newsInfoBean?.titleEng
            self.lbContent.text = newsInfoBean?.contentEng
            break
        }
    }
    
    @IBAction func tappedOnLINK(_ sender: Any) {
        //Goto URl link
        if let urltoGo = newsInfoBean?.newsUrl {
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

extension NewsPopupViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        //locationManager.startUpdatingLocation()
        
        //5
        newsMapView.settings.myLocationButton = true
        
//        print("Promotion ::: update location")
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.first != nil else {
            return
        }
        
        let long: CLLocationDegrees = self.newsInfoBean?.longitude ?? 0.0
        let lati: CLLocationDegrees = self.newsInfoBean?.latitude ?? 0.0
        //let coordinate = CLLocationCoordinate2D(latitude: long, longitude: lati)
        
        
        // update camera position
        self.newsMapView.camera = GMSCameraPosition(latitude: lati, longitude: long, zoom: 15, bearing: 0, viewingAngle: 0)
        
        self.newsMapView.isMyLocationEnabled = true
        self.newsMapView.animate(toLocation: CLLocationCoordinate2DMake(lati, long))
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lati, long)
        //marker.title = "DIR-ACE Technology"
        //marker.snippet = "Myanmar"
        marker.map = self.newsMapView
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        
        // 8
        //locationManager.stopUpdatingLocation()
//        print("Promotion ::: change location (\(coordinate.latitude) , \(coordinate.longitude))")
//        print("Promotion ::: current location (\(location.coordinate.latitude) , \(location.coordinate.longitude))")
    }
}

extension NewsPopupViewController: GMSMapViewDelegate {
    //class code
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\((self.newsInfoBean?.latitude)!),\((self.newsInfoBean?.longitude)!)&zoom=14&views=traffic&q=\((self.newsInfoBean?.latitude)!),\((self.newsInfoBean?.longitude)!)")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string:
                "https://www.google.com/maps/search/?api=1&query=\((self.newsInfoBean?.latitude)!),\((self.newsInfoBean?.longitude)!)")! as URL)
        }
        return true
    }
    
    @objc(mapView:didTapOverlay:) func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        
//        print("print")
    }
}
