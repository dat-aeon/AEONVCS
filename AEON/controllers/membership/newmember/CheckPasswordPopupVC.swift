//
//  CheckPasswordPopupVC.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 3/9/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class CheckPasswordPopupVC: BaseUIViewController {

    @IBOutlet weak var svTermsCon: UIScrollView!
    @IBOutlet weak var lbTermsTItle: UILabel!
    @IBOutlet weak var lblTermsCon: UILabel!
    @IBOutlet weak var lbSwichTitle: UILabel!
    @IBOutlet weak var swAgree: UISwitch!
    @IBOutlet weak var tfPassword: UITextField! {
        didSet {
            self.tfPassword.layer.cornerRadius = 3
            self.tfPassword.clipsToBounds = true
            self.tfPassword.layer.borderColor = UIColor.gray.cgColor
            self.tfPassword.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var delegate :CheckPasswordPopupButtonDelegate?
    
    var titleString = "Enter Password"
    
    @IBOutlet weak var imgShowPassword: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnOK.isEnabled = false
        self.btnOK.alpha = 0.5
        self.swAgree.isOn = false
        
         NotificationCenter.default.addObserver(self, selector: #selector(doForceDismissCoupon), name: NSNotification.Name(rawValue: "doForceDismissCoupon"), object: nil)
        
        self.swAgree.addTarget(self, action: #selector(switchIsChanged), for: UIControl.Event.valueChanged)

        self.lblTermsCon.text = strtnc
        self.updateViews()
//        self.imgShowPassword.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickPasswordVisible)))
//
    
    }
    
    @objc func switchIsChanged(mySwitch: UISwitch) {
        super.updateViews()
        if mySwitch.isOn {
            self.btnOK.isEnabled = true
            self.btnOK.alpha = 1.0
            //print("switch is on")
        } else {
            self.btnOK.isEnabled = false
            self.btnOK.alpha = 0.5
            //print("switch is off")
        }
    }
    
    @objc override func updateViews() {
        super.updateViews()
        self.lblTitle.text = "loanconfirm.term.label".localized
        self.lbSwichTitle.text = "loanconfirm.term.switch.label".localized
        self.lblTitle.attributedText = Utils.setLineSpacing(data: lblTitle.text!)
        self.lblTermsCon.attributedText = Utils.setLineSpacing(data: lblTermsCon.text!)
        
        //print("\(mmText.count)")
    }
    
    @objc func doForceDismissCoupon() {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.lblTitle.text = titleString
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "doForceDismissCoupon"), object: nil)
    }
    
    @IBAction func onClickOkBtn(_ sender: UIButton) {
        delegate?.onClickOkBtn(password: self.tfPassword, popUpView: self)
    }
    
    @IBAction func onClickCancelBtn(_ sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doTogglePasswordVisible(_ sender: Any) {
        if tfPassword.isSecureTextEntry{
            tfPassword.isSecureTextEntry = false
            imgShowPassword.tintColor = UIColor.gray // change icon here
            imgShowPassword.image = UIImage(named: "invisible-icon")
            
        }else{
            tfPassword.isSecureTextEntry = true
            imgShowPassword.tintColor = UIColor(netHex: 0xB70081) // change icon here
            imgShowPassword.image = UIImage(named: "visible-icon")
        }
    }
    
    var strtnc = """
                ဤသဘောတူကတိစာချုပ်၏ စည်းကမ်းချက်များအရ AEON ၏ Small Loan ရယူသူကိုနောင်တွင် “Cutstomer” အားအာမခံပေးသူရှိလျှင်နောင်တွင် “Guarantor” ဟုလည်းကောင်း၊ AEON Microfinance (Myanmar) Company Limited ကိုယ်စား Customer များသို့ AEON ၏ Small Loan ထောက်ပံ့ရာတွင် လွယ်ကူမှုရှိစေရန် ကူညီဆောင်ရွက်ပေးသူ AEON’s Agent ကို နောင်တွင် “Agent” ဟုလည်းကောင်း၊ AEON Microfinance (Myanmar) Company Limited ကို နောင်တွင် “Finance Provider” ဟုလည်းကောင်း ရည်ညွှန်းခေါ်ဆိုရေးသားမည်ဖြစ်သည်။ Customer, Guarantor, Agent နှင့် Finance Provider တို့သည် အောက်ဖော်ပြပါစည်းကမ်းချက်များကို အသီးသီးလိုက်နာဆောင်ရွက်ကြရန် သဘောတူညီကြပါသည်။
        ၁။    Finance Provider သည် Customer သို့အသေးစားချေးငွေထောက်ပံ့ပေးရန်သဘောတူသည်။ ထိုအသေးစားချေးငွေအား Customer နှင့် Agent တို့ သဘောတူညီမှုရယူထားသည့်အတွက် Customer မှ Agent သို့ ပေးချေရမည့်ကျသင့်ငွေကြေးအဖြစ် Finance Provider သည် Agent မှတဆင့်ပေးချေရန် သဘောတူသည်။ ထိုသို့ Finance Provider မှ Agent မှတဆင့်ပေးချေသော ငွေကြေးပမာဏကို Customer သည် Finance Provider ထံမှ ချေးငွေရယူမှုအဖြစ်မှတ်ယူရမည်ဖြစ်သည်။
        ၂။    Agent ထံမှအသေးစားချေးငွေ (Small Loan) ကိုလက်ခံရရှိပြီးနောက် Customer သည် သဘောတူစာချုပ်ပါအပြီးသတ်အတည်ပြုချက်စာတိုင်းတွင်လက်မှတ်ရေးထိုးပေးရမည့်အပြင်ငွေရင်း၊အတိုးနှင့် အခြားစရိတ်စကများပါဝင်သောချေးငွေကို Finance Provider သို့အပြည့်အဝပြန်လည်ပေးဆပ်ရန်ကိုလည်းသဘောတူညီသည်။ Customer သည်သဘောတူညီချက်ပါစည်းကမ်းချက်များကိုအပြည့်အဝလိုက်နာဆောင်ရွက်ရန်ကိုလည်းသဘောတူညီသည်။ ချေးငွေပြန်လည်ပေးဆပ်မှုကို Finance Provider သတ်မှတ်သည့် ၎င်း၏ရုံးခွဲ (သို့မဟုတ်) ငွေလွှဲဌာန (သို့မဟုတ်) ဘဏ်တို့တွင် သတ်မှတ်ထားသည့်နည်းလမ်းများအတိုင်း Customer ကပေးဆပ်ရမည်ဖြစ်ပါသည်။ ချေးငွေ ပြန်ပေးဆပ်ရမည့်နည်းလမ်းနှင့် စည်ကမ်းချက်များကို ချေးငွေပြန်ဆပ်သည့်စာရင်းဇယားတွင် Finance Provider ကသတ်မှတ်ပြဌာန်းထားပါသည်။ သဘောတူစာချုပ်တွင် သတ်မှတ်ထားသော ပထမဆုံးအရစ်ကျငွေပြန်ဆပ်ရန်စေ့ရောက်သည့်အချိန်တွင်လစဉ်ပြန်ဆပ်ငွေကို Customer ကအချိန်မီ ပေးဆပ်ရမည်။ ထို့ပြင် နောက်ထပ်ချေးငွေပြန်ဆပ်ရမည့်အချိန်စေ့ရောက်တိုင်းလစဉ်ပြန်ဆပ်ငွေကို ပေးဆပ်ရမည်။ ထိုသို့ လစဉ်ပေးချေမှုကိုချေးငွေပြေကျေသည့်အထိအောက်တွင်ဖော်ပြထားသည့် စည်းကမ်းချက်များနှင့် အစီအစဉ်အတိုင်း ပေးဆပ်ရမည်။
           ၂.၁။ ။ ချေးငွေပြန်ဆပ်သည့် စာရင်းဇယားပေါ်အခြေပြု၍ လစဉ်(၂)ရက်နေ့တိုင်းတွင် Finance Provider  သို့ချေးငွေပြန်ဆပ်ခြင်းကို ချေးငွေပြေကျသည့်အထိ လစဉ်ပြုရမည်။
           ၂.၂။  ။ မြန်မာကျပ်ငွေဖြင့်သာ ချေးငွေအားလုံးကိုပြန်ဆပ်ရမည်။ မြန်မာနိုင်ငံအသေးစားငွေရေးကြေးရေး ဥပဒေအရ နှစ်စဉ်အမှန်ထိရောက် အတိုးနှုန်း (Annual effective interest rate – Not more than 30%) ၃၀%ထက်မပိုသောအတိုးနှုန်းဖြင့်တွက်ချက်ပါသည်။
           ၂.၃။ ။ Finance Provider ၏မူဝါဒအပေါ်အခြေခံ၍ စာချုပ်ချုပ်ဆိုသည့်နေ့တွင် ကျသင့်သည့် စာချုပ်ချုပ်ခ၊ ဝန်ဆောင်စရိတ်နှင့် အခြားကုန်ကျစရိတ်များကို Customer မှ Finance Provider (သို့မဟုတ်) Agent မှတစ်ဆင့်ပေးချေရမည်။ မြန်မာနိုင်ငံအသေးစားငွေရေးကြေးရေး ဥပဒေအရ ချေးငွေပမာဏ၏ ၅% ထက်မပိုသော မဖြစ်မနေစုဆောင်းငွေ (Compulsory Saving) ကို Customer မှ Finance Provider (သို့မဟုတ်) Agent မှ တဆင့်အပ်နှံရပါမည်။ နှစ်စဉ်အတိုးနှုန်း ၁၅% ဖြင့်တွက်ချက်ပေးပါမည်။
           ၂.၄။    ။ သဘောတူစာချုပ် ချုပ်ဆိုသည့်နေ့ရက်မှ (၇) ရက်အတွင်း Customer သည် Finance Provider နှင့် Agent တို့၏ကြိုတင်သဘောတူညီချက်ဖြင့် စာချုပ်ကို ပယ်ဖျက်နိုင်သည်။ထိုသို့ပယ်ဖျက်ပါက Finance Provider နှင့် Agent တို့ထံ Customer ကပေးသွင်းထားသည့် စာရွက်စာတမ်းစရိတ်များကို Customer သို့ပြန်လည်ထုတ်ပေးရမည်။
           ၂.၅။    ။ ငွေပေးချေမှုကို Finance Provider ၏ရုံးခွဲ(သို့) Finance Provider ၏ဘဏ်စာရင်းသို့ပေးသွင်းနိုင်သည်။ ထိုပေးချေမှုနှင့် စပ်လျဉ်းသည့်စာရိတ်စကများကို Customer က ကျခံရမည်။
        ၂.၆။     ။ Finance Provider ၏ရုံးခွဲသို့ပေးဆပ်မှုအတွက် စရိတ်ကျခံရန်မလိုပါ။
        ၃။    ချေးငွေပြန်ဆပ်ရက်ကျော်လွန်ခြင်းကြောင့် ဆောင်ရွက်ရမည့်ကိစ္စများနှင့် တရားစွဲဆိုရ၍ ကုန်ကျစရိတ်များ(သို့မဟုတ်) အထက်ပါကဲ့သို့သော အခြေအနေဖြစ်ရပ်များကြောင့် Finance Provider ၏ကုန်ကျစရိတ် အဝဝအတွက် Customer တွင်တာဝန်ရှိစေရမည်။
        ၃.၁။     ။ ငွေပေးဆပ်ရန် စေ့ရောက်သည့်နေ့ရက်အတွင်း Customer သည် ချေးငွေပေးဆပ်ရန်ပျက်ကွက်လျှင် Finance Provider ၏ မူဝါဒနှင့်အညီ နောက်ကျကြေးကို ပေးဆပ်ရန် Customer ကသဘောတူညီသည်။ သို့ရာတွင် Customer အနေဖြင့် နောက်ကျပေးသွင်းနိုင်သည်ဟူသော အဓိပ္ပာယ် မသက်ရောက်စေရ။
        ၃.၂။     ။ Customer မှ ချေးငွေအချိန်မီပေးဆပ်ရန်ပျက်ကွက်မှုရှိလာလျှင် Finance Provider ၏မူဝါဒနှင့်အညီ အိမ်တိုင်ရာရောက်ကွင်းဆင်းကောက်ခံမှုအတွက် ကုန်ကျစရိတ် အဝဝကို Customer ကပေးချေရန်သဘောတူညီသည်။
        ၃.၃။     ။ ချက်လက်မှတ်ဖြင့် ငွေပေးချေရာ ယင်းချက်လက်မှတ်သည်အကြောင်းကြောင်းကြောင့် တရားဝင်ခိုင်မြဲမှုမရှိသည့် အခြေအနေတွင် အဆိုပါချက်လက်မှတ်နှင့် ပတ်သက်သည့် စရိတ်စကများကို Customer က Finance Provider သို့ ပေးချေရမည်။
        ၄။    Customer သည်စာချုပ်ကို သက်တမ်းမကုန်ဆုံးမီ ရပ်စဲလိုပါက Finance Provider က သတ်မှတ်ထားသည့်အတိုင်း ကြိုတင်ငွေပေးချေမှုပြုလုပ်၍ ရပ်စဲနိုင်သည်။
        ၅။    Customer သည်ဤသဘောတူစာချုပ်တွင် အရစ်ကျငွေအသီးသီးပြန်ဆပ်ရန်အတွက် အသုံးပြုရန်ဖော်ပြထားသည့် ဘဏ်စာရင်း (သို့မဟုတ်) လုပ်ငန်းဌာန (သို့မဟုတ်)နေရပ်လိပ်စာ စသည့်တို့ကိုပြောင်းလဲလိုလျှင် ထိုသို့ပြောင်းလဲသည့်နေ့ရက်မှ (၇) ရက်ထက်နောက်မကျဘဲ Finance Provider ထံကြိုတင်အကြောင်းကြားစာကို ပေးပို့ရမည်။
         ၆။    Finance Provider သည် အောက်ပါကိစ္စရပ်များအတွက် သဘောတူစာချုပ်ကို စာဖြင့် ရေးသားအကြောင်းကြား၍ ရပ်စဲခွင့်ရှိသည်။
           ၆.၁။     ။ Customer သည်ချေးငွေပြန်ဆပ်မှုကို နှစ်လဆက်တိုက်ပေးဆပ်ရန် ပျက်ကွက်သည့်အခါ (သို့မဟုတ်)
           ၆.၂။     ။ Customer သည် လူမွဲစာရင်းဝင်ဖြစ်သွားသောအခါ (သို့မဟုတ်) တရားရုံးတစ်ရုံးမှ ၎င်းအားလူမွဲဖြစ်ကြောင်းစီရင် ဆုံးဖြစ်သောအခါ (သို့မဟုတ်) ၎င်း၏ပစ္စည်းဥစ္စာများကို သိမ်းဆည်းခံရသောအခါ (သို့မဟုတ်)
           ၆.၃။    ။ ဤသဘောတူစာချုပ်နှင့် ပတ်သက်၍သော်လည်းကောင်း၊ ဤသဘောတူမှုအတွက် အဓိကကျသောအချက်အလက်နှင့် ပတ်သတ်၍သော်လည်းကောင်း၊ Customer သည်မမှန်မကန် (သို့မဟုတ်) ဖြစ်ရပ်မှန်ကိုဖုံးကွယ်၍ဖော်ပြချုပ်ဆိုသည့်အခါ (သို့မဟုတ်)
           ၆.၄။    ။ ဤသဘောသူစာချုပ်ပါစည်းကမ်းချက်များကို Customer သည်လိုက်နာဆောင်ရွက်ခြင်းမပြုသည့်အခါ
        ၇။    Finance Provider သည်ဤသဘောတူစာချုပ်တွင်ပါရှိသော ပုဂ္ဂိုလ်ရေးအချက်အလက်များအပါအဝင် Customer ၏သတင်းအချက်အလက်များကိုကြွေးဝယ်ကတ်ထုတ်ပေးခြင်း၊အသက်အာမခံ၊ အာမခံကိစ္စရပ်များ၊ချေးငွေပေးဆပ်မှုကိစ္စရပ်များ(သို့မဟုတ်)နောင်တွင်ဆောင်ရွက်မည့် Finance Provider၊ ၎င်းနှင့်ဆက်စပ်မှုရှိသောလုပ်ငန်းများ၏ ဝန်ဆောင်မှုကိစ္စရပ်များအတွက်သိမ်းဆည်းခြင်း၊ဖလှယ်ခြင်း၊အသုံးပြုခြင်းပြုနိုင်သည်။ Customer သည်မိမိ၏ သတင်းအချက်အလက်များအတွက် ထိုသို့သဘောတူမှုကို မည့်သည့်ကိစ္စတွင်မှ ပယ်ဖျက်ခြင်းမရှိစေရ။ ထို့ပြင် Customer သည် Finance Provider ထံမှ ဖြစ်စေ၊အခြားပုဂ္ဂိုလ်တစ်ဦးဦးထံမှဖြစ်စေ၊ သတင်းအချက်အလက်များ တရားဝင်ရယူထားသော အခြားပုဂ္ဂိုလ်များထံမှ ဖြစ်စေ နစ်နာကြေး၊ လျော်ကြေးတစ်စုံတစ်ရာ တောင်းဆိုခြင်းမရှိစေရ။ ထို့ပြင် Customer ၏သတင်းအချက်တစ်စုံတစ်ရာပြောင်းလဲမှုရှိပါက Customer သည် Finance Provider ထံချက်ချင်းအကြောင်းကြားရမည်။
        ၈။    ဤသဘောတူညီချက်တွင် ဖော်ပြပါရှိသောအတိုးနှုန်း၊ဝန်ဆောင်ခ၊ကုန်ကျစရိတ်များအပါအဝင် ဤစာချုပ်ပါပဋိညာဉ် စည်းကမ်းချက်များကို Finance Provider ကစိစစ်ပြောင်းလဲခွင့်ရှိကြောင်း Customer ကသဘောတူညီသည်။ Finance Provider သည် အသိပေးအကြောင်းကြားခြင်းမရှိဘဲ ချေးငွေနှင့် ပတ်သတ်သောစာရွက်စာတမ်းများကို Customer သို့ပြန်လည်ပေးဆပ်ခြင်းမပြုဘဲ အများဆုံးချေးယူရှိသော ချေးငွေပမဏကန့်သတ်ချက်ကိုပြုပြင်ပြောင်းလဲနိုင်ရန် (သို့မဟုတ်) ချေးငွေထုတ်ချေးပေးခြင်းအား ငြင်းဆန်နိုင်ရန်အခွင့်အာဏာရှိသည်။
        ၉။    Finance Provider တွင်ကြွေးမြီးများကောက်ခံရန် ကိုယ်စားလှယ်လွှဲနိုင်သည့် အခွင့်အာဏာရှိစေရမည်။
        ၁၀။    Customer သည်ချေးငွေပြန်ဆပ်ရန်ပျက်ကွက်ပါက ကြွေးမြီးကို Customer ထံမှဦးစွာတောင်းခံခြင်းပြုရန်မလိုဘဲ Customer ပေးရန်ကျန်ရှိသည့်ငွေရင်း၊အတိုး၊စရိတ်စကနှင့်အခြားအခကြေးငွေများ အပါအဝင် အကြွေးကျန်အားလုံးကို Guarantor က Finance Provider သို့ပေးဆပ်ရန်သဘောတူညီသည်။
        ၁၁။    Customer သည်သဘောတူစာချုပ်ပါစည်းကမ်းချက်များကို ဖောက်ဖျက်သည်ဟုယုံကြည်နိုင်လောက်သောအခါတွင် Finance Provider သည်ဤသဘောတူညီစာချုပ်ပါအခွင့်အာဏာများအတိုင်းရေးယူခြင်း (သို့မဟုတ်) စည်းကမ်းချက်များဖြစ်စေ၊ ချွင်းချက်မဲ့ဖြင့်ဖြစ်စေ သက်ညှာပေးခြင်း၊လျှော့ပေါ့ပေးခြင်းကိုပြုနိုင်သည်။ Finance Provider သည် Customer ကိုအရေးမယူဘဲ သက်ညှာပေးခြင်းကိုလည်း ထိုမှနှောင်တွင် အချိန်မရွေး ပြန်လည်ပယ်ဖျက်ကာ အရေးယူနိုင်သည်။
        ၁၂။    ဤသဘောတူညီချက်ပါ ပြဋ္ဌန်းချက်အားလုံးသည် သီးခြားစီသက်ရောက်မှုရှိသည်။ ဤသဘောတူညီချက်ပါ ပြဋ္ဌန်းချက်အချို့သည် ဥပဒေနှင့်မညီခြင်း၊ ခိုင်မာမှုမရှိခြင်း၊ ဥပဒေနှင့်အညီဆောင်ရွက်ရန် အာနိသင်မရှိခြင်းတို့ဖြစ်ပေါ်လျှင် ယင်းပြဋ္ဌန်းချက်သာလျှင် ပျက်ပြယ်မည်ဖြစ်ပြီး ကျန်ပြဋ္ဌန်းချက်များသည် ဥပဒေအရခိုင်မာမှု၊ တည်မြဲမှု၊ အကျိုးသက်ရောက်မှုရှိကြောင်း သဘောတူညီကြပါသည်။
        ၁၃။    ဤသဘောတူစာချုပ်သည် မြန်မာနိုင်ငံရှိ ဥပဒေများနှင့်အညီ သက်ရောက်မှုရှိသည်။ ဤသဘောတူညီချက်ပါ ကိစ္စတစ်ရပ်ရပ်နှင့် စည်းကမ်းချက်တစ်ရပ်ရပ်နှင့် စပ်လျဉ်း၍ ပေါ်ပေါက်ဖြစ်ပွားသော အငြင်းပွားမှုများကို စာချုပ်တွင် ပါဝင်လက်မှတ်ရေးထိုးထား သူတို့က အခင်အမင်မပျက် မိတ်ဆွေကောင်းပီသစွာဖြင့် ညှိနှိုင်းဖြေရှင်းကြရန် သဘောတူညီကြသည်။ ယင်းအငြင်းပွားမှုကို တစ်လအတွင်းဖြေရှင်း၍ ပြေလည်မှုမရှိပါက တစ်ဦးဦးက မြန်မာနိုင်ငံရှိ သက်ဆိုင်ရာတရားရုံးများတွင် တင်ပြတရားစွဲဆိုနိုင်သည်။
        ၁၄။    ဤသဘောတူညီချက်သည်စာချုပ်ပါသက်ဆိုင်ရာပုဂ္ဂိုလ်များသာမက၎င်းတို့၏အမွေခံများ၊ ကိုယ်စားလှယ်များ၊ လွှဲအပ်ထားသူများနှင့်ဆက်ခံသူအားလုံးတို့အပေါ်တွင်လည်း စည်းနှောင်အကျိုးသက်ရောက်မှုရှိစေရမည်။ Finance Provider သည် Customer ထံသို့ကြိုတင်အကြောင်းကြားစာရေးသားပေးပို့ကာ ဤသဘောတူချက်အရ Finance Provider ၏လုပ်ပိုင်ခွင့်များ၊ အကျိုးခံစားခွင့်များ၊ လိုက်နာရမည့်စည်းကမ်းချက်များကို တစ်စိတ်တစ်ပိုင်းသော်လည်းကောင်း၊ အားလုံးသော်လည်းကောင်း ကိုယ်စားလှယ်လွှဲအပ်ခြင်း၊ လွှဲပြောင်းပေးအပ်ခြင်းမရှိစေရ။
        ၁၅။    ချေးငွေပေးဆပ်မှုဇယားနှင့် Finance Provider ၏မူဝါဒတို့သည် ဤသဘောတူချက်၏ အစိတ်အပိုင်းများအဖြစ် ပါဝင်ရမည်။
    """
}

protocol CheckPasswordPopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController)
    
}
