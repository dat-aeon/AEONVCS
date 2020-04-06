//
//  VerifyMemberViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import SearchTextField

class VerifyMemberViewController: BaseUIViewController {
    
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    @IBOutlet weak var svMemberRegisterVerify: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAgreementNo: UILabel!
    @IBOutlet weak var tfAgreementNo: UITextField?
    @IBOutlet weak var lbAgreeErrorMessage: UILabel!
    
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lbAgeNotification: UILabel!
    @IBOutlet weak var tfDob: UITextField?
    @IBOutlet weak var lbDobErrorMessage: UILabel!
    
    @IBOutlet weak var tfTownshipAutoText: SearchTextField!
    
    @IBOutlet weak var lblNrcNo: UILabel!
    @IBOutlet weak var vDivision: UIView!
    @IBOutlet weak var lblDivision: UILabel!
    //@IBOutlet weak var vTownship: UIView!
    //@IBOutlet weak var lblTownship: UILabel!
    @IBOutlet weak var vNrcType: UIView!
    @IBOutlet weak var lblNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField?
    @IBOutlet weak var lbNrcNoErrorMessage: UILabel!
    
    @IBOutlet weak var btnCallNow: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    @IBOutlet weak var lblNotify: UILabel!
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedTownshipList = [String]()
    
    var customerId : String! = ""
    var hotlinePhone: String!
    var tokenInfo: TokenData?
    var sessionInfo : SessionDataBean?
    
    // Error message language control
    var agreeMesgLocale:String?
    var dobMesgLocale : String?
    var nrcMesgLocale : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("Start VerifyMemberViewController :::::::::::::::")
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        self.lbAgreeErrorMessage.text = Constants.BLANK
        self.lbDobErrorMessage.text = Constants.BLANK
        self.lbNrcNoErrorMessage.text = Constants.BLANK
        
        // check network
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        
        //autocomplete
        self.tfTownshipAutoText.theme.cellHeight = 40
        self.tfTownshipAutoText.maxResultsListHeight = 300
        self.tfTownshipAutoText.startVisible = true
        self.tfTownshipAutoText.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfTownshipAutoText.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfTownshipAutoText.theme.bgColor = UIColor.groupTableViewBackground
        self.tfTownshipAutoText.theme.separatorColor = UIColor.lightGray
        self.svMemberRegisterVerify.delegate = self
        
        // focus cousor
        DispatchQueue.main.async {
            self.tfAgreementNo?.becomeFirstResponder()
        }
        self.tfAgreementNo?.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.tfNrcNo?.keyboardType = UIKeyboardType.numberPad
        self.customerId = UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID)
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
        self.hotlinePhone = sessionInfo?.hotlineNo
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().loadNrcData(success: { (townshipList) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.allTownShipList = townshipList
            self.selectedTownshipList = townshipList[0]
            self.lblDivision.text = self.divisionList[0]
            //self.lblTownship.text = self.allTownShipList[0][0]
            self.lblNrcType.text = self.nrcTypeList[0]
            self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.JSON_FAILURE {
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.CUSTOMER_TYPE_VIEW_CONTROLLER) as! CustomerTypeViewController
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
            }
        }
        
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        //components.year = -10
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        datePickerView.maximumDate = maxDate
        
        tfDob?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
        
