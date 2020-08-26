//
//  OutletMapViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 7/27/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import GoogleMaps

class OutletMapViewController: UIViewController {
    
    @IBOutlet weak var ivMarkerMobile: UIImageView!
    @IBOutlet weak var ivMarkerNonMobile: UIImageView!
//    @IBOutlet weak var ivMarkerPersonal: UIImageView!
    @IBOutlet weak var ivMarkerMotorcycle: UIImageView!
    @IBOutlet weak var ivMarkerMultipleLoan: UIImageView!
    
    @IBOutlet weak var mvOutletNav: GMSMapView!
    
    private let locationManager = CLLocationManager()
    
    var outletBean : OutletInfoBean?
    var outletBeanList : [OutletInfoBean]?
    
    var markerDelegate :GMSMapViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ivMarkerMobile.image = UIImage(named: "marker-mobile128")
        self.ivMarkerNonMobile.image = UIImage(named: "marker-nonmobile128")
        self.ivMarkerMultipleLoan.image = UIImage(named: "marker-multiple")
        //self.ivMarkerMobile.tintColor = UIColor.blue
        //self.ivMarkerPersonal.tintColor = UIColor.red
        //self.ivMarkerNonMobile.tintColor = UIColor.yellow
        //self.ivMarkerMultipleLoan.tintColor = UIColor.orange

        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        OutletInfoViewModel.init().getOutletData(success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.outletBeanList = result.data.outletInfoList
            print("outlet map ::::::: \(self.outletBeanList!.count)")
            self.reloadOutletList()
             self.locationManager.startUpdatingLocation()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "Outlet " + error)
            }
            
        }
        
        self.mvOutletNav.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func reloadOutletList() {
        
        for outletInfo in self.outletBeanList! {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(outletInfo.latitude!, outletInfo.longitude!)
            marker.title = outletInfo.outletName
            
            if outletInfo.phoneNo != nil {
                marker.snippet = outletInfo.address! + "\n" + outletInfo.phoneNo!
            } else {
                marker.snippet = outletInfo.address!
            }
            
            if outletInfo.isAeonOutlet! {
                marker.icon = UIImage(named: "marker-aeon")
                
            } else {
                if outletInfo.roleType == 1 {
                    marker.icon = ivMarkerMobile.image
                    //marker.icon = GMSMarker.markerImage(with: UIColor.blue)
                    
                } else if outletInfo.roleType == 2 {
                    marker.icon = ivMarkerNonMobile.image
                    //marker.icon = GMSMarker.markerImage(with: UIColor.systemYellow)
                    
                } else if outletInfo.roleType == 3 {
                    //marker.icon = UIImage(named: "marker-personal")
                    //marker.icon = ivMarkerMultipleLoan.image
                     marker.icon = GMSMarker.markerImage(with: UIColor.red)
                    
                }
                else if outletInfo.roleType == 4 {
                    //marker.icon = UIImage(named: "marker-motorcycle")
                    marker.icon = GMSMarker.markerImage(with: UIColor.yellow)

                }
                else if outletInfo.roleType == 5 {
                    //marker.icon = UIImage(named: "marker-motorcycle")
                    marker.icon = ivMarkerMultipleLoan.image
                    //marker.icon = GMSMarker.markerImage(with: UIColor.orange)
                }
            }
            //marker.icon = UIImage(named: "camera-capture")
            marker.map = self.mvOutletNav
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            //print("Outlet location : ", outletInfo.latitude!, outletInfo.longitude!)
        }
    }
}

extension OutletMapViewController: CLLocationManagerDelegate {
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
        mvOutletNav.settings.myLocationButton = true
        //mapView
        //        print("Promotion ::: update location")
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let long: CLLocationDegrees = self.outletBean?.longitude ?? 0.0
        let lati: CLLocationDegrees = self.outletBean?.latitude ?? 0.0
        _ = CLLocationCoordinate2D(latitude: long, longitude: lati)
        
        
        // update camera position
        self.mvOutletNav.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        self.mvOutletNav.isMyLocationEnabled = true
        //self.mvOutletNav.animate(toLocation: CLLocationCoordinate2DMake(lati, long))
        
        // Creates a marker in the map.
        
        
        // 8
        locationManager.stopUpdatingLocation()
        //        print("Promotion ::: change location (\(coordinate.latitude) , \(coordinate.longitude))")
        //        print("Promotion ::: current location (\(location.coordinate.latitude) , \(location.coordinate.longitude))")
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        
    }
}

extension OutletMapViewController: GMSMapViewDelegate {
    //class code
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        let locationManager = CLLocationManager()
        let myLatitude = self.locationManager.location?.coordinate.latitude
        let myLongitude = self.locationManager.location?.coordinate.longitude

        if (UIApplication.shared.canOpenURL(URL.init(string:"comgooglemaps://")!)) {
           
            UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=\(myLatitude!),\(myLongitude!)&daddr=\(marker.position.latitude),\(marker.position.longitude)&directionsmode=driving")!)

        } else {
            
            UIApplication.shared.open(URL(string: "https://maps.google.com/maps?saddr=\(myLatitude!),\(myLongitude!)&daddr=\(marker.position.latitude),\(marker.position.longitude)&directionsmode=driving")! as URL)

            print("https://maps.google.com/maps?saddr=\(myLatitude!),\(myLongitude!)&daddr=\(marker.position.latitude),\(marker.position.longitude)&directionsmode=driving")
        }
        
    }
}
