//
//  ApplicationListVC.swift
//  AEONVCS
//
//  Created by mac on 11/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftyJSON

class ApplicationListVC: BaseUIViewController {
    
   
    @IBOutlet weak var clearBtnLable: UIButton!
    @IBOutlet weak var tfAppNo: SkyFloatingLabelTextField!
    @IBOutlet weak var tfAppDate: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnStatus: UIButton!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var tbApplicationList: UITableView!
    
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var agreementNoLabel: UILabel!
    @IBOutlet weak var approvedAmountLabel: UILabel!
    @IBOutlet weak var approveTermLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myanmarLabel: UIImageView!
    @IBOutlet weak var englishLabel: UIImageView!
    @IBOutlet weak var backBtnLabel: UIImageView!
    var appDateString = ""
    var loanCategory = ["Select Category", "Mobile Loan", "Nonmobile Loan"]
    var loanCategoryIndex = ["0", "1", "2"]
    
    var appStatus = ["All", "New" , "Index", "Upload Finished", "Document Followup Waiting", "Document Followup updated", "Document Followup Checked", "Cancel", "Reject", "Approve", "Purchase Cancel", "Purchase Initial", "Purchase Confirm waiting", "Purchase Confirmed", "Purchase Completed", "Settlement Upload Finish", "Settlement Pending"]
      var appStatusIndex = ["0", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17"]
    
    var selectedCategory = 0
    var selectedStatus = 0
    
    var tokenInfo: TokenData?
    
    var myApplicationList = [DAInquiryResponse]()
    
    var appListWithSection = Dictionary<String, [DAInquiryResponse]>()
    
    // type list
    var mobileList = [DAInquiryResponse]()
    var nonMobileList = [DAInquiryResponse]()
    
    //Register successful
    var isRegisterSuccess = false
    var logoutTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.phoneNoLabel.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
                                             self.nameLabel.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
                                   self.typeLabel.text = "Lv.2 : Login user"
              self.myanmarLabel.isUserInteractionEnabled = true
              self.englishLabel.isUserInteractionEnabled = true
               self.backBtnLabel.isUserInteractionEnabled = true
              self.myanmarLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
              self.englishLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
               self.backBtnLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        // Do any additional setup after loading the view.
        
        self.setupView()
        self.updateViews()
        self.setupDob()
        
       // self.lblCategory.text = self.loanCategory[self.selectedCategory]
        //self.lblStatus.text = self.appStatus[self.selectedStatus]
        
        if self.isRegisterSuccess {
            self.doSearchApplicationListAPI()
            self.isRegisterSuccess = false
        }
    }
    
