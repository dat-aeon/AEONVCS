//
//  ForceChangePhoneConfirmViewController.swift
//  AEONVCS
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit
import DatePickerDialog
import SearchTextField

class ForceChangePhoneConfirmViewController: BaseUIViewController {

    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblBarLevel: UILabel!
    @IBOutlet weak var lblBarPhoneNo: UILabel!
    
    @IBOutlet weak var bbClose: UIBarButtonItem!
    @IBOutlet weak var bbFlag: UIBarButtonItem!
    
    @IBOutlet weak var vMainView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPhoneNo: UILabel!
    @IBOutlet weak var tfPhoneNo: UITextField!
    @IBOutlet weak var lbPhoneErrorMessage: UILabel!
    
    @IBOutlet weak var tfTownshipAutoText: SearchTextField!
    
    @IBOutlet weak var lbNrcNo: UILabel!
    @IBOutlet weak var vDivision: UIView!
    @IBOutlet weak var lbDivision: UILabel!
    //@IBOutlet weak var vTownship: UIView!
    //@IBOutlet weak var lbTownship: UILabel!
    @IBOutlet weak var vNrcType: UIView!
    @IBOutlet weak var lbNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField!
    @IBOutlet weak var lbNrcErrorMessage: UILabel!
    
    @IBOutlet weak var btnNext: UIButton!
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedTownshipList = [String]()
    
    // Error message Language control
    var phoneMesgLocale : String?
    var nrcMesgLocale : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblBarPhoneNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
        
        self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

        
        self.tfNrcNo?.keyboardType = UIKeyboardType.numberPad
        self.tfPhoneNo?.keyboardType = UIKeyboardType.numberPad
        self.tfPhoneNo.setMaxLength(maxLength: 11)
        self.lbPhoneErrorMessage.text = Constants.BLANK
        self.lbNrcErrorMessage.text = Constants.BLANK
        self.tfPhoneNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
        
        //autocomplete
        self.tfTownshipAutoText.theme.cellHeight = 40
        self.tfTownshipAutoText.maxResultsListHeight = 300
        self.tfTownshipAutoText.startVisible = true
        self.tfTownshipAutoText.theme.font = UIFont.systemFont(ofSize: 14)
        self.tfTownshipAutoText.theme.fontColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        self.tfTownshipAutoText.theme.bgColor = UIColor.groupTableViewBackground
        self.tfTownshipAutoText.theme.separatorColor = UIColor.lightGray
        
        self.tfNrcNo.setMaxLength(maxLength: 6)
        // check network
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().loadNrcData(success: { (townshipList) in
            //RegisterViewModel.init().getNrcData(success: { (townshipList) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.allTownShipList = townshipList
            self.selectedTownshipList = townshipList[0]
            self.lbDivision.text = self.divisionList[0]
            //self.lbTownship.text = self.allTownShipList[0][0]
            self.lbNrcType.text = self.nrcTypeList[0]
            self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.JSON_FAILURE {
                let alertController = UIAlertController(title: Constants.SERVER_ERROR_TITLE, message: error, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
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
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            var frame = self.tfNrcNo!.frame
            frame.size.width = 100
            self.tfNrcNo?.frame = frame
        }
        
        tfNrcNo?.delegate = self
        tfPhoneNo?.delegate = self
        self.tfNrcNo?.setNeedsLayout()
        
        switch Locale.currentLocale {
        case .EN:
            bbFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbFlag.image = UIImage(named: "en_flag")
        }
        self.lbTitle.text = "resetpass.confirm.title".localized
        self.lbNrcNo.text = "register.nrc.label".localized
        self.lbPhoneNo.text = "register.phoneno.label".localized
        self.btnNext.setTitle("secquestconfirm.confrim.button".localized, for: UIControl.State.normal)
    }
    
    @IBAction func onClickClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func onClickFlag(_ sender: UIBarButtonItem) {
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
            bbFlag.image = UIImage(named: "mm_flag")
        case .MY:
            bbFlag.image = UIImage(named: "en_flag")
        }
        self.lbTitle.text = "resetpass.confirm.title".localized
        self.lbNrcNo.text = "register.nrc.label".localized
        self.lbPhoneNo.text = "register.phoneno.label".localized
        self.btnNext.setTitle("secquestconfirm.confrim.button".localized, for: UIControl.State.normal)
        self.lbPhoneErrorMessage.text = self.phoneMesgLocale?.localized
        self.lbNrcErrorMessage.text = self.nrcMesgLocale?.localized
    }
    
    @objc override func keyboardWillChange(notification : Notification) {
        
//        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            //vMainView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            //vMainView.contentInset = UIEdgeInsets.zero
            
        }
        
        //vMainView.scrollIndicatorInsets = svMemberRegister.contentInset
        
    }

    @objc func onClickDivisionDropDown(){
        self.tfNrcNo?.resignFirstResponder()
        self.tfPhoneNo?.resignFirstResponder()
        openDivisionSelectionPopUp()
    }
    
    @objc func onClickTownshipDropDown(){
        self.tfNrcNo?.resignFirstResponder()
        self.tfPhoneNo?.resignFirstResponder()
        openTownshipSelectionPopUp()
    }
    
    @objc func onClickNrcTypeDropDown(){
        self.tfNrcNo?.resignFirstResponder()
        self.tfPhoneNo?.resignFirstResponder()
        openNrcTypeSelectionPopUp()
    }
    
