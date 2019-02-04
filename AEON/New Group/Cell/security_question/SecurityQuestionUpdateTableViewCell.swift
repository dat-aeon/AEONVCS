//
//  SecurityQuestionUpdateTableViewCell.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecurityQuestionUpdateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var ivPasswordVisible: UIImageView!
    
    var delegate:SecurityQuestionUpdateDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivPasswordVisible.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickPasswordVisible)))
    }
    
    @objc func onClickPasswordVisible(){
        if tfPassword.isSecureTextEntry{
            tfPassword.isSecureTextEntry = false
            ivPasswordVisible.tintColor = UIColor.gray // change icon here
        }else{
            tfPassword.isSecureTextEntry = true
            ivPasswordVisible.tintColor = UIColor(netHex: 0xB70081) // change icon here
        }
    }
    
    @IBAction func onClickUpdateButton(_ sender: UIButton) {
        delegate?.onClickUpdateButton(password: tfPassword.text)
    }
}

protocol SecurityQuestionUpdateDelegate {
    func onClickUpdateButton(password:String?)
}