    override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
       self.title = "aeonservice.da.list.title".localized
        self.btnSearch.setTitle("da.search".localized, for: .normal)
        self.clearBtnLable.setTitle("da.clear".localized, for: .normal)
        self.tbApplicationList.reloadData()
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
//                           let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
//                           navigationVC.modalPresentationStyle = .overFullScreen
//                           self.present(navigationVC, animated: true, completion:nil)
                        self.performSegue(withIdentifier: "mainsegue", sender: nil)
                           
                       }))

                              // show the alert
                              self.present(alert, animated: true, completion: nil)
                       
                       
                   }
               }) { (error) in
                   print(error)
               }
           }
    @objc func onTapMMLocale() {
             print("click")
             super.NewupdateLocale(flag: 1)
             updateViews()
         }
         @objc func onTapEngLocale() {
             print("click")
             super.NewupdateLocale(flag: 2)
             updateViews()
         }
       @objc func onTapBack() {
           print("click")
           self.dismiss(animated: true, completion: nil)
       }
    @IBAction func doGoBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doChangeLanguage(_ sender: Any) {
        self.updateLocale()
        self.updateViews()
    }
    
    @IBAction func doDetailClick(_ sender: UIButton) {
    }
    
    @IBAction func ClearBtnPress(_ sender: UIButton) {
        tfAppNo.text = ""
        tfAppDate.text = ""
    }
    func setupView() {
        self.tbApplicationList.delegate = self
        self.tbApplicationList.dataSource = self
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
           
           self.tfAppDate?.inputView = datePickerView
           datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
           
           self.tfAppDate?.delegate = self
       }
       
       
       @objc func dobDatePickerFromValueChanged(sender:UIDatePicker) {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           self.tfAppDate?.text = dateFormatter.string(from: sender.date)
           self.appDateString = dateFormatter.string(from: sender.date)
           
       }
    
    func openLoanCategoryPopup() {
            if UIDevice.current.userInterfaceIdiom == .pad {
                let action = UIAlertController.actionSheetWithItems(items: loanCategory, action: { (value)  in
    //                let selectedType = self.typeResidence[Int(value)!-1]
                   self.lblCategory.text = value
                    
                    self.selectedCategory = self.loanCategory.firstIndex(of: value)!
                    print(value)
                })
                action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                if let popoverPresentationController = action.popoverPresentationController {
                    popoverPresentationController.sourceView = self.view
                }
                //Present the controller
                self.present(action, animated: true, completion: nil)
                
            } else {
                
                let action = UIAlertController.actionSheetWithItems(items: loanCategory, action: { (value)  in
    //                let selectedType = self.typeResidence[-1]
                     self.lblCategory.text = value
                                       
                    self.selectedCategory = self.loanCategory.firstIndex(of: value)!
                    print(value)
                })
                action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                //Present the controller
                self.present(action, animated: true, completion: nil)
                
            }
        }
    
    func openAppStatusPopup() {
            if UIDevice.current.userInterfaceIdiom == .pad {
                let action = UIAlertController.actionSheetWithItems(items: appStatus, action: { (value)  in
    //                let selectedType = self.typeResidence[Int(value)!-1]
                   self.lblStatus.text = value
                    
                    self.selectedStatus = self.loanCategory.firstIndex(of: value)!
                    print(value)
                })
                action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                if let popoverPresentationController = action.popoverPresentationController {
                    popoverPresentationController.sourceView = self.view
                }
                //Present the controller
                self.present(action, animated: true, completion: nil)
                
            } else {
                
                let action = UIAlertController.actionSheetWithItems(items: appStatus, action: { (value)  in
    //                let selectedType = self.typeResidence[-1]
                     self.lblStatus.text = value
                     
                     self.selectedStatus = self .appStatus.firstIndex(of: value)!
                     print(value)
                })
                action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                //Present the controller
                self.present(action, animated: true, completion: nil)
                
            }
        }
    

    @IBAction func tappedOnLoanCategory(_ sender: Any) {
        self.openLoanCategoryPopup()
    }
    
    
    @IBAction func tappedOnAppStatus(_ sender: Any) {
        self.openAppStatusPopup()
    }
    
    func doSearchApplicationListAPI() {
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        let customerId = UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        let loantypeindex = self.loanCategoryIndex[self.selectedCategory]
        let statusindex = self.appStatusIndex[self.selectedStatus]
        
        let inquiryResquest = DAInquiryResquest(customerId: customerId!, daLoanTypeId: loantypeindex, applicationNo: self.tfAppNo.text ?? "", appliedDate: self.tfAppDate.text ?? "", status: statusindex, offset: "0", limit: "10")
        
        DAViewModel.init().doGetApplicationInquiryList(tokenInfo: tokenInfo!, mylistRequest: inquiryResquest, success: { (inquiryResponse) in
            
            self.myApplicationList = inquiryResponse
            var dicttemp = Dictionary<String, [DAInquiryResponse]>()
            
            self.mobileList =  self.myApplicationList.filter { $0.daLoanTypeId == 1 }
            
            if self.mobileList.count > 0 {
                dicttemp["Mobile Loan"] = self.mobileList
            }
            
            self.nonMobileList =  self.myApplicationList.filter { $0.daLoanTypeId == 2 }
            
            if self.nonMobileList.count > 0 {
                dicttemp["Nonmobile Loan"] = self.nonMobileList
            }
            
            self.appListWithSection = dicttemp
            print("\(self.appListWithSection.count)")
            self.tbApplicationList.reloadData()
            
        }) { (error) in
            print("error:: \(error)")
        }
    }
    
    @IBAction func doSearchApplicationList(_ sender: Any) {
        self.doSearchApplicationListAPI()
    }
    
    func doCancelYourApplication(applicationid: Int) {
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        DAViewModel.init().doCancelApplication(tokenInfo: tokenInfo!, inquiryAppId: "\(applicationid)", success: { (responseObj) in
            let alertController = UIAlertController(title: "\(responseObj.status ?? Constants.SUCCESS)", message: "\(responseObj.message ?? Messages.DA_SUCCESS_INFO.localized)", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                  //do cancel api
                self.doSearchApplicationListAPI()
            }))
            self.present(alertController, animated: true, completion: nil)
        }) { (error) in
            
        }
    }
    
}

extension ApplicationListVC : AttachmentEditedDelegate {
    func refreshAppList() {
        self.doSearchApplicationListAPI()
    }
    
}