    func openDivisionSelectionPopUp() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lbDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count >= Int(value)!{
                    self.selectedTownshipList = self.allTownShipList[Int(value)! - 1]
                    //self.lbTownship.text = self.selectedTownshipList[0]
                    self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
                print("\(self.selectedTownshipList)")
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lbDivision
            }
            
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
                self.lbDivision.text = self.divisionList[Int(value)!-1]
                if self.allTownShipList.count >= Int(value)!{
                    self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
                    //self.lbTownship.text = self.selectedTownshipList[0]
                    self.tfTownshipAutoText.filterStrings(self.selectedTownshipList)
                    self.tfTownshipAutoText.text = Constants.BLANK
                }
                print(value)
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(action, animated: true, completion: nil)
        }
    }
    
    func openTownshipSelectionPopUp() {

        // popup view test
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
                self.lbNrcType.text = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            if let popoverPresentationController = action.popoverPresentationController {
                popoverPresentationController.sourceView = self.lbNrcType
            }
            self.present(action, animated: true, completion: nil)
            
        } else {
            let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
                self.lbNrcType.text = value
                print(value)
                
            })
            action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(action, animated: true, completion: nil)
        }
    }
    
    func isErrorExist() -> Bool {
        var isError = false
        // not to overwrite error message
        var isNRCError = false
        
        // Validate NRC Township
        if self.tfTownshipAutoText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbNrcErrorMessage.text = Messages.NRC_TOWNSHIP_EMPTY_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_TOWNSHIP_EMPTY_ERROR
            isError = true
            isNRCError = true
            
        } else if !self.selectedTownshipList.contains(self.tfTownshipAutoText.text!){
            self.lbNrcErrorMessage.text = Messages.NRC_TOWNSHIP_INVALID_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_TOWNSHIP_INVALID_ERROR
            isError = true
            isNRCError = true
            
        } else {
            self.lbNrcErrorMessage.text = Constants.BLANK
            self.nrcMesgLocale = Constants.BLANK
            isNRCError = false
        }
        
        // Validate Nrc No.
        if self.tfNrcNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbNrcErrorMessage.text = Messages.NRC_NO_EMPTY_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_NO_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isNrcNoValidate(nrcNo: (self.tfNrcNo?.text)!){
            self.lbNrcErrorMessage.text = Messages.NRC_LENGTH_ERROR.localized
            self.nrcMesgLocale = Messages.NRC_LENGTH_ERROR
            isError = true
            
        } else {
            if !isNRCError {
                self.nrcMesgLocale = Constants.BLANK
                self.lbNrcErrorMessage.text = Constants.BLANK
            }
        }
        
        //Validate Phone No.
        if self.tfPhoneNo?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lbPhoneErrorMessage.text = Messages.PHONE_REG_EMPTY_ERROR.localized
            self.phoneMesgLocale = Messages.PHONE_REG_EMPTY_ERROR
            isError = true
            
        } else if !Utils.isPhoneValidate(phoneNo: (self.tfPhoneNo?.text)!){
            // validate phone no format
            self.lbPhoneErrorMessage.text = Messages.PHONE_REG_LENGTH_ERROR.localized
            self.phoneMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
            isError = true
            
        } else {
            self.lbPhoneErrorMessage.text = Constants.BLANK
            self.phoneMesgLocale = Constants.BLANK
        }
        return isError
    }
    
    @IBAction func onClickNextBtn(_ sender: UIButton) {
        
        if isErrorExist() {
            return
        }
        
        let divisionCode: String = (self.lbDivision?.text!)!
        let townshipCode: String = (self.tfTownshipAutoText?.text!)!
        let nrcType: String = (self.lbNrcType?.text!)!
        let nrcNo: String = (self.tfNrcNo?.text!)!
        
        let nrc = divisionCode + "/" + townshipCode + nrcType + nrcNo
        let phoneNo = self.tfPhoneNo.text!
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        AppLockCheckViewModel.init().checkAppLock(phoneNo: phoneNo, nrcNo: nrc, success: { (result) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if result.status == Constants.STATUS_500 {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: Messages.NOT_EXIST_CUSTOMER_INFO.localized)
                return
                
            } else {
                if result.lockStatus == 0 {
//                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_SEC_CONFIRM_VIEW_CONTROLLER) as! UINavigationController
//                    let vc = navigationVC.children.first as! ForceChangeSecConfirmViewController
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.FORCE_CHANGE_SEC_CONFIRM_VIEW_CONTROLLER) as! ForceChangeSecConfirmViewController
                    vc.phoneNo = phoneNo
                    vc.nrcNo = nrc
                    vc.hotlinePhone = result.hotlinePhone
                    vc.custQuesCount = result.custQuesCount
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                } else {
//                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.RESET_PASSWORD_VIEW_CONTROLLER) as! UINavigationController
//                    let vc = navigationVC.children.first as! ResetPasswordViewController
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.RESET_PASSWORD_VIEW_CONTROLLER) as! ResetPasswordViewController
                    
                    vc.phoneNo = phoneNo
                    vc.nrcNo = nrc
                    vc.isAppLock = true
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                }
            }
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.REGISTER_ERROR_TITLE, message: error)
            }
        }
        
    }
    
}

extension ForceChangePhoneConfirmViewController: TownshipSelectDelegate {
    func onClickTownshipCode(townshipCode: String) {
        //self.lbTownship.text = townshipCode
    }
}
