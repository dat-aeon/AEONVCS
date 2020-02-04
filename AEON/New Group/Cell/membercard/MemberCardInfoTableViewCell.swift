//
//  MemberCardInfoTableViewCell.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol MemberCardInfoCellDelegate {
    func tappedOnAgreementNumber(currentIndex: Int)
    func tappedOnQRcode(currentIndex: Int)
}

class MemberCardInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var btnQRcode: UIButton!
    @IBOutlet weak var ivBackgroundGif: UIImageView!
    @IBOutlet weak var ivQRCode: UIImageView!
    @IBOutlet weak var lblAgreementNo: UILabel!
    @IBOutlet weak var lblFinancialData: UILabel!
    
    @IBOutlet weak var qrHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAgreementList: UIButton!
    
    
    
    var delegate : MemberCardInfoCellDelegate?
    var sessionInfo:SessionDataBean?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    func setData(data:AgreementInfo){
        
        let text = "\(data.agreementNo ?? "")"
        let textRange = NSRange(location: 0, length: (text.count))
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        self.lblAgreementNo.attributedText = attributedText
        
//        self.lblAgreementNo.text = data.agreementNo
        //self.ivBackgroundGif.loadGif(asset: "Aeon-Animate-1")
        //self.ivBackgroundGif.loadGif(asset: "AEON-gif")
        
        if data.qrShow == 2 {
           
            //let qrData =  "www.aeonmicrofinance.com.mm \n \(data.agreementNo ?? Constants.BLANK)"
            //let qrData = self.getQRString(aggrementobj: data)
            let qrCode = Utils.init().generateQRCode(data:data.encodeStringForQr!)
            self.ivQRCode.image = qrCode
            self.ivQRCode.isHidden = false
            self.qrHeight.constant = 160.0
            
            print("QR SHOW: \(data.qrShow ?? 0) = \(data.agreementNo ?? Constants.BLANK)")
            
        } else {
            self.ivQRCode.isHidden = true
            self.qrHeight.constant = 0.0
        }
        let financialAmt = data.financialAmt ?? 0
        let amount = Formatter.withSeparator.string(from: financialAmt as NSNumber)
        self.lblFinancialData.text = "\(amount ?? "0") Ks\t / \t \(data.financialTerm ?? 0) months"
        
        
    }
    
    @IBAction func tappedOnAgreementNumber(_ sender: Any) {
        if let btn = sender as? UIButton {
            self.delegate?.tappedOnAgreementNumber(currentIndex: btn.tag)
        }
    }
    
    func getQRString(aggrementobj : AgreementInfo) -> String {
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
        sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
         let jsonobj = [
            "customerId": "\(sessionInfo?.customerId ?? 0)",
            "daPurchaseInfoId": "",
            "daApplicationInfoId": "\(aggrementobj.daApplicationInfoId ?? 0)",
            "customerName": "\(sessionInfo?.name ?? "")",
            "customerNrc": "\(sessionInfo?.nrcNo ?? "")",
            "agreementNo": "\(aggrementobj.agreementNo ?? "")",
            "loanAmount": "\(aggrementobj.financialAmt ?? 0)",
            "loanTerm": "\(aggrementobj.financialTerm)",
            "customerNo": "\(sessionInfo?.customerNo ?? "")"
                ]
                
        //        let str = self.JSONStringify(value: jsonobj!)
                if let theJSONData = try?  JSONSerialization.data(
                     withJSONObject: jsonobj,
                     options: .prettyPrinted
                     ),
                     let theJSONText = String(data: theJSONData,
                                              encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                         print("JSON string = \(theJSONText)")
//                   return self.encryptanddecrypt(strtoEncrypt: theJSONText)
                   }
        
        return ""
    }
    /*
    func encryptanddecrypt(strtoEncrypt: String) -> String {
        let value = strtoEncrypt  // This is the value that we want to encrypt
        let key = "B777ER200A350MM2"     // This is the key

        let EncryptedValue = try! value.aesEncrypt(mykey: key)
        print("encrypt : \(EncryptedValue)")
        
        let DecryptedValue = try! EncryptedValue.aesDecrypt(mykey: key)
        print("decrypt : \(DecryptedValue)")
        
        return EncryptedValue
    }
    */
    @IBAction func tappedOnQRcode(_ sender: Any) {
         if let btn = sender as? UIButton {
            self.delegate?.tappedOnQRcode(currentIndex: btn.tag)
        }
    }
    
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

//extension Integer {
//    var formattedWithSeparator: String {
//        return Formatter.withSeparator.string(for: self) ?? ""
//    }
//}
