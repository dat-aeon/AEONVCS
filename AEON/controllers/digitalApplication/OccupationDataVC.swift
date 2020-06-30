//
//  OccupationDataVC.swift
//  AEONVCS
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SearchTextField

class OccupationDataVC: BaseUIViewController {
    
    @IBOutlet weak var svOccupationData: UIScrollView!
    @IBOutlet weak var lblBldNo: UILabel!
    @IBOutlet weak var tfBldNO: UITextField!
    @IBOutlet weak var lblRoomNo: UILabel!
    @IBOutlet weak var tfRoomNo: UITextField!
    @IBOutlet weak var lblFloor: UILabel!
    @IBOutlet weak var tfFloor: UITextField!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var lblQrt: UILabel!
    @IBOutlet weak var tfQrt: UITextField!
    @IBOutlet weak var lblTsp: UILabel!
    @IBOutlet weak var tfTsp: SearchTextField!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var btnCity: UIButton!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyAddress: UILabel!
    
    @IBOutlet weak var lblSalaryDate: UILabel!
    @IBOutlet weak var lblTotalIncome: UILabel!
    @IBOutlet weak var lblOtherIncome: UILabel!
    @IBOutlet weak var lblMonthlyBasicIncome: UILabel!
    @IBOutlet weak var lblCompanyStatus: UILabel!
    @IBOutlet weak var lblYearService: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblDepartment: UILabel!
    @IBOutlet weak var lblContactTime: UILabel!
    @IBOutlet weak var lblCompanyTelNo: UILabel!
    
    @IBOutlet weak var lblCompanyNameError: UILabel!
    @IBOutlet weak var lblAddressError: UILabel!
    @IBOutlet weak var lblTelNoError: UILabel!
    @IBOutlet weak var lblContactTimeError: UILabel!
    @IBOutlet weak var lblDepartmentError: UILabel!
    @IBOutlet weak var lblPositionError: UILabel!
    @IBOutlet weak var lblYearServiceError: UILabel!
    @IBOutlet weak var lblStatusError: UILabel!
    @IBOutlet weak var lblMonthlyIncomeError: UILabel!
    @IBOutlet weak var lblOtherIncomeError: UILabel!
//    @IBOutlet weak var lblTotalIncomeError: UILabel!
    @IBOutlet weak var lblSalaryDateError: UILabel!
    
