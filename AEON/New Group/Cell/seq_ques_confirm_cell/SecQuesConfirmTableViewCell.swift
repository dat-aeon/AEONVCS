//
//  SecQuesConfirmTableViewCell.swift
//  AEON
//
//  Created by Mobile User on 1/30/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesConfirmTableViewCell: UITableViewCell {

    @IBOutlet weak var vDivision: UIView!
    @IBOutlet weak var lblDivision: UILabel!
    @IBOutlet weak var vTownship: UIView!
    @IBOutlet weak var lblTownship: UILabel!
    @IBOutlet weak var vNrcType: UIView!
    @IBOutlet weak var lblNrcType: UILabel!
    @IBOutlet weak var tfNrcNo: UITextField!
    @IBOutlet weak var tfPhoneNo: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var delegate :SecQuesConfirmDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vDivision.layer.borderWidth = 1
        self.vDivision.layer.cornerRadius = 4 as CGFloat
        self.vDivision.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vTownship.layer.borderWidth = 1
        self.vTownship.layer.cornerRadius = 4 as CGFloat
        self.vTownship.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.vNrcType.layer.borderWidth = 1
        self.vNrcType.layer.cornerRadius = 4 as CGFloat
        self.vNrcType.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        self.vDivision.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickDivision)))
        
        self.vTownship.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickTownship)))
        
        self.vNrcType.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickNrcType)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:SecurityQuestionConfirm) {
        self.tfPhoneNo.text = data.phoneNo
        self.tfNrcNo.text = data.nrcNumber
       
    }
    
    @objc func onClickDivision(){
        delegate?.onClickDivision()
    }
    
    @objc func onClickTownship(){
        delegate?.onClickTownship()
    }
    @objc func onClickNrcType(){
        delegate?.onClickNrcType()
    }
    @IBAction func onClickConfirmBtn(_ sender: UIButton) {
        delegate?.onClickConfirm()
    }
}

protocol SecQuesConfirmDelegate {
    func onClickConfirm()
    func onClickDivision()
    func onClickTownship()
    func onClickNrcType()
}
