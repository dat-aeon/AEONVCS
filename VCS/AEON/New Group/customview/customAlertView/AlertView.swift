//
//  AlertView.swift
//  AEONVCS
//
//  Created by Ant on 19/10/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//
import UIKit
import Foundation

class AlertView: UIView {
    static let instance = AlertView()
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var closeImg: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
//        closeImg.isUserInteractionEnabled = true
//        self.closeImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView)))
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func closeView(){
        parentView.removeFromSuperview()
    }
    private func commonInit() {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    func showAlert(title: String,message: String,alertType: String) {
        self.messageLabel.text = message
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
}