    @IBOutlet weak var tfAM: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPM: SkyFloatingLabelTextField!
    @IBOutlet weak var tfYear: SkyFloatingLabelTextField!
    @IBOutlet weak var tfMonth: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnCompanyStatus: UIButton! {
        didSet {
            self.btnCompanyStatus.clipsToBounds = true
            self.btnCompanyStatus.layer.cornerRadius = 5
            self.btnCompanyStatus.layer.borderWidth = 1.0
            self.btnCompanyStatus.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    
    @IBOutlet weak var tfSalaryDate: UITextField!
    
    @IBOutlet weak var tfCompanyName: UITextField!
    @IBOutlet weak var tfCompanyTelNo: UITextField!
    @IBOutlet weak var tfDepartment: UITextField!
    @IBOutlet weak var tfPosition: UITextField!
    @IBOutlet weak var tfCompanyStatusAutoText: SearchTextField!
    @IBOutlet weak var tfCompanyStatus: UITextField!
    
    @IBOutlet weak var tfMonthlyBasicIncome: UITextField!
    @IBOutlet weak var tfOtherIncome: UITextField!
    @IBOutlet weak var tfTotalIncome: UITextField!
    @IBOutlet weak var lbTotalIncomeTxt: UILabel!
    
    
//    var companyStatusList = ["Public Company","Factory", "Police","Private Company","SME Owner","Goverment Office", "Taxi Owner", "Specialist", "SME officer", "Military", "NGO", "Other"]
//    
    
    var daysArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    
    var yearList :[Int]!
    var monthList :[Int]!
    var numberPicker : UIPickerView!
    
    // City Township
    var allTownNameList = [String]()
    var cityNameList = [String]()
    var cityTownshipModel = CityTownShipModel()
    var selectedCityID : Int?
    var selectedTownshipID: Int?
    
    var companyNameMesgLocale: String?
    var companyAddressMesgLocale: String?
    var companyTelNoMesgLocale: String?
    var contactTimeMesgLocale: String?
    var departmentMesgLocale: String?
    var positionMesgLocale: String?
    var yearServiceMesgLocale: String?
    var companyStatusMesgLocale: String?
    var monthlyBasicIncomeMesgLocale: String?
    var otherIncomeMesgLocale: String?
    var totalIncomeMesgLocale: String?
    var salaryDateMesgLocale: String?
    
    var selectedStatusIndex = 1
    var logoutTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
       // logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        self.lblCompanyNameError.text = Constants.BLANK
//        self.lblAddressError.text = Constants.BLANK
        self.lblTelNoError.text = Constants.BLANK
        self.lblContactTimeError.text = Constants.BLANK
        self.lblDepartmentError.text = Constants.BLANK
        self.lblPositionError.text = Constants.BLANK
        self.lblYearServiceError.text = Constants.BLANK
        self.lblStatusError.text = Constants.BLANK
        self.lblMonthlyIncomeError.text = Constants.BLANK
        self.lblOtherIncomeError.text = Constants.BLANK
        //self.lblTotalIncomeError.text = Constants.BLANK
        self.lblSalaryDateError.text = Constants.BLANK
        
        
        self.tfAM.font = UIFont.systemFont(ofSize: 15)
        self.tfPM.font = UIFont.systemFont(ofSize: 15)
        self.tfYear.font = UIFont.systemFont(ofSize: 15)
        self.tfMonth.font = UIFont.systemFont(ofSize: 15)
        
        self.tfAM.keyboardType = .numberPad
        self.tfPM.keyboardType = .numberPad
        self.tfYear.keyboardType = .numberPad
        self.tfMonth.keyboardType = .numberPad
        
        
       self.tfCompanyStatus.isHidden = true
        //autocomplete
        self.tfCompanyStatusAutoText.theme.cellHeight = 40
        self.tfCompanyStatusAutoText.maxResultsListHeight = 300
        self.tfCompanyStatusAutoText.startVisible = true
        self.tfCompanyStatusAutoText.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfCompanyStatusAutoText.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfCompanyStatusAutoText.theme.bgColor = UIColor.groupTableViewBackground
        self.tfCompanyStatusAutoText.theme.separatorColor = UIColor.lightGray
        //let v = CommonDataCConstants.some
        self.tfCompanyStatusAutoText.filterStrings(Constants.companyStatusList)
        self.tfCompanyStatusAutoText.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.selectedStatusIndex = itemPosition + 1
            self.tfCompanyStatusAutoText.text = item.title
            self.tfCompanyStatusAutoText.backgroundColor = UIColor.white
            if item.title == "Other" {
                self.tfCompanyStatus.isHidden = false
            } else {
                self.tfCompanyStatus.isHidden = true
                self.tfCompanyStatus.text = Constants.BLANK
            }
        }
        
        tfCompanyName.setMaxLength(maxLength: 60)
        tfCompanyTelNo.setMaxLength(maxLength: 11)
        tfDepartment.setMaxLength(maxLength: 60)
        tfPosition.setMaxLength(maxLength: 60)
        tfAM?.setMaxLength(maxLength: 2)
        tfPM?.setMaxLength(maxLength: 2)
        tfYear?.setMaxLength(maxLength: 2)
        tfMonth?.setMaxLength(maxLength: 2)
        tfCompanyStatus.setMaxLength(maxLength: 50)
        tfMonthlyBasicIncome.setMaxLength(maxLength: 12)
        tfOtherIncome.setMaxLength(maxLength: 12)
        tfTotalIncome.setMaxLength(maxLength: 12)
        tfBldNO.setMaxLength(maxLength: 20)
        tfRoomNo.setMaxLength(maxLength: 20)
        tfFloor.setMaxLength(maxLength: 20)
        tfQrt.setMaxLength(maxLength: 100)
        tfStreet.setMaxLength(maxLength: 100)
        tfTsp.setMaxLength(maxLength: 100)
        
        tfCompanyName.autocapitalizationType = .allCharacters
        tfCompanyStatus.autocapitalizationType = .allCharacters
        tfDepartment.autocapitalizationType = .allCharacters
        tfPosition.autocapitalizationType = .allCharacters
        tfBldNO.autocapitalizationType = .allCharacters
        tfRoomNo.autocapitalizationType = .allCharacters
        tfFloor.autocapitalizationType = .allCharacters
        tfQrt.autocapitalizationType = .allCharacters
        tfStreet.autocapitalizationType = .allCharacters
        
        // Year of Serice
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        yearList = [Int]()
        for y in 0...99 {
            yearList.append(y)
        }
        
        monthList = [Int]()
        for m in 0...11 {
            monthList.append(m)
        }
        self.numberPicker = UIPickerView()
        self.numberPicker.dataSource = self
        self.numberPicker.delegate = self
        
        self.tfYear.delegate = self
        self.tfYear.inputView = numberPicker
        self.tfYear.text = "\(yearList[0])"
        
        self.tfMonth.delegate = self
        self.tfMonth.inputView = numberPicker
        self.tfMonth.text = "\(monthList[0])"
        
        
        self.updateViews()
        self.setupTownshipCityData()
        self.setupAMTimepicker()
        self.setupPMTimepicker()
        
        self.tfMonthlyBasicIncome.addTarget(self, action: #selector(basicIncomeDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.tfOtherIncome.addTarget(self, action: #selector(otherIncomeDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(markOccupationDataLastState), name: NSNotification.Name(rawValue: "markOccupationDataLastState"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showOccupationForm(notification:)), name: NSNotification.Name(rawValue: "showOccupationForm"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorLabelOccupation), name: NSNotification.Name(rawValue: "showErrorLabel"), object: nil)
        
        // mendatory fields background setting
        self.tfCompanyName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfStreet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfTsp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyTelNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfAM.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfPM.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfDepartment.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfPosition.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfYear.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMonth.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyStatusAutoText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfCompanyStatus.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tfMonthlyBasicIncome.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    @objc func runTimedCode() {
                   multiLoginGet()
               // print("kms\(logoutTimer)")
               }
       func multiLoginGet(){
                  let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
               var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
              MultiLoginModel.init().makeMultiLogin(customerId: customerId
                      , loginDeviceId: deviceID, success: { (results) in
                      print("kaungmyat san multi >>>  \(results)")
                      
                      if results.data.logoutFlag == true {
                          print("success stage logout")
                          // create the alert
                                 let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)

                                 // add an action (button)
                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                              self.logoutTimer?.invalidate()
                              let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                              navigationVC.modalPresentationStyle = .overFullScreen
                              self.present(navigationVC, animated: true, completion:nil)
                              
                          }))

                                 // show the alert
                                 self.present(alert, animated: true, completion: nil)
                          
                          
                      }
                  }) { (error) in
                      print(error)
                  }
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
            svOccupationData.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
            
        } else {
            svOccupationData.contentInset = UIEdgeInsets.zero
        }
        svOccupationData.scrollIndicatorInsets = svOccupationData.contentInset
    }

    @objc func basicIncomeDidChange(_ textField: UITextField) {
        print("textfield did change")
        
        let basicString = "\(textField.text ?? "0")"
        let basicInt = Int(basicString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        let otherString = "\(self.tfOtherIncome.text ?? "0")"
        let otherInt = Int(otherString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        let total = basicInt + otherInt
        self.lbTotalIncomeTxt.text = Int(total).thousandsFormat
        self.tfMonthlyBasicIncome.text = basicInt.thousandsFormat
        
    }
    
    @objc func otherIncomeDidChange(_ textField: UITextField) {
        print("textfield did change")
        
        let basicString = "\(self.tfMonthlyBasicIncome.text ?? "0")"
        let basicInt = Int(basicString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        let otherString = "\(textField.text ?? "0")"
        let otherInt = Int(otherString.replacingOccurrences(of: ",", with: "")) ?? 0
        
        let total = basicInt + otherInt
        self.lbTotalIncomeTxt.text = Int(total).thousandsFormat
        self.tfOtherIncome.text = otherInt.thousandsFormat
    }
    
    @IBAction func onClickCityBtn(_ sender: UIButton) {
        self.tfAM?.resignFirstResponder()
        self.tfPM.resignFirstResponder()
        openCitySelectionPopUp()
    }
    
    func openCitySelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                
                if self.allTownNameList.count >= 0 {
                    self.tfTsp.filterStrings(self.allTownNameList)
                    self.tfTsp.text = Constants.BLANK
                    self.tfTsp.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.tfCity
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: cityNameList, action: { (value)  in
                self.btnCity.setTitle(value, for: UIControl.State.normal)
                self.selectedCityID = self.cityTownshipModel.cityNameIdDic![value]
                self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                
                if self.allTownNameList.count >= 0 {
                    self.tfTsp.filterStrings(self.allTownNameList)
                    self.tfTsp.text = Constants.BLANK
                    self.tfTsp.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
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
        self.tfTsp.theme.cellHeight = 40
        self.tfTsp.maxResultsListHeight = 300
        self.tfTsp.startVisible = true
        self.tfTsp.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfTsp.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfTsp.theme.bgColor = UIColor.groupTableViewBackground
        self.tfTsp.theme.separatorColor = UIColor.lightGray
        self.tfTsp.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfTsp.text = item.title
            self.tfTsp.backgroundColor = UIColor.white
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
            self.btnCity.setTitle(self.cityNameList[0], for: UIControl.State.normal)
            self.allTownNameList = model.cityIdTownListDic![self.selectedCityID!]!
            self.tfTsp.filterStrings(self.allTownNameList)
            
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
      
    func setupAMTimepicker() {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        self.tfAM?.inputView = datePickerView
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let min = timeFormatter.date(from: "00:00")
        let max = timeFormatter.date(from: "11:59")
        datePickerView.minimumDate = min
        datePickerView.maximumDate = max

        datePickerView.addTarget(self, action: #selector(timePickerFromValueChangedAM), for: UIControl.Event.valueChanged)
        
        self.tfAM?.delegate = self
    }
    
    func setupPMTimepicker() {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        self.tfPM?.inputView = datePickerView
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let min = timeFormatter.date(from: "12:00")
        let max = timeFormatter.date(from: "23:59")
        datePickerView.minimumDate = min
        datePickerView.maximumDate = max

        datePickerView.addTarget(self, action: #selector(timePickerFromValueChangedPM), for: UIControl.Event.valueChanged)
        
        self.tfPM?.delegate = self
    }
    
    @objc func timePickerFromValueChangedAM(sender:UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeStyle = .short
        self.tfAM.text = String(timeFormatter.string(from: sender.date).split(separator: " ")[0])
        //self.view.endEditing(true)
    }
    @objc func timePickerFromValueChangedPM(sender:UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeStyle = .short
        self.tfPM.text = String(timeFormatter.string(from: sender.date).split(separator: " ")[0])
        //self.view.endEditing(true)
    }
    
    @objc func showErrorLabelOccupation() {
        _ = self.isErrorExist()
    }
    
    @objc func showOccupationForm(notification: Notification) {
        if let dict = notification.userInfo as? Dictionary<String, Any> {
            print("showOccupationForm \(dict)")
            if let sVar = dict["data"] as? OccupationDataRequest {
                self.fillThisForm(data: sVar)
            }
        }
    }
    
    func fillThisForm(data: OccupationDataRequest) {
        self.tfCompanyName.text = data.companyName
        self.textFieldDidChange(self.tfCompanyName)
        
//        self.tvCompanuAddress.text = data.companyAddress
        self.tfCompanyTelNo.text = data.companyTelNo
        self.textFieldDidChange(self.tfCompanyTelNo)
        
        self.tfDepartment.text = data.department
        self.textFieldDidChange(self.tfDepartment)
        
        self.tfPosition.text = data.position
        self.textFieldDidChange(self.tfPosition)
        
        if data.yearOfServiceYear == 0 {
            self.tfYear.text = "0"
        } else {
            self.tfYear.text = "\(data.yearOfServiceYear)"
        }
        self.textFieldDidChange(self.tfYear)
        
        if data.yearOfServiceMonth == 0 {
            self.tfMonth.text = "0"
        } else {
            self.tfMonth.text = "\(data.yearOfServiceMonth)"
        }
        self.textFieldDidChange(self.tfMonth)
        
        self.selectedStatusIndex = data.companyStatus
        //self.btnCompanyStatus.setTitle("\(self.companyStatusList[self.selectedStatusIndex - 1])", for: .normal)
        let status = self.lblStatusError.text ?? Constants.BLANK
        if status == Constants.BLANK {
            self.tfCompanyStatusAutoText.text = Constants.companyStatusList[self.selectedStatusIndex - 1]
        }
        self.textFieldDidChange(self.tfCompanyStatusAutoText)
        
        self.tfCompanyStatus.text = data.companyStatusOther
        self.textFieldDidChange(self.tfCompanyStatus)
        
        if self.selectedStatusIndex == Constants.companyStatusList.count {
            self.tfCompanyStatus.isHidden = false
        } else {
            self.tfCompanyStatus.isHidden = true
        }
        
        if data.monthlyBasicIncome == 0.0 {
            self.tfMonthlyBasicIncome.text = ""
        } else {
            let val = Int(Double(data.monthlyBasicIncome))
            self.tfMonthlyBasicIncome.text = "\(val.thousandsFormat)"
        }
        self.textFieldDidChange(self.tfMonthlyBasicIncome)
        
        if data.otherIncome == 0.0 {
            self.tfOtherIncome.text = ""
        } else {
            let val = Int(Double(data.otherIncome))
            self.tfOtherIncome.text = "\(val.thousandsFormat)"
        }
        if data.totalIncome == 0.0 {
            //self.tfTotalIncome.text = ""
            self.lbTotalIncomeTxt.text = ""
        } else {
            let val = Int(Double(data.totalIncome))
            self.lbTotalIncomeTxt.text = "\(val.thousandsFormat)"
        }
        
        let dobtemp = data.salaryDay
        
        //        if dobtemp != nil {
        self.tfSalaryDate.text  = "\(dobtemp)"
        //        }
        //        else {
        //            self.tfSalaryDate.text  = data.salaryDay
        //        }
        
        self.tfAM.text = data.contactTimeFrom
        self.textFieldDidChange(self.tfAM)
        
        self.tfPM.text = data.contactTimeTo
        self.textFieldDidChange(self.tfPM)
        
        self.tfBldNO.text = data.companyAddressBuildingNo
        self.tfRoomNo.text = data.companyAddressRoomNo
        self.tfFloor.text = data.companyAddressFloor
        self.tfStreet.text = data.companyAddressStreet
        self.textFieldDidChange(self.tfStreet)
        
        self.tfQrt.text = data.companyAddressQtr
        
        if data.companyAddressCity != 0 {
            for cityName in self.cityTownshipModel.cityNameIdDic!.keys{
                let id = self.cityTownshipModel.cityNameIdDic![cityName]
                if id == data.companyAddressCity {
                    self.btnCity.setTitle(cityName, for: UIControl.State.normal)
                    self.selectedCityID = id
                    break
                }
            }
        }
        
        if data.companyAddressTownship != 0{
            for townName in self.cityTownshipModel.townNameIdDic!.keys{
                let id = self.cityTownshipModel.townNameIdDic![townName]
                if id == data.companyAddressTownship {
                    self.tfTsp.text = townName
                    self.allTownNameList = self.cityTownshipModel.cityIdTownListDic![self.selectedCityID!]!
                    self.tfTsp.filterStrings(self.allTownNameList)
                    self.selectedTownshipID = id
                    break
                }
            }
        }
        self.textFieldDidChange(self.tfTsp)
        
    }
    
    @objc func markOccupationDataLastState() {
        
        self.markOccupationErrorCount()
        self.tfTsp.hideResultsList()
        self.tfCompanyStatusAutoText.hideResultsList()
        
        var yearService = 0
        if self.tfYear.text != "" {
            if let intString = Int(self.tfYear.text!) {
                yearService = intString
            }
        }
        
        var monthService = 0
        if self.tfMonth.text != "" {
            if let intString = Int(self.tfMonth.text!) {
                monthService = intString
            }
        }
        
        var monthlyIncome = 0.0
        if self.tfMonthlyBasicIncome.text != ""{
            if let intString = Double(self.tfMonthlyBasicIncome.text!.replacingOccurrences(of: ",", with: "")) {
                monthlyIncome = intString
            }
        }
        
        var otherIncome = 0.0
        if self.tfOtherIncome.text != "" {
            if let intString = Double(self.tfOtherIncome.text!.replacingOccurrences(of: ",", with: "")) {
                otherIncome = intString
            }
        }
        
        var totalIncome = 0.0
        if self.lbTotalIncomeTxt.text != "" {
            if let intString = Double(self.lbTotalIncomeTxt.text!.replacingOccurrences(of: ",", with: "")) {
                totalIncome = intString
            }
        }
        
        if self.tfCompanyName == nil {
            return
        }
        
        if self.tfStreet == nil {
            return
        }
        
        if self.tfCompanyTelNo == nil {
            return
        }
        
        //
        if self.tfPosition == nil {
            return
        }
        //
        //        if self.tfAM == nil {
        //            return
        //        }
        //
        //        if self.tfPM == nil {
        //            return
        //        }
        
        if self.tfDepartment == nil {
            return
        }
        
        if self.tfCompanyStatus == nil {
            return
        }
        
        if self.tfSalaryDate == nil {
            return
        }
        
        let appData = OccupationDataRequest(daApplicantCompanyInfoId: occupationFormID,companyName: self.tfCompanyName.text?.uppercased() ?? "", companyAddress: "", companyTelNo: self.tfCompanyTelNo.text ?? "", contactTimeFrom: self.tfAM.text ?? "", contactTimeTo: self.tfPM.text ?? "", department: self.tfDepartment.text?.uppercased() ?? "", position: self.tfPosition.text?.uppercased() ?? "", yearOfServiceYear: yearService, yearOfServiceMonth: monthService, companyStatus: self.selectedStatusIndex, companyStatusOther: self.tfCompanyStatus.text?.uppercased() ?? "", monthlyBasicIncome: monthlyIncome, otherIncome: otherIncome, totalIncome: totalIncome, salaryDay: Int(self.tfSalaryDate.text ?? "0") ?? 0, companyAddressBuildingNo: "\(self.tfBldNO.text?.uppercased() ?? "")", companyAddressRoomNo: "\(self.tfRoomNo.text?.uppercased() ?? "")", companyAddressFloor: "\(self.tfFloor.text?.uppercased() ?? "")", companyAddressStreet: "\(self.tfStreet.text?.uppercased() ?? "")", companyAddressQtr: "\(self.tfQrt.text?.uppercased() ?? "")", companyAddressTownship: self.selectedTownshipID ?? 0, companyAddressCity: self.selectedCityID ?? 0)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetOccupationData"), object: self, userInfo: ["appData": appData])
        self.view.endEditing(true)
    }
    
    @objc override func updateViews() {
        super.updateViews()
        
        self.lblCompanyName.text = "occupation_company_name".localized
        self.lblCompanyAddress.text = "occupation_company_address".localized
        self.lblCompanyTelNo.text = "occupation_company_telno".localized
        self.lblContactTime.text = "occupation_company_contact_time".localized
        self.lblDepartment.text = "occupation_company_department".localized
        self.lblPosition.text = "occupation_company_position".localized
        self.lblYearService.text = "occupation_company_year_service".localized
        self.lblCompanyStatus.text = "occupation_company_status".localized
        self.lblMonthlyBasicIncome.text = "occupation_monthly_income".localized
        self.lblOtherIncome.text = "occupation_other_income".localized
        self.lblTotalIncome.text = "occupation_total_income".localized
        self.lblSalaryDate.text = "occupation_salary_date".localized
        
        self.lblBldNo.text = "da.buildno".localized
        self.lblFloor.text = "da.floor".localized
        self.lblRoomNo.text = "da.roomno".localized
        self.lblStreet.text = "da.street".localized
        self.lblQrt.text = "da.quarter".localized
        self.lblTsp.text = "da.township".localized
        self.lblCity.text = "da.city".localized
        
        self.lblCompanyNameError.text = self.companyNameMesgLocale?.localized
        self.lblAddressError.text = self.companyAddressMesgLocale?.localized
        self.lblTelNoError.text = self.companyTelNoMesgLocale?.localized
        self.lblContactTimeError.text = self.contactTimeMesgLocale?.localized
        self.lblDepartmentError.text = self.departmentMesgLocale?.localized
        self.lblPositionError.text = self.positionMesgLocale?.localized
        self.lblYearServiceError.text = self.yearServiceMesgLocale?.localized
        self.lblStatusError.text = self.companyStatusMesgLocale?.localized
        self.lblMonthlyIncomeError.text = self.monthlyBasicIncomeMesgLocale?.localized
        self.lblOtherIncomeError.text = self.otherIncomeMesgLocale?.localized
        //self.lblTotalIncomeError.text = self.totalIncomeMesgLocale?.localized
        self.lblSalaryDateError.text = self.salaryDateMesgLocale?.localized
        
    }
    
    func setupDob() {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        //components.year = -10
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        datePickerView.maximumDate = maxDate
        
        tfSalaryDate?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
        
    }
    
    
    @objc func dobDatePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tfSalaryDate?.text = dateFormatter.string(from: sender.date)
        
    }
    
    func openCompanyStatusPopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: Constants.companyStatusList, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.btnCompanyStatus.setTitle(value, for: .normal)
                self.selectedStatusIndex = Constants.companyStatusList.firstIndex(of: value)! + 1
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: Constants.companyStatusList, action: { (value)  in
                //                let selectedType = self.typeResidence[-1]
                self.btnCompanyStatus.setTitle(value, for: .normal)
                self.selectedStatusIndex = Constants.companyStatusList.firstIndex(of: value)! + 1
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openSalaryDayPopup() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: daysArray, action: { (value)  in
                //                let selectedType = self.typeResidence[Int(value)!-1]
                self.tfSalaryDate.text = value
                
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: daysArray, action: { (value)  in
                //                let selectedType = self.typeResidence[-1]
                self.tfSalaryDate.text = value
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func doSelectSalaryDay(_ sender: Any) {
        self.openSalaryDayPopup()
    }
    
    
    @IBAction func doSelectCompanyStatus(_ sender: Any) {
        self.openCompanyStatusPopup()
    }
    
    @IBAction func doSaveData(_ sender: Any) {
        
        self.markOccupationDataLastState()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveDA"), object: nil)
        //        if isErrorExist() {
        //            return
        //        }
        
    }
    
    func isErrorExist() -> Bool {
        
        var isError = false
        // not to overwrite error message
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfCompanyName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfCompanyName?.text = Constants.BLANK
            self.lblCompanyNameError.text = Messages.COMPANY_NAME_EMPTY_ERROR.localized
            self.companyNameMesgLocale = Messages.COMPANY_NAME_EMPTY_ERROR
            isError = true
        }
//       else if !Utils.isNameValidate(name: (self.tfCompanyName!.text)!){
//
//            self.lblCompanyNameError.text = Messages.NAME_REG_FORMAT_ERROR.localized
//            self.companyNameMesgLocale = Messages.NAME_REG_FORMAT_ERROR
//            isError = true
//
//        }
        else {
            self.companyNameMesgLocale = Constants.BLANK
            self.lblCompanyName.text = Constants.BLANK
        }
        
        // Company address
        if self.tfStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfStreet?.text = Constants.BLANK
            self.lblAddressError.text = Messages.COMPANY_ADDRESS_EMPTY_ERROR.localized
            self.companyAddressMesgLocale = Messages.COMPANY_ADDRESS_EMPTY_ERROR
            isError = true
            
        } else {
            self.companyAddressMesgLocale = Constants.BLANK
            self.lblAddressError.text = Constants.BLANK
        }
        
        if self.tfTsp?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfTsp?.text = Constants.BLANK
            self.lblAddressError.text = Messages.COMPANY_ADDRESS_EMPTY_ERROR.localized
            self.companyAddressMesgLocale = Messages.COMPANY_ADDRESS_EMPTY_ERROR
            isError = true
            
        } else if !self.allTownNameList.contains((self.tfTsp?.text)!) {
            self.tfTsp?.text = Constants.BLANK
            self.lblAddressError.text = Messages.ADDRESS_INVALID_ERROR.localized
            self.companyAddressMesgLocale = Messages.ADDRESS_INVALID_ERROR
            isError = true
                   
        } else {
            self.lblAddressError.text = Constants.BLANK
            self.companyAddressMesgLocale = Constants.BLANK
        }
        
        // Department
        if self.tfDepartment?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfDepartment?.text = Constants.BLANK
            self.lblDepartmentError.text = Messages.DEPARTMENT_EMPTY_ERROR.localized
            self.departmentMesgLocale = Messages.DEPARTMENT_EMPTY_ERROR
            isError = true
            
        } else {
            self.departmentMesgLocale = Constants.BLANK
            self.lblDepartmentError.text = Constants.BLANK
        }
        
        //Position
        if self.tfPosition?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfPosition?.text = Constants.BLANK
            self.lblPositionError.text = Messages.POSITION_EMPTY_ERROR.localized
            self.positionMesgLocale = Messages.POSITION_EMPTY_ERROR
            isError = true
            
        } else {
            self.positionMesgLocale = Constants.BLANK
            self.lblPositionError.text = Constants.BLANK
        }
        
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfCompanyTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfCompanyTelNo?.text = Constants.BLANK
            self.lblTelNoError.text = Messages.TEL_NO_EMPTY_ERROR.localized
            self.companyTelNoMesgLocale = Messages.TEL_NO_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isNumberValidate(phoneNo: (self.tfCompanyTelNo?.text)!){
            // validate phone no format
            self.lblTelNoError.text = Messages.PHONE_COMPANY_LENGTH_ERROR.localized
            self.companyTelNoMesgLocale = Messages.PHONE_COMPANY_LENGTH_ERROR
            isError = true
            
        } else {
            self.companyTelNoMesgLocale = Constants.BLANK
            self.lblTelNoError.text = Constants.BLANK
        }
        
        //YEAR of Stay
        if self.tfYear?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfYear?.text = Constants.BLANK
            self.lblYearServiceError.text = Messages.YEAR_SERVICE_EMPTY_ERROR.localized
            self.yearServiceMesgLocale = Messages.YEAR_SERVICE_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblYearServiceError.text = Constants.BLANK
            self.yearServiceMesgLocale = Constants.BLANK
        }
        
        if self.tfMonth?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            self.tfMonth?.text = Constants.BLANK
            self.lblYearServiceError.text = Messages.YEAR_SERVICE_EMPTY_ERROR.localized
            self.yearServiceMesgLocale = Messages.YEAR_SERVICE_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblYearServiceError.text = Constants.BLANK
            self.yearServiceMesgLocale = Constants.BLANK
        }
        
        //Contact Time
        //        if self.tfAM?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        //            self.tfAM?.text = Constants.BLANK
        //            self.lblContactTimeError.text = Messages.CONTACT_TIME_EMPTY_ERROR.localized
        //            self.contactTimeMesgLocale = Messages.CONTACT_TIME_EMPTY_ERROR
        //            isError = true
        //
        //        } else {
        //            self.lblContactTimeError.text = Constants.BLANK
        //            self.contactTimeMesgLocale = Constants.BLANK
        //        }
        
        //        if self.tfPM?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        //            self.tfPM?.text = Constants.BLANK
        //            self.lblContactTimeError.text = Messages.CONTACT_TIME_EMPTY_ERROR.localized
        //            self.contactTimeMesgLocale = Messages.CONTACT_TIME_EMPTY_ERROR
        //            isError = true
        //
        //        } else {
        //            self.lblContactTimeError.text = Constants.BLANK
        //            self.contactTimeMesgLocale = Constants.BLANK
        //        }
        
        if self.tfCompanyStatusAutoText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lblStatusError.text = Messages.COMPANY_STATUS_EMPTY_ERROR.localized
            self.companyStatusMesgLocale = Messages.COMPANY_STATUS_EMPTY_ERROR
            isError = true
            
        } else if !Constants.companyStatusList.contains(self.tfCompanyStatusAutoText.text!){
            self.lblStatusError.text = Messages.COMPANY_STATUS_INVALID_ERROR.localized
            self.companyStatusMesgLocale = Messages.COMPANY_STATUS_INVALID_ERROR
            isError = true
            
        } else if self.tfCompanyStatusAutoText.text == "Other" {
            if self.tfCompanyStatus?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                self.tfCompanyStatus?.text = Constants.BLANK
                self.lblStatusError.text = Messages.COMPANY_STATUS_EMPTY_ERROR.localized
                self.companyStatusMesgLocale = Messages.COMPANY_STATUS_EMPTY_ERROR
                isError = true
                
            } else {
                self.lblStatusError.text = Constants.BLANK
                self.companyStatusMesgLocale = Constants.BLANK
            }
        } else {
            self.lblStatusError.text = Constants.BLANK
            self.companyStatusMesgLocale = Constants.BLANK
        }
        
        // MONTHLY BASIC INCOME
        if self.tfMonthlyBasicIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true && (self.tfMonthlyBasicIncome!.text)! == "0" {
            self.tfMonthlyBasicIncome?.text = Constants.BLANK
            self.lblMonthlyIncomeError.text = Messages.MONTHLY_INCOME_EMPTY_ERROR.localized
            self.monthlyBasicIncomeMesgLocale = Messages.MONTHLY_INCOME_EMPTY_ERROR
            isError = true
            
        } else {
            self.monthlyBasicIncomeMesgLocale = Constants.BLANK
            self.lblMonthlyIncomeError.text = Constants.BLANK
        }
        
        // OTHER INCOME
//        if self.tfOtherIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            self.tfOtherIncome?.text = Constants.BLANK
//            self.lblOtherIncomeError.text = Messages.MONTHLY_INCOME_EMPTY_ERROR.localized
//            self.otherIncomeMesgLocale = Messages.MONTHLY_INCOME_EMPTY_ERROR
//            isError = true
//            
//        } else {
//            self.otherIncomeMesgLocale = Constants.BLANK
//            self.lblOtherIncomeError.text = Constants.BLANK
//        }
        
        // TOTAL INCOME
//        if self.tfTotalIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            self.tfTotalIncome?.text = Constants.BLANK
//            self.lblTotalIncomeError.text = Messages.TOTAL_INCOME_EMPTY_ERROR.localized
//            self.totalIncomeMesgLocale = Messages.TOTAL_INCOME_EMPTY_ERROR
//            isError = true
//
//        } else {
//            self.totalIncomeMesgLocale = Constants.BLANK
//            self.lblTotalIncomeError.text = Constants.BLANK
//        }
        
        // Validate Date of Birth [dd-MM-yyyy]
        if self.tfSalaryDate?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfSalaryDate?.text = Constants.BLANK
            self.lblSalaryDateError.text = Messages.DOB_EMPTY_ERROR.localized
            self.salaryDateMesgLocale = Messages.DOB_EMPTY_ERROR
            isError = true
            
        } else {
            self.salaryDateMesgLocale = Constants.BLANK
            self.lblSalaryDateError.text = Constants.BLANK
        }
        
        
        return isError
    } //End of isErrorExit
    
    func markOccupationErrorCount() {
        
        var errorcount = 0
        // not to overwrite error message
        
        // Validate Name [a-zA-Z0-9 ]
        if self.tfCompanyName?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            
            errorcount += 1
            
        }
