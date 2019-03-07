//
//  TermsConditionViewController.swift
//  AEONVCS
//
//  Created by mac on 2/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class TermsConditionAgreeViewController: BaseUIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var svTermsCon: UIScrollView!
    @IBOutlet weak var lblTermsCon: UILabel!
    @IBOutlet weak var lblSwitch: UILabel!
    @IBOutlet weak var swAgree: UISwitch!
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var bbLoaleFlag: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnAgree.isEnabled = false
        self.btnAgree.alpha = 0.5
        self.swAgree.isOn = false
        
        let maxSize = CGSize(width: svTermsCon.frame.size.width, height: svTermsCon.frame.size.height)
        let size = lblTermsCon.sizeThatFits(maxSize)
        lblTermsCon.frame       = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        self.swAgree.addTarget(self, action: #selector(switchIsChanged), for: UIControl.Event.valueChanged)

        switch Locale.currentLocale {
        case .EN:
            self.bbLoaleFlag.image = UIImage(named: "mm_flag")
            self.lblTermsCon.text = engText
        case .MY:
            self.bbLoaleFlag.image = UIImage(named: "en_flag")
            self.lblTermsCon.text = mmText
            print("\(mmText.count)")
        }
        self.lblTitle.text = "terms.title".localized
        lblSwitch.text = "terms.switch.label".localized
        
        print("\(mmText.count)")
    }
    @objc func switchIsChanged(mySwitch: UISwitch) {
        super.updateViews()
        if mySwitch.isOn {
            self.btnAgree.isEnabled = true
            self.btnAgree.alpha = 1.0
            print("switch is on")
        } else {
            self.btnAgree.isEnabled = false
            self.btnAgree.alpha = 0.5
            print("switch is off")
        }
    }
    @IBAction func onClickeLocaleChange(_ sender: UIBarButtonItem) {
        super.updateLocale()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            self.bbLoaleFlag.image = UIImage(named: "mm_flag")
            self.lblTermsCon.text = engText
        case .MY:
            bbLoaleFlag.image = UIImage(named: "en_flag")
            self.lblTermsCon.text = mmText
        }
        self.lblTitle.text = "terms.title".localized
        lblSwitch.text = "terms.switch.label".localized
        
        print("\(mmText.count)")
    }
    
    @IBAction func onClickAgreeBtn(_ sender: UIButton) {
        
        UserDefaults.standard.set(true, forKey: Constants.IS_ALREADY_ACCEPT)
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func setTermsConsLabel(){
        
        switch Locale.currentLocale {
        case .EN:
            self.lblTermsCon.text = engText
        case .MY:
            self.lblTermsCon.text = mmText
        }
    }
    
    let engText:String = """
        1. General Information of the Service
            AEON Microfinance (Myanmar) Mobile Application for the customer of AEON Microfinance (Myanmar) Company Limited("AEON") to verify account information as well as execute transactions via application on mobile phone and tablet (“Application”) or website of AEON (“Website”).
        
        2. Agreement on Service Usage
            In using the online service, the customer hereby acknowledges,agrees and accepts as follows:
        2.1 The customer agrees to abide by and be liable to AEON under the terms and conditions prescribed herein, on Application and Website including the terms and conditions to be further prescribed or amended by AEON as it deems appropriate, which shall form part of these terms and conditions.
        2.2 The customer agrees that any transaction made via the online service after logging in using Username, Password specifically granted to the customer, including customer verification of identifying identity and confirming transaction of the customer shall be deemed as correctly and validly made by the customer. Upon confirming the transaction, the transaction shall be legally binding on the customer and can be cited as evidence without any other evidence bearing the customer’s signature required. In this regard, the customer waives the right to object or challenge AEON against any such transaction executed via the online service and the accuracy thereof.
        2.3 AEON reserves the right to provide all or some features of the mobile application during the service hours announced on Website or Application. The mobile application’s features available on Website and Application may be different. AEON may consider to configure, remove or add any features at any time as it deems appropriate.
        2.4 The customer agrees and acknowledges that AEON may not be able to provide the online service in the event of breakdown, malfunction, improvement or reparation of the computer system, component, telecommunication system and relevant network system or any force majeure events.
        2.5 AEON reserves the right to suspend or stop the online service temporarily or permanently at any time with notice to the customer as necessary or on reasonable basis.
         
        3. Conditions of Use
        For security in using the Online Service, the customer agrees:
        3.1 To ensure that the computer terminal, equipment and other electronic communication devices, connection to internet network and/or web browser used to access the Online Service have adequate capacity and have been installed with protection against computer viruses, malwares and any other deceptive programs designed to destroy or restrict accession to data and other threats, as well as meet the standard specifications set by AEON.
        3.2 To be careful in accessing to and filling out information concerning member card, personal information and other information of the customer.
        3.3 To protect and keep confidential personal information, the Username, Password as assigned to the customer by AEON and those changed afterwards.
        3.4 Not to leave the computer terminal, equipment and /or other electronic communication devices which are logged in unattended and to log off the online service every time after use.
        3.5 In the event that the customer accesses to the mobile application using shared computers, shared electronic communication devices and/or public internet network the customer agrees to be responsible for all damages incurred by the customer, AEON and any other person should there be any unauthorized access to or any transaction being executed through the mobile application, or personal information of the customer or other AEON’s customers being revealed. In this regard, AEON reserves the right to suspend the mobile application, whether in whole or in part, for so long as and in the event that the customer accesses to the mobile application in such manner or through such or other connection AEON deems unsecured.
        3.6 If the Password of the customer is lost, stolen or if the customer suspects that other person may know or be able to guess them, the customer shall promptly change the Password by the method as prescribed by AEON. It shall be sole responsibility of the customer to do so. Failure to do so will result in liability to the customer for all transactions and all losses and damages occurred.
        3.7 In the event of error while using or transacting via the Online Service, the customer shall inform AEON in writing within 7 days from the date of such error, otherwise it shall be deemed that the transaction executed is correct and valid.
        In reporting error, the customer shall prepare and send to AEON a letter informing at least the following details:
        3.7.1 Date and time of the transaction;
        3.7.2 Location of the computer terminal, equipment or the electronic communication devices used and type of internet network connection;
        3.7.3 16-digit number of member card, name and contactable telephone number of the customer;
        3.7.4 Type of transaction; and
        3.7.5 Description of the error and reference code (if any)
         
        4. Protection of Customer Security
        AEON reserves the right to suspend the Online Service if repeatedly entered wrong Username, Password over the number of times allowed by AEON. In such case, transaction on process shall be immediately cancelled and the customer shall not be able to claim for any damages which may arise therefrom. To resume the Online Service, the customer can Call Center of AEON at 01-9345-466 during working days and hours.
         
        5. No Warranty
        The information and materials contained in Application and Website, including text, graphics, links or other items are provided on "as is" and "as available" basis. AEON does not warrant the accuracy, adequacy or completeness of the information and materials, and expressly disclaims liability for errors or omissions in providing information and materials. No warranty of any kind, implied, expressed or statutory including but not limited to the warranties of non-infringement of third party rights and title, merchantability, fitness for a particular purpose and freedom from computer virus, is given in conjunction therewith.
         
        6. Exemption of Liability
        In no event shall AEON be liable for any losses, damages including without limitation direct, indirect, special, incidental or consequential damages or difficulties incurred by the customer from using or transacting via the Online Service including in the following cases:
            6.1 The customer discloses his/her Username, Password to other person so as to allow such other person to login and execute transactions on his/her behalf, including to use the Online Service for illegal purpose.
        6.2 Any cause attributable to deliberate act or negligence on the part of the customer.
        6.3 Non-compliance by the customer with the terms and conditions of the Online Service including manuals and guidelines for using the Online Service issued by AEON, or any applicable laws and regulations.
        6.4 Any error occurred from change or cancellation of the instruction and/or information transmitted to the Online Service or failure of performance, error, omission, interruption, defect, delay in operation or transmission of the system and/or web browser and/or the internet service provider or telephone network provider of the customer or AEON.
        6.5 Cyber intrusion and/or attack by any person or group of person on any hardware, software and/or components relating to the Online Service, including release of program that may be harmful to system such as Virus, Trojan Horses and Worms which may affect the operation of the Online Service.
        6.6 Damage and/or inability to use the system, program and/or equipment for using the Online Service whether it be of AEON or other person, including but not limited to damage and/or error of the system, program, computer server system, electricity supply system, telecommunication devices, electricity devices, telephone line and/or telecommunication network system and/or any part of electronic system occurs.
        6.7 Any loss of data in the course of transmission whether via the Online Service system or other system of AEON or other system of the customer or internet service provider.
        6.8 Any damage caused by fire, earthquake, flood, accidents, riots, protests, civil disturbances, war, closure of business or strikes, disruption of electricity or services provided by the internet service provider, or other force majeure beyond the control of AEON and AEON is prevented from providing the Online Service.
        In those cases under clauses 6.1 – 6.3, the customer agrees to be responsible for any and all damages suffered by AEON and any other persons.
         
        7. Service Fees
        The customer agrees to pay service fees, charges and other expenses for the Online Service usage at the rates prescribed by AEON (at present, the Online Service is provided free-of-charge).
         
        8. Information
        8.1 The customer agrees that AEON may contact, inquire, maintain, collect, disclose and use any or all information concerning the customer as necessary and appropriate or as AEON deems beneficial to the customer in receiving information on other products and/or services.
        8.2 In case that AEON is required to disclose financial information or transaction or other information related to  the Online Service usage of the customer to any agencies pursuant to the provisions of laws, orders, or rules and regulations issued by any competent or regulating authorities  or disclosure is made for the benefit of the Online Service provision or for such other purpose as AEON deems appropriate, the customer agrees and consents AEON to disclose and/or report information and transaction of the customer in all respects, and agrees that such consent shall continue to be valid regardless of the customer’s terminating subscription to the Online Service, the Online Service account, or loan account or credit card account has been closed.
         
        9. Communication
        AEON may contact the customer via mobile phone, address or email given or last informed to AEON.
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
    (၁) ၀န္ေဆာင္မႈႏွင့္ဆက္စပ္ေသာအေထြေထြ သတင္းအခ်က္အလက္မ်ား

    AEON Microfinance (Myanmar) Co.Ltd. (AEON) ၏ Customer မ်ားအတြက္ AEON Microfinance (Myanmar) Mobile Application သည္ Customer ၏အခ်က္အလက္မ်ားအား မိုဘိုင္းဖုန္း၊တက္ဘလက္ႏွင့္ အီရြန္၀က္ဆိုဒ္မွ တဆင့္ ေလွ်ာက္ထားမွဳ.မ်ားကို စစ္ေဆးရန္ႏွင့္ အျခားေသာ၀န္ေဆာင္မႈမ်ားကိုလည္း ေဆာင္႐ြက္ႏိုင္ရန္ျဖစ္ပါသည္။

    (၂) ၀န္ေဆာင္မႈအသုံးျပဳျခင္းဆိုင္ရာ သေဘာတူညီမႈ

    Online Services အား အသုံးျပဳျခင္းျဖင့္ Customerသည္ ေအာက္ပါအခ်က္အလက္မ်ားအား သိရွိ နားလည္ သေဘာတူ လက္ခံပါသည္။

    ၂.၁ ) Customer သည္ Application ေပၚတြင္လည္းေကာင္း၊ Website ေပၚတြင္လည္းေကာင္း Company မွ ေနာင္တြင္ အခါအားေလ်ာ္စြာ ျပင္ဆင္မည့္ သင့္ေလ်ာ္သည့္ စည္းကမ္းခ်က္မ်ားကို လည္း ယခု ေဖာ္ျပထားေသာ စည္းကမ္းခ်က္မ်ား၏ အစိတ္အပိုင္းတစ္ခုအေနျဖင့္ ဆက္လက္ တည္ရွိေနမည္ ျဖစ္ေၾကာင္း သေဘာတူညီပါသည္္။

    ၂.၂) Customerသည္ မည္သည့္ ေဆာင္ရြက္ခ်က္မွဳမ်ိဳးကိုမဆို လုပ္ေဆာင္ရန္ ၎အား ေပးအပ္ထားေသာ User Name, Password ျဖင့္ Online Service သို႔ ၀င္ေရာက္ ေဆာင္ရြက္ ခ်က္မ်ားအား ကိုယ္တိုင္ ကိုယ္ပိုင္သေဘာဆႏၵျဖင့္ေဆာင္႐ြက္ျခင္းျဖစ္သည္ဟုသတ္မွတ္ပါသည္။
    ေဆာင္႐ြက္မွွဳ.မ်ားအား အတည္ျပဳၿပီးပါက Customer၏ ေဆာင္႐ြက္မွဳ.မ်ားအား တရား၀င္ သက္ေသ အေထာက္ထားအျဖစ္ သတ္မွတ္ထားျခင္းျဖစ္သျဖင့္ Customer၏ ထိုးၿမဲလက္မွတ္အား ရယူရန္ မလိုအပ္ေတာ့ပါ။
    ဤအေၾကာင္းအရာႏွင့္ ပတ္သတ္၍ Customer သည္ Online Services အသုံးျပဳေသာ မည္သည့္၀န္ေဆာင္မႈႏွင့္ပတ္သတ္၍ AEON အား ကန္႔ကြက္ျခင္း တရားစြဲဆိုခြင့္ မရွိေစရပါ။

    ၂.၃) AEON သည္ ၀န္ေဆာင္မႈ႕ ေပးသည့္ အခ်ိန္အတြင္း Mobile Application (သို႔) ဝဘ္ဆိုဒ္၏ ၀န္ေဆာင္မႈ အားလုံး (သို႔) အခ်ိဳ႕ အစိတ္အပိုင္းမ်ားအား ျပင္ဆင္စီစဥ္ ေဆာင္႐ြက္ႏိုင္ခြင့္ ရွိသည္။
    Mobile Applicationတြင္ ပါဝင္ေသာ ဝန္ေဆာင္မႈမ်ားႏွင့္ ဝဘ္ဆိုဒ္တြင္ပါဝင္ေသာ ဝန္ေဆာင္မႈမ်ား အၾကားတစ္ခါတရံ ကြဲလြဲမႈမ်ားရွိႏိုင္ပါသည္။ AEONသည္ မည္သည့္အခ်ိန္တြင္မဆို ဝန္ေဆာင္မႈ မ်ားအား သင့္ေတာ္သလို အသစ္ထည့္သြင္းျခင္း၊ ပယ္ဖ်က္ျခင္း၊ ျပင္ဆင္ျခင္းမ်ားအား ျပဳလုပ္ႏိုင္ ပါသည္။
    ၂.၄) ကြန္ပ်ဴတာစနစ္ခ်ိဳ.ယြင္းမွဳ.၊ ဆက္သြယ္ေရးဆိုင္ရာခ်ိဳ.ယြင္းမွဳ.၊ ကြန္ယက္ပိုင္းဆိုင္ရာ ခ်ိဳ.ယြင္းမွဳ.၊ အျခားေသာ သဘာဝေဘးအႏၲရာယ္မ်ားေၾကာင့္ Online Service အလုပ္မလုပ္ျခင္း မ်ားရွိပါက  Customer အေနျဖင့္ နားလည္ ခြင့္လြတ္ရန္ သေဘာတူပါသည္။

    ၂.၅) AEON သည္ Customer အား ႀကိဳတင္အသိေပးရန္လိုအပ္ပါက အသိေပးၿပီး Online Service ကို ယာယီေသာ္လည္းေကာင္း၊ အျမဲတမ္းေသာ္လည္းေကာင္း ရပ္ဆိုင္းႏိုင္ခြင့္ရွိပါသည္။

    ၃) မိုဘိုင္းအသုံးျပဳျခင္းဆိုင္ရာ သတ္မွတ္ခ်က္မ်ား
    Mobile Application အသုံးျပဳရာတြင္ လုံၿခဳံေရးအလို႔ငွာ ေအာက္ပါအခ်က္မ်ားအား Customer မွ လိုက္နာေဆာင္ရြက္ရန္ သေဘာတူညီပါသည္-

    ၃.၁) Online Service အား အသုံးျပဳရာတြင္ အသုံးျပဳေသာ ဆက္သြယ္ေရးစက္ပစၥည္းမ်ား၊ ကြန္ပ်ဴတာမ်ား၊ ကြန္ယက္မ်ား၊ ဝဘ္ဘေရာက္ဇာမ်ားသည္ ဗိုင္းရပ္စ္မ်ားႏွင့္ အျခားေသာ အခ်က္အလက္အားေႏွာက္ယွက္ေဖာက္ထြင္းႏိုင္သည့္ ပ႐ိုဂရမ္မ်ားမွ အကာအကြယ္ရရွိေအာင္ ေဆာင္႐ြက္ထားရန္လိုအပ္ၿပီး AEON ၏သတ္မွတ္စံႏႈန္းမ်ားႏွင့္လည္း ကိုက္ညီရပါမည္။

    ၃.၂) Customer ၏ အဖြဲ႕ဝင္ကဒ္၊ ကိုယ္ေရးကိုယ္တာႏွင့္ အျခားေသာအခ်က္အလက္မ်ားအား ျဖည့္စြက္ျခင္း၊ ရယူျခင္းမ်ားျပဳလုပ္ရာတြင္ ဂ႐ုျပဳေဆာင္႐ြက္ရန္ လိုအပ္ပါသည္။

    ၃.၃) AEON မွ Customer သို႔ေပးအပ္ထားေသာ Username, Password ႏွင့္ ျပင္ဆင္ ေျပာင္းလဲလိုက္ေသာ Password မ်ားအား လုံၿခဳံစြာ ထိန္းသိမ္းထားရပါမည္။

    ၃.၄) အသုံးျပဳေသာဆက္သြယ္ေရးစက္ပစၥည္းမ်ား၊ ကြန္ပ်ဴတာမ်ားအားLogin ဝင္ေရာက္လ်က္ အေနအထားျဖင့္ ထြက္ခြာျခင္း မျပဳလုပ္ရန္ႏွင့္ Mobile Application အား အသုံးျပဳၿပီးတိုင္း Log out ျပဳလုပ္ရပါမည္။

    ၃.၅) မွ်ေဝ၍ အသုံးျပဳေသာ ဆက္သြယ္ေရးစက္ပစၥည္းမ်ား၊ ကြန္ပ်ဴတာမ်ား၊ အမ်ားသုံး အင္တာနက္ ကြန္ယက္မ်ား အသုံးျပဳျခင္းအတြက္ Customer, AEON, အျခားသူ တစ္ဦးဦးေၾကာင့္ ျဖစ္ေပၚလာေသာ ခြင့္ျပဳခ်က္မရွိသည့္ ဝန္ေဆာင္မႈ အသုံးခ် ေဆာင္႐ြက္ျခင္း၊ Customer၏ ကိုယ္ေရးအခ်က္အလက္ ေပါက္ၾကားျခင္း၊ အျခားေသာ AEON Customerမ်ား၏ အခ်က္ အလက္မ်ား ေပါက္ၾကားျခင္း စသည့္ မည္သည့္ ထိခိုက္နစ္နာမွဳ.မ်ိဳးကိုမဆို Customer မွ အျပည့္အဝ တာဝန္ယူရန္ သေဘာတူညီပါသည္။ ဤအေၾကာင္းအရာႏွင့္ ဆက္စပ္၍ လုံၿခဳံမႈမရွိဟု ယူဆရေသာ ခ်ိတ္ဆက္မႈႏွင့္ Customer၏ Mobile Application အသုံးခ်ခြင့္အား တစ္စိတ္တစ္ပိုင္းေသာ္လည္းေကာင္း၊ အျပည့္အဝေသာ္လည္းေကာင္း ရပ္ဆိုင္းရန္ AEON တြင္ အခြင့္ ရွိပါသည္။
    ၃.၆) အကယ္၍ Customer ၏ Password သည္ ေပ်ာက္ဆုံးျခင္း၊ အခိုးခံရျခင္း၊ အျခားသူတစ္ဦးက သိရွိျခင္း (သို႔) ခန္႔မွန္းနိင္သည္ဟု ယူဆရပါက AEON မွၫႊန္ၾကားထားသည့္ နည္းလမ္းအတိုင္း Password အား ခ်က္ျခင္း ေျပာင္းလဲရပါမည္။ ထိုသို႔ ျပဳလုပ္ရန္မွာ Customer ၏ တာဝန္သာ ျဖစ္ပါသည္။ ထိုသို႔ ျပဳလုပ္ရန္ ပ်က္ကြက္ပါက Customer အတြက္ ဆုံးရွုဳံးမွဳ.ႏွင့္ ထိခိုက္နစ္နာမႈမ်ား အတြက္ Customer တြင္သာ တာ၀န္ရွိပါမည္။

    ၃.၇) Online Service အသုံးျပဳ၍ ဝန္ေဆာင္မႈမ်ားအား ေဆာင္႐ြက္ရာတြင္ အမွားအယြင္း တစုံတရာျဖစ္ေပၚလာပါက Customer အေနျဖင့္ ျဖစ္ပြားသည့္ေန႔မွ (၇)ရက္အတြင္း AEON သို႔ စာျဖင့္ အေၾကာင္းၾကားရပါမည္။ ထိုသို႔မဟုတ္ပါက ေဆာင္႐ြက္မႈအား မွန္ကန္ အက်ဳံးဝင္သည္ဟု ယူဆေဆာင္႐ြက္သြားပါမည္။
    အေၾကာင္းၾကားစာတြင္ ေအာက္ပါ အေသးစိတ္ အခ်က္မ်ား ပါဝင္ရပါမည္-

    ၃.၇.၁)    ဝန္ေဆာင္မႈ ေဆာင္႐ြက္သည့္ ေန႔စြဲ ႏွင့္ အခ်ိန္
    ၃.၇.၂) အသုံးျပဳေသာ ဆက္သြယ္ေရးစက္ပစၥည္းမ်ား၊ ကြန္ပ်ဴတာမ်ား၏ တည္ေနရာႏွင့္  ခ်ိတ္ဆက္ေသာ အင္တာနက္ ကြန္ယက္အမ်ိဳးအစား
    ၃.၇.၃)    အဖြဲ႕ဝင္၏ ဂဏန္း၁၆လုံးပါ အဖြဲ.၀င္ကတ္ျပားနံပါတ္၊ အမည္၊ ဆက္သြယ္ရန္ဖုန္း
    ၃.၇.၄)    ေဆာင္႐ြက္ခဲ့သည့္ ဝန္ေဆာင္မႈ အမ်ိဳးအစား
    ၃.၇.၅)    အမွားအယြင္းျဖစ္ပြားစဥ္ ေဖာ္ျပခဲ့ေသာစာသားႏွင့္ အၫႊန္းကုဒ္ (ပါရွိပါက)

    ၄) Customer ၏ လုံၿခဳံေရးအတြက္ အကာအကြယ္မ်ား

    AEONမွ ခြင့္ျပဳထားေသာ Username မွားယြင္းအသုံးျပဳျခင္းႏွင့္ခြင့္ျပဳထားေသာ အၾကိမ္အေရ အတြက္ထက္ ပို၍ Password အား ဆက္တိုက္ျဖည့္စြက္ပါက Online Service အား AEON မွ ရပ္ဆိုင္းပိုင္ခြင့္ရွိပါသည္။ထိုသို.ရပ္ဆိုင္းမွဳ.မ်ားအတြက္ Customerတြင္ထိခိုက္မွဳ.ရွိပါကCustomer  အေနျဖင့္ AEONသို. ေတာင္းဆိုပိုင္ခြင့္ မရွိပါ။
    Online Service အား ျပန္လည္ အသုံးျပဳႏိုင္ရန္ Customer အေနျဖင့္ AEON ၏ Call Center ဖုန္းနံပါတ္ 01-93 45 466 သို႔ အလုပ္ခ်ိန္အတြင္း ဆက္သြယ္ႏိုင္ပါသည္။

    ၅) တာ၀န္ခံမွဳ.မွ ကင္းလြတ္ျခင္း

    Mobile Application ႏွင့္ ဝဘ္ဆိုဒ္တြင္ပါရွိေသာ စာသား၊ပုံ၊လင့္ခ္ႏွင့္ အျခားေသာ အခ်က္ အလက္မ်ားမွာ အရွိအတိုင္းရရွိႏိုင္မည့္ အတိုင္းအတာအထိသာ ေဖာ္ျပထားသည္ျဖစ္ရာ  တိက်ေသခ်ာမႈ၊ ျပည့္စုံလုံေလာက္မႈႏွင့္ ပတ္သက္၍ AEON မွ အာမ မခံ၊ တာ၀န္မယူသလို ၎ေဖာ္ျပပါ အခ်က္အလက္ ပါဝင္မႈမ်ားႏွင့္ပတ္သက္၍ မွားယြင္းျခင္း ပ်က္ကြက္ျခင္းမ်ား အတြက္လည္း AEON တြင္တာဝန္မရွိပါ။

    ၆)တာဝန္မရွိျခင္းႏွင့္ တာ၀န္ယူမွဳ.မွ ကင္းလြတ္ျခင္း။

    ေအာက္ပါကိစၥရပ္မ်ား အပါအဝင္ customerမွ တိုက္႐ိုက္ေသာ္လည္းေကာင္း၊ သြယ္ဝိုက္၍ ေသာ္လည္းေကာင္း တမင္ရည္႐ြယ္၍ေသာ္လည္းေကာင္း မရည္႐ြယ္ပဲ မေတာ္တဆေသာ္ လည္းေကာင္း၊ အြန္လိုင္းဝန္ေဆာင္မႈအား အသုံးျပဳ၍ ေဆာင္႐ြက္မႈေၾကာင့္ ျဖစ္ေပၚလာသည့္ ေနာက္ဆက္တြဲ ပ်က္စီးမည့္ မည္သည့္ ဆုံးရႈံးမႈ၊ ထိခိုက္မႈ၊ နစ္နာမႈ မ်ားအတြက္ AEON တြင္ တာဝန္မရွိေစရပါ-

    ၆.၁) Customer သည္ ၎၏ Username, Password တို႔အား အျခားသူ တစ္ဦးဦးအား ေဖာ္ျပသျဖင့္ ၎မွ Customer ၏ ကိုယ္စား ဝန္ေဆာင္မႈမ်ားအား တရားဥပေဒႏွင့္ မလြတ္ကင္းေသာ ကိစၥရပ္မ်ားအား ရည္ရြယ္ခ်က္ျဖင့္ ေဆာင္ရြက္ျခင္း။

    ၆.၂) Customer ၏ တမင္သက္သက္ေသာ္လည္းေကာင္း ေပါ့ပ်က္စြာေသာ္လည္းေကာင္း လုပ္ေဆာင္မႈေၾကာင့္ျဖစ္ပ်က္ေသာ မည္သည့္ အေၾကာင္းကိစၥရပ္မ်ားမဆို။

    ၆.၃) AEON မွ ထုတ္ေဝထားေသာ အြန္လိုင္းဝန္ေဆာင္မႈအတြက္ လက္စြဲႏွင့္ လမ္းၫႊန္ခ်က္မ်ား၊ စည္းမ်ဥ္းႏွင့္ သတ္မွတ္ခ်က္မ်ားကို Customer မွ လိုက္နာရန္ ပ်က္ကြက္ျခင္း မ်ားေၾကာင့္ ျဖစ္ေပၚလာေသာ ျပဌာန္းထားသည့္ ဥပေဒမ်ား၊ စည္းမ်ဥ္းမ်ားႏွင့္ မကိုက္ညီေသာ ကိစၥရပ္မ်ား။

    ၆.၄) လမ္းၫႊန္ခ်က္မ်ားေျပာင္းလဲျခင္း၊ ပယ္ဖ်က္ျခင္း(သို.မဟုတ္) ၊ Online Servcie အလုပ္ မလုပ္ျခင္း အမွားႏွင့္ က်န္ခဲ့ျခင္းမ်ား၊ ေႏွာင့္ယွက္မွဳ.မ်ား ၾကန္.ၾကာမွဳ.မ်ား အတြက္ တာ၀န္မရွိပါ။

    ၆.၅) အြန္လိုင္းအသုံးျပဳသည့္ Hardware, Software မ်ားအားျပင္ပ ပုဂိိိဳလ္တစ္ဦး(သို.) ပုဂိဳလ္တစ္စုမွ တိုက္ခိုက္ျခင္းေၾကာင့္ ျဖစ္ေပၚလာမည့္ ထိခိုက္မွဳ.မ်ား။

    ၆.၆) အြန္လိုင္းအသုံးျပဳရာတြင္ ကြန္ပ်ဴတာခ်ိဳ.ယြင္းျခင္း၊ လွ်ပ္စစ္စနစ္ခ်ိဳ.ယြင္းျခင္း၊ ဆက္သြယ္ေရး စနစ္ခ်ိဳ.ယြင္းျခင္း၊ လွ်ပ္စစ္ပစၥည္းမ်ား ခ်ိဳ.ယြင္းျခင္း၊ တယ္လီဖုန္းဆက္သြယ္ေရး လိုင္းမ်ား ခ်ိဳ.ယြင္းျခင္းေၾကာင့္ ျဖစ္ေပၚလာနိဳင္သည့္ ဆုံးရွဳံးမွဳ.မ်ား။

    ၇)ဝန္ေဆာင္ခ
    အြန္လိုင္းဝန္ေဆာင္မႈအား အသုံးျပဳရာတြင္ AEON မွ သတ္မွတ္ထားေသာ  ၀န္ေဆာင္ခႏွင့္ အျခားေသာ ကုန္က်စရိတ္မ်ား ေပးေဆာင္ရန္ Customer မွ သေဘာတူပါသည္။(လက္ရွိတြင္ အြန္လိုင္း ဝန္ေဆာင္ခ ေပးရန္မလိုပါ။)


    ၈)သတင္းအခ်က္အလက္မ်ားအသုံးျပဳျခင္း။
    ၈.၁)  Customer ႏွင့္ ပတ္သက္ဆက္စပ္ေသာ အခ်က္အလက္မ်ားမွ သင့္ေတာ္သလို၊ လိုအပ္သလို (သို႔) အားလုံးအား အဆက္အသြယ္လုပ္ျခင္း၊ ထိန္းသိမ္းျခင္း၊ စုေဆာင္းျခင္း၊ ေဖာ္ျပျခင္းႏွင့္ Customer အတြက္ အက်ိဳးရွိမည္ဟု AEON မွယူဆေသာ အျခား ထုတ္ကုန္ႏွင့္ ဝန္ေဆာင္မႈမ်ားတြင္ အသုံးခ်ျခင္းအား Customer မွ သေဘာတူညီပါသည္။

    ၈.၂) ဥပေဒအရေသာ္လည္းေကာင္း၊ အြန္လိုင္းဝန္ေဆာင္မႈအတြက္ အက်ိဳးရွိသည္ဟု ယူဆ၍ေသာ္ လည္းေကာင္း၊ Customer ၏ အခ်က္အလက္မ်ားႏွင့္တကြ ဝန္ေဆာင္မႈအား အသုံးျပဳထားသည့္ ေဆာင္႐ြက္မႈမ်ားအား AEON မွ လိုအပ္ပါက ထုတ္ေဖာ္ျပသရန္ Customer မွ သေဘာတူညီ ပါသည္။

    ၉)ဆက္သြယ္ေဆာင္ရြက္ျခင္းမ်ား
    AEON သည္ Customer မွ ေနာက္ဆုံးသတင္းေပးထားေသာ ဖုန္းနံပါတ္၊ လိပ္စာ၊ အီးေမးလ္ စသည္တို႔ျဖင့္ ဆက္သြယ္ႏိုင္ပါသည္။ AEON မွ ဖုန္း၊ အီးေမးလ္၊ ဝဘ္ဆိုဒ္၊ ေဆာ့ဝဲလ္၊ SMS၊ စာတိုက္မွတဆင့္ စာပို႔ျခင္းတို႔အား AEON မွ Customer သို.အသိေပးသည္ဟုယူဆ၍ AEON (သို႔) အျခားသူမ်ား၊ အဖြဲ႕အစည္းမ်ား၏ ေၾကာ္ျငာမ်ား၊ ဝန္ေဆာင္မႈမ်ားႏွင့္ထုတ္ကုန္မ်ား ေဈးကြက္ ျမႇင့္တင္ျခင္းအလို႔ငွာ ဆက္သြယ္ေဆာင္႐ြက္ျခင္းမ်ားအား Customer မွ ခြင့္ျပဳ သေဘာတူပါသည္။

    ၁၀)ဝန္ေဆာင္မႈအား ပယ္ဖ်က္ျခင္း

    ၁၀.၁)ေအာက္ပါ အေျခအေနမ်ားတြင္ AEONသည္ Customerအား ၾကိဳတင္အသိေပး သေဘာ တူညီမွဳ.မရယူပဲ မည္သည့္ အစိတ္အပိုင္းမဆို အသိမေပးပဲ အြန္လိုင္း ဝန္ေဆာင္မႈအား ပယ္ဖ်က္ ႏိုင္ခြင့္ရွိသည္-

    က) Customerသည္ မွတ္ပုံတင္သည့္ေန႔ (သို႔) ေနာက္ဆုံးဝင္ေရာက္သည့္ေန႔မွ အြန္လိုင္း ဝန္ေဆာင္မႈအား တႏွစ္ေက်ာ္အသံုးမျပဳျခင္း။

    ခ ) မည္သည့္ အေၾကာင္းျပခ်က္ႏွင့္မဆို AEON အားေပးေခ်ရမည့္ ဝန္ေဆာင္မႈ အဖိုးအခမ်ားႏွင့္ အျခားကုန္က်စားရိတ္မ်ား မေပးသြင္းျခင္းအပါအဝင္ အြန္လိုင္းဝန္ေဆာင္မႈ၏ စည္းမ်ဥ္း စည္းကမ္း ခ်က္မ်ားအား Customer မွ လိုက္နာရန္ပ်က္ကြက္ျခင္း။

    ၁၀.၂) အြန္လိုင္းဝန္ေဆာင္မႈမွ မည္သည့္ ဝန္ေဆာင္မႈ အစိတ္အပိုင္းကိုမဆို ၾကိဳတင္ အေၾကာင္း မၾကားပဲ AEON မွပယ္ဖ်က္ ႏိုင္ခြင့္ရွိသည္။

    ၁၀.၃) Customerသည္ AEON အား သတ္မွတ္ထားေသာနည္းလည္းမ်ားႏွင့္အညီ အေၾကာင္းၾကား ပါက အြန္လိုင္းဝန္ေဆာင္မႈအား ပယ္ဖ်က္၊ ရပ္စဲႏိုင္ပါသည္။

    ၁၁)အျခား အေျခအေနမ်ား

    ၁၁.၁) ဤစည္းကမ္းခ်က္မ်ားထဲတြင္ပါဝင္ေသာ စည္းကမ္းခ်က္တစ္ခုခုသည္ မွန္ကန္မွဳ.မရွိျခင္း၊ ဥပေဒႏွင့္ ညီညႊတ္မွဳ.မရွိျခင္း (သို႔) ေဆာင္႐ြက္ရန္ အဆင္မေျပျဖစ္လာျခင္းမ်ား ရွိလာပါကလည္း၊ ၎ စည္းကမ္းခ်က္ အစိတ္အပိုင္းသည္ က်န္ရွိသည့္ စည္းကမ္းခ်က္မ်ား၏ မွန္ကန္မႈႏွင့္ ေဆာင္႐ြက္ႏိုင္မႈတို႔အား သက္ေရာက္ႏိုင္ေစျခင္းမရွိေစရပါ။

    ၁၁.၂)အြန္လိုင္းဝန္ေဆာင္မႈအား အသုံးျပဳေနစဥ္ AEON ႏွင့္ Customer အၾကား သေဘာတူညီမႈ တခုခုအရ  ထပ္ေဆာင္းဝန္ေဆာင္မႈေပးရာတြင္ ၎ထပ္ေဆာင္းဝန္ေဆာင္မႈသည္ အြန္လိုင္း ဝန္ေဆာင္မႈ၏ အစိတ္အပိုင္းတစ္ခုအေနအျဖင့္ Customer မွ သေဘာတူညီပါသည္။အျငင္းပြားမႈ တစုံတရာျဖစ္ပြားလာပါက မူလအြန္လိုင္းဝန္ေဆာင္မႈႏွင့္ ပတ္သက္လ်င္ အြန္လိုင္းဝန္ေဆာင္မႈ၏ စည္းကမ္းခ်က္သည္ အတည္ျဖစ္ၿပီး ထပ္တိုးဝန္ေဆာင္မႈႏွင့္ပတ္သက္လ်င္ ထပ္တိုးဝန္ေဆာင္မႈ၏ စည္းကမ္းခ်က္သည္ အတည္ျဖစ္ပါသည္။

    ၁၁.၃) Customerသည္ ၎၏ ဝန္ေဆာင္မႈ ေဆာင္႐ြက္သည့္အတြက္ အတည္ျပဳ မွတ္တမ္းမ်ားအား ပုံႏွိပ္၍ သိမ္းဆည္းထားႏိုင္ပါသည္။

    ၁၁.၄)အကယ္၍ ဤစည္းကမ္းခ်က္မ်ားသည္ AEON၏ အျခားေသာ ဝန္ေဆာင္မႈမ်ား၏ စည္းကမ္းခ်က္မ်ားႏွင့္ ကြဲျပားမႈမ်ားရွိပါက ဤစည္းကမ္းခ်က္မ်ားသည္ အြန္လိုင္းဝန္ေဆာင္မႈ အတြက္သာ သီးသန္.ျဖစ္ရပါမည္။

    ၁၁.၅) အျငင္းပြားမႈတစုံတရာ ျဖစ္ပြားပါက AEON အေနျဖင့္ Customer ႏွင့္ ပတ္သက္၍ အေရးယူေဆာင္႐ြက္မႈ တစုံတရာျပဳလုပ္ရာတြင္ ဥပေဒအရ ခြင့္ျပဳထားေသာ မည္သည့္ အခြင့္အေရး၊ ကုစားမႈမ်ားေၾကာင့္မွ် ေႏွာင့္ေႏွးျခင္း၊ ပ်က္ကြက္ျခင္း၊ ပယ္ဖ်က္ျခင္းမရွိပဲ AEON ၏ ဤ ေဖာ္ျပပါ စည္းကမ္းခ်က္မ်ားအတိုင္းသာ ေဆာင္႐ြက္ႏိုင္ပါမည္။

    ၁၁.၆) အြန္လိုင္းဝန္ေဆာင္မႈႏွင့္ ၎၏ ထပ္တိုးဝန္ေဆာင္မႈမ်ားမွ ျဖစ္ေပၚလာႏိုင္သည့္ အျငင္းပြားမႈမ်ား အေပၚတြင္ ျမန္မာႏိုင္ငံ၏ ဥပေဒမ်ားႏွင့္အညီ ျမန္မာနိဳင္ငံအတြင္းရွိ တရား႐ုံးမ်ားတြင္သာ ဤစည္းကမ္းခ်က္မ်ားအရ တရားစီရင္မွဳ.ကို Customer ႏွင့္ AEON မွ သေဘာတူညီပါသည္။
"""
}
