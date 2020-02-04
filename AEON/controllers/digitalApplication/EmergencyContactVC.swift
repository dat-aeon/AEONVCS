//
//  EmergencyContactVC.swift
//  AEONVCS
//
//  Created by mac on 10/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SearchTextField

class EmergencyContactVC: BaseUIViewController {
    
    
    @IBOutlet weak var svEmergencyData: UIScrollView!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnParent: UIButton! {
        didSet {
            self.btnParent.clipsToBounds = true
            self.btnParent.layer.cornerRadius = 5
            self.btnParent.layer.borderWidth = 1.0
            self.btnParent.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
//    @IBOutlet weak var tvCurrentAddress: UITextView! {
//        didSet {
//            self.tvCurrentAddress.clipsToBounds = true
//            self.tvCurrentAddress.layer.cornerRadius = 5
//            self.tvCurrentAddress.layer.borderWidth = 1.0
//            self.tvCurrentAddress.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
//        }
//    }
    
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblRelationshipError: UILabel!
    @IBOutlet weak var lblCurrentAddress: UILabel!
    @IBOutlet weak var lblCurrentAddressError: UILabel!
    @IBOutlet weak var lblBuildNo: UILabel!
    @IBOutlet weak var tfCurrentBldNo: UITextField!
    @IBOutlet weak var lblCurrentRoomNo: UILabel!
    @IBOutlet weak var tfCurrentRoomNo: UITextField!
    @IBOutlet weak var lblCurrentFloor: UILabel!
    @IBOutlet weak var tfCurrentFloor: UITextField!
    @IBOutlet weak var lblCurrentStreet: UILabel!
    @IBOutlet weak var tfCurrentStreet: UITextField!
    @IBOutlet weak var lblCurrentQrt: UILabel!
    @IBOutlet weak var tfCurrentQrt: UITextField!
    @IBOutlet weak var lblCurrentTsp: UILabel!
    @IBOutlet weak var tfTownshipAutoText: SearchTextField!
    @IBOutlet weak var lblCurrentCity: UILabel!
    @IBOutlet weak var btnCurrentCity: UIButton!
    @IBOutlet weak var tfCityAutoText: UITextField!
    
    @IBOutlet weak var lblMobilenoError: UILabel!
    @IBOutlet weak var lblResidentTelNoError: UILabel!
    @IBOutlet weak var lblOtherTelNoError: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRsWithApplicant: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    @IBOutlet weak var lblResidentTelNo: UILabel!
    @IBOutlet weak var lblOtherTelNo: UILabel!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfRsWithApplicant: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMobileNo: UITextField!
    @IBOutlet weak var tfResidentTelNo: UITextField!
    @IBOutlet weak var tfOtherTelNo: UITextField!
    
    
    var nameMesgLocale: String?
    var rsWithApplicantMesgLocale: String?
    var addressMesgLocale: String?
    var mobileNoMesgLocale: String?
    var residentTelNoMesgLocale: String?
    var otherTelNoMesgLocale: String?
    //var rsWith = ["Parent", "Sponse", "Relative", "Friend", "Other"]
    
    var selectedRSWith = 1
    
    // City Township
    var allTownNameList = [String]()
    var cityNameList = [String]()
    var cityTownshipModel = CityTownShipModel()
    var selectedCityID : Int?
    var selectedTownshipID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblNameError.text = Constants.BLANK
        self.lblRelationshipError.text = Constants.BLANK
        self.lblCurrentAddressError.text = Constants.BLANK
         self.lblMobilenoError.text = Constants.BLANK
        self.lblResidentTelNoError.text = Constants.BLANK
        self.lblOtherTelNoError.text = Constants.BLANK
        
        self.updateViews()
        self.setupTownshipCityData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(markEmergencyContactLastState), name: NSNotification.Name(rawValue: "markEmergencyContactDataLastState"), object: nil)
//
        NotificationCenter.default.addObserver(self, selector: #selector(showEmergencyForm(notification:)), name: NSNotification.Name(rawValue: "showEmergencyForm"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorLabelEmergency), name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
        
        tfName.setMaxLength(maxLength: 50)
        tfRsWithApplicant.setMaxLength(maxLength: 50)
        tfMobileNo.setMaxLength(maxLength: 14)
        tfResidentTelNo.setMaxLength(maxLength: 11)
        tfOtherTelNo.setMaxLength(maxLength: 14)
        
        tfCurrentBldNo.setMaxLength(maxLength: 20)
        tfCurrentFloor.setMaxLength(maxLength: 20)
        tfCurrentRoomNo.setMaxLength(maxLength: 20)
        tfCurrentStreet.setMaxLength(maxLength: 100)
        tfCurrentQrt.setMaxLength(maxLength: 100)
        tfTownshipAutoText.setMaxLength(maxLength: 100)
        //tvCurrentAddress.delegate = self
        
        tfName.autocapitalizationType = .allCharacters
        tfRsWithApplicant.autocapitalizationType = .allCharacters
        tfCurrentBldNo.autocapitalizationType = .allCharacters
        tfCurrentRoomNo.autocapitalizationType = .allCharacters
        tfCurrentStreet.autocapitalizationType = .allCharacters
        tfCurrentFloor.autocapitalizationType = .allCharacters
        tfCurrentQrt.autocapitalizationType = .allCharacters
        
        // mendatory fields background setting
        self.tfName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfRsWithApplicant.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCurrentStreet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMobileNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            textField.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
        } else {
            textField.backgroundColor = UIColor.white
        }
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification {
            svEmergencyData.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
            
        } else {
            svEmergencyData.contentInset = UIEdgeInsets.zero
        }
        svEmergencyData.scrollIndicatorInsets = svEmergencyData.contentInset
    }