//        else if !Utils.isNameValidate(name: (self.tfCompanyName!.text)!){
//            
//            errorcount += 1
//            
//        }
        
        // Company address
        if self.tfStreet?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if self.tfTsp.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        } else if !self.allTownNameList.contains((self.tfTsp?.text)!) {
            errorcount += 1
        }
        
        // Department
        if self.tfDepartment?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
        }
        
        //Position
        if self.tfPosition?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
        }
        
        //Validate Phone No. [09[0-9]{7,9}]
        if self.tfCompanyTelNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } else if !Utils.isNumberValidate(phoneNo: (self.tfCompanyTelNo?.text)!){
            // validate phone no format
            errorcount += 1
            
        }
        
        //YEAR of Stay
        if self.tfYear?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        }
        
        if self.tfMonth?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorcount += 1
            
        }
        
        //Contact Time
        //        if self.tfAM?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        //             errorcount += 1
        //
        //        }
        //
        //        if self.tfPM?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
        //             errorcount += 1
        //
        //        }
        let comstatus = self.tfCompanyStatusAutoText.text ?? ""
        if comstatus.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorcount += 1
            
        } else if !Constants.companyStatusList.contains(comstatus){
            errorcount += 1
            
        } else if comstatus == "Other" {
            if self.tfCompanyStatus?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                errorcount += 1
                
            }
        }
        
        // MONTHLY BASIC INCOME
        if self.tfMonthlyBasicIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true  || (self.tfMonthlyBasicIncome.text)! == "0"{
            errorcount += 1
            
        }
        
