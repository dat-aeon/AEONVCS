//
//  VerifyMemberViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class VerifyMemberViewController: BaseUIViewController {

    
    @IBOutlet weak var svMemberRegisterVerify: UIScrollView!
    @IBOutlet weak var tfAgreementNo: UITextField?
    @IBOutlet weak var tfDob: UITextField?
    @IBOutlet weak var vDivision: UIView!
    @IBOutlet weak var lblDivision: UILabel!
    @IBOutlet weak var vTownship: UIView!
    @IBOutlet weak var lblTownship: UILabel!
    @IBOutlet weak var vNrcType: UIView!
    @IBOutlet weak var lblNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField?
    @IBOutlet weak var btnVerify: UIButton!
    
    var divisionList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14"]
    var allTownShipList = [[String]]()
    var nrcTypeList  = ["(N)","(P)","(E)"]
    var selectedTownshipList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        RegisterViewModel.init().loadNrcData(success: { (result) in
            RegisterViewModel.init().getNrcData(success: { (townshipList) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                self.allTownShipList = townshipList
                self.selectedTownshipList = townshipList[0]
                self.lblDivision.text = self.divisionList[0]
                self.lblTownship.text = self.allTownShipList[0][0]
                self.lblNrcType.text = self.nrcTypeList[0]
            }) { (error) in
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                Utils.showAlert(viewcontroller: self, title: "Loading Error", message: error)
            }
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            Utils.showAlert(viewcontroller: self, title: "Loading Failed", message: error)
        }
        
        tfDob?.delegate = self
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = -10
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        datePickerView.maximumDate = maxDate
        
        tfDob?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(dobDatePickerFromValueChanged), for: UIControl.Event.valueChanged)
        
        self.vTownship.layer.borderWidth = 1
        self.vTownship.layer.cornerRadius = 4 as CGFloat
        self.vTownship.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vDivision.layer.borderWidth = 1
        self.vDivision.layer.cornerRadius = 4 as CGFloat
        self.vDivision.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vNrcType.layer.borderWidth = 1
        self.vNrcType.layer.cornerRadius = 4 as CGFloat
        self.vNrcType.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
    vDivision.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickDivisionDropDown)))
    vTownship.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickTownshipDropDown)))
    vNrcType.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickNrcTypeDropDown)))
        
        
        tfAgreementNo?.delegate = self
        tfDob?.delegate = self
        tfNrcNo?.delegate = self
   
        tfNrcNo?.setMaxLength(maxLength: 6)
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
    
    @objc func dobDatePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        tfDob?.text = dateFormatter.string(from: sender.date)
        
    }
    
    @objc func onClickDivisionDropDown(){
        openDivisionSelectionPopUp()
    }
    
    @objc func onClickTownshipDropDown(){
        openTownshipSelectionPopUp()
    }
    
    @objc func onClickNrcTypeDropDown(){
        openNrcTypeSelectionPopUp()
    }
    
    func openDivisionSelectionPopUp() {
        let action = UIAlertController.actionSheetWithItems(items: divisionList, action: { (value)  in
            self.lblDivision.text = self.divisionList[Int(value)!-1]
            if self.allTownShipList.count>Int(value)!{
                self.selectedTownshipList = self.allTownShipList[Int(value)!-1]
                self.lblTownship.text = self.selectedTownshipList[0]
            }
            print(value)
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    func openTownshipSelectionPopUp() {
        let action = UIAlertController.actionSheetWithItems(items: selectedTownshipList, action: { (value)  in
            self.lblTownship.text = value
            print(value)
            
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    func openNrcTypeSelectionPopUp() {
        let action = UIAlertController.actionSheetWithItems(items: nrcTypeList, action: { (value)  in
            self.lblNrcType.text = value
            print(value)
            
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        //Present the controller
        self.present(action, animated: true, completion: nil)
    }
    
    @IBAction func onClickCallNow(_ sender: UIButton) {
        "0992384242".makeCall()
    }
    
    
    @IBAction func onClickVerifyButton(_ sender: UIButton) {
        
        var isError = false
        
        if self.tfAgreementNo?.text?.isEmpty ?? true{
            self.tfAgreementNo?.showError(message: "Please input agreement no")
            isError = true
        }
        
        if self.tfDob?.text?.isEmpty ?? true{
            self.tfDob?.showError(message: "Please input your birthday")
            isError = true
        }
        
        if self.tfNrcNo?.text?.isEmpty ?? true{
            self.tfNrcNo?.showError(message: "Please input NRC No.")
            isError = true
        }
        
        if self.tfNrcNo?.text?.count ?? 0 < 6{
            self.tfNrcNo?.text = ""
            self.tfNrcNo?.showError(message: "must be 6 digits")
            isError = true
        }
        
        if isError {
            return
        }
        //loadCustomViewIntoController()
        //return
        let divisionCode: String = (self.lblDivision?.text!)!
        let townshipCode: String = (self.lblTownship?.text!)!
        let nrcType: String = (self.lblNrcType?.text!)!
        let nrcNo: String = (self.tfNrcNo?.text!)!
        
        let nrc = divisionCode + "/" + townshipCode + nrcType + nrcNo
        
        
        let verifyUserInfoRequest = CheckVerifyUserInfoRequest(
            agreementNo: (self.tfAgreementNo?.text)!,
            dob: (self.tfDob?.text!)!,
            nrcNo: nrc,
            customerId: "")
        
        RegisterViewModel.init().checkVerifyUserInfo(verifyUserRequest: verifyUserInfoRequest, success: { (result) in
            
            Utils.showAlert(viewcontroller: self, title: "Check Result", message: "\(result.responseStatus) - \(result.customerNo)", action: {
                self.openCamera(imagePickerControllerDelegate: self)
            })

        }) { (error) in
            Utils.showAlert(viewcontroller: self, title: "Failed", message: error)
        }
    }
    
    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension VerifyMemberViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            //            self.ivPreview.image = pickedImage
            //nextvc.data = previousData
            //nextvc.image = pickedImage
            //present(nextvc)
            print("image is not null")
            
//            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberInfoPreviewViewController") as! UINavigationController
//            let vc = navigationVC.children.first as! MemberInfoPreviewViewController
//            vc.registerRequestData = self.registerRequestData
//            vc.profileImage = pickedImage ?? UIImage(named: "Image")!
//            vc.memberResponseData = self.memberResponseData!
//            vc.qaList = self.qaList
//            self.present(navigationVC, animated: true, completion: nil)
            
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoTakingViewController") as! UINavigationController
            let vc = navigationVC.children.first as! PhotoTakingViewController
            //            vc.registerRequestData = self.registerRequestData
            vc.profileImage = pickedImage 
            vc.customerNo = ""
            self.present(navigationVC, animated: true, completion: nil)
            
        } else {
            print("image is null")
        }
        
    }
}
