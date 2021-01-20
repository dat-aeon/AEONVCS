//
//  LoanConfirmationViewcon.swift
//  AEONVCS
//
//  Created by Ant on 08/01/2021.
//  Copyright © 2021 AEON microfinance. All rights reserved.
//



import UIKit
import FlexibleSteppedProgressBar
import SwipeMenuViewController
import SwiftyJSON
import AVFoundation
import NotificationCenter
import AAViewAnimator
import UserNotifications


class LoanConfirmationViewcon: BaseUIViewController {
   
    
    @IBOutlet weak var lblFinanceAmtError: UILabel!
    @IBOutlet weak var lblTermsFinanceError: UILabel!
    
    @IBOutlet weak var joinImage: UIImageView!
    @IBOutlet weak var tfFinanceAmt: UITextField!
    @IBOutlet weak var tfProcessingfee: UITextField!
    @IBOutlet weak var tfCompulsory: UITextField!
    @IBOutlet weak var tfTotalRepayment: UITextField!
    @IBOutlet weak var tfFirstRepayment: UITextField!
    @IBOutlet weak var tfMonthlyRepayment: UITextField!
    @IBOutlet weak var tfLastPayment: UITextField!
    
    @IBOutlet weak var lblTermOfFinance: UILabel!
    
    @IBOutlet weak var collectViewLoanTerm: UICollectionView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var svLoanConfirmation: UIScrollView!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var enableJoin: UIButton!
    @IBOutlet weak var productTypeView: UIView! {
        didSet {
                   self.productTypeView.clipsToBounds = true
                   self.productTypeView.layer.cornerRadius = 5
                   self.productTypeView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
                   self.productTypeView.layer.borderWidth = 1.0
               }
    }
    @IBOutlet weak var viewTermOfFinance: UIView! {
        didSet {
            self.viewTermOfFinance.clipsToBounds = true
            self.viewTermOfFinance.layer.cornerRadius = 5
            self.viewTermOfFinance.layer.borderWidth = 1.0
            self.viewTermOfFinance.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
    }
    var termsOfFinance = [String]()
    var selectedproductTypeWith = 1
    var selectedLoanTerm = ""
    var selectedTerm = -1
    var tokenInfo: TokenData?
    let oneToOneFifty = ["6"]
    let oneFiftyToSeventy = ["6", "9", "12", "18"]
    let overSeventyToTwoHundred = ["9", "12", "18"]
    var selectedTermOfFinance = 0
    var termFinanceMesgLocale: String?
    var financeAmtMesgLocale: String?
    var isMobileSelected = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.lblTermsFinanceError.text = termFinanceMesgLocale?.localized
        tfFinanceAmt.isUserInteractionEnabled = true
        self.lblTermsFinanceError.text = Constants.BLANK
        self.collectViewLoanTerm.delegate = self
        self.collectViewLoanTerm.dataSource = self
        self.backImage.isUserInteractionEnabled = true
        self.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtn)))
        self.productTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openProductTypeWithPopup)))
        self.tfFinanceAmt.addTarget(self, action: #selector(addSeparatorDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    @objc func backBtn() {
           self.dismiss(animated: true, completion: nil)
       }
    @IBAction func previewBtnPress(_ sender: UIButton) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    @IBAction func nextBtnPress(_ sender: UIButton) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "GuarantorVC") as! GuarantorVC
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    @IBAction func joinLoanEnable(_ sender: UIButton) {
        enableJoin.isSelected = !enableJoin.isSelected

           if enableJoin.isSelected {
               print("I am selected.")
            let normalImage = UIImage(named: "circle_selected.png")
            joinImage.image = normalImage
           } else {
                let selectedImage = UIImage(named: "circle.png")
            joinImage.image = selectedImage
           }
    }
    @objc override func keyboardWillChange(notification : Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification {
            svLoanConfirmation.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)

        } else {
            svLoanConfirmation.contentInset = UIEdgeInsets.zero
        }
        svLoanConfirmation.scrollIndicatorInsets = svLoanConfirmation.contentInset
    }
    
    func isErrorExit() -> Bool {
        
        var isError = false
        
        
        if self.tfFinanceAmt?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.tfFinanceAmt?.text = Constants.BLANK
            self.lblFinanceAmtError.text = Messages.FINANCE_AMT_EMPTY_ERROR.localized
            self.financeAmtMesgLocale = Messages.FINANCE_AMT_EMPTY_ERROR
            isError = true
            
        } else {
            let amt = Int(self.tfFinanceAmt.text?.replacingOccurrences(of: ",", with: "") ?? "0")
            if amt! < 50000 || amt! > 2000000 {
                self.tfFinanceAmt?.text = Constants.BLANK
                self.lblFinanceAmtError.text = Messages.FINANCE_AMT_LIMIT_ERROR.localized
                self.financeAmtMesgLocale = Messages.FINANCE_AMT_LIMIT_ERROR
                isError = true
                
            } else {
                self.lblFinanceAmtError.text = Constants.BLANK
                self.financeAmtMesgLocale = Constants.BLANK
            }
        }
        
        if self.lblTermOfFinance?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
            self.lblTermOfFinance?.text = Constants.BLANK
            self.lblTermsFinanceError.text = Messages.FINANCE_TERM_EMPTY_ERROR.localized
            self.termFinanceMesgLocale = Messages.FINANCE_TERM_EMPTY_ERROR
            isError = true
            
        } else {
            self.lblTermsFinanceError.text = Constants.BLANK
            self.termFinanceMesgLocale = Constants.BLANK
        }
        

        return isError
    }
    func doCalculateLoan(amt: String, terms: String) {
        
        if amt == "" || terms == "" || amt == "0.0" || terms == "0" {
            return
        }
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        let removedComma = amt.replacingOccurrences(of:  ",", with: "")
        
        let loanRequest = LoanCalculatorRequest(financeAmount: "\(removedComma)", loanTerm: terms, motorCycleLoanFlag: "false")
        
        
        
        print("loan Request Amt: \(loanRequest.financeAmount) Term: \(loanRequest.loanTerm) motorcycle: \(loanRequest.motorCycleLoanFlag)")
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        LoanCalculatorViewModel.init().executeLoanCalculator(calculatorInfo: loanRequest, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.showLoanResult(loanResult: result)
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
            self.resetLoanResult()
            
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else if error == Constants.EXPIRE_TOKEN {
                Utils.showExpireAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "COUPON " + Messages.EXPIRE_TOKEN_ERROR.localized)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "News " + error)
            }
        }
        
    }
    func showLoanResult(loanResult: LoanCalculator) {
        self.tfProcessingfee.text = Int(loanResult.processingFees ?? 0).thousandsFormat
        self.tfCompulsory.text = Int(loanResult.conSaving ?? 0).thousandsFormat
        self.tfTotalRepayment.text = Int(loanResult.totalRepayment ?? 0).thousandsFormat
        self.tfFirstRepayment.text = Int(loanResult.firstPayment ?? 0).thousandsFormat
        self.tfMonthlyRepayment.text = Int(loanResult.monthlyPayment ?? 0).thousandsFormat
        self.tfLastPayment.text = Int(loanResult.lastPayment ?? 0).thousandsFormat
    }
    func resetLoanResult() {
        self.tfProcessingfee.text = ""
        self.tfCompulsory.text = ""
        self.tfTotalRepayment.text = ""
        self.tfFirstRepayment.text = ""
        self.tfMonthlyRepayment.text = ""
        self.tfLastPayment.text = ""
    }
   @objc func openProductTypeWithPopup() {
              if UIDevice.current.userInterfaceIdiom == .pad {
                  let action = UIAlertController.actionSheetWithItems(items: Constants.productTpyeWithList, action: { (value)  in
                      //                let selectedType = self.typeResidence[Int(value)!-1]
                      self.productTypeLabel.text = value
                      self.selectedproductTypeWith = Constants.productTpyeWithList.firstIndex(of: value)! + 1
                      print(value)
                  })
                  action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                  if let popoverPresentationController = action.popoverPresentationController {
                      popoverPresentationController.sourceView = self.view
                  }
                  //Present the controller
                  self.present(action, animated: true, completion: nil)
                  
              } else {
                  
                  let action = UIAlertController.actionSheetWithItems(items: Constants.productTpyeWithList, action: { (value)  in
                      //                let selectedType = self.typeResidence[-1]
                   
                    
                      self.productTypeLabel.text = value
                  
                      self.selectedproductTypeWith = Constants.productTpyeWithList.firstIndex(of: value)! + 1
                      print(value)
                   if value == "Education Loan"{
                
//                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "JointApplicationDataVC") as! JointApplicationDataVC
//                    navigationVC.modalPresentationStyle = .overFullScreen
//                    self.present(navigationVC, animated: true, completion: nil)
                    Utils.showAlert(viewcontroller: self, title: "Joint Application", message: "joint") {
                        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "JointApplicationDataVC") as! JointApplicationDataVC
                                           navigationVC.modalPresentationStyle = .overFullScreen
                                           self.present(navigationVC, animated: true, completion: nil)
                    }
                   }else if value == "Motocycle Loan"{
                    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "JointApplicationDataVC") as! JointApplicationDataVC
                    navigationVC.modalPresentationStyle = .overFullScreen
                   }else{
                    
                   }
                               
                   
                   
                  })
                  action.addAction(UIAlertAction.init(title: Constants.CANCEL, style: UIAlertAction.Style.cancel, handler: nil))
                  //Present the controller
                  self.present(action, animated: true, completion: nil)
                  
              }
          }
}
extension LoanConfirmationViewcon: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.termsOfFinance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("call size for item ")
//        if self.loanTerms.count > 3 {
            let calculatedWidth = Int(self.collectViewLoanTerm.frame.size.width)/self.termsOfFinance.count
            print("\(calculatedWidth)")
        
            //let totalWidth = calculatedWidth * self.loanTerms.count
        //let actualWidth = self.viewTermOfFinance.frame.size.width - self.lblTitleLoanTerm.frame.size.width
        
        //print("totalwidht : \(totalWidth), actual width : \(actualWidth)")
        
        if UIDevice().screenType == .iPhone5 {
            if self.termsOfFinance.count > 3 {
                return CGSize(width: calculatedWidth, height: Int(self.collectViewLoanTerm.frame.size.height))
            } else {
               return CGSize(width: 50, height: Int(self.collectViewLoanTerm.frame.size.height))
            }
            
        }
       else {
            return CGSize(width: 50, height: Int(self.collectViewLoanTerm.frame.size.height))
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "confirmTermCollectionCell", for: indexPath) as? ConfrimTermCollectionViewCell)!
        if selectedTerm == indexPath.item {
            cell.imgOptionTerm.image = UIImage(named: "imgCircleDot")
             self.selectedLoanTerm = self.termsOfFinance[indexPath.item]
        } else {
             cell.imgOptionTerm.image = UIImage(named: "imgCircle")
        }
        
        cell.lblOptionTerm.text = "\(self.termsOfFinance[indexPath.item])"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item < self.termsOfFinance.count {
            self.selectedTerm = indexPath.item
            self.selectedLoanTerm = self.termsOfFinance[indexPath.item]
            self.collectViewLoanTerm.reloadData()
            
            self.doCalculateLoan(amt: self.tfFinanceAmt.text ?? "", terms: self.selectedLoanTerm)
            
        }
    }
    @objc func addSeparatorDidChange(_ textField: UITextField) {
        print("textfield did change")
        
        let totalString = "\(textField.text ?? "")"
        let removedComma = totalString.replacingOccurrences(of: ",", with: "")
        self.tfFinanceAmt.text = Int(removedComma)?.thousandsFormat
        self.selectedTerm = -1
        self.selectedLoanTerm = "0"
        self.collectViewLoanTerm.reloadData()
        self.refreshLoanTerm(amt: removedComma)
        
        if textField.text == "" {
            textField.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:200.0/255.0, alpha: 1.0)
        } else {
            textField.backgroundColor = UIColor.white
        }
    }
    func refreshLoanTerm(amt: String) {
        if let number = Int(amt) {
            if number > 2000000 {
                
                self.termsOfFinance = []
                
            } else if number < 50000 {
                
                self.termsOfFinance = []
            } else if number >= 50000 && number <= 150000 {
                let tempArray = self.termsOfFinance
                
                self.termsOfFinance = self.oneToOneFifty
                
                if !tempArray.elementsEqual(self.termsOfFinance) {
                    self.selectedTermOfFinance = 0
                    self.selectedTerm = -1
                }
                
            } else if number > 150000 && number <= 700000 {
                let tempArray = self.termsOfFinance
                 
                self.termsOfFinance = self.oneFiftyToSeventy
                
                if !tempArray.elementsEqual(self.termsOfFinance) {
                    self.selectedTermOfFinance = 0
                     self.selectedTerm = -1
                }
                
                
            } else if number > 700000 {
                let tempArray = self.termsOfFinance
               
                self.termsOfFinance = self.overSeventyToTwoHundred
                
                if !tempArray.elementsEqual(self.termsOfFinance) {
                   self.selectedTermOfFinance = 0
                     self.selectedTerm = -1
                }
               
            } else {
//                self.isWarningShowing = false
            }
           
            if self.termsOfFinance.count > 0 {
                self.lblTermOfFinance.text = self.termsOfFinance[self.selectedTermOfFinance]
                self.doCalculateLoan(amt: self.tfFinanceAmt.text ?? "", terms: self.selectedLoanTerm)
            } else {
                self.lblTermOfFinance.text = ""
                self.resetLoanResult()
            }
        }
        
        self.collectViewLoanTerm.reloadData()
        
//            self.viewDidLayoutSubviews()
    }
//    func callNotification(image: UIImage) {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectFoto"), object: self, userInfo: ["img": image])
//
//        }
}
