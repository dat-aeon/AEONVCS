//
//  TermsConditionViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 2/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class TermsConditionAgreeViewController: BaseUIViewController {
    
    
    @IBOutlet weak var mytextview: UITextView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var svTermsCon: UIScrollView!
    @IBOutlet weak var lblTermsCon: UILabel!
    @IBOutlet weak var lblSwitch: UILabel!
    @IBOutlet weak var swAgree: UISwitch!
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var bbLoaleFlag: UIBarButtonItem!
    @IBOutlet weak var dialogView: CardView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tfFirstTimePhone: UITextField!
    @IBOutlet weak var lbErrorMsg: UILabel!
    @IBOutlet weak var lblRequestPhNo: UILabel!
    
    
      override func viewDidLoad() {
          super.viewDidLoad()
       
let myColor: UIColor = UIColor(red: 200, green: 1, blue: 132, alpha: 0.75)
        self.mytextview.text = myColor.cgColor as? String
          roomCall()
          let defaults = UserDefaults.standard
          defaults.set(2, forKey: "eng")
          updateViews()
          btnNext.isUserInteractionEnabled = true
          self.btnAgree.isEnabled = false
          self.btnAgree.alpha = 0.5
          self.swAgree.isOn = false
        //   self.btnAgree.titleLabel?.text  = "verify.secque.confirm.button".localized
          
          
           self.lbErrorMsg.text = Constants.BLANK
          self.imgMMlocale.isUserInteractionEnabled = true
          self.imgEnglocale.isUserInteractionEnabled = true

          self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
          self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))

          
          dialogView.isHidden = true
          
      //    let maxSize = CGSize(width: svTermsCon.frame.size.width, height: svTermsCon.frame.size.height)
