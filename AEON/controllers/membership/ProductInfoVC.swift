//
//  ProductInfoVC.swift
//  AEONVCS
//
//  Created by Sumyat Thu on 11/13/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductInfoVC: BaseUIViewController {
    
    @IBOutlet weak var lblTitleProductname: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblTitleModel: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    
    @IBOutlet weak var lblTitleBrand: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    
    @IBOutlet weak var lblTitleCode: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    
    @IBOutlet weak var lblTitlePrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblTitleCashdown: UILabel!
    @IBOutlet weak var lblCashdown: UILabel!
    
    @IBOutlet weak var lblTitleLoantype: UILabel!
    @IBOutlet weak var lblLoanType: UILabel!
    
    @IBOutlet weak var lblTitleInvoice: UILabel!
    @IBOutlet weak var lblInvoice: UILabel!
    
    @IBOutlet weak var bgTapView: UIView!
    
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
     var sessionInfo:SessionDataBean?
    var tokenInfo: TokenData?
    
    var purchaseid = 0
    var appinfoid = 0
    var qrproductinfo = QRProductInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.bgTapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.onClickTapView)))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         self.fillDataUI()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        
    
        self.lblTitleProductname.text = "product_info.productname".localized
        self.lblTitleCode.text = "product_info.productcode".localized
        self.lblTitleBrand.text = "product_info.brand".localized
        self.lblTitleModel.text = "prodcut_info.model".localized
        self.lblTitlePrice.text = "prodcut_info.price".localized
        self.lblTitleInvoice.text = "prodcut_info.invoice".localized
        self.lblTitleCashdown.text = "prodcut_info.cashdown".localized
        self.lblTitleLoantype.text = "prodcut_info.loantype".localized
        self.btnOk.setTitle("prodcut_info.confirm".localized, for: .normal)
        self.btnCancel.setTitle("prodcut_info.cancel".localized, for: .normal)
    }
    
    
    
    func doConfirmProductInfo() {
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
               tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
               sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
        DAViewModel.init().getProductInfoConfirmVM(tokenInfo: tokenInfo!, purchaseid: "\(self.purchaseid)", cusId: "\(sessionInfo?.customerId ?? 0)", appid: "\(self.appinfoid)", success: { (okstring) in
            let alertController = UIAlertController(title: "Your Purchasing is successfully confirmed!", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alertController, animated: true, completion: nil)
        }) { (error) in
            print("doGetAgreementlist error : \(error)")
            let alertController = UIAlertController(title: "There is an error in purchase confimation!", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func doCancelProductInfo() {
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
               tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
               sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
        
        DAViewModel.init().getProductInfoCancelVM(tokenInfo: tokenInfo!, purchaseid: "\(self.purchaseid)", cusId: "\(sessionInfo?.customerId ?? 0)", appid: "\(self.appinfoid)", success: { (okstring) in
            let alertController = UIAlertController(title: "Your Purchasing is successfully canceled!", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alertController, animated: true, completion: nil)
        }) { (error) in
            print("doGetAgreementlist error : \(error)")
            let alertController = UIAlertController(title: "There is an error in purchase cancellation!", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Constants.OK, style: UIAlertAction.Style.default, handler: { action in
                
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func fillDataUI() {
        
        self.lblProductName.text = self.qrproductinfo.productName ?? ""
        self.lblModel.text = self.qrproductinfo.model ?? ""
        self.lblBrand.text = self.qrproductinfo.brand ?? ""
        self.lblCode.text = self.qrproductinfo.productCode ?? ""
        self.lblPrice.text = "\(self.qrproductinfo.price ?? 0.0)"
        self.lblCashdown.text = "\(self.qrproductinfo.cashDownAmount ?? 0.0)"
        if self.qrproductinfo.daLoanTypeId == 1 {
            self.lblLoanType.text = "Mobile"
        } else {
            self.lblLoanType.text = "Nonmobile"
        }
        self.lblInvoice.text = "\(self.qrproductinfo.invoiceNo ?? "")"
        
    }

    @objc func onClickTapView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tappedOnConfirm(_ sender: Any) {
        self.doConfirmProductInfo()
    }
    
    @IBAction func tappedOnCancel(_ sender: Any) {
        self.doCancelProductInfo()
    }
    
    
}
