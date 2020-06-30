//
//  LoanCalculatorViewController.swift
//  AEONVCS
//
//  Created by mac on 8/23/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoanCalculatorViewController: BaseUIViewController {
    
    
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    @IBOutlet weak var lblBarCusType: UILabel!
    
    
    @IBOutlet weak var colviewLoanTerm: UICollectionView!
    @IBOutlet weak var viewLoanAmt: UIView! {
        didSet {
            self.viewLoanAmt.layer.cornerRadius = 5
            self.viewLoanAmt.clipsToBounds = true
            self.viewLoanAmt.layer.borderColor = UIColor.lightGray.cgColor
            self.viewLoanAmt.layer.borderWidth = 0.5
            
        }
    }
    @IBOutlet weak var viewMotorCycle: UIView! {
        didSet {
            self.viewMotorCycle.layer.cornerRadius = 5
            self.viewMotorCycle.clipsToBounds = true
            self.viewMotorCycle.layer.borderColor = UIColor.lightGray.cgColor
            self.viewMotorCycle.layer.borderWidth = 0.5
            
        }
    }
    
    @IBOutlet weak var viewLoanTerm: UIView! {
        didSet {
            self.viewLoanTerm.layer.cornerRadius = 5
            self.viewLoanTerm.clipsToBounds = true
            self.viewLoanTerm.layer.borderColor = UIColor.lightGray.cgColor
            self.viewLoanTerm.layer.borderWidth = 0.5
            
        }
    }
    
    @IBOutlet weak var btnCalculate: UIButton! {
        didSet {
            self.btnCalculate.layer.cornerRadius = 5
            self.btnCalculate.clipsToBounds = true
            self.btnCalculate.layer.borderColor = UIColor.lightGray.cgColor
            self.btnCalculate.layer.borderWidth = 0.5
            
        }
    }
    
    @IBOutlet weak var viewPaymentFee: UIView! {
        didSet {
            self.viewPaymentFee.layer.cornerRadius = 5
            self.viewPaymentFee.clipsToBounds = true
            self.viewPaymentFee.layer.borderColor = UIColor.lightGray.cgColor
            self.viewPaymentFee.layer.borderWidth = 0.5
            
        }
    }
    
    @IBOutlet weak var viewProcessingFee: UIView! {
        didSet {
            self.viewProcessingFee.layer.cornerRadius = 5
            self.viewProcessingFee.clipsToBounds = true
        
        }
    }
    
    @IBOutlet weak var viewTotalRepay: UIView! {
        didSet {
            self.viewTotalRepay.layer.cornerRadius = 5
            self.viewTotalRepay.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var viewFirstRepay: UIView! {
        didSet {
            self.viewFirstRepay.layer.cornerRadius = 5
            self.viewFirstRepay.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var viewMonthlyRepay: UIView! {
        didSet {
            self.viewMonthlyRepay.layer.cornerRadius = 5
            self.viewMonthlyRepay.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var viewLastPayment: UIView! {
        didSet {
            self.viewLastPayment.layer.cornerRadius = 5
            self.viewLastPayment.clipsToBounds = true
            
        }
    }
    @IBOutlet weak var viewCompulsory: UIView! {
        didSet {
            self.viewCompulsory.layer.cornerRadius = 5
            self.viewCompulsory.clipsToBounds = true
            self.viewCompulsory.layer.borderColor = UIColor.lightGray.cgColor
            self.viewCompulsory.layer.borderWidth = 0.5
            
        }
    }
    
    @IBOutlet weak var viewBgLblCompulsory: UIView! {
        didSet {
            self.viewBgLblCompulsory.layer.cornerRadius = 5
            self.viewBgLblCompulsory.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var viewBgLblTotalCompulsory: UIView! {
        didSet {
            self.viewBgLblTotalCompulsory.layer.cornerRadius = 5
            self.viewBgLblTotalCompulsory.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var lblEmptyLoanAmt: UILabel!
    @IBOutlet weak var heightLblEmptyLoanAmt: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitleMotorCycle: UILabel!
    @IBOutlet weak var lblTitleLoanTerm: UILabel!
    @IBOutlet weak var lblTitleProcessingFee: UILabel!
    @IBOutlet weak var lblTitleTotalRepay: UILabel!
    @IBOutlet weak var lblTitleFirstRepay: UILabel!
    @IBOutlet weak var lblTitleMonthlyRepay: UILabel!
    @IBOutlet weak var lblTitleLastPayment: UILabel!
    @IBOutlet weak var lblTitleCompulsory: UILabel!
    @IBOutlet weak var lblTitleTotalCompulsory: UILabel!
    
    @IBOutlet weak var lblProcessingFee: UILabel!
    @IBOutlet weak var lblTotalRepay: UILabel!
    @IBOutlet weak var lblFirstRepay: UILabel!
    @IBOutlet weak var lblMonthlyRepay: UILabel!
    @IBOutlet weak var lblLastPayment: UILabel!
    @IBOutlet weak var lblCompulsory: UILabel!
    @IBOutlet weak var lblTotalCompulsory: UILabel!
    
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var heightWarningView: NSLayoutConstraint!
    @IBOutlet weak var txtLoanAmt: UITextField!
    
    @IBOutlet weak var switchMotorCycle: UISwitch!
    
    @IBOutlet weak var lblWarningLoanTerm: UILabel!
    @IBOutlet weak var heightWarningLoanTerm: NSLayoutConstraint!
    
    @IBOutlet weak var viewCalculate: UIView!
    
    
    var isWarningShowing = false
    
    var isLoanTermSelected = true
    
    let oneToOneFifty = ["6"]
    let oneFiftyToSeventy = ["6", "9", "12", "18"]
    let overSeventyToTwoHundred = ["9", "12", "18"]
    let motorCycleLoanTerm = ["12", "18", "24"]
    
    var selectedLoanTerm = ""
    var selectedTerm = -1
    var loanTerms = [String]()
    
    var tokenInfo: TokenData?
    var returnedLoanResult = LoanCalculator()
    
    var isCalculatingWithNoLoanAmount = false
    
    var isMotorcycleOn = false
    
    var heightViewCalculate = 0
    
    let MINIMUM_AMOUNT = 50000
    let MAXIMUM_AMOUNT = 2000000
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.heightWarningLoanTerm.constant = 0
        self.lblWarningLoanTerm.isHidden = true
        
        self.imgMMlocale.isUserInteractionEnabled = true
              self.imgEnglocale.isUserInteractionEnabled = true
              self.imgBack.isUserInteractionEnabled = true
              
              self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
              self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
              self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        
        // Do any additional setup after loading the view.
        self.setupView()
        
        if let _ = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME) {
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
                       self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
             self.lblBarCusType.text = "Lv.2 : Login user"
            
        }else{
            
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
            self.lblBarName.text = ""
            self.lblBarCusType.text = "Lv.1 : Application user"
            
        }
        var logoutTimer: Timer?
        if lblBarCusType.text == "Lv.2 : Login user" {
                          print("kms ssssssssss>>>>>>")
                    logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
                      }
        
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
                   // self.logoutTimer?.invalidate()
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
    func setupView() {
        self.colviewLoanTerm.delegate = self
        self.colviewLoanTerm.dataSource = self
        
//        self.txtLoanAmt.delegate = self
        
        self.updateViews()
        
        self.txtLoanAmt.addTarget(self, action: #selector(textFieldDidChange(_:)),
                            for: UIControl.Event.editingChanged)
        self.txtLoanAmt.setMaxLength(maxLength: 9)
        
    }
    
   
    @IBOutlet weak var heightVCalculate: NSLayoutConstraint!
    @IBOutlet weak var heightCalculateView: NSLayoutConstraint!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.txtLoanAmt.text!.count == 0 {
            if self.isCalculatingWithNoLoanAmount {
               
                self.lblEmptyLoanAmt.text = "loan.empty_loan_amount".localized
                self.heightLblEmptyLoanAmt.constant = self.lblEmptyLoanAmt.requiredHeight + 10
            } else {
                self.heightLblEmptyLoanAmt.constant = 0
            }
            
            
            self.heightWarningView.constant = 0
        } else {
            self.heightLblEmptyLoanAmt.constant = 0
            
            if self.isWarningShowing {
                self.heightWarningView.constant = self.lblWarning.requiredHeight + 20
                //            self.isWarningShowing = false
            } else {
                self.heightWarningView.constant = 0
            }
        }
        
        if !self.isLoanTermSelected {
            self.heightWarningLoanTerm.constant = self.lblWarningLoanTerm.requiredHeight + 5
            self.lblWarningLoanTerm.isHidden = false
        } else {
            self.heightWarningLoanTerm.constant = 0
        }

          
        
    }
   
    @objc func onTapBack() {
                 self.dismiss(animated: true, completion: nil)
              }
    
     @objc func onTapMMLocale() {
              super.NewupdateLocale(flag: 1)
    //           changeLocale()
            updateViews()
           }
           @objc func onTapEngLocale() {
              super.NewupdateLocale(flag: 2)
    //           changeLocale()
            updateViews()
           }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.setupInitialState()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        if self.switchMotorCycle.isOn == true {
            self.lblWarning.text = "loan.warning_minimum_motorcycle".localized
             self.colviewLoanTerm.reloadData()
        }else{
             self.lblWarning.text = "loan.warning_minimum".localized
        }
       
        self.lblTitleMotorCycle.text = "loan.motor_cycle".localized
        self.lblTitleLoanTerm.text = "loan.loan_term".localized
        self.lblTitleProcessingFee.text = "loan.fee".localized
        self.lblTitleTotalRepay.text = "loan.total_repay".localized
        self.lblTitleFirstRepay.text = "loan.first_repay".localized
        self.lblTitleMonthlyRepay.text = "loan.monthly_repay".localized
        self.lblTitleLastPayment.text = "loan.last_payment".localized
        self.lblTitleCompulsory.text = "loan.compulsory_saving".localized
        self.lblTitleTotalCompulsory.text = "loan.total_compulsory".localized
        
        self.txtLoanAmt.placeholder = "loan.loan_amount".localized
        self.lblEmptyLoanAmt.text = "loan.empty_loan_amount".localized
        self.btnCalculate.setTitle("loan.calculate".localized, for: .normal)
        self.lblWarningLoanTerm.text = "loan.select_loan_term".localized
        
    }
    
    func hideResultView() {
        self.viewCompulsory.isHidden = true
        self.viewPaymentFee.isHidden = true
    }
    
    @IBAction func closeTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func showResultView() {
        self.viewPaymentFee.isHidden = false
        self.viewCompulsory.isHidden = false
    }
    
    func setupInitialState() {
        self.lblEmptyLoanAmt.text = ""
        self.lblWarning.text = ""
        
        self.hideResultView()
        
        self.loanTerms = [String]()
        self.colviewLoanTerm.reloadData()
        
        self.switchMotorCycle.isOn = false
         self.txtLoanAmt.text = ""
        
        self.isMotorcycleOn = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.txtLoanAmt.becomeFirstResponder()
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("textfield did change")
         self.isCalculatingWithNoLoanAmount = false
        self.hideResultView()
        self.selectedTerm = -1
        self.colviewLoanTerm.reloadData()
        
        if textField.text!.count < 9 {
            let totalString = "\(textField.text ?? "")"
            let removedComma = totalString.replacingOccurrences(of: ",", with: "")
            self.txtLoanAmt.text = Int(removedComma)?.thousandsFormat
            self.refreshLoanTerm(amt: removedComma)
        }
//        self.checkAmountisValid(amt: removedComma, isCalculating: false)
    }
    
    @IBAction func tappedOnCalculate(_ sender: Any) {
    
        let totalString = "\(self.txtLoanAmt.text ?? "")"
        
        if totalString.count == 0 {
            self.isCalculatingWithNoLoanAmount = true
            self.viewDidLayoutSubviews()
        } else {
            self.isCalculatingWithNoLoanAmount = false
            let removedComma = totalString.replacingOccurrences(of: ",", with: "")
            self.checkAmountisValid(amt: removedComma, isCalculating: true)
            self.doCalculateLoan()
        }
    }
    
    func checkAmountisValid(amt: String, isCalculating: Bool) {
        
        if let number = Int(amt) {
            if number > 2000000 {
                self.lblWarning.text = "loan.warning_maximum".localized
                print("lblWarnign Size : \(self.lblWarning.requiredHeight)")
                self.isWarningShowing = true
                self.loanTerms = []
                
            } else if number < MINIMUM_AMOUNT {
                self.lblWarning.text = "loan.warning_minimum".localized
                print("lblWarnign Size : \(self.lblWarning.requiredHeight)")
                self.isWarningShowing = true
                self.loanTerms = []
            } else if number >= MINIMUM_AMOUNT && number <= 150000 {
                let tempArray = self.loanTerms
                if self.isMotorcycleOn {
                    self.loanTerms = self.motorCycleLoanTerm
                } else {
                    self.loanTerms = self.oneToOneFifty
                }
                if !tempArray.elementsEqual(self.loanTerms) {
                    self.selectedTerm = -1
                }
                self.colviewLoanTerm.reloadData()
                self.isWarningShowing = false
            } else if number > 150000 && number <= 700000 {
                let tempArray = self.loanTerms
                if self.isMotorcycleOn {
                    self.loanTerms = self.motorCycleLoanTerm
                } else {
                    self.loanTerms = self.oneFiftyToSeventy
                }
                if !tempArray.elementsEqual(self.loanTerms) {
                    self.selectedTerm = -1
                }
                self.colviewLoanTerm.reloadData()
                self.isWarningShowing = false
            } else if number > 700000 {
                let tempArray = self.loanTerms
                if self.isMotorcycleOn {
                    self.loanTerms = self.motorCycleLoanTerm
                } else {
                    self.loanTerms = self.overSeventyToTwoHundred
                }
                if !tempArray.elementsEqual(self.loanTerms) {
                    self.selectedTerm = -1
                }
                self.colviewLoanTerm.reloadData()
                self.isWarningShowing = false
            } else {
                self.isWarningShowing = false
            }
            
            if isMotorcycleOn {
                if number < 350000 {
                    //loan.warning_minimum_motorcycle
                    print("Motor Cycle ON NUMBEr LESS THAN 350,000")
                    self.lblWarning.text = "loan.warning_minimum_motorcycle".localized
                    print("lblWarnign Size : \(self.lblWarning.requiredHeight)")
                    self.isWarningShowing = true
                    self.loanTerms = []
                    self.colviewLoanTerm.reloadData()
                }
            }
        }
        
//        self.toggleLoanCalculatorBtn()
        
        if isCalculating {
            print("Calculating!")
            self.viewDidLayoutSubviews()
        }
    }
    
    func refreshLoanTerm(amt: String) {
        if let number = Int(amt) {
            if number > 2000000 {
                
                self.loanTerms = []
                
            } else if number < MINIMUM_AMOUNT {
                
                self.loanTerms = []
            } else if number >= MINIMUM_AMOUNT && number <= 150000 {
                let tempArray = self.loanTerms
                if self.isMotorcycleOn {
                    self.loanTerms = self.motorCycleLoanTerm
                } else {
                    self.loanTerms = self.oneToOneFifty
                }
                if !tempArray.elementsEqual(self.loanTerms) {
                    self.selectedTerm = -1
                }
                
            } else if number > 150000 && number <= 700000 {
                let tempArray = self.loanTerms
                if self.isMotorcycleOn {
                    self.loanTerms = self.motorCycleLoanTerm
                } else {
                    self.loanTerms = self.oneFiftyToSeventy
                }
                if !tempArray.elementsEqual(self.loanTerms) {
                    self.selectedTerm = -1
                }
                
                
            } else if number > 700000 {
                let tempArray = self.loanTerms
                if self.isMotorcycleOn {
                    self.loanTerms = self.motorCycleLoanTerm
                } else {
                    self.loanTerms = self.overSeventyToTwoHundred
                }
                if !tempArray.elementsEqual(self.loanTerms) {
                    self.selectedTerm = -1
                }
               
            } else {
//                self.isWarningShowing = false
            }
            
            if isMotorcycleOn {
                if number < 350000 {
                    //loan.warning_minimum_motorcycle
                    print("Motor Cycle ON NUMBEr LESS THAN 350,000")
                   
                    self.loanTerms = []
                   
                }
            }
        }
        
        self.colviewLoanTerm.reloadData()
        
        self.viewDidLayoutSubviews()
    }
    
    func doCalculateLoan() {
        
        if isWarningShowing {
            return
        }
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        
        
        let valueOfMotorCycle = self.isMotorcycleOn ? "true" : "false"
        
        let removedComma = "\(self.txtLoanAmt.text ?? "")".replacingOccurrences(of:  ",", with: "")
        
        if selectedTerm <= -1 {
            self.isLoanTermSelected = false
            self.viewDidLayoutSubviews()
            return
        } else {
        
            self.isLoanTermSelected = true
            self.viewDidLayoutSubviews()
        }
        
        let loanRequest = LoanCalculatorRequest(financeAmount: "\(removedComma)", loanTerm: "\(self.selectedLoanTerm)", motorCycleLoanFlag: "\(valueOfMotorCycle)")
        
        
        
        print("loan Request Amt: \(loanRequest.financeAmount) Term: \(loanRequest.loanTerm) motorcycle: \(loanRequest.motorCycleLoanFlag)")
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        LoanCalculatorViewModel.init().executeLoanCalculator(calculatorInfo: loanRequest, success: { (result) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.returnedLoanResult = result
            self.showCalculatorResult()
            
        }) { (error) in
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
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
    
    func showCalculatorResult() {
        self.showResultView()
        
        self.lblProcessingFee.text = "\(self.returnedLoanResult.processingFees?.thousandsFormat ?? "")"
        self.lblCompulsory.text = "\(self.returnedLoanResult.conSaving?.thousandsFormat ?? "")"
        self.lblFirstRepay.text = "\(self.returnedLoanResult.firstPayment?.thousandsFormat ?? "")"
        self.lblLastPayment.text = "\(self.returnedLoanResult.lastPayment?.thousandsFormat ?? "")"
        self.lblTotalRepay.text = "\(self.returnedLoanResult.totalRepayment?.thousandsFormat ?? "")"
        self.lblTotalCompulsory.text = "\(self.returnedLoanResult.totalConSaving?.thousandsFormat ?? "")"
        self.lblMonthlyRepay.text = "\(self.returnedLoanResult.monthlyPayment?.thousandsFormat ?? "")"
    }
    
    @IBAction func toggleMotorCycleValueChanged(_ sender: Any) {
        self.selectedTerm = -1
        self.hideResultView()
        if let onOffMotorCycle = sender as? UISwitch
        {
            self.isMotorcycleOn = onOffMotorCycle.isOn
            
            let totalString = "\(self.txtLoanAmt.text ?? "")"
            let removedComma = totalString.replacingOccurrences(of: ",", with: "")
            self.checkAmountisValid(amt: removedComma, isCalculating: true)
            self.refreshLoanTerm(amt: removedComma)
//            if self.isMotorcycleOn {
//                self.loanTerms = self.motorCycleLoanTerm
//                self.colviewLoanTerm.reloadData()
//            } else {
//                if self.txtLoanAmt.text?.count == 0 {
//                    self.loanTerms = self.motorCycleLoanTerm
//                    self.colviewLoanTerm.reloadData()
//                } else {
//                    self.refreshLoanTerm(amt: removedComma)
//                }
//            }
        }
    }
    
    func toggleLoanCalculatorBtn() {
        
        if isWarningShowing {
            self.btnCalculate.isUserInteractionEnabled = false
            self.btnCalculate.backgroundColor = UIColor.lightGray
        } else {
            self.btnCalculate.isUserInteractionEnabled = true
            self.btnCalculate.backgroundColor = UIColor(red:183.0/255.0, green:0.0/255.0, blue:129.0/255.0, alpha: 1.0)
        }
    }
}

extension LoanCalculatorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.loanTerms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("call size for item ")
//        if self.loanTerms.count > 3 {
            let calculatedWidth = Int(self.colviewLoanTerm.frame.size.width)/self.loanTerms.count
            print("\(calculatedWidth)")
        
            let totalWidth = calculatedWidth * self.loanTerms.count
        let actualWidth = self.viewLoanTerm.frame.size.width - self.lblTitleLoanTerm.frame.size.width
        
        print("totalwidht : \(totalWidth), actual width : \(actualWidth)")
        
        if UIDevice().screenType == .iPhone5 {
            if self.loanTerms.count > 3 {
                return CGSize(width: calculatedWidth, height: Int(self.colviewLoanTerm.frame.size.height))
            } else {
               return CGSize(width: 50, height: Int(self.colviewLoanTerm.frame.size.height))
            }
            
        }
       else {
            return CGSize(width: 50, height: Int(self.colviewLoanTerm.frame.size.height))
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "idLoanTermCell", for: indexPath) as? colLoanTermCell)!
        
        if selectedTerm == indexPath.item {
            cell.cellImgOption.image = UIImage(named: "imgCircleDot")
             self.selectedLoanTerm = self.loanTerms[indexPath.item]
        } else {
             cell.cellImgOption.image = UIImage(named: "imgCircle")
        }
        
        cell.cellLblNumber.text = "\(self.loanTerms[indexPath.item])"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item < self.loanTerms.count {
            self.selectedTerm = indexPath.item
            self.selectedLoanTerm = self.loanTerms[indexPath.item]
            self.colviewLoanTerm.reloadData()
            
            self.tappedOnCalculate(UIButton())
        }
    }
}

extension UILabel{
    
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    public var requiredHeightForNewsEventsTitle: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 2
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
   
}

extension Int {
    
    public var thousandsFormat: String {
      
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        let result = formatter.string(from: NSNumber(value: self))
        
        return result!
        
    }
    
}