    @objc func showErrorLabelEmergency() {
       _ = self.isErrorExist()
    }
    
    @objc func showEmergencyForm(notification: Notification) {
        if let dict = notification.userInfo as? Dictionary<String, Any> {
        print("showemergencyform \(dict)")
        if let sVar = dict["data"] as? EmergencyContactRequest {
            self.fillThisForm(data: sVar)
            }
        }
    }
    
    @IBAction func onClickCityBtn(_ sender: UIButton) {
        openCitySelectionPopUp()
    }
    
    func openCitySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCurrentCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                
                if self.allTownNameList.count >= 0 {
                    self.tfTownshipAutoText.filterStrings(self.allTownNameList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.tfCityAutoText
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCurrentCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                
                if self.allTownNameList.count >= 0 {
                    self.tfTownshipAutoText.filterStrings(self.allTownNameList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func setupTownshipCityData() {
        
        //autocomplete
        self.tfTownshipAutoText.theme.cellHeight = 40
        self.tfTownshipAutoText.maxResultsListHeight = 300
        self.tfTownshipAutoText.startVisible = true
        self.tfTownshipAutoText.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfTownshipAutoText.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfTownshipAutoText.theme.bgColor = UIColor.groupTableViewBackground
        self.tfTownshipAutoText.theme.separatorColor = UIColor.lightGray
        self.tfTownshipAutoText.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfTownshipAutoText.text = item.title
            self.selectedTownshipID = self.cityTownshipModel.townNameIdDic![item.title]
            print("\(item.title)", "\(self.selectedTownshipID ?? 0)")
        }
        
        //load city township data
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        DAViewModel.init().getCityTownshipList(success: { (model) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.cityTownshipModel = model
            for cityName in model.cityNameIdDic!.keys {
                self.cityNameList.append(cityName)
            }
            // Company Address
            self.selectedCityID = model.cityNameIdDic![self.cityNameList[0]]
            self.btnCurrentCity.setTitle(self.cityNameList[0], for: UIControl.State.normal)
            self.allTownNameList = model.cityIdTownListDic![self.selectedCityID!]!
            self.tfTownshipAutoText.filterStrings(self.allTownNameList)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.JSON_FAILURE {
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    //                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.CUSTOMER_TYPE_VIEW_CONTROLLER) as! UINavigationController
                    //                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            }
        }
    }
     
    func fillThisForm(data: EmergencyContactRequest) {
        self.tfName.text = data.name
        self.textFieldDidChange(self.tfName)
        
        self.selectedRSWith = data.relationship
        self.btnParent.setTitle("\(Constants.rsWithList[self.selectedRSWith - 1])", for: .normal)
        if self.selectedRSWith == Constants.rsWithList.count {
            self.tfRsWithApplicant.isHidden = false
        } else {
            self.tfRsWithApplicant.isHidden = true
        }
        self.tfRsWithApplicant.text = data.relationshipOther
        self.textFieldDidChange(self.tfRsWithApplicant)
        
        //self.tvCurrentAddress.text = data.currentAddress
        self.tfCurrentBldNo.text = data.currentAddressBuildingNo
        self.tfCurrentRoomNo.text = data.currentAddressRoomNo
        self.tfCurrentFloor.text = data.currentAddressFloor
        self.tfCurrentQrt.text = data.currentAddressQtr
        self.tfCurrentStreet.text = data.currentAddressStreet
        self.textFieldDidChange(self.tfCurrentStreet)
        
        if data.currentAddressCity != 0 {
            for cityName in self.cityTownshipModel.cityNameIdDic!.keys{
                let id = self.cityTownshipModel.cityNameIdDic![cityName]
                if id == data.currentAddressCity {
                    self.btnCurrentCity.setTitle(cityName, for: UIControl.State.normal)
                    self.selectedCityID = id
                    break
                }
            }
        }
        
        if data.currentAddressTownship != 0{
            for townName in self.cityTownshipModel.townNameIdDic!.keys{
                let id = self.cityTownshipModel.townNameIdDic![townName]
                if id == data.currentAddressTownship {
                    self.tfTownshipAutoText.text = townName
                    self.selectedTownshipID = id
                    self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                    self.tfTownshipAutoText.filterStrings(self.allTownNameList)
                    break
                }
            }
        }
        self.textFieldDidChange(self.tfTownshipAutoText)
        
        self.tfMobileNo.text = data.mobileNo
        self.textFieldDidChange(self.tfMobileNo)
        
        self.tfResidentTelNo.text = data.residentTelNo
        self.tfOtherTelNo.text = data.otherPhoneNo
        
    }
    
    @objc func markEmergencyContactLastState() {
       
        self.markEmergencyContactErrorCount()
         self.tfTownshipAutoText.hideResultsList()
        
        let appData = EmergencyContactRequest(daEmergencyContactInfoId: emergencyFormID, name: self.tfName.text ?? "", relationship: self.selectedRSWith, relationshipOther: self.tfRsWithApplicant.text ?? "", currentAddress: "", mobileNo: self.tfMobileNo.text ?? "", residentTelNo: self.tfResidentTelNo.text ?? "", otherPhoneNo: self.tfOtherTelNo.text ?? "", currentAddressFloor: self.tfCurrentFloor.text ?? "", currentAddressBuildingNo: self.tfCurrentBldNo.text ?? "", currentAddressRoomNo: self.tfCurrentRoomNo.text ?? "", currentAddressStreet: self.tfCurrentStreet.text ?? "", currentAddressQtr: self.tfCurrentQrt.text ?? "", currentAddressTownship: self.selectedTownshipID ?? 0, currentAddressCity: selectedCityID ?? 0)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetEmergencyContactData"), object: self, userInfo: ["appData": appData])
        self.view.endEditing(true)
    }
    
    @objc override func updateViews() {
        super.updateViews()
        
        self.lblName.text = "emergencycontact_name".localized
        self.lblRsWithApplicant.text = "emergencycontact_rsapplicant".localized
        self.lblCurrentAddress.text = "emergencycontact_currentaddress".localized
        self.lblMobileNo.text = "emergencycontact_mobileno".localized
        self.lblResidentTelNo.text = "emergencycontact_residenttelno".localized
        self.lblOtherTelNo.text = "emergencycontact_othertelno".localized
        
        self.lblBuildNo.text = "da.buildno".localized
        self.lblCurrentFloor.text = "da.floor".localized
        self.lblCurrentRoomNo.text = "da.roomno".localized
        self.lblCurrentStreet.text = "da.street".localized
        self.lblCurrentQrt.text = "da.quarter".localized
        self.lblCurrentTsp.text = "da.township".localized
        self.lblCurrentCity.text = "da.city".localized
        
        self.lblNameError.text = nameMesgLocale?.localized
        self.lblRelationshipError.text = rsWithApplicantMesgLocale?.localized
        self.lblCurrentAddressError.text = addressMesgLocale?.localized
        self.lblMobilenoError.text = mobileNoMesgLocale?.localized
        self.lblResidentTelNoError.text = residentTelNoMesgLocale?.localized
        self.lblOtherTelNoError.text = otherTelNoMesgLocale?.localized
        
    }
    
    @IBAction func doShowRsWithApplicantList(_ sender: Any) {
        self.openRsWithApplicantPopup()
    }
    
    func openRsWithApplicantPopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: Constants.rsWithList, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.btnParent.setTitle(value, for: .normal)
                self.selectedRSWith = Constants.rsWithList.firstIndex(of: value)! + 1
                print(value)
                if self.selectedRSWith == Constants.rsWithList.count {
                    self.tfRsWithApplicant.isHidden = false
                } else {
                    self.tfRsWithApplicant.isHidden = true
                }
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: Constants.rsWithList, action: { (value)  in
                //                let selectedType = self.typeResidence[-1]
                self.btnParent.setTitle(value, for: .normal)
                self.selectedRSWith = Constants.rsWithList.firstIndex(of: value)! + 1
                print(value)
                if self.selectedRSWith == Constants.rsWithList.count {
                    self.tfRsWithApplicant.isHidden = false
                } else {
                    self.tfRsWithApplicant.isHidden = true
                }
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func isErrorExist() -> Bool {
        
        var isError = false
        // not to overwrite error message
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfName?.text = Constants.BLANK
            self.lblNameError.text = Messages.NAME_EMPTY_ERROR.localized
            self.nameMesgLocale = Messages.NAME_EMPTY_ERROR
            isError = true
            
        }
//        else if !Utils.isNameValidate(name: (self.tfName!.text)!){
//
//            self.lblNameError.text = Messages.NAME_REG_FORMAT_ERROR.localized
//            self.nameMesgLocale = Messages.NAME_REG_FORMAT_ERROR
//            isError = true
//
//        }
        else {
            self.nameMesgLocale = Constants.BLANK
            self.lblNameError.text = Constants.BLANK
        }
        
        if self.btnParent.titleLabel?.text == "Other" {
            if self.tfRsWithApplicant?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                self.tfRsWithApplicant?.text = Constants.BLANK
                self.lblRelationshipError.text = Messages.RSWITHAPPLICANT_EMPTY_ERROR.localized
                self.rsWithApplicantMesgLocale = Messages.RSWITHAPPLICANT_EMPTY_ERROR
                isError = true
                
            } else {
                self.rsWithApplicantMesgLocale = Constants.BLANK
                self.lblRelationshipError.text = Constants.BLANK
            }
        }
        
        // Address
        if self.tfCurrentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfCurrentStreet?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.addressMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true
            
        } else {
            self.addressMesgLocale = Constants.BLANK
            self.lblCurrentAddressError.text = Constants.BLANK
        }
        
        if self.tfTownshipAutoText?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfTownshipAutoText?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_EMPTY_ERROR.localized
            self.addressMesgLocale = Messages.ADDRESS_EMPTY_ERROR
            isError = true
            
        } else if !self.allTownNameList.contains((self.tfTownshipAutoText?.text)!) {
            self.tfTownshipAutoText?.text = Constants.BLANK
            self.lblCurrentAddressError.text = Messages.ADDRESS_INVALID_ERROR.localized
            self.addressMesgLocale = Messages.ADDRESS_INVALID_ERROR
            isError = true
                   
        } else {
            self.addressMesgLocale = Constants.BLANK
            self.lblCurrentAddressError.text = Constants.BLANK
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfMobileNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfMobileNo?.text = Constants.BLANK
            self.lblMobilenoError.text = Messages.PHONE_REG_EMPTY_ERROR.localized
            self.mobileNoMesgLocale = Messages.PHONE_REG_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isPhoneValidate(phoneNo: (self.tfMobileNo?.text)!){
            // validate phone no format
            self.lblMobilenoError.text = Messages.PHONE_LENGTH_ERROR.localized
            self.mobileNoMesgLocale = Messages.PHONE_LENGTH_ERROR
            isError = true
            
        } else {
            self.mobileNoMesgLocale = Constants.BLANK
            self.lblMobilenoError.text = Constants.BLANK
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfResidentTelNo.text!.count > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfResidentTelNo?.text)!){
                // validate phone no format
                self.lblResidentTelNoError.text = Messages.PHONE_LENGTH_ERROR.localized
                self.residentTelNoMesgLocale = Messages.PHONE_LENGTH_ERROR
                isError = true
                
            } else {
                self.residentTelNoMesgLocale = Constants.BLANK
                self.lblResidentTelNoError.text = Constants.BLANK
            }
        }  else {
            self.residentTelNoMesgLocale = Constants.BLANK
            self.lblResidentTelNoError.text = Constants.BLANK
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfOtherTelNo.text!.count > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfOtherTelNo?.text)!){
                // validate phone no format
                self.lblOtherTelNoError.text = Messages.PHONE_LENGTH_ERROR.localized
                self.otherTelNoMesgLocale = Messages.PHONE_LENGTH_ERROR
                isError = true
                
            } else {
                self.otherTelNoMesgLocale = Constants.BLANK
                self.lblOtherTelNoError.text = Constants.BLANK
            }
        }  else {
            self.otherTelNoMesgLocale = Constants.BLANK
            self.lblOtherTelNoError.text = Constants.BLANK
        }
        