//        self.vTownship.layer.borderWidth = 1
//        self.vTownship.layer.cornerRadius = 4 as CGFloat
//        self.vTownship.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vDivision.layer.borderWidth = 1
        self.vDivision.layer.cornerRadius = 4 as CGFloat
        self.vDivision.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vNrcType.layer.borderWidth = 1
        self.vNrcType.layer.cornerRadius = 4 as CGFloat
        self.vNrcType.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
    vDivision.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickDivisionDropDown)))
    //vTownship.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickTownshipDropDown)))
    vNrcType.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickNrcTypeDropDown)))
        
        
        tfAgreementNo?.delegate = self
        tfDob?.delegate = self
        tfNrcNo?.delegate = self
        tfNrcNo?.setMaxLength(maxLength: 6)
        tfAgreementNo?.setMaxLength(maxLength: 19)
        
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.title = "membership.title".localized
        self.lblTitle.text = "verify.title".localized
        self.lblAgreementNo.text = "verify.agreementno.label".localized
        self.tfAgreementNo?.placeholder = "verify.agreementno.holder".localized
        self.lblDob.text = "verify.dob.label".localized
        self.tfDob?.placeholder = "verify.dob.holder".localized
        self.lbAgeNotification.text = "register.dob.restrict.label".localized
        self.lblNrcNo.text = "verify.nrc.label".localized
        self.btnCallNow.setTitle("verify.callnow.button".localized, for: UIControl.State.normal)
        self.btnVerify.setTitle("verify.verify.button".localized, for: UIControl.State.normal)
        self.lblNotify.text = "verify.warning.notify".localized
        
        self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
        
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            svMemberRegisterVerify.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            svMemberRegisterVerify.contentInset = UIEdgeInsets.zero
            
        }
        
        svMemberRegisterVerify.scrollIndicatorInsets = svMemberRegisterVerify.contentInset
        
    }
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
    }
    
    
    @objc func onTapBack() {
       print("click")
        self.dismiss(animated: true, completion: nil)
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

    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
        }
        self.title = "membership.title".localized
        self.lblTitle.text = "verify.title".localized
        self.lblAgreementNo.text = "verify.agreementno.label".localized
        self.tfAgreementNo?.placeholder = "verify.agreementno.holder".localized
        self.lblDob.text = "verify.dob.label".localized
        self.tfDob?.placeholder = "verify.dob.holder".localized
        self.lbAgeNotification.text = "register.dob.restrict.label".localized
        self.lblNrcNo.text = "verify.nrc.label".localized
        self.btnCallNow.setTitle("verify.callnow.button".localized, for: UIControl.State.normal)
        self.btnVerify.setTitle("verify.verify.button".localized, for: UIControl.State.normal)
        
        self.lbAgreeErrorMessage.text = self.agreeMesgLocale?.localized
        self.lbNrcNoErrorMessage.text = self.nrcMesgLocale?.localized
        self.lbDobErrorMessage.text = self.dobMesgLocale?.localized
        
        self.lblNotify.text = "verify.warning.notify".localized
    }
    
    @objc func dobDatePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        tfDob?.text = dateFormatter.string(from: sender.date)
        
    }
    
    @objc func onClickDivisionDropDown(){
        self.tfDob?.resignFirstResponder()
        self.tfAgreementNo?.resignFirstResponder()
        self.tfNrcNo?.resignFirstResponder()
        openDivisionSelectionPopUp()
    }
    
    @objc func onClickTownshipDropDown(){
        self.tfDob?.resignFirstResponder()
        self.tfAgreementNo?.resignFirstResponder()
        self.tfNrcNo?.resignFirstResponder()
        openTownshipSelectionPopUp()
    }
    
    @objc func onClickNrcTypeDropDown(){
        self.tfDob?.resignFirstResponder()
        self.tfAgreementNo?.resignFirstResponder()
        self.tfNrcNo?.resignFirstResponder()
        openNrcTypeSelectionPopUp()
    }
    
    func openDivisionSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lblDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count>=Int(value)!{
                    self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
                    //self.lblTownship.text = self.selectedTownshipList[0]
                    self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        } else {
            
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lblDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count>=Int(value)!{
                    self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
                    //self.lblTownship.text = self.selectedTownshipList[0]
                    self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    func openTownshipSelectionPopUp() {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, action: { (value)  in
//                self.lblTownship.text = value
//                print(value)
//
//            })
//            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
//            if let popoverPresentationController = action.popoverPresentationController {
//                popoverPresentationController.sourceView = self.view
//            }
//        } else {
//            let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, action: { (value)  in
//                self.lblTownship.text = value
//                print(value)
//
//            })
//            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
//            //Present the controller
//            self.present(action, animated: true, completion: nil)
//        }

        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.NRC_POPUP_VIEW_CONTROLLER) as! NRCpopupViewController
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        
        self.definesPresentationContext = true
        popupVC.townshipDelegate = self
        popupVC.townshipList = self.selectedTownshipList
        self.present(popupVC, animated: true, completion: nil)
        
    }
    
    func openNrcTypeSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
            self.lblNrcType.text = value
            print(value)
            
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
            }
        } else {
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
                self.lblNrcType.text = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
            self.present(action, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func onClickCallNow(_ sender: UIButton) {
        self.hotlinePhone.makeCall()
    }
    
    
    @IBAction func onClickVerifyButton(_ sender: UIButton) {
        
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        var isError = false
        // not to overwrite error message
        var isNRCError = false
        
        // Validate Agreement No.
        if self.tfAgreementNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbAgreeErrorMessage.text = Messages.AGREEMENT_NO_EMPTY_ERROR.localized
            self.agreeMesgLocale = Messages.AGREEMENT_NO_EMPTY_ERROR
            isError = true
            
        }else if !Utils.isAgreementNoValidate(agreementNo: (self.tfAgreementNo?.text)!){
            self.lbAgreeErrorMessage.text = Messages.AGREEMENT_NO_LENGTH_ERROR.localized
            self.agreeMesgLocale = Messages.AGREEMENT_NO_LENGTH_ERROR
            isError = true
            
        } else {
            self.lbAgreeErrorMessage.text = Constants.BLANK
            self.agreeMesgLocale = Constants.BLANK
        }
        
        // Validate Date of Birth
        if self.tfDob?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbDobErrorMessage.text = Messages.DOB_EMPTY_ERROR.localized
            self.dobMesgLocale = Messages.DOB_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isDobValidate(dob: (self.tfDob?.text)!){
            self.lbDobErrorMessage.text = Messages.DOB_FORMAT_ERROR.localized
            self.dobMesgLocale = Messages.DOB_FORMAT_ERROR
            isError = true
            
        } else {
            self.lbDobErrorMessage.text = Constants.BLANK
            self.dobMesgLocale = Constants.BLANK
        }
        
        if self.tfTownshipAutoText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbNrcNoErrorMessage.text = Messages.NRC_TOWNSHIP_EMPTY_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_TOWNSHIP_EMPTY_ERROR
            isError = true
            isNRCError = true
            
        } else if !self.selectedTownshipList.contains(self.tfTownshipAutoText.text!){
            self.lbNrcNoErrorMessage.text = Messages.NRC_TOWNSHIP_INVALID_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_TOWNSHIP_INVALID_ERROR
            isError = true
            isNRCError = true
            
        } else {
            self.lbNrcNoErrorMessage.text = Constants.BLANK
            self.nrcMesgLocale = Constants.BLANK
            isNRCError = false
        }
        
        // Validate Nrc No.
        if self.tfNrcNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbNrcNoErrorMessage.text = Messages.NRC_NO_EMPTY_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_NO_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isNrcNoValidate(nrcNo: (self.tfNrcNo?.text)!){
            self.lbNrcNoErrorMessage.text = Messages.NRC_LENGTH_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_LENGTH_ERROR
            isError = true
            
        } else {
            if !isNRCError {
                self.nrcMesgLocale = Constants.BLANK
                self.lbNrcNoErrorMessage.text = Constants.BLANK
            }
        }
        
        if isError {
            return
        }
        //loadCustomViewIntoController()
        //return
        let divisionCode: String = (self.lblDivision?.text!)!
        let townshipCode: String = (self.tfTownshipAutoText?.text!)!
        let nrcType: String = (self.lblNrcType?.text!)!
        let nrcNo: String = (self.tfNrcNo?.text!)!
        
        let nrc = divisionCode + "/" + townshipCode + nrcType + nrcNo
        
        
        let verifyUserInfoRequest = CheckVerifyUserInfoRequest(
            agreementNo: (self.tfAgreementNo?.text)!,
            dob: super.changeYMDformat(date: (self.tfDob?.text!)!),
            nrcNo: nrc,
            customerId: self.customerId)
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().checkVerifyUserInfo(verifyUserRequest: verifyUserInfoRequest, token: (tokenInfo?.access_token)!, refreshToken: (tokenInfo?.refresh_token)!, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if result.data?.verifyStatus == Constants.VALID_MEMBER{
                //success(result)
            
                /**
                                    previous code comment
                 */
                //let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SEC_QUEST_VERIFY_VIEW_CONTROLLER) as! UINavigationController
                //let vc = navigationVC.children.first as! SecQuestionVerifyViewController
                
                /**
                                            Comment by me to change NavigationVC to UIVC
                 */
//                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_UPLOAD_VIEW_CONTROLLER) as! UINavigationController
//                let vc = navigationVC.children.first as! PhotoUploadViewController
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.PHOTO_UPLOAD_VIEW_CONTROLLER) as! PhotoUploadViewController
                vc.verifyData.agreementNo = verifyUserInfoRequest.agreementNo
                vc.verifyData.customerNo = (result.data?.customerNo)!
                vc.verifyData.dateOfBirth = verifyUserInfoRequest.dateOfBirth
                vc.verifyData.nrcNo = verifyUserInfoRequest.nrcNo
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
                
            } else if result.data?.verifyStatus == Constants.INVALID_MEMBER_INFO {
                Utils.showAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: Messages.VERIFY_INVALID_ERROR.localized)
                
            } else if result.data?.verifyStatus == Constants.INVALID_MEMBER {
                Utils.showAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: Messages.VERIFY_INVALID_ERROR.localized)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: Messages.AGREENO_INVALID_ERROR.localized)
                
            }
            
        }) { (error) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.SERVER_FAILURE {
                
            } else if error == Constants.EXPIRE_TOKEN {
                Utils.showExpireAlert(viewcontroller: self, title: Constants.VERIFY_FAILED_TITIE, message: Messages.EXPIRE_TOKEN_ERROR.localized)
                
            } else {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            }
            
        }
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension VerifyMemberViewController: TownshipSelectDelegate {
    func onClickTownshipCode(townshipCode: String) {
        //self.lblTownship.text = townshipCode
    }
}

extension VerifyMemberViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tfTownshipAutoText.hideResultsList()
    }
}
