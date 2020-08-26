//
//  PopupViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 3/9/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class CouponPopupViewController: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var delegate :PopupButtonDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         NotificationCenter.default.addObserver(self, selector: #selector(doForceDismissCoupon), name: NSNotification.Name(rawValue: "doForceDismissCoupon"), object: nil)
        
        
        
    }
    
    @objc func doForceDismissCoupon() {
        self.dismiss(animated: false, completion: nil)
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
}

protocol PopupButtonDelegate {
    func onClickOkBtn(password: UITextField, popUpView: UIViewController)
    
}
