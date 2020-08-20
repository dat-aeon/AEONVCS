//
//  ApplyLoanVC.swift
//  AEONVCS
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//


import UIKit
import FlexibleSteppedProgressBar
import SwipeMenuViewController
import SwiftyJSON
import AVFoundation
class ApplyLoanVC: BaseUIViewController {
    
   
    @IBOutlet weak var viewBgTop: UIView!  {
        didSet {
            
            self.viewBgTop.layer.masksToBounds = false
            self.viewBgTop.layer.shadowRadius = 4
            self.viewBgTop.layer.shadowOpacity = 0.9
            self.viewBgTop.layer.shadowColor = UIColor.gray.cgColor
            self.viewBgTop.layer.shadowOffset = CGSize(width: 0 , height:2)
        }
    }
    
    @IBOutlet weak var vSeperator: UIView!
    
    @IBOutlet weak var viewBgProgressBar: UIView!
    @IBOutlet weak var viewSwipeMenu: SwipeMenuView!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    @IBOutlet weak var lblForm1: UILabel!
    @IBOutlet weak var lblForm2: UILabel!
    @IBOutlet weak var lblForm3: UILabel!
    @IBOutlet weak var lblForm5: UILabel!
    @IBOutlet weak var lblForm4: UILabel!
    
    
    @IBOutlet weak var heightTopMostView: NSLayoutConstraint!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var backBtnLabel: UIImageView!
    @IBOutlet weak var phoneLabelBtn: UILabel!
    @IBOutlet weak var nameLabelBtn: UILabel!
    @IBOutlet weak var myanmarLabelBtn: UIImageView!
    @IBOutlet weak var engLabelBtn: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.myanmarLabelBtn.isUserInteractionEnabled = true
        self.engLabelBtn.isUserInteractionEnabled = true
         self.backBtnLabel.isUserInteractionEnabled = true
//        self.myanmarLabelBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
//        self.engLabelBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
//         self.backBtnLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        // Do any additional setup after loading the view.
//        self.setupProgressBarWithoutLastState()
//       
//        self.setupSwipeMenuViewControllers()
//        self.setupSwipeMenuView()
//        
//        self.title = "aeonservice.da.form.title".localized
        
       
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//
//    }
    
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        if isAttachmentEdit {
//            self.heightTopMostView.constant = 91
//        } else {
//            self.heightTopMostView.constant = 0
//        }
//    }
//
//
//    func setupSwipeMenuViewControllers() {
//        let storyboard = UIStoryboard(name: "DA", bundle: nil)
//        let applicationdataVC = storyboard.instantiateViewController(withIdentifier: CommonNames.APPLICATION_DATA_VC) as! ApplicationDataVC
//        let occupationdataVC = storyboard.instantiateViewController(withIdentifier: CommonNames.OCCUPATION_DATA_VC)
//        let emergencycontactVC = storyboard.instantiateViewController(withIdentifier: CommonNames.EMERGENCY_CONTACT_VC)
//        let guarantorVC = storyboard.instantiateViewController(withIdentifier: CommonNames.GUARANTOR_VC)
//        let lConfirmationVC = storyboard.instantiateViewController(withIdentifier: CommonNames.LOAN_CONFIRMATION_VC) as! LoanConfirmationVC
////        self.delegate = lConfirmationVC as applyLoanDelegate
//        self.delegate = applicationdataVC as applyLoanDelegate
//        self.vControllers.append(applicationdataVC)
//        self.vControllers.append(occupationdataVC)
//        self.vControllers.append(emergencycontactVC)
//        self.vControllers.append(guarantorVC)
//        self.vControllers.append(lConfirmationVC)
//    }
//
//    func setupSwipeMenuView() {
//        viewSwipeMenu.dataSource = self
//        viewSwipeMenu.delegate = self
//
//        var options: SwipeMenuViewOptions = .init()
//        options.tabView.additionView.underline.height = 0
//        viewSwipeMenu.reloadData(options: options)
//    }
//
//    func setupProgressBarWithoutLastState() {
//        progressBarWithoutLastState = FlexibleSteppedProgressBar()
//        progressBarWithoutLastState.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(progressBarWithoutLastState)
//
//        var minusWidth = CGFloat(40.0)
//        if UIDevice().screenType == .iPhone6Plus || UIDevice().screenType == .iPhoneXR {
//            minusWidth = CGFloat(0.0)
//        }
//
//        // iOS9+ auto layout code
//        let horizontalConstraint = progressBarWithoutLastState.centerXAnchor.constraint(equalTo: self.viewBgProgressBar.centerXAnchor)
//        let verticalConstraint = progressBarWithoutLastState.topAnchor.constraint(
//            equalTo: self.viewBgProgressBar.topAnchor,
//            constant: 10
//        )
//        let widthConstraint = progressBarWithoutLastState.widthAnchor.constraint(equalToConstant: self.viewBgProgressBar.frame.size.width - minusWidth)
//        let heightConstraint = progressBarWithoutLastState.heightAnchor.constraint(equalToConstant: 20)
//        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//
//        // Customise the progress bar here
//        progressBarWithoutLastState.numberOfPoints = 5
//        progressBarWithoutLastState.lineHeight = 3
//        progressBarWithoutLastState.radius = 20
//        progressBarWithoutLastState.progressRadius = 25
//        progressBarWithoutLastState.progressLineHeight = 3
//        progressBarWithoutLastState.delegate = self
//        progressBarWithoutLastState.selectedBackgoundColor = progressColor
//        progressBarWithoutLastState.selectedOuterCircleStrokeColor = backgroundColor
//        progressBarWithoutLastState.currentSelectedCenterColor = progressColor
//        progressBarWithoutLastState.stepTextColor = textColorHere
//        progressBarWithoutLastState.currentSelectedTextColor = progressColor
//
//        progressBarWithoutLastState.currentIndex = 0
////        progressBarWithoutLastState.textDistance = 10
//        progressBarWithoutLastState.stepTextFont = UIFont.systemFont(ofSize: 9.0)
//
//
//    }
//
//    @IBAction func doGoBack(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//
//    @IBAction func doChangeLanguage(_ sender: Any) {
//        self.localeChanged()
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeLocaleForApplicationData"), object: nil)
//    }
//
//
//    func changeTextIndicator(selectedIndex: Int) {
//        switch selectedIndex {
//        case 0:
//            self.lblForm1.textColor = progressColor
//            self.lblForm2.textColor = textColorHere
//            self.lblForm3.textColor = textColorHere
//            self.lblForm4.textColor = textColorHere
//            self.lblForm5.textColor = textColorHere
//        case 1:
//            self.lblForm1.textColor = textColorHere
//            self.lblForm2.textColor = progressColor
//            self.lblForm3.textColor = textColorHere
//            self.lblForm4.textColor = textColorHere
//            self.lblForm5.textColor = textColorHere
//
//        case 2:
//            self.lblForm1.textColor = textColorHere
//            self.lblForm2.textColor = textColorHere
//            self.lblForm3.textColor = progressColor
//            self.lblForm4.textColor = textColorHere
//            self.lblForm5.textColor = textColorHere
//
//        case 3:
//            self.lblForm1.textColor = textColorHere
//            self.lblForm2.textColor = textColorHere
//            self.lblForm3.textColor = textColorHere
//            self.lblForm4.textColor = progressColor
//            self.lblForm5.textColor = textColorHere
//
//        case 4:
//            self.lblForm1.textColor = textColorHere
//            self.lblForm2.textColor = textColorHere
//            self.lblForm3.textColor = textColorHere
//            self.lblForm4.textColor = textColorHere
//            self.lblForm5.textColor = progressColor
//
//        default:
//            self.lblForm1.textColor = UIColor.red
//            self.lblForm2.textColor = UIColor.darkGray
//            self.lblForm3.textColor = UIColor.darkGray
//            self.lblForm4.textColor = UIColor.darkGray
//            self.lblForm5.textColor = UIColor.darkGray
//        }
//    }
//
    

}

//extension ApplyLoanVC: FlexibleSteppedProgressBarDelegate {
//
//    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
//                     didSelectItemAtIndex index: Int) {
//        progressBar.currentIndex = index
//        if index > minIndex {
//            minIndex = index
//            progressBar.completedTillIndex = minIndex
//
//        }
//        self.viewSwipeMenu.jump(to: index, animated: true)
//    }
//
//    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
//                     canSelectItemAtIndex index: Int) -> Bool {
//        return true
//    }
//
//    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
//                     textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
//
////            if position == FlexibleSteppedProgressBarTextLocation.bottom {
////                switch index {
////
////                case 0: return "Application Data"
////                case 1: return "Occupation Data"
////                case 2: return "Emergency Contact"
////                case 3: return "Guarantor"
////                case 4: return "Loan Confirmation"
////                default: return ""
////
////                }
////
////            }
////            else
////                if position == FlexibleSteppedProgressBarTextLocation.center {
////                switch index {
////
////                case 0: return "1"
////                case 1: return "2"
////                case 2: return "3"
////                case 3: return "4"
////                case 4: return "5"
////                default: return "0"
////
////                }
////            }
//
//        return ""
//    }
//}

//extension ApplyLoanVC: SwipeMenuViewDelegate {
//
//    // MARK - SwipeMenuViewDelegate
//    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
//        // Codes
//    }
//
//    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
//        // Codes
//    }
//
//    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
//        // Codes
//        if fromIndex == 0 {
//
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markAppDataLastState"), object: nil)
//        } else if fromIndex == 1 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markOccupationDataLastState"), object: nil)
//        } else if fromIndex == 2 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markEmergencyContactDataLastState"), object: nil)
//        } else if fromIndex == 3 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markGuarantorDataLastState"), object: nil)
//        } else if fromIndex == 4 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "markLoanConfirmationLastState"), object: nil)
//        } else {
//            if let app = UserDefaults.standard.object(forKey: "appData") as? ApplicationDataRequest {
//                print("app : \(app.customerId)")
//            }
//
//        }
//
//        if toIndex == 0 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAppForm"), object: self, userInfo: ["data": self.myAppData as Any])
//        } else if toIndex == 2 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showEmergencyForm"), object: self, userInfo: ["data": self.myContactData as Any])
//        } else if toIndex == 1 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showOccupationForm"), object: self, userInfo: ["data": self.myOccupationData as Any])
//        } else if toIndex == 3 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showGuarantorForm"), object: self, userInfo: ["data": self.myGuarantorData as Any])
//        } else if toIndex == 4 {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showLoanForm"), object: self, userInfo: ["data": self.myLoanData as Any])
//        }
//    }
//
//    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
//        // Codes
//        self.changeTextIndicator(selectedIndex: toIndex)
//        self.progressBarWithoutLastState.currentIndex = toIndex
//
//
//    }
//}

//extension ApplyLoanVC: SwipeMenuViewDataSource {
//
//    //MARK - SwipeMenuViewDataSource
//    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
//        return self.vControllers.count
//    }
//
//    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
//        return ""
//    }
//
//    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
//
//        return self.vControllers[index]
//    }
//}