//        // OTHER INCOME
//        if self.tfOtherIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            errorcount += 1
//
//        }
        
//        // TOTAL INCOME
//        if self.tfTotalIncome?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//            errorcount += 1
//
//        }
        
        // Validate Date of Birth [dd-MM-yyyy]
        if self.tfSalaryDate?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            errorcount += 1
            
        } 
        
        UserDefaults.standard.set(errorcount, forKey: Constants.OCCUPATION_DATA_ERROR_COUNT)
        
    } //End of markErrorCount
    
    @IBAction func tapOnNextOccu(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnNext"), object: nil , userInfo: ["index" : 2])
    }
    
}

extension OccupationDataVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tfTsp.hideResultsList()
        self.tfCompanyStatusAutoText.hideResultsList()
    }
}
extension OccupationDataVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 100
    }
}

extension OccupationDataVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.numberPicker?.reloadAllComponents()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if tfYear.isFirstResponder {
            return yearList.count
        } else if tfMonth.isFirstResponder {
            return monthList.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if tfYear.isFirstResponder {
            return "\(yearList[row])"
        } else if tfMonth.isFirstResponder {
            return "\(monthList[row])"
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if tfYear.isFirstResponder {
            tfYear.text = "\(yearList[row])"
            
        } else if tfMonth.isFirstResponder {
            tfMonth.text = "\(monthList[row])"
            
        }
        
        self.view.endEditing(true)
    }
    
}