        return isError
    }
    
    func markEmergencyContactErrorCount() {
        
        var errorcount = 0
        // not to overwrite error message
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        }
//        else if !Utils.isNameValidate(name: (self.tfName!.text)!){
//            
//            errorcount += 1
//            
//        }
        
        if self.btnParent.titleLabel?.text == "Other" {
            if self.tfRsWithApplicant?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                errorcount += 1
                
            }
        }
        
        // Department
        if self.tfCurrentStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if self.tfTownshipAutoText?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if !self.allTownNameList.contains((self.tfTownshipAutoText?.text)!) {
            errorcount += 1
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfMobileNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else if !Utils.isPhoneValidate(phoneNo: (self.tfMobileNo?.text)!){
            // validate phone no format
            errorcount += 1
            
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfResidentTelNo.text!.count > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfResidentTelNo?.text)!){
                // validate phone no format
                errorcount += 1
                
            }
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfOtherTelNo.text!.count > 0 {
            if !Utils.isNumberValidate(phoneNo: (self.tfOtherTelNo?.text)!){
                // validate phone no format
                errorcount += 1
                
            }
        }
        
        UserDefaults.standard.set(errorcount, forKey: Constants.EMERGENCY_CONTACT_ERROR_COUNT)
    }
    
    @IBAction func doSaveData(_ sender: Any) {
        
        self.markEmergencyContactLastState()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveDA"), object: nil)
//        if isErrorExist() {
//            return
//        }
    }
    
    
    @IBAction func tapOnNextEcontact(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnNext"), object: nil , userInfo: ["index" : 3])
    }
    

}

extension EmergencyContactVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tfTownshipAutoText.hideResultsList()
        
    }
}
extension EmergencyContactVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 100
    }
}
