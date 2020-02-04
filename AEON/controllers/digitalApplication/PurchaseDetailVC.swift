//
//  PurchaseDetailVC.swift
//  AEONVCS
//
//  Created by mac on 11/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class PurchaseDetailVC: BaseUIViewController {
    
    
    @IBOutlet weak var tbPurchase: UITableView!
    
    var inquiryAppID = 0
    var tokenInfo: TokenData?
    var purchaseInfo = PurchaseDetail()
    
    var purchasedetail = ["da.outlet_name", "prodcut_info.loantype", "product_info.productcode", "product_info.productname", "product_info.brand", "prodcut_info.model", "prodcut_info.price", "prodcut_info.cashdown", "da.purchasedate", "prodcut_info.invoice", "da.agreement_no", "da.finance_amt", "da.finance_term", "da.processing_fee", "da.compulsory_saving", "da.settlement", "da.member_card", "prodcut_info.invoice", "Cash Receipt", "da.agreement", "application_data.othernationality"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
        
    }
    
    override func updateViews() {
        super.updateViews()
        self.tbPurchase.reloadData()
    }
    

    func setupView()
    {
        self.tbPurchase.delegate = self
        self.tbPurchase.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.doGetPurchaseDetailAPI()
    }
    
    func doGetPurchaseDetailAPI() {
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        DAViewModel.init().doInquiryPurchaseDetail(tokenInfo: tokenInfo!, inquiryAppId: "\(self.inquiryAppID)", success: { (purchaseDetailObj) in
            self.purchaseInfo = purchaseDetailObj
            self.tbPurchase.reloadData()
        }) { (error) in
            print("doGetPurchaseDetailAPI : \(error)")
        }
    }
    
    @IBAction func tappedOnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

extension PurchaseDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var totalrow = 16
        let attachmentfiles = self.purchaseInfo.purchaseInfoAttachmentDtoList
        if attachmentfiles != nil {
            let typeOne =  attachmentfiles!.filter { $0.fileType == 1 }
            if typeOne.count > 0 {
                totalrow += 1
            }
            let typeTwo =  attachmentfiles!.filter { $0.fileType == 2 }
            if typeTwo.count > 0 {
                totalrow += 1
            }
            let typeThree =  attachmentfiles!.filter { $0.fileType == 3 }
            if typeThree.count > 0 {
                totalrow += 1
            }
            let typeFour =  attachmentfiles!.filter { $0.fileType == 4 }
            if typeFour.count > 0 {
                totalrow += 1
            }
        }
        return totalrow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= 16 {
            return 200
        }
        
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= 16 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "idUserCardTBCell", for: indexPath) as! cellPurchaseImages
            
            let subtitleString = self.purchasedetail[indexPath.row]
            let attachmentfiles = self.purchaseInfo.purchaseInfoAttachmentDtoList
            var imagefile = ""
            var imagefileArray = [String]()
            if attachmentfiles != nil {
                switch indexPath.row {
                case 16, 17, 18, 19, 20:
                    var filteredArray =  attachmentfiles!.filter { $0.fileType == 1 }
                    print(filteredArray)
                    if filteredArray.count == 0 {
                        filteredArray =  attachmentfiles!.filter { $0.fileType == 2 }
                        
                        if filteredArray.count == 0 {
                             filteredArray =  attachmentfiles!.filter { $0.fileType == 3 }
                            
                            if filteredArray.count == 0 {
                                filteredArray =  attachmentfiles!.filter { $0.fileType == 4 }
                                
                                if filteredArray.count != 0 {
                                    for attachment in filteredArray {
                                        imagefile = "https://ass.aeoncredit.com.mm/daso/purchase-image-files/\(attachment.filePath ?? "")"
                                    imagefileArray.append(imagefile)
                                    
                                    }
                                }
                            } else {
                                for attachment in filteredArray {
                                    imagefile = "https://ass.aeoncredit.com.mm/daso/purchase-image-files/\(attachment.filePath ?? "")"
                                imagefileArray.append(imagefile)
                            }
                        }
                            
                        } else {
                            for attachment in filteredArray {
                                imagefile = "https://ass.aeoncredit.com.mm/daso/purchase-image-files/\(attachment.filePath ?? "")"
                            imagefileArray.append(imagefile)
                        }
                        }
                        
                    }  else {
                        for attachment in filteredArray {
                            imagefile = "https://ass.aeoncredit.com.mm/daso/purchase-image-files/\(attachment.filePath ?? "")"
                            imagefileArray.append(imagefile)
                            
                            }
                    }
                    
                default:
                    imagefile = ""
                }
            }
            cell.cellLbltitle.text = subtitleString.localized
            cell.imagefilename = imagefile
            cell.imagefiles = imagefileArray
            return cell
        } else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.PURCHASE_LIST_CELL, for: indexPath) as! cellPurchaseList
        
        
        var subtitleString = ""
        
        switch indexPath.row {
        case 0:
            subtitleString = self.purchaseInfo.outletName ?? ""
            
        case 1:
            if self.purchaseInfo.daLoanTypeId ?? 0 == 1 {
                subtitleString = "Mobile"
            } else {
                subtitleString = "Nonmobile"
            }
            
        case 2:
            subtitleString = self.purchaseInfo.productCode ?? ""
            
        case 3:
            subtitleString = self.purchaseInfo.productName ?? ""
         
        case 4:
            subtitleString = self.purchaseInfo.brand ?? ""
            
        case 5:
            subtitleString = self.purchaseInfo.model ?? ""
            
        case 6:
            subtitleString = "\(self.purchaseInfo.price ?? 0.0)"
            
        case 7:
            subtitleString = "\(self.purchaseInfo.cashDownAmount ?? 0.0)"
            
        case 8:
            subtitleString = self.purchaseInfo.purchaseDate ?? ""
            
        case 9:
            subtitleString = self.purchaseInfo.invoiceNo ?? ""
            
        case 10:
            subtitleString = self.purchaseInfo.agreementNo ?? ""
            
        case 11:
            subtitleString = "\(self.purchaseInfo.financeAmount ?? 0.0)"
            
        case 12:
            subtitleString = "\(self.purchaseInfo.financeTerm ?? 0)"
            
        case 13:
            subtitleString = "\(self.purchaseInfo.processingFees ?? 0.0)"
            
        case 14:
            subtitleString = "\(self.purchaseInfo.compulsoryAmount ?? 0.0)"
            
        case 15:
            subtitleString = "\(self.purchaseInfo.settlementAmount ?? 0.0)"
            
            
        default:
            subtitleString = ""
        }
        
            cell.setData(purchasedetail: self.purchasedetail[indexPath.row].localized, subtitle: subtitleString)
        
        return cell
        }
    }
    
    
}



