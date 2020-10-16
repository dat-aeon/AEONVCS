//
//  OutletListViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 7/27/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMaps

class OutletListViewController: BaseUIViewController {

    @IBOutlet weak var tvOutletList: UITableView!
    
    var outletList = [OutletInfoBean]()
    var selectedRow = 0
    var selectedOutletBean:OutletInfoBean?
    var tokenInfo: TokenData?
    var isDidLoad = false
    
    let locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    
    var reload = true
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.reloadOutletList()
        
//        let locationManager = CLLocationManager()
//        let myLatitude = locationManager.location?.coordinate.latitude
//        let myLongitude = locationManager.location?.coordinate.longitude
//        self.currentLocation = CLLocation(latitude: myLatitude!, longitude: myLongitude!)
        
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
//            locationManager.startMonitoringSignificantLocationChanges()
        }
        
        self.tvOutletList.register(UINib(nibName: CommonNames.OUTLET_LIST_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.OUTLET_LIST_TABLE_CELL)
        self.tvOutletList.dataSource = self
        self.tvOutletList.delegate = self
        self.tvOutletList.tableFooterView = UIView()
        
        self.isDidLoad = true
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 20.0, repeats: true, block: { timer in
            //print("FIRE!!!")
//            self.locationManager.startUpdatingLocation()
//            self.locationManager.stopUpdatingLocation()
            self.reload = true
        })

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.timer.invalidate()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.tvOutletList.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isDidLoad {
            isDidLoad = false
        } else {
//            self.reloadOutletList()
        }
    }
    
    func reloadOutletList(){
        
//        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
//        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
//        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        OutletInfoViewModel.init().getOutletData(success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            let limitDistance = Double(result.data.outletLimitMetre!)
            print("current location ", self.currentLocation!)
            
            if result.data.outletInfoList.count > 0 {
                self.outletList.removeAll()
            }
    
            // check distance
            for outletdata in result.data.outletInfoList {
                var outletInfo = outletdata
                //print("\(outletInfo.outletName)outlet: \(outletInfo.isAeonOutlet)")
                if outletInfo.latitude != nil && outletInfo.longitude != nil {
                    let outletCoordinate = CLLocation(latitude: outletInfo.latitude ?? 0.0, longitude: outletInfo.longitude ?? 0.0)
                    //print("outlet coordinate ", outletCoordinate)
                    //print("my coordinate ", self.currentLocation)

                
//                    let distanceInMeters = outletCoordinate.distance(from: self.currentLocation!)
                    
                    let distanceInMeters = self.getDistanceFromLatLon(lat1: self.currentLocation?.coordinate.latitude ?? 0.0, lon1: self.currentLocation?.coordinate.longitude ?? 0.0, lat2: outletCoordinate.coordinate.latitude, lon2: outletCoordinate.coordinate.longitude)
                   
                    //print("\(outletInfo.outletName)distance : ", distanceInMeters)
                    outletInfo.distance = distanceInMeters
                    
                    if distanceInMeters < limitDistance {
                        self.outletList.append(outletInfo)
                    }
                }
            }
            
            let list = self.outletList.sorted(by: { Int($0.distance!) < Int($1.distance!)})
            self.outletList = list
            //self.outletList = result.data.outletInfoList
            print("outlet list :::::::\(self.outletList.count)",result.data.outletLimitMetre!)
            self.tvOutletList.reloadData()
            
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
    }
}

extension OutletListViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.outletList.count
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.OUTLET_LIST_TABLE_CELL, for: indexPath) as! OutletListTableViewCell
        
        cell.setOutletData(outletInfo: self.outletList[indexPath.row])
        
        return cell
    }
    
}

extension OutletListViewController:UITableViewDelegate, UIPopoverControllerDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        
        self.selectedOutletBean = self.outletList[indexPath.row]
        self.selectedRow = indexPath.row
        
        //let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.OUTLET_DETAIL_VIEW_CONTROLLER) as! OutletDetailViewController
        popupVC.modalPresentationStyle = .fullScreen
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.outletInfo = self.selectedOutletBean!
        
        let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        
        //pVC?.sourceView = sender
        //pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
        
        self.definesPresentationContext = true
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
        //popupVC.delegate = self
        popupVC.currentLocation = self.currentLocation
        self.present(popupVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(80.0)
    }
}

extension OutletListViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let locationLat = locValue.latitude
        let locationLong = locValue.longitude
        
        let tupleOne = (1, 2, 3)
        
        print("tuple : \(tupleOne)")
        
        self.currentLocation = CLLocation(latitude: locationLat, longitude: locationLong)
        
        print("currentlocation: \(self.currentLocation?.coordinate.latitude) - \(self.currentLocation?.coordinate.longitude)")
        
        if self.reload {
            self.reload = false
            self.reloadOutletList()
        }
        
        
    }
    
    func getDistanceFromLatLon(lat1: Double,lon1: Double,lat2: Double,lon2: Double) -> Double {
        let R = 6371.0
        let dlat = deg2rad(lat2-lat1)
        let dLon = deg2rad(lon2-lon1)
        let a = sin(dlat/2) * sin(dlat/2) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon/2) * sin(dLon/2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        let d = R * c
        let dINMe = d * 1000
        return dINMe
    }

    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }

}



//function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
//  var R = 6371; // Radius of the earth in km
//  var dLat = deg2rad(lat2-lat1);  // deg2rad below
//  var dLon = deg2rad(lon2-lon1);
//  var a =
//    Math.sin(dLat/2) * Math.sin(dLat/2) +
//    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
//    Math.sin(dLon/2) * Math.sin(dLon/2)
//    ;
//  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
//  var d = R * c; // Distance in km
//  return d;
//}
//
//function deg2rad(deg) {
//  return deg * (Math.PI/180)
//}
