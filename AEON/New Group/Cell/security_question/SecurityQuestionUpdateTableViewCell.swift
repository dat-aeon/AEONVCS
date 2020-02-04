//
//  SecurityQuestionUpdateTableViewCell.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecurityQuestionUpdateTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var ivPasswordVisible: UIImageView!
    @IBOutlet weak var lbMessage: UILabel!
    
    //Error message language control
    var messageLocale : String?
    
    var delegate:SecurityQuestionUpdateDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tfPassword.delegate = self
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapRecognizer)
        
        self.ivPasswordVisible.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickPasswordVisible)))
    }
    
    @objc func didTapView() {
        contentView.endEditing(true)
        print("didTapView")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func onClickPasswordVisible(){
        if tfPassword.isSecureTextEntry{
            tfPassword.isSecureTextEntry = false
            ivPasswordVisible.tintColor = UIColor.gray // change icon here
            ivPasswordVisible.image = UIImage(named: "invisible-icon")
            
        }else{
            tfPassword.isSecureTextEntry = true
            ivPasswordVisible.tintColor = UIColor(netHex: 0xB70081) // change icon here
            ivPasswordVisible.image = UIImage(named: "visible-icon")
            
        }
    }
    
    @IBAction func onClickUpdateButton(_ sender: UIButton) {
        delegate?.onClickUpdateButton(cell: self)
    }
}

protocol SecurityQuestionUpdateDelegate {
    func onClickUpdateButton(cell:SecurityQuestionUpdateTableViewCell)
}
