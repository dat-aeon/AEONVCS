//
//  AgentChannelPopupViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 11/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import GoogleMaps

class AgentChannelPopupViewController: BaseUIViewController {

    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var vCategoryList: UIView!
    @IBOutlet weak var txtCategory: UILabel!
    
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var vBrandList: UIView!
    @IBOutlet weak var txtBrand: UILabel!
    
    @IBOutlet weak var lbAddText: UILabel!
    @IBOutlet weak var txtAddText: UITextView!
    @IBOutlet weak var lbAddTextErrMesg: UILabel!
    
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var lbAddressErrMesg: UILabel!
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var imgCloseBtn: UIImageView!
    
    var categoryList = [CategoryData]()
    var categoryNameList = [String]()
    var brandList = [BrandData]()
    var brandNameList = [String]()
    
    var senderName: String = Constants.BLANK
    var senderId: Int = 0
    
    var socketReq = SocketReqBean()
    var param = SocketParam()
    
    var atDelegate : PopupSendButtonDelegate?
    
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

                self.vCategoryList.layer.borderWidth = 1
                self.vCategoryList.layer.cornerRadius = 4 as CGFloat
                self.vCategoryList.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
                
                self.vBrandList.layer.borderWidth = 1
                self.vBrandList.layer.cornerRadius = 4 as CGFloat
                self.vBrandList.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
                
                vCategoryList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickCategoryDropDown)))
                vBrandList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBrandDropDown)))
                
                self.imgCloseBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickClosePopup(tapGestureRecognizer:))))
                
                self.lbCategory.text = "agentchannel.category.label".localized
                self.lbBrand.text = "agentchannel.brand.label".localized
                self.lbAddText.text = "agentchannel.additional.label".localized
                self.lbAddress.text = "agentchannel.location.label".localized
                self.btnSend.setTitle("agentchannel.send.button".localized, for: UIControl.State.normal)
                
                // check network
                if Network.reachability.isReachable == false {
                    super.networkConnectionError()
                    return
                }
                
                self.senderName = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)!
                self.senderId = UserDefaults.standard.integer(forKey: Constants.USER_INFO_CUSTOMER_ID)
                
                CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
                
                txtAddText.text = ""
                txtAddress.text = ""
                lbAddTextErrMesg.text = Constants.BLANK
                lbAddressErrMesg.text = Constants.BLANK
                
                // get current places
                
                locationManager = CLLocationManager()
                locationManager!.requestWhenInUseAuthorization()
                locationManager!.requestAlwaysAuthorization()
                
                if CLLocationManager.locationServicesEnabled() {
                    locationManager!.delegate = self
                    locationManager!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager!.startUpdatingLocation()
                }
                
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            }
            
            override func viewWillAppear(_ animated: Bool) {
                if self.brandNameList.count > 0 {
                    txtBrand.text = self.brandNameList[0]
                }
                if self.categoryNameList.count > 0 {
                    txtCategory.text = self.categoryNameList[0]
                }
            }
            
            @objc override func updateViews() {
                super.updateViews()
                self.lbCategory.text = "agentchannel.category.label".localized
                self.lbBrand.text = "agentchannel.brand.label".localized
                self.lbAddText.text = "agentchannel.additional.label".localized
                self.lbAddress.text = "agentchannel.location.label".localized
                self.btnSend.setTitle("agentchannel.send.button".localized, for: UIControl.State.normal)
            }
            
            @objc func onClickClosePopup(tapGestureRecognizer : UITapGestureRecognizer) {
                self.dismiss(animated: true, completion: nil)
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            }
            
    @IBAction func onClickSendBtn(_ sender: UIButton) {
         atDelegate?.onClickSendBtn(categoryName: self.txtCategory, brandName: self.txtBrand, addText: self.txtAddText, address: txtAddress, addTextErr: self.lbAddTextErrMesg, addressErr: self.lbAddressErrMesg, popUpView: self)
    }
    
            @objc func onClickCategoryDropDown(){
                self.txtAddText?.resignFirstResponder()
                self.txtAddress?.resignFirstResponder()
                openCategorySelectionPopUp()
            }
            
            func openCategorySelectionPopUp() {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    
                    let action = UIAlertController.actionSheetWithItems(items: self.categoryNameList, action: { (value)  in
                        self.txtCategory.text = value
                        
                    })
                    action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                    if let popoverPresentationController = action.popoverPresentationController {
                        popoverPresentationController.sourceView = self.txtCategory
                    }
                    
                    self.present(action, animated: true, completion: nil)
                    
                } else {
                    let action = UIAlertController.actionSheetWithItems(items: self.categoryNameList, action: { (value)  in
                        self.txtCategory.text = value
                        print(value)
                    })
                    action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                    
                    self.present(action, animated: true, completion: nil)
                }
            }
            
            @objc func onClickBrandDropDown(){
                self.txtAddText?.resignFirstResponder()
                self.txtAddress?.resignFirstResponder()
                openBrandSelectionPopUp()
            }
            
            func openBrandSelectionPopUp() {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    
                    let action = UIAlertController.actionSheetWithItems(items: self.brandNameList, action: { (value)  in
                        self.txtBrand.text = value
                        
                    })
                    action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                    if let popoverPresentationController = action.popoverPresentationController {
                        popoverPresentationController.sourceView = self.txtBrand
                    }
                    
                    self.present(action, animated: true, completion: nil)
                    
                } else {
                    let action = UIAlertController.actionSheetWithItems(items: self.brandNameList, action: { (value)  in
                        self.txtBrand.text = value
                        print(value)
                    })
                    action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                    
                    self.present(action, animated: true, completion: nil)
                }
            }
        }

        extension AgentChannelPopupViewController : CLLocationManagerDelegate {
            func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                guard status == .authorizedWhenInUse else {
                    return
                }
                // 4
                locationManager!.startUpdatingLocation()
            }
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                guard let location = locations.first else {
                    return
                }
                let geoCoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

                    var placeMark: CLPlacemark!
                    placeMark = placemarks?[0]
                    if let place = placeMark {
                        self.txtAddress.text = place.thoroughfare! + ", " + place.subLocality! + ", " + place.locality! + ", " + place.country!
                    }
                    
                })
                locationManager?.stopUpdatingLocation()
            }
        }

        protocol PopupSendButtonDelegate {
            func onClickSendBtn(categoryName: UILabel, brandName:UILabel, addText: UITextView, address: UITextView, addTextErr : UILabel, addressErr: UILabel, popUpView: UIViewController)
            
        }