//          let size = lblTermsCon.sizeThatFits(maxSize)
//          lblTermsCon.frame       = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
          
          self.swAgree.addTarget(self, action: #selector(switchIsChanged), for: UIControl.Event.valueChanged)

          switch Locale.currentLocale {
          case .EN:
              self.bbLoaleFlag.image = UIImage(named: "mm_flag")
            self.mytextview.font = UIFont(name: "Arial", size: 18)
            let myColor: UIColor = UIColor(red: 200, green: 1, blue: 132, alpha: 0.75)
            self.mytextview.text = myColor.cgColor as? String
//            self.lblTermsCon.textColor = myColor
//              self.lblTermsCon.text = "engText"
            self.mytextview.text = engText
             
          case .MY:
              self.bbLoaleFlag.image = UIImage(named: "en_flag")
            self.mytextview.font = UIFont(name: "PyidaungsuBook", size: 18)
            let myColor: UIColor = UIColor(red: 200, green: 1, blue: 132, alpha: 0.75)
            self.mytextview.text = myColor.cgColor as? String
            self.mytextview.text = mmText
            
//            self.lblTermsCon.font = UIFont(name: "PyidaungsuBook", size: 18)
//            let myColor: UIColor = UIColor(red: 50, green: 0, blue: 0, alpha: 0.75)
//            self.lblTermsCon.textColor = myColor
//            self.lblTermsCon.text = mmText
             
              //print("\(mmText.count)")
          }
          self.lblTitle.text = "terms.title".localized
          self.lblSwitch.text = "terms.switch.label".localized
          self.lblRequestPhNo.text = "terms.ReqPhNo".localized
          self.btnNext.setTitle("terms.Next".localized, for: .normal)
                self.btnNext.setTitleColor(.white, for: .normal)
         
        //  self.lblTitle.attributedText = Utils.setLineSpacing(data: lblTitle.text!)
          self.lblRequestPhNo.attributedText = Utils.setLineSpacing(data: lblRequestPhNo.text!)
          self.mytextview.attributedText = Utils.setLineSpacing(data: mytextview.text!)
          //print("\(mmText.count)")
          
          self.tfFirstTimePhone.keyboardType = .numberPad
          
          
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.touchHappen))
          
          self.wholeView.addGestureRecognizer(tap)
          
      }
      func roomCall(){
          RoomSyncViewModel.init().roomSync(phoneNo: UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE) ?? "09", success: {(result) in
              
              let freeCustomerInfoId = result.data.freeCustomerInfoID
              
              UserDefaults.standard.set(freeCustomerInfoId, forKey: Constants.FREECUS_INFO_ID)
              
          }) { (error) in
              print(error.localized)
          }
      }


      @objc func onTapMMLocale() {
         print("click")
          
          let defaults = UserDefaults.standard
          defaults.set(1, forKey: "mya")
          super.NewupdateLocale(flag: 1)
         
          updateViews()
      }
      @objc func onTapEngLocale() {
         print("click")
          let defaults = UserDefaults.standard
          defaults.set(2, forKey: "eng")
          super.NewupdateLocale(flag: 2)
         
          updateViews()
      }

      
      @IBAction func onTouchNext(_ sender: Any) {
          
          if isErrorExist() {
              return
          }
          
                  UserDefaults.standard.set(true, forKey: Constants.IS_ALREADY_ACCEPT)
                  UserDefaults.standard.set(true, forKey: Constants.IS_FIRST_INSTALL)
          UserDefaults.standard.set(self.tfFirstTimePhone.text, forKey: Constants.FIRST_TIME_PHONE)
          let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                  navigationVC.modalPresentationStyle = .overFullScreen
                  self.present(navigationVC, animated: true, completion: nil)
          
      }
      @objc func touchHappen(){
          
          self.wholeView.endEditing(true)
          self.dialogView.endEditing(true)
          
          dialogView.isHidden = true
        swAgree.isOn = false
          wholeView.alpha = 1
          btnAgree.isUserInteractionEnabled = true
          swAgree.isUserInteractionEnabled = true
          
      }
      
      
      @objc func switchIsChanged(mySwitch: UISwitch) {
          super.updateViews()
          if mySwitch.isOn {
            self.dialogView.isHidden = false
              self.btnAgree.isEnabled = true
              self.btnAgree.alpha = 1.0
              //print("switch is on")
             
          } else {
            self.dialogView.isHidden = true
              self.btnAgree.isEnabled = false
              self.btnAgree.alpha = 0.5
              //print("switch is off")
          }
      }
      @IBAction func onClickeLocaleChange(_ sender: UIBarButtonItem) {
          super.updateLocale()
      }
      
      @objc override func updateViews() {
          super.updateViews()
          self.lbErrorMsg.text = "PHONE_EMPTY_ERROR".localized
           self.btnNext.setTitle("terms.Next".localized, for: .normal)
                       self.btnNext.setTitleColor(.white, for: .normal)
         
          self.btnAgree.setTitle("verify.secque.confirm.button".localized, for: .normal)
          self.btnAgree.setTitleColor(.white, for: .normal)
          switch Locale.currentLocale {
          case .EN:
              self.bbLoaleFlag.image = UIImage(named: "mm_flag")
            self.mytextview.text = engText
            self.mytextview.font = UIFont(name: "Arial", size: 18)
            //  self.lblTermsCon.text = engText
          case .MY:
              bbLoaleFlag.image = UIImage(named: "en_flag")
//            self.lblTermsCon.font = UIFont(name: "PyidaungsuBook", size: 18)
//              self.lblTermsCon.text = mmText
            self.mytextview.font = UIFont(name: "PyidaungsuBook", size: 18)
            self.mytextview.text = mmText
          }
          self.lblTitle.text = "terms.title".localized
          lblSwitch.text = "terms.switch.label".localized
         
         
          self.lblTitle.attributedText = Utils.setLineSpacing(data: lblTitle.text!)
          self.mytextview.attributedText = Utils.setLineSpacing(data: mytextview.text!)
          
          self.lblRequestPhNo.text = "terms.ReqPhNo".localized
          self.lblRequestPhNo.attributedText = Utils.setLineSpacing(data: lblRequestPhNo.text!)
          
          //print("\(mmText.count)")
      }
      
      @IBAction func onClickAgreeBtn(_ sender: UIButton) {
          
  //        UserDefaults.standard.set(true, forKey: Constants.IS_ALREADY_ACCEPT)
  //        UserDefaults.standard.set(true, forKey: Constants.IS_FIRST_INSTALL)
  //        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
  //        navigationVC.modalPresentationStyle = .overFullScreen
  //        self.present(navigationVC, animated: true, completion: nil)
          
          wholeView.alpha = 0.5
          btnAgree.isUserInteractionEnabled = false
          swAgree.isUserInteractionEnabled = false
         
          dialogView.isHidden = false
          dialogView.isUserInteractionEnabled = true
          
          
          
          
      }
      
      @objc func setTermsConsLabel(){
          
          switch Locale.currentLocale {
          case .EN:
            //  self.lblTermsCon.text = engText
            self.mytextview.text = engText
          case .MY:
            self.mytextview.text = mmText
          }
         // self.mytextview.attributedText = Utils.setLineSpacing(data: mytextview.text!)
          self.lblTitle.attributedText = Utils.setLineSpacing(data: lblTitle.text!)
           self.lblRequestPhNo.attributedText = Utils.setLineSpacing(data: lblRequestPhNo.text!)
          
      }
      
      func isErrorExist() -> Bool{
          
          var isError = false
          
          if self.tfFirstTimePhone?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true{
              self.tfFirstTimePhone?.text = Constants.BLANK
              self.lbErrorMsg.text = Messages.PHONE_REG_EMPTY_ERROR.localized
  //            self.phoneMesgLocale = Messages.PHONE_REG_EMPTY_ERROR
              isError = true
              
          } else if !Utils.isPhoneValidate(phoneNo: (self.tfFirstTimePhone?.text)!){
              // validate phone no format
              self.lbErrorMsg.text = Messages.PHONE_REG_LENGTH_ERROR.localized
  //            self.phoneMesgLocale = Messages.PHONE_REG_LENGTH_ERROR
              isError = true
              
          } else {
  //            self.phoneMesgLocale = Constants.BLANK
              self.lbErrorMsg.text = Constants.BLANK
          }
          
          return isError
      }
      
      @objc override func keyboardWillChange(notification : Notification) {
          guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
              return
          }
          if notification.name == UIResponder.keyboardWillShowNotification {
  //            wholeView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
              
          } else {
  //            wholeView.contentInset = UIEdgeInsets.zero
          }
  //        wholeView.scrollIndicatorInsets = svMemberRegister.contentInset
      }
      
      
      
      
      
      let engText:String = """
          1. General Information of the Service AEON Microfinance (Myanmar) Mobile Application for the customer of AEON Microfinance (Myanmar) Company Limited("AEON") to verify account information as well as execute transactions via application on mobile phone and tablet (“Application”) or website of AEON (“Website”).
          
          2. Agreement on Service Usage In using the online service, the customer hereby acknowledges,agrees and accepts as follows:
          2.1 The customer agrees to abide by and be liable to AEON under the terms and conditions prescribed herein, on Application and Website including the terms and conditions to be further prescribed or amended by AEON as it deems appropriate, which shall form part of these terms and conditions.
          2.2 The customer agrees that any transaction made via the online service after logging in using Username, Password specifically granted to the customer, including customer verification of identifying identity and confirming transaction of the customer shall be deemed as correctly and validly made by the customer. Upon confirming the transaction, the transaction shall be legally binding on the customer and can be cited as evidence without any other evidence bearing the customer’s signature required. In this regard, the customer waives the right to object or challenge AEON against any such transaction executed via the online service and the accuracy thereof.
          2.3 AEON reserves the right to provide all or some features of the mobile application during the service hours announced on Website or Application. The mobile application’s features available on Website and Application may be different. AEON may consider to configure, remove or add any features at any time as it deems appropriate.
          2.4 The customer agrees and acknowledges that AEON may not be able to provide the online service in the event of breakdown, malfunction, improvement or reparation of the computer system, component, telecommunication system and relevant network system or any force majeure events.
          2.5 AEON reserves the right to suspend or stop the online service temporarily or permanently at any time with notice to the customer as necessary or on reasonable basis.

          3. Conditions of Use For security in using the Online Service, the customer agrees:
          3.1 To ensure that the computer terminal, equipment and other electronic communication devices, connection to internet network and/or web browser used to access the Online Service have adequate capacity and have been installed with protection against computer viruses, malwares and any other deceptive programs designed to destroy or restrict accession to data and other threats, as well as meet the standard specifications set by AEON.
          3.2 To be careful in accessing to and filling out information concerning member card, personal information and other information of the customer.
          3.3 To protect and keep confidential personal information, the Username, Password as assigned to the customer by AEON and those changed afterwards.
          3.4 Not to leave the computer terminal, equipment and /or other electronic communication devices which are logged in unattended and to log off the online service every time after use.
          3.5 In the event that the customer accesses to the mobile application using shared computers, shared electronic communication devices and/or public internet network the customer agrees to be responsible for all damages incurred by the customer, AEON and any other person should there be any unauthorized access to or any transaction being executed through the mobile application, or personal information of the customer or other AEON’s customers being revealed. In this regard, AEON reserves the right to suspend the mobile application, whether in whole or in part, for so long as and in the event that the customer accesses to the mobile application in such manner or through such or other connection AEON deems unsecured.
          3.6 If the Password of the customer is lost, stolen or if the customer suspects that other person may know or be able to guess them, the customer shall promptly change the Password by the method as prescribed by AEON. It shall be sole responsibility of the customer to do so. Failure to do so will result in liability to the customer for all transactions and all losses and damages occurred.
          3.7 In the event of error while using or transacting via the Online Service, the customer shall inform AEON in writing within 7 days from the date of such error, otherwise it shall be deemed that the transaction executed is correct and valid.In reporting error, the customer shall prepare and send to AEON a letter informing at least the following details:
          3.7.1 Date and time of the transaction;
          3.7.2 Location of the computer terminal, equipment or the electronic communication devices used and type of internet network connection;
          3.7.3 16-digit number of member card, name and contactable telephone number of the customer;
          3.7.4 Type of transaction; and
          3.7.5 Description of the error and reference code (if any)
           
          4. Protection of Customer Security AEON reserves the right to suspend the Online Service if repeatedly entered wrong Username, Password over the number of times allowed by AEON. In such case, transaction on process shall be immediately cancelled and the customer shall not be able to claim for any damages which may arise therefrom. To resume the Online Service, the customer can Call Center of AEON at 09-9697-12111 during working days and hours.
           
          5. No Warranty The information and materials contained in Application and Website, including text, graphics, links or other items are provided on "as is" and "as available" basis. AEON does not warrant the accuracy, adequacy or completeness of the information and materials, and expressly disclaims liability for errors or omissions in providing information and materials. No warranty of any kind, implied, expressed or statutory including but not limited to the warranties of non-infringement of third party rights and title, merchantability, fitness for a particular purpose and freedom from computer virus, is given in conjunction therewith.
           
          6. Exemption of Liability In no event shall AEON be liable for any losses, damages including without limitation direct, indirect, special, incidental or consequential damages or difficulties incurred by the customer from using or transacting via the Online Service including in the following cases:
          6.1 The customer discloses his/her Username, Password to other person so as to allow such other person to login and execute transactions on his/her behalf, including to use the Online Service for illegal purpose.
          6.2 Any cause attributable to deliberate act or negligence on the part of the customer.
          6.3 Non-compliance by the customer with the terms and conditions of the Online Service including manuals and guidelines for using the Online Service issued by AEON, or any applicable laws and regulations.
          6.4 Any error occurred from change or cancellation of the instruction and/or information transmitted to the Online Service or failure of performance, error, omission, interruption, defect, delay in operation or transmission of the system and/or web browser and/or the internet service provider or telephone network provider of the customer or AEON.
          6.5 Cyber intrusion and/or attack by any person or group of person on any hardware, software and/or components relating to the Online Service, including release of program that may be harmful to system such as Virus, Trojan Horses and Worms which may affect the operation of the Online Service.
          6.6 Damage and/or inability to use the system, program and/or equipment for using the Online Service whether it be of AEON or other person, including but not limited to damage and/or error of the system, program, computer server system, electricity supply system, telecommunication devices, electricity devices, telephone line and/or telecommunication network system and/or any part of electronic system occurs.
          6.7 Any loss of data in the course of transmission whether via the Online Service system or other system of AEON or other system of the customer or internet service provider.
          6.8 Any damage caused by fire, earthquake, flood, accidents, riots, protests, civil disturbances, war, closure of business or strikes, disruption of electricity or services provided by the internet service provider, or other force majeure beyond the control of AEON and AEON is prevented from providing the Online Service.In those cases under clauses 6.1 – 6.3, the customer agrees to be responsible for any and all damages suffered by AEON and any other persons.
           
          7. Service Fees The customer agrees to pay service fees, charges and other expenses for the Online Service usage at the rates prescribed by AEON (at present, the Online Service is provided free-of-charge).
           
          8. Information
          8.1 The customer agrees that AEON may contact, inquire, maintain, collect, disclose and use any or all information concerning the customer as necessary and appropriate or as AEON deems beneficial to the customer in receiving information on other products and/or services.
          8.2 In case that AEON is required to disclose financial information or transaction or other information related to  the Online Service usage of the customer to any agencies pursuant to the provisions of laws, orders, or rules and regulations issued by any competent or regulating authorities  or disclosure is made for the benefit of the Online Service provision or for such other purpose as AEON deems appropriate, the customer agrees and consents AEON to disclose and/or report information and transaction of the customer in all respects, and agrees that such consent shall continue to be valid regardless of the customer’s terminating subscription to the Online Service, the Online Service account, or loan account or credit card account has been closed.
          9. Communication AEON may contact the customer via mobile phone, address or email given or last informed to AEON.
          The customer agrees to allow AEON to contact via mobile phone, email, Website, Application, SMS and postage including for the purpose of advertising and marketing products and services of AEON and other persons/entities, which shall be deemed that the customer is duly notified by AEON.
           
          10. Service Cancellation
          10.1 AEON has the right to cancel the Online Service without notifying the customer in the following events:
          (1) the customer has not logged in the Online Service for more than 1 year from the subscription date or from the date last logged in.
          (2) the customer breaches any terms and conditions of the Online Service including failure to pay service fee, charges or expenses in relation to any services of AEON for whatsoever reasons.
          10.2 AEON has the right to cancel any features of the Online Service without prior notice.
          10.3 The customer may cancel the Online Service by notifying AEON in the prescribed manner. Upon cancellation, any transaction in process shall be cancelled immediately.
          11. Other Conditions
          11.1 If any terms and conditions contained herein is invalid, contrary to law or becomes unenforceable, the invalidity, contradiction and unenforceability of such part shall not affect or prejudice the validity and enforceability of the remaining terms and conditions.
          11.2 In the course of the Online Service usage, if there is any agreement on supplementary service of any kind between AEON and the customer, the customer agrees that the supplementary service shall be part of the Online Service. These terms and conditions shall be applied to the Online Service and terms and conditions of the supplementary service shall be regarded as additional terms and conditions and form part of these terms and conditions. In case of conflict, these terms and conditions shall prevail with respect to the Online Service and the terms and conditions for supplementary service shall prevail with respect to the supplementary service.
          11.3 The customer may print out the transaction confirmation page for his/her own record.
          11.4 In case these terms and conditions differ from the terms and conditions of other services provided by AEON, these terms and conditions shall be prevailed for the Online Service only.
          11.5 No delay, omission or waiver of exercising any rights or remedies as conferred by laws and these terms and conditions by AEON shall impair such rights or remedies or constitute a waiver thereof, nor shall any single or partial delay, omission or waiver of exercising of such rights or remedies preclude any other or further exercise thereof or the exercise of any other rights or remedies or be regarded as waiver or consent by AEON for the customer to proceed with any actions.
          11.6 The customer and AEON agree that these terms and conditions shall be subject to and be interpreted in accordance with and governed by the laws of Myanmar and that Myanmar court shall have exclusive jurisdiction over disputes arisen from the Online Service and its supplementary services.
          """
      
      let mmText: String = """
  (၁) ဝန်ဆောင်မှုနှင့်ဆက်စပ်သောအထွေထွေ သတင်းအချက်အလက်များ AEON Microfinance (Myanmar) Co.Ltd. (AEON) ၏ Customer များအတွက် AEON Microfinance (Myanmar) Mobile Application သည် Customer ၏အချက်အလက်များအား မိုဘိုင်းဖုန်း၊တက်ဘလက်နှင့် အီရွန်ဝက်ဆိုဒ်မှ တဆင့် လျှောက်ထားမှု.များကို စစ်ဆေးရန်နှင့် အခြားသောဝန်ဆောင်မှုများကိုလည်း ဆောင်ရွက်နိုင်ရန်ဖြစ်ပါသည်။

  (၂) ဝန်ဆောင်မှုအသုံးပြုခြင်းဆိုင်ရာ သဘောတူညီမှု Online Services အား အသုံးပြုခြင်းဖြင့် Customerသည် အောက်ပါအချက်အလက်များအား သိရှိ နားလည် သဘောတူ လက်ခံပါသည်။
  ၂.၁ ) Customer သည် Application ပေါ်တွင်လည်းကောင်း၊ Website ပေါ်တွင်လည်းကောင်း Company မှ နောင်တွင် အခါအားလျော်စွာ ပြင်ဆင်မည့် သင့်လျော်သည့် စည်းကမ်းချက်များကို လည်း ယခု ဖော်ပြထားသော စည်းကမ်းချက်များ၏ အစိတ်အပိုင်းတစ်ခုအနေဖြင့် ဆက်လက် တည်ရှိနေမည် ဖြစ်ကြောင်း သဘောတူညီပါသည််။
  ၂.၂) Customerသည် မည်သည့် ဆောင်ရွက်ချက်မှုမျိုးကိုမဆို လုပ်ဆောင်ရန် ၎င်းအား ပေးအပ်ထားသော User Name, Password ဖြင့် Online Service သို့ ဝင်ရောက် ဆောင်ရွက် ချက်များအား ကိုယ်တိုင် ကိုယ်ပိုင်သဘောဆန္ဒဖြင့်ဆောင်ရွက်ခြင်းဖြစ်သည်ဟုသတ်မှတ်ပါသည်။ဆောင်ရွက်မှှု.များအား အတည်ပြုပြီးပါက Customer၏ ဆောင်ရွက်မှု.များအား တရားဝင် သက်သေ အထောက်ထားအဖြစ် သတ်မှတ်ထားခြင်းဖြစ်သဖြင့် Customer၏ ထိုးမြဲလက်မှတ်အား ရယူရန် မလိုအပ်တော့ပါ။ဤအကြောင်းအရာနှင့် ပတ်သတ်၍ Customer သည် Online Services အသုံးပြုသော မည်သည့်ဝန်ဆောင်မှုနှင့်ပတ်သတ်၍ AEON အား ကန့်ကွက်ခြင်း တရားစွဲဆိုခွင့် မရှိစေရပါ။
  ၂.၃) AEON သည် ဝန်ဆောင်မှု့ ပေးသည့် အချိန်အတွင်း Mobile Application (သို့) ဝဘ်ဆိုဒ်၏ ဝန်ဆောင်မှု အားလုံး (သို့) အချို့ အစိတ်အပိုင်းများအား ပြင်ဆင်စီစဉ် ဆောင်ရွက်နိုင်ခွင့် ရှိသည်။Mobile Applicationတွင် ပါဝင်သော ဝန်ဆောင်မှုများနှင့် ဝဘ်ဆိုဒ်တွင်ပါဝင်သော ဝန်ဆောင်မှုများ အကြားတစ်ခါတရံ ကွဲလွဲမှုများရှိနိုင်ပါသည်။ AEONသည် မည်သည့်အချိန်တွင်မဆို ဝန်ဆောင်မှု များအား သင့်တော်သလို အသစ်ထည့်သွင်းခြင်း၊ ပယ်ဖျက်ခြင်း၊ ပြင်ဆင်ခြင်းများအား ပြုလုပ်နိုင် ပါသည်။
  ၂.၄) ကွန်ပျူတာစနစ်ချို.ယွင်းမှု.၊ ဆက်သွယ်ရေးဆိုင်ရာချို.ယွင်းမှု.၊ ကွန်ယက်ပိုင်းဆိုင်ရာ ချို.ယွင်းမှု.၊ အခြားသော သဘာဝဘေးအန္တရာယ်များကြောင့် Online Service အလုပ်မလုပ်ခြင်း များရှိပါက  Customer အနေဖြင့် နားလည် ခွင့်လွတ်ရန် သဘောတူပါသည်။
  ၂.၅) AEON သည် Customer အား ကြိုတင်အသိပေးရန်လိုအပ်ပါက အသိပေးပြီး Online Service ကို ယာယီသော်လည်းကောင်း၊ အမြဲတမ်းသော်လည်းကောင်း ရပ်ဆိုင်းနိုင်ခွင့်ရှိပါသည်။

  ၃) မိုဘိုင်းအသုံးပြုခြင်းဆိုင်ရာ သတ်မှတ်ချက်များ Mobile Application အသုံးပြုရာတွင် လုံခြုံရေးအလို့ငှာ အောက်ပါအချက်များအား Customer မှ လိုက်နာဆောင်ရွက်ရန် သဘောတူညီပါသည်-
  ၃.၁) Online Service အား အသုံးပြုရာတွင် အသုံးပြုသော ဆက်သွယ်ရေးစက်ပစ္စည်းများ၊ ကွန်ပျူတာများ၊ ကွန်ယက်များ၊ ဝဘ်ဘရောက်ဇာများသည် ဗိုင်းရပ်စ်များနှင့် အခြားသော အချက်အလက်အားနှောက်ယှက်ဖောက်ထွင်းနိုင်သည့် ပရိုဂရမ်များမှ အကာအကွယ်ရရှိအောင် ဆောင်ရွက်ထားရန်လိုအပ်ပြီး AEON ၏သတ်မှတ်စံနှုန်းများနှင့်လည်း ကိုက်ညီရပါမည်။
  ၃.၂) Customer ၏ အဖွဲ့ဝင်ကဒ်၊ ကိုယ်ရေးကိုယ်တာနှင့် အခြားသောအချက်အလက်များအား ဖြည့်စွက်ခြင်း၊ ရယူခြင်းများပြုလုပ်ရာတွင် ဂရုပြုဆောင်ရွက်ရန် လိုအပ်ပါသည်။
  ၃.၃) AEON မှ Customer သို့ပေးအပ်ထားသော Username, Password နှင့် ပြင်ဆင် ပြောင်းလဲလိုက်သော Password များအား လုံခြုံစွာ ထိန်းသိမ်းထားရပါမည်။
  ၃.၄) အသုံးပြုသောဆက်သွယ်ရေးစက်ပစ္စည်းများ၊ ကွန်ပျူတာများအားLogin ဝင်ရောက်လျက် အနေအထားဖြင့် ထွက်ခွာခြင်း မပြုလုပ်ရန်နှင့် Mobile Application အား အသုံးပြုပြီးတိုင်း Log out ပြုလုပ်ရပါမည်။
  ၃.၅) မျှဝေ၍ အသုံးပြုသော ဆက်သွယ်ရေးစက်ပစ္စည်းများ၊ ကွန်ပျူတာများ၊ အများသုံး အင်တာနက် ကွန်ယက်များ အသုံးပြုခြင်းအတွက် Customer, AEON, အခြားသူ တစ်ဦးဦးကြောင့် ဖြစ်ပေါ်လာသော ခွင့်ပြုချက်မရှိသည့် ဝန်ဆောင်မှု အသုံးချ ဆောင်ရွက်ခြင်း၊ Customer၏ ကိုယ်ရေးအချက်အလက် ပေါက်ကြားခြင်း၊ အခြားသော AEON Customerများ၏ အချက် အလက်များ ပေါက်ကြားခြင်း စသည့် မည်သည့် ထိခိုက်နစ်နာမှု.မျိုးကိုမဆို Customer မှ အပြည့်အဝ တာဝန်ယူရန် သဘောတူညီပါသည်။ ဤအကြောင်းအရာနှင့် ဆက်စပ်၍ လုံခြုံမှုမရှိဟု ယူဆရသော ချိတ်ဆက်မှုနှင့် Customer၏ Mobile Application အသုံးချခွင့်အား တစ်စိတ်တစ်ပိုင်းသော်လည်းကောင်း၊ အပြည့်အဝသော်လည်းကောင်း ရပ်ဆိုင်းရန် AEON တွင် အခွင့် ရှိပါသည်။
  ၃.၆) အကယ်၍ Customer ၏ Password သည် ပျောက်ဆုံးခြင်း၊ အခိုးခံရခြင်း၊ အခြားသူတစ်ဦးက သိရှိခြင်း (သို့) ခန့်မှန်းနိင်သည်ဟု ယူဆရပါက AEON မှညွှန်ကြားထားသည့် နည်းလမ်းအတိုင်း Password အား ချက်ခြင်း ပြောင်းလဲရပါမည်။ ထိုသို့ ပြုလုပ်ရန်မှာ Customer ၏ တာဝန်သာ ဖြစ်ပါသည်။ ထိုသို့ ပြုလုပ်ရန် ပျက်ကွက်ပါက Customer အတွက် ဆုံးရှုံးမှု နှင့် ထိခိုက်နစ်နာမှုများ အတွက် Customer တွင်သာ တာဝန်ရှိပါမည်။
  ၃.၇) Online Service အသုံးပြု၍ ဝန်ဆောင်မှုများအား ဆောင်ရွက်ရာတွင် အမှားအယွင်း တစုံတရာဖြစ်ပေါ်လာပါက Customer အနေဖြင့် ဖြစ်ပွားသည့်နေ့မှ (၇)ရက်အတွင်း AEON သို့ စာဖြင့် အကြောင်းကြားရပါမည်။ ထိုသို့မဟုတ်ပါက ဆောင်ရွက်မှုအား မှန်ကန် အကျုံးဝင်သည်ဟု ယူဆဆောင်ရွက်သွားပါမည်။
  အကြောင်းကြားစာတွင် အောက်ပါ အသေးစိတ် အချက်များ ပါဝင်ရပါမည်-
  ၃.၇.၁)    ဝန်ဆောင်မှု ဆောင်ရွက်သည့် နေ့စွဲ နှင့် အချိန်
  ၃.၇.၂) အသုံးပြုသော ဆက်သွယ်ရေးစက်ပစ္စည်းများ၊ ကွန်ပျူတာများ၏ တည်နေရာနှင့်  ချိတ်ဆက်သော အင်တာနက် ကွန်ယက်အမျိုးအစား
  ၃.၇.၃)    အဖွဲ့ဝင်၏ ဂဏန်း၁၆လုံးပါ အဖွဲ.ဝင်ကတ်ပြားနံပါတ်၊ အမည်၊ ဆက်သွယ်ရန်ဖုန်း
  ၃.၇.၄)    ဆောင်ရွက်ခဲ့သည့် ဝန်ဆောင်မှု အမျိုးအစား
  ၃.၇.၅)    အမှားအယွင်းဖြစ်ပွားစဉ် ဖော်ပြခဲ့သောစာသားနှင့် အညွှန်းကုဒ် (ပါရှိပါက)

  ၄) Customer ၏ လုံခြုံရေးအတွက် အကာအကွယ်များ AEONမှ ခွင့်ပြုထားသော Username မှားယွင်းအသုံးပြုခြင်းနှင့်ခွင့်ပြုထားသော အကြိမ်အရေ အတွက်ထက် ပို၍ Password အား ဆက်တိုက်ဖြည့်စွက်ပါက Online Service အား AEON မှ ရပ်ဆိုင်းပိုင်ခွင့်ရှိပါသည်။ထိုသို.ရပ်ဆိုင်းမှု.များအတွက် Customerတွင်ထိခိုက်မှု.ရှိပါကCustomer  အနေဖြင့် AEONသို. တောင်းဆိုပိုင်ခွင့် မရှိပါ။Online Service အား ပြန်လည် အသုံးပြုနိုင်ရန် Customer အနေဖြင့် AEON ၏ Call Center ဖုန်းနံပါတ် 09-9697-12111 သို့ အလုပ်ချိန်အတွင်း ဆက်သွယ်နိုင်ပါသည်။

  ၅) တာဝန်ခံမှု.မှ ကင်းလွတ်ခြင်း Mobile Application နှင့် ဝဘ်ဆိုဒ်တွင်ပါရှိသော စာသား၊ပုံ၊လင့်ခ်နှင့် အခြားသော အချက် အလက်များမှာ အရှိအတိုင်းရရှိနိုင်မည့် အတိုင်းအတာအထိသာ ဖော်ပြထားသည်ဖြစ်ရာ  တိကျသေချာမှု၊ ပြည့်စုံလုံလောက်မှုနှင့် ပတ်သက်၍ AEON မှ အာမ မခံ၊ တာဝန်မယူသလို ၎င်းဖော်ပြပါ အချက်အလက် ပါဝင်မှုများနှင့်ပတ်သက်၍ မှားယွင်းခြင်း ပျက်ကွက်ခြင်းများ အတွက်လည်း AEON တွင်တာဝန်မရှိပါ။

  ၆)တာဝန်မရှိခြင်းနှင့် တာဝန်ယူမှု.မှ ကင်းလွတ်ခြင်း။ အောက်ပါကိစ္စရပ်များ အပါအဝင် customerမှ တိုက်ရိုက်သော်လည်းကောင်း၊ သွယ်ဝိုက်၍ သော်လည်းကောင်း တမင်ရည်ရွယ်၍သော်လည်းကောင်း မရည်ရွယ်ပဲ မတော်တဆသော် လည်းကောင်း၊ အွန်လိုင်းဝန်ဆောင်မှုအား အသုံးပြု၍ ဆောင်ရွက်မှုကြောင့် ဖြစ်ပေါ်လာသည့် နောက်ဆက်တွဲ ပျက်စီးမည့် မည်သည့် ဆုံးရှုံးမှု၊ ထိခိုက်မှု၊ နစ်နာမှု များအတွက် AEON တွင် တာဝန်မရှိစေရပါ-
  ၆.၁) Customer သည် ၎င်း၏ Username, Password တို့အား အခြားသူ တစ်ဦးဦးအား ဖော်ပြသဖြင့် ၎င်းမှ Customer ၏ ကိုယ်စား ဝန်ဆောင်မှုများအား တရားဥပဒေနှင့် မလွတ်ကင်းသော ကိစ္စရပ်များအား ရည်ရွယ်ချက်ဖြင့် ဆောင်ရွက်ခြင်း။
  ၆.၂) Customer ၏ တမင်သက်သက်သော်လည်းကောင်း ပေါ့ပျက်စွာသော်လည်းကောင်း လုပ်ဆောင်မှုကြောင့်ဖြစ်ပျက်သော မည်သည့် အကြောင်းကိစ္စရပ်များမဆို။
  ၆.၃) AEON မှ ထုတ်ဝေထားသော အွန်လိုင်းဝန်ဆောင်မှုအတွက် လက်စွဲနှင့် လမ်းညွှန်ချက်များ၊ စည်းမျဉ်းနှင့် သတ်မှတ်ချက်များကို Customer မှ လိုက်နာရန် ပျက်ကွက်ခြင်း များကြောင့် ဖြစ်ပေါ်လာသော ပြဌာန်းထားသည့် ဥပဒေများ၊ စည်းမျဉ်းများနှင့် မကိုက်ညီသော ကိစ္စရပ်များ။
  ၆.၄) လမ်းညွှန်ချက်များပြောင်းလဲခြင်း၊ ပယ်ဖျက်ခြင်း(သို.မဟုတ်) ၊ Online Servcie အလုပ် မလုပ်ခြင်း အမှားနှင့် ကျန်ခဲ့ခြင်းများ၊ နှောင့်ယှက်မှု.များ ကြန်.ကြာမှု.များ အတွက် တာဝန်မရှိပါ။
  ၆.၅) အွန်လိုင်းအသုံးပြုသည့် Hardware, Software များအားပြင်ပ ပုဂိိိုလ်တစ်ဦး(သို.) ပုဂိုလ်တစ်စုမှ တိုက်ခိုက်ခြင်းကြောင့် ဖြစ်ပေါ်လာမည့် ထိခိုက်မှု.များ။
  ၆.၆) အွန်လိုင်းအသုံးပြုရာတွင် ကွန်ပျူတာချို.ယွင်းခြင်း၊ လျှပ်စစ်စနစ်ချို.ယွင်းခြင်း၊ ဆက်သွယ်ရေး စနစ်ချို.ယွင်းခြင်း၊ လျှပ်စစ်ပစ္စည်းများ ချို.ယွင်းခြင်း၊ တယ်လီဖုန်းဆက်သွယ်ရေး လိုင်းများ ချို.ယွင်းခြင်းကြောင့် ဖြစ်ပေါ်လာနိုင်သည့် ဆုံးရှုံးမှု.များ။

  ၇)ဝန်ဆောင်ခ အွန်လိုင်းဝန်ဆောင်မှုအား အသုံးပြုရာတွင် AEON မှ သတ်မှတ်ထားသော  ဝန်ဆောင်ခနှင့် အခြားသော ကုန်ကျစရိတ်များ ပေးဆောင်ရန် Customer မှ သဘောတူပါသည်။(လက်ရှိတွင် အွန်လိုင်း ဝန်ဆောင်ခ ပေးရန်မလိုပါ။)

  ၈)သတင်းအချက်အလက်များအသုံးပြုခြင်း။
  ၈.၁)  Customer နှင့် ပတ်သက်ဆက်စပ်သော အချက်အလက်များမှ သင့်တော်သလို၊ လိုအပ်သလို (သို့) အားလုံးအား အဆက်အသွယ်လုပ်ခြင်း၊ ထိန်းသိမ်းခြင်း၊ စုဆောင်းခြင်း၊ ဖော်ပြခြင်းနှင့် Customer အတွက် အကျိုးရှိမည်ဟု AEON မှယူဆသော အခြား ထုတ်ကုန်နှင့် ဝန်ဆောင်မှုများတွင် အသုံးချခြင်းအား Customer မှ သဘောတူညီပါသည်။
  ၈.၂) ဥပဒေအရသော်လည်းကောင်း၊ အွန်လိုင်းဝန်ဆောင်မှုအတွက် အကျိုးရှိသည်ဟု ယူဆ၍သော် လည်းကောင်း၊ Customer ၏ အချက်အလက်များနှင့်တကွ ဝန်ဆောင်မှုအား အသုံးပြုထားသည့် ဆောင်ရွက်မှုများအား AEON မှ လိုအပ်ပါက ထုတ်ဖော်ပြသရန် Customer မှ သဘောတူညီ ပါသည်။

  ၉)ဆက်သွယ်ဆောင်ရွက်ခြင်းများ AEON သည် Customer မှ နောက်ဆုံးသတင်းပေးထားသော ဖုန်းနံပါတ်၊ လိပ်စာ၊ အီးမေးလ် စသည်တို့ဖြင့် ဆက်သွယ်နိုင်ပါသည်။ AEON မှ ဖုန်း၊ အီးမေးလ်၊ ဝဘ်ဆိုဒ်၊ ဆော့ဝဲလ်၊ SMS၊ စာတိုက်မှတဆင့် စာပို့ခြင်းတို့အား AEON မှ Customer သို.အသိပေးသည်ဟုယူဆ၍ AEON (သို့) အခြားသူများ၊ အဖွဲ့အစည်းများ၏ ကြော်ငြာများ၊ ဝန်ဆောင်မှုများနှင့်ထုတ်ကုန်များ ဈေးကွက် မြှင့်တင်ခြင်းအလို့ငှာ ဆက်သွယ်ဆောင်ရွက်ခြင်းများအား Customer မှ ခွင့်ပြု သဘောတူပါသည်။

  ၁၀)ဝန်ဆောင်မှုအား ပယ်ဖျက်ခြင်း
  ၁၀.၁)အောက်ပါ အခြေအနေများတွင် AEONသည် Customerအား ကြိုတင်အသိပေး သဘော တူညီမှု.မရယူပဲ မည်သည့် အစိတ်အပိုင်းမဆို အသိမပေးပဲ အွန်လိုင်း ဝန်ဆောင်မှုအား ပယ်ဖျက် နိုင်ခွင့်ရှိသည်-
  က) Customerသည် မှတ်ပုံတင်သည့်နေ့ (သို့) နောက်ဆုံးဝင်ရောက်သည့်နေ့မှ အွန်လိုင်း ဝန်ဆောင်မှုအား တနှစ်ကျော်အသုံးမပြုခြင်း။
  ခ ) မည်သည့် အကြောင်းပြချက်နှင့်မဆို AEON အားပေးချေရမည့် ဝန်ဆောင်မှု အဖိုးအခများနှင့် အခြားကုန်ကျစားရိတ်များ မပေးသွင်းခြင်းအပါအဝင် အွန်လိုင်းဝန်ဆောင်မှု၏ စည်းမျဉ်း စည်းကမ်း ချက်များအား Customer မှ လိုက်နာရန်ပျက်ကွက်ခြင်း။
  ၁၀.၂) အွန်လိုင်းဝန်ဆောင်မှုမှ မည်သည့် ဝန်ဆောင်မှု အစိတ်အပိုင်းကိုမဆို ကြိုတင် အကြောင်း မကြားပဲ AEON မှပယ်ဖျက် နိုင်ခွင့်ရှိသည်။
  ၁၀.၃) Customerသည် AEON အား သတ်မှတ်ထားသောနည်းလည်းများနှင့်အညီ အကြောင်းကြား ပါက အွန်လိုင်းဝန်ဆောင်မှုအား ပယ်ဖျက်၊ ရပ်စဲနိုင်ပါသည်။

  ၁၁)အခြား အခြေအနေများ
  ၁၁.၁) ဤစည်းကမ်းချက်များထဲတွင်ပါဝင်သော စည်းကမ်းချက်တစ်ခုခုသည် မှန်ကန်မှု.မရှိခြင်း၊ ဥပဒေနှင့် ညီညွှတ်မှု.မရှိခြင်း (သို့) ဆောင်ရွက်ရန် အဆင်မပြေဖြစ်လာခြင်းများ ရှိလာပါကလည်း၊ ၎င်း စည်းကမ်းချက် အစိတ်အပိုင်းသည် ကျန်ရှိသည့် စည်းကမ်းချက်များ၏ မှန်ကန်မှုနှင့် ဆောင်ရွက်နိုင်မှုတို့အား သက်ရောက်နိုင်စေခြင်းမရှိစေရပါ။
  ၁၁.၂)အွန်လိုင်းဝန်ဆောင်မှုအား အသုံးပြုနေစဉ် AEON နှင့် Customer အကြား သဘောတူညီမှု တခုခုအရ  ထပ်ဆောင်းဝန်ဆောင်မှုပေးရာတွင် ၎င်းထပ်ဆောင်းဝန်ဆောင်မှုသည် အွန်လိုင်း ဝန်ဆောင်မှု၏ အစိတ်အပိုင်းတစ်ခုအနေအဖြင့် Customer မှ သဘောတူညီပါသည်။အငြင်းပွားမှု တစုံတရာဖြစ်ပွားလာပါက မူလအွန်လိုင်းဝန်ဆောင်မှုနှင့် ပတ်သက်လျင် အွန်လိုင်းဝန်ဆောင်မှု၏ စည်းကမ်းချက်သည် အတည်ဖြစ်ပြီး ထပ်တိုးဝန်ဆောင်မှုနှင့်ပတ်သက်လျင် ထပ်တိုးဝန်ဆောင်မှု၏ စည်းကမ်းချက်သည် အတည်ဖြစ်ပါသည်။
  ၁၁.၃) Customerသည် ၎င်း၏ ဝန်ဆောင်မှု ဆောင်ရွက်သည့်အတွက် အတည်ပြု မှတ်တမ်းများအား ပုံနှိပ်၍ သိမ်းဆည်းထားနိုင်ပါသည်။
  ၁၁.၄)အကယ်၍ ဤစည်းကမ်းချက်များသည် AEON၏ အခြားသော ဝန်ဆောင်မှုများ၏ စည်းကမ်းချက်များနှင့် ကွဲပြားမှုများရှိပါက ဤစည်းကမ်းချက်များသည် အွန်လိုင်းဝန်ဆောင်မှု အတွက်သာ သီးသန်.ဖြစ်ရပါမည်။
  ၁၁.၅) အငြင်းပွားမှုတစုံတရာ ဖြစ်ပွားပါက AEON အနေဖြင့် Customer နှင့် ပတ်သက်၍ အရေးယူဆောင်ရွက်မှု တစုံတရာပြုလုပ်ရာတွင် ဥပဒေအရ ခွင့်ပြုထားသော မည်သည့် အခွင့်အရေး၊ ကုစားမှုများကြောင့်မျှ နှောင့်နှေးခြင်း၊ ပျက်ကွက်ခြင်း၊ ပယ်ဖျက်ခြင်းမရှိပဲ AEON ၏ ဤ ဖော်ပြပါ စည်းကမ်းချက်များအတိုင်းသာ ဆောင်ရွက်နိုင်ပါမည်။
  ၁၁.၆) အွန်လိုင်းဝန်ဆောင်မှုနှင့် ၎င်း၏ ထပ်တိုးဝန်ဆောင်မှုများမှ ဖြစ်ပေါ်လာနိုင်သည့် အငြင်းပွားမှုများ အပေါ်တွင် မြန်မာနိုင်ငံ၏ ဥပဒေများနှင့်အညီ မြန်မာနိုင်ငံအတွင်းရှိ တရားရုံးများတွင်သာ ဤစည်းကမ်းချက်များအရ တရားစီရင်မှု.ကို Customer နှင့် AEON မှ သဘောတူညီပါသည်။
  """

  }