extension ApplicationListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.appListWithSection.keys.count
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UILabel(frame: CGRect(x: 60, y: 0, width: 0, height: 0))
//        header.backgroundColor = UIColor(red: 183.0/255.0, green: 0.0, blue: 129.0/255.0, alpha: 1)
//
//        if self.appListWithSection.keys.count == 1{
//            if self.mobileList.count >= 1 {
//                header.text = "    Mobile Loan"
//            } else {
//                header.text = "    Nonmobile Loan"
//            }
//        } else {
//            if section == 0 {
//                header.text = "    Mobile Loan"
//            } else {
//                header.text = "    Nonmobile Loan"
//            }
//        }
//
//        header.textColor = .white
//        header.font = UIFont(name: "PyidaungsuBook-Bold", size: 20)
//        return header
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var arrayTemp = [DAInquiryResponse]()
        
        if self.appListWithSection.keys.count == 1{
            if self.mobileList.count >= 1 {
                arrayTemp = self.appListWithSection["Mobile Loan"]!
            } else if self.nonMobileList.count >= 1{
                arrayTemp = self.appListWithSection["Nonmobile Loan"]!
            }
        } else {
            if section == 0 {
                arrayTemp = self.appListWithSection["Mobile Loan"]!
                
            } else {
                arrayTemp = self.appListWithSection["Nonmobile Loan"]!
            }
        }
        return arrayTemp.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.APPLICATION_LIST_CELL, for: indexPath) as! cellApplicationList
               
               
//       cell.setData(newsInfoBean: self.newsList[indexPath.row])
        var sectionarray = [DAInquiryResponse]()
        if self.appListWithSection.keys.count == 1{
            if self.mobileList.count >= 1 {
                sectionarray = self.appListWithSection["Mobile Loan"]!
            } else {
                sectionarray = self.appListWithSection["Nonmobile Loan"]!
            }
        } else {
            if indexPath.section == 0 {
                sectionarray = self.appListWithSection["Mobile Loan"]!
            } else {
                sectionarray = self.appListWithSection["Nonmobile Loan"]!
            }
        }
        cell.delegate = self
        let currentobj = sectionarray[indexPath.row]
        cell.btnCancel.tag = currentobj.daApplicationInfoId ?? 0
        cell.btnPurchaseDetail.tag = currentobj.daApplicationInfoId ?? 0
        cell.btnAttachmentEdit.tag = currentobj.daApplicationInfoId ?? 0
        cell.btnDetail.tag = currentobj.daApplicationInfoId ?? 0
        
        cell.formActualStatus = currentobj.status ?? 0
        cell.setData(appForm: sectionarray[indexPath.row])
               
        return cell
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        var sectionarray = [DAInquiryResponse]()
//        if self.appListWithSection.keys.count == 1{
//            if self.mobileList.count == 1 {
//                sectionarray = self.appListWithSection["Mobile Loan"]!
//            } else {
//                sectionarray = self.appListWithSection["Nonmobile Loan"]!
//            }
//        } else {
//            if indexPath.section == 0 {
//                sectionarray = self.appListWithSection["Mobile Loan"]!
//            } else {
//                sectionarray = self.appListWithSection["Nonmobile Loan"]!
//            }
//        }
//
//        let currentobj = sectionarray[indexPath.row]
//
//        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DETAIL_VC) as! ApplicationDetailVC
//        popupVC.modalPresentationStyle = .overCurrentContext
//        popupVC.modalTransitionStyle = .crossDissolve
//        popupVC.inquiryAppID = currentobj.daApplicationInfoId ?? 0
//
//        let pVC = popupVC.popoverPresentationController
//        pVC?.permittedArrowDirections = .any
//
//
//
//        self.definesPresentationContext = true
//        //popupVC.delegate = self
//        self.present(popupVC, animated: true, completion: nil)
    }
    
}
//

extension ApplicationListVC: cellApplicationListDelegate {
    func showApplicationDetail(index: Int) {

            //let currentobj = sectionarray[indexPath.row]
            
            let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DETAIL_VC) as! ApplicationDetailVC
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            popupVC.inquiryAppID = index
            
            let pVC = popupVC.popoverPresentationController
            pVC?.permittedArrowDirections = .any
            self.definesPresentationContext = true
            //popupVC.delegate = self
            self.present(popupVC, animated: true, completion: nil)
        
    }
    
    func showPurchaseDetail(index: Int) {
        
        let filteredArray =  self.myApplicationList.filter { $0.daLoanTypeId == 1 }
        print(filteredArray)
        
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PURCHASE_DETAIL_VC) as! PurchaseDetailVC
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.inquiryAppID = index
        
        let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        self.definesPresentationContext = true
        //popupVC.Delegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    
    func showAttachmentDetail(index: Int) {
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.ATTACHMENT_EDIT_VC) as! AttachmentEditVC
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.inquiryAppID = index
        popupVC.editDelegate = self
        let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        
        self.definesPresentationContext = true
        
        self.present(popupVC, animated: true, completion: nil)
    }
    
    func showCancelDialog(index: Int) {
        let alertController = UIAlertController(title: "Are you sure you want to cancel this application?", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.CANCEL, style: UIAlertAction.Style.default, handler: { action in
              
        }))
        alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
              //do cancel api
            self.doCancelYourApplication(applicationid: index)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
